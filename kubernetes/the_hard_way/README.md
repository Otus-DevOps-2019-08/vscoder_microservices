#### Подготовка

```shell
gcloud config set compute/region us-west1
gcloud config set compute/zone us-west1-c
```

#### Installing the Client Tools

##### Install CFSSL

```shell
cd ~/bin
wget -q --show-progress --https-only --timestamping \
  https://storage.googleapis.com/kubernetes-the-hard-way/cfssl/linux/cfssl \
  https://storage.googleapis.com/kubernetes-the-hard-way/cfssl/linux/cfssljson
chmod +x cfssl cfssljson
cd -
cfssl version
```
```log
Version: 1.3.4
Revision: dev
Runtime: go1.13
```

##### Install kubectl

```shell
cd ~/bin
wget https://storage.googleapis.com/kubernetes-release/release/v1.15.3/bin/linux/amd64/kubectl
chmod +x kubectl
cd -
kubectl version --client
```
```log
Client Version: version.Info{Major:"1", Minor:"15", GitVersion:"v1.15.3", GitCommit:"2d3c76f9091b6bec110a5e63777c332469e0cba2", GitTreeState:"clean", BuildDate:"2019-08-19T11:13:54Z", GoVersion:"go1.12.9", Compiler:"gc", Platform:"linux/amd64"}
```


#### Provisioning Compute Resources

##### Virtual Private Cloud Network

```shell
gcloud compute networks create kubernetes-the-hard-way --subnet-mode custom
gcloud compute networks subnets create kubernetes \
  --network kubernetes-the-hard-way \
  --range 10.240.0.0/24
```
```log
Created [https://www.googleapis.com/compute/v1/projects/<GCP_PROJECT_ID>/regions/us-west1/subnetworks/kubernetes].
NAME        REGION    NETWORK                  RANGE
kubernetes  us-west1  kubernetes-the-hard-way  10.240.0.0/24
```

##### Firewall Rules

Create a firewall rule that allows internal communication across all protocols:

```shell
gcloud compute firewall-rules create kubernetes-the-hard-way-allow-internal \
  --allow tcp,udp,icmp \
  --network kubernetes-the-hard-way \
  --source-ranges 10.240.0.0/24,10.200.0.0/16
```
```log
Creating firewall...done.                                                                                                                                           
NAME                                    NETWORK                  DIRECTION  PRIORITY  ALLOW         DENY  DISABLED
kubernetes-the-hard-way-allow-internal  kubernetes-the-hard-way  INGRESS    1000      tcp,udp,icmp        False
```

Create a firewall rule that allows external SSH, ICMP, and HTTPS:

```shell
gcloud compute firewall-rules create kubernetes-the-hard-way-allow-external \
  --allow tcp:22,tcp:6443,icmp \
  --network kubernetes-the-hard-way \
  --source-ranges 0.0.0.0/0
```
```log
Creating firewall...done.                                                                                                                                           
NAME                                    NETWORK                  DIRECTION  PRIORITY  ALLOW                 DENY  DISABLED
kubernetes-the-hard-way-allow-external  kubernetes-the-hard-way  INGRESS    1000      tcp:22,tcp:6443,icmp        False
```

> An [external load balancer](https://cloud.google.com/compute/docs/load-balancing/network/) will be used to expose the Kubernetes API Servers to remote clients.

List the firewall rules in the kubernetes-the-hard-way VPC network:

```shell
gcloud compute firewall-rules list --filter="network:kubernetes-the-hard-way"
```
```log
NAME                                    NETWORK                  DIRECTION  PRIORITY  ALLOW                 DENY  DISABLED
kubernetes-the-hard-way-allow-external  kubernetes-the-hard-way  INGRESS    1000      tcp:22,tcp:6443,icmp        False
kubernetes-the-hard-way-allow-internal  kubernetes-the-hard-way  INGRESS    1000      tcp,udp,icmp                False
```

##### Kubernetes Public IP Address

```shell
gcloud compute addresses create kubernetes-the-hard-way \
  --region $(gcloud config get-value compute/region)
```
```log
Created [https://www.googleapis.com/compute/v1/projects/<GCP_PROJECT_ID>/regions/us-west1/addresses/kubernetes-the-hard-way].
```

view
```shell
gcloud compute addresses list --filter="name=('kubernetes-the-hard-way')"
```
```log
NAME                     ADDRESS/RANGE   TYPE      PURPOSE  NETWORK  REGION    SUBNET  STATUS
kubernetes-the-hard-way  35.199.170.187  EXTERNAL                    us-west1          RESERVED
```

##### Compute Instances

###### Kubernetes Controllers

```shell
for i in 0 1 2; do
  gcloud compute instances create controller-${i} \
    --async \
    --boot-disk-size 200GB \
    --can-ip-forward \
    --image-family ubuntu-1804-lts \
    --image-project ubuntu-os-cloud \
    --machine-type n1-standard-1 \
    --private-network-ip 10.240.0.1${i} \
    --scopes compute-rw,storage-ro,service-management,service-control,logging-write,monitoring \
    --subnet kubernetes \
    --tags kubernetes-the-hard-way,controller
done
```

###### Kubernetes Workers

Each worker instance requires a pod subnet allocation from the Kubernetes cluster CIDR range. The pod subnet allocation will be used to configure container networking in a later exercise. The pod-cidr instance metadata will be used to expose pod subnet allocations to compute instances at runtime.

> The Kubernetes cluster CIDR range is defined by the Controller Manager's --cluster-cidr flag. In this tutorial the cluster CIDR range will be set to 10.200.0.0/16, which supports 254 subnets.

```shell
for i in 0 1 2; do
  gcloud compute instances create worker-${i} \
    --async \
    --boot-disk-size 200GB \
    --can-ip-forward \
    --image-family ubuntu-1804-lts \
    --image-project ubuntu-os-cloud \
    --machine-type n1-standard-1 \
    --metadata pod-cidr=10.200.${i}.0/24 \
    --private-network-ip 10.240.0.2${i} \
    --scopes compute-rw,storage-ro,service-management,service-control,logging-write,monitoring \
    --subnet kubernetes \
    --tags kubernetes-the-hard-way,worker
done
```

###### Verification

```shell
gcloud compute instances list
```
```log
NAME                     ZONE            MACHINE_TYPE   PREEMPTIBLE  INTERNAL_IP  EXTERNAL_IP     STATUS
...
controller-0             us-west1-c      n1-standard-1               10.240.0.10  35.233.182.189  RUNNING
controller-1             us-west1-c      n1-standard-1               10.240.0.11  34.83.7.85      RUNNING
controller-2             us-west1-c      n1-standard-1               10.240.0.12  35.247.67.153   RUNNING
worker-0                 us-west1-c      n1-standard-1               10.240.0.20  35.230.10.43    RUNNING
worker-1                 us-west1-c      n1-standard-1               10.240.0.21  34.82.42.149    RUNNING
worker-2                 us-west1-c      n1-standard-1               10.240.0.22  35.247.117.9    RUNNING
```


#### Configuring SSH Access

test connection
```shell
gcloud compute ssh controller-0
```
всё ok


### Provisioning a CA and Generating TLS Certificates

#### Certificate Authority

Generate the CA configuration file, certificate, and private key:
```shell
{

cat > ca-config.json <<EOF
{
  "signing": {
    "default": {
      "expiry": "8760h"
    },
    "profiles": {
      "kubernetes": {
        "usages": ["signing", "key encipherment", "server auth", "client auth"],
        "expiry": "8760h"
      }
    }
  }
}
EOF

cat > ca-csr.json <<EOF
{
  "CN": "Kubernetes",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "US",
      "L": "Portland",
      "O": "Kubernetes",
      "OU": "CA",
      "ST": "Oregon"
    }
  ]
}
EOF

cfssl gencert -initca ca-csr.json | cfssljson -bare ca

}
```
```log
2019/12/21 21:56:09 [INFO] generating a new CA key and certificate from CSR
2019/12/21 21:56:09 [INFO] generate received request
2019/12/21 21:56:09 [INFO] received CSR
2019/12/21 21:56:09 [INFO] generating key: rsa-2048
2019/12/21 21:56:09 [INFO] encoded CSR
2019/12/21 21:56:09 [INFO] signed certificate with serial number 493451992746291580635025373765985106755034489125
```
```shell
ls -la ./ca*
```
```log
-rw-rw-r-- 1 localusername localusername  232 дек 21 21:56 ./ca-config.json
-rw-r--r-- 1 localusername localusername 1005 дек 21 21:56 ./ca.csr
-rw-rw-r-- 1 localusername localusername  211 дек 21 21:56 ./ca-csr.json
-rw------- 1 localusername localusername 1679 дек 21 21:56 ./ca-key.pem
-rw-rw-r-- 1 localusername localusername 1318 дек 21 21:56 ./ca.pem
```

Results:
```
ca-key.pem
ca.pem
```

#### Client and Server Certificates

##### The Admin Client Certificate

Generate the admin client certificate and private key:

```shell
{

cat > admin-csr.json <<EOF
{
  "CN": "admin",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "US",
      "L": "Portland",
      "O": "system:masters",
      "OU": "Kubernetes The Hard Way",
      "ST": "Oregon"
    }
  ]
}
EOF

cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca-config.json \
  -profile=kubernetes \
  admin-csr.json | cfssljson -bare admin

}
```
```log
2019/12/21 22:01:21 [INFO] generate received request
2019/12/21 22:01:21 [INFO] received CSR
2019/12/21 22:01:21 [INFO] generating key: rsa-2048
2019/12/21 22:01:22 [INFO] encoded CSR
2019/12/21 22:01:22 [INFO] signed certificate with serial number 488173018730364906469477658224792062018534836604
2019/12/21 22:01:22 [WARNING] This certificate lacks a "hosts" field. This makes it unsuitable for
websites. For more information see the Baseline Requirements for the Issuance and Management
of Publicly-Trusted Certificates, v.1.1.6, from the CA/Browser Forum (https://cabforum.org);
specifically, section 10.2.3 ("Information Requirements").
```

```shell
ls -la ./admin*
```
```log
-rw-r--r-- 1 localusername localusername 1033 дек 21 22:01 ./admin.csr
-rw-rw-r-- 1 localusername localusername  231 дек 21 22:01 ./admin-csr.json
-rw------- 1 localusername localusername 1675 дек 21 22:01 ./admin-key.pem
-rw-rw-r-- 1 localusername localusername 1428 дек 21 22:01 ./admin.pem
```

Results:
```
admin-key.pem
admin.pem
```

##### The Kubelet Client Certificates

Kubernetes uses a special-purpose authorization mode called Node Authorizer, that specifically authorizes API requests made by Kubelets. In order to be authorized by the Node Authorizer, Kubelets must use a credential that identifies them as being in the system:nodes group, with a username of system:node:<nodeName>. In this section you will create a certificate for each Kubernetes worker node that meets the Node Authorizer requirements.

Generate a certificate and private key for each Kubernetes worker node:
```shell
for instance in worker-0 worker-1 worker-2; do
cat > ${instance}-csr.json <<EOF
{
  "CN": "system:node:${instance}",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "US",
      "L": "Portland",
      "O": "system:nodes",
      "OU": "Kubernetes The Hard Way",
      "ST": "Oregon"
    }
  ]
}
EOF

EXTERNAL_IP=$(gcloud compute instances describe ${instance} \
  --format 'value(networkInterfaces[0].accessConfigs[0].natIP)')

INTERNAL_IP=$(gcloud compute instances describe ${instance} \
  --format 'value(networkInterfaces[0].networkIP)')

cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca-config.json \
  -hostname=${instance},${EXTERNAL_IP},${INTERNAL_IP} \
  -profile=kubernetes \
  ${instance}-csr.json | cfssljson -bare ${instance}
done
```
```log
2019/12/21 22:04:39 [INFO] generate received request
2019/12/21 22:04:39 [INFO] received CSR
2019/12/21 22:04:39 [INFO] generating key: rsa-2048
2019/12/21 22:04:39 [INFO] encoded CSR
2019/12/21 22:04:39 [INFO] signed certificate with serial number 646921721206508068771935468926679050944095323998
2019/12/21 22:04:40 [INFO] generate received request
2019/12/21 22:04:40 [INFO] received CSR
2019/12/21 22:04:40 [INFO] generating key: rsa-2048
2019/12/21 22:04:40 [INFO] encoded CSR
2019/12/21 22:04:40 [INFO] signed certificate with serial number 661902976827002159863412853114492091268446513250
2019/12/21 22:04:42 [INFO] generate received request
2019/12/21 22:04:42 [INFO] received CSR
2019/12/21 22:04:42 [INFO] generating key: rsa-2048
2019/12/21 22:04:42 [INFO] encoded CSR
2019/12/21 22:04:42 [INFO] signed certificate with serial number 589441125089766689419063844893527457787063213490
```

```shell
ls -la ./worker-*
```
```log
-rw-r--r-- 1 localusername localusername 1119 дек 21 22:04 ./worker-0.csr
-rw-rw-r-- 1 localusername localusername  244 дек 21 22:04 ./worker-0-csr.json
-rw------- 1 localusername localusername 1675 дек 21 22:04 ./worker-0-key.pem
-rw-rw-r-- 1 localusername localusername 1493 дек 21 22:04 ./worker-0.pem
-rw-r--r-- 1 localusername localusername 1119 дек 21 22:04 ./worker-1.csr
-rw-rw-r-- 1 localusername localusername  244 дек 21 22:04 ./worker-1-csr.json
-rw------- 1 localusername localusername 1679 дек 21 22:04 ./worker-1-key.pem
-rw-rw-r-- 1 localusername localusername 1493 дек 21 22:04 ./worker-1.pem
-rw-r--r-- 1 localusername localusername 1119 дек 21 22:04 ./worker-2.csr
-rw-rw-r-- 1 localusername localusername  244 дек 21 22:04 ./worker-2-csr.json
-rw------- 1 localusername localusername 1675 дек 21 22:04 ./worker-2-key.pem
-rw-rw-r-- 1 localusername localusername 1493 дек 21 22:04 ./worker-2.pem
```

Results:
```
worker-0-key.pem
worker-0.pem
worker-1-key.pem
worker-1.pem
worker-2-key.pem
worker-2.pem
```

##### The Controller Manager Client Certificate

Generate the kube-controller-manager client certificate and private key:

```shell
{

cat > kube-controller-manager-csr.json <<EOF
{
  "CN": "system:kube-controller-manager",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "US",
      "L": "Portland",
      "O": "system:kube-controller-manager",
      "OU": "Kubernetes The Hard Way",
      "ST": "Oregon"
    }
  ]
}
EOF

cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca-config.json \
  -profile=kubernetes \
  kube-controller-manager-csr.json | cfssljson -bare kube-controller-manager

}
```
```log
2019/12/21 22:08:07 [INFO] generate received request
2019/12/21 22:08:07 [INFO] received CSR
2019/12/21 22:08:07 [INFO] generating key: rsa-2048
2019/12/21 22:08:07 [INFO] encoded CSR
2019/12/21 22:08:07 [INFO] signed certificate with serial number 282100416808483075061927568693274269806490431363
2019/12/21 22:08:07 [WARNING] This certificate lacks a "hosts" field. This makes it unsuitable for
websites. For more information see the Baseline Requirements for the Issuance and Management
of Publicly-Trusted Certificates, v.1.1.6, from the CA/Browser Forum (https://cabforum.org);
specifically, section 10.2.3 ("Information Requirements").
```

```shell
ls -la ./kube-controller-manager*
```
```log
-rw-r--r-- 1 localusername localusername 1090 дек 21 22:08 ./kube-controller-manager.csr
-rw-rw-r-- 1 localusername localusername  272 дек 21 22:08 ./kube-controller-manager-csr.json
-rw------- 1 localusername localusername 1675 дек 21 22:08 ./kube-controller-manager-key.pem
-rw-rw-r-- 1 localusername localusername 1484 дек 21 22:08 ./kube-controller-manager.pem
```

Results:
```
kube-controller-manager-key.pem
kube-controller-manager.pem
```

##### The Kube Proxy Client Certificate

Generate the kube-proxy client certificate and private key:

```shell
{

cat > kube-proxy-csr.json <<EOF
{
  "CN": "system:kube-proxy",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "US",
      "L": "Portland",
      "O": "system:node-proxier",
      "OU": "Kubernetes The Hard Way",
      "ST": "Oregon"
    }
  ]
}
EOF

cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca-config.json \
  -profile=kubernetes \
  kube-proxy-csr.json | cfssljson -bare kube-proxy

}
```
```log
2019/12/21 22:10:48 [INFO] generate received request
2019/12/21 22:10:48 [INFO] received CSR
2019/12/21 22:10:48 [INFO] generating key: rsa-2048
2019/12/21 22:10:48 [INFO] encoded CSR
2019/12/21 22:10:48 [INFO] signed certificate with serial number 699245214187098074937861857695356970369268578588
2019/12/21 22:10:48 [WARNING] This certificate lacks a "hosts" field. This makes it unsuitable for
websites. For more information see the Baseline Requirements for the Issuance and Management
of Publicly-Trusted Certificates, v.1.1.6, from the CA/Browser Forum (https://cabforum.org);
specifically, section 10.2.3 ("Information Requirements").
```

```shell
ls -la ./kube-proxy*
```
```log
-rw-r--r-- 1 localusername localusername 1058 дек 21 22:10 ./kube-proxy.csr
-rw-rw-r-- 1 localusername localusername  248 дек 21 22:10 ./kube-proxy-csr.json
-rw------- 1 localusername localusername 1675 дек 21 22:10 ./kube-proxy-key.pem
-rw-rw-r-- 1 localusername localusername 1452 дек 21 22:10 ./kube-proxy.pem
```

Results:
```
kube-proxy-key.pem
kube-proxy.pem
```

##### The Scheduler Client Certificate

Generate the kube-scheduler client certificate and private key:

```shell
{

cat > kube-scheduler-csr.json <<EOF
{
  "CN": "system:kube-scheduler",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "US",
      "L": "Portland",
      "O": "system:kube-scheduler",
      "OU": "Kubernetes The Hard Way",
      "ST": "Oregon"
    }
  ]
}
EOF

cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca-config.json \
  -profile=kubernetes \
  kube-scheduler-csr.json | cfssljson -bare kube-scheduler

}
```
```log
2019/12/21 22:14:27 [INFO] generate received request
2019/12/21 22:14:27 [INFO] received CSR
2019/12/21 22:14:27 [INFO] generating key: rsa-2048
2019/12/21 22:14:27 [INFO] encoded CSR
2019/12/21 22:14:27 [INFO] signed certificate with serial number 87364666028936239744069931957549193072914873388
2019/12/21 22:14:27 [WARNING] This certificate lacks a "hosts" field. This makes it unsuitable for
websites. For more information see the Baseline Requirements for the Issuance and Management
of Publicly-Trusted Certificates, v.1.1.6, from the CA/Browser Forum (https://cabforum.org);
specifically, section 10.2.3 ("Information Requirements").
```

```shell
ls -la ./kube-scheduler*
```
```log
-rw-r--r-- 1 localusername localusername 1066 дек 21 22:14 ./kube-scheduler.csr
-rw-rw-r-- 1 localusername localusername  254 дек 21 22:14 ./kube-scheduler-csr.json
-rw------- 1 localusername localusername 1675 дек 21 22:14 ./kube-scheduler-key.pem
-rw-rw-r-- 1 localusername localusername 1460 дек 21 22:14 ./kube-scheduler.pem
```

Results:
```
kube-scheduler-key.pem
kube-scheduler.pem
```

##### The Kubernetes API Server Certificate

The kubernetes-the-hard-way static IP address will be included in the list of subject alternative names for the Kubernetes API Server certificate. This will ensure the certificate can be validated by remote clients.

Generate the Kubernetes API Server certificate and private key:

```shell
{

KUBERNETES_PUBLIC_ADDRESS=$(gcloud compute addresses describe kubernetes-the-hard-way \
  --region $(gcloud config get-value compute/region) \
  --format 'value(address)')

KUBERNETES_HOSTNAMES=kubernetes,kubernetes.default,kubernetes.default.svc,kubernetes.default.svc.cluster,kubernetes.svc.cluster.local

cat > kubernetes-csr.json <<EOF
{
  "CN": "kubernetes",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "US",
      "L": "Portland",
      "O": "Kubernetes",
      "OU": "Kubernetes The Hard Way",
      "ST": "Oregon"
    }
  ]
}
EOF

cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca-config.json \
  -hostname=10.32.0.1,10.240.0.10,10.240.0.11,10.240.0.12,${KUBERNETES_PUBLIC_ADDRESS},127.0.0.1,${KUBERNETES_HOSTNAMES} \
  -profile=kubernetes \
  kubernetes-csr.json | cfssljson -bare kubernetes

}
```
```log
Your active configuration is: [otus-devops-docker]
2019/12/21 22:22:44 [INFO] generate received request
2019/12/21 22:22:44 [INFO] received CSR
2019/12/21 22:22:44 [INFO] generating key: rsa-2048
2019/12/21 22:22:44 [INFO] encoded CSR
2019/12/21 22:22:44 [INFO] signed certificate with serial number 690224727919982074800003085081049019466554903078
```

```shell
ls -la ./kubernetes*
```
```log
-rw-r--r-- 1 localusername localusername 1289 дек 21 22:22 ./kubernetes.csr
-rw-rw-r-- 1 localusername localusername  232 дек 21 22:22 ./kubernetes-csr.json
-rw------- 1 localusername localusername 1675 дек 21 22:22 ./kubernetes-key.pem
-rw-rw-r-- 1 localusername localusername 1663 дек 21 22:22 ./kubernetes.pem
```

> The Kubernetes API server is automatically assigned the kubernetes internal dns name, which will be linked to the first IP address (10.32.0.1) from the address range (10.32.0.0/24) reserved for internal cluster services during the control plane bootstrapping lab.

Results:
```
kubernetes-key.pem
kubernetes.pem
```

##### The Service Account Key Pair

The Kubernetes Controller Manager leverages a key pair to generate and sign service account tokens as described in the managing service accounts documentation.

Generate the service-account certificate and private key:

```shell
{

cat > service-account-csr.json <<EOF
{
  "CN": "service-accounts",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "US",
      "L": "Portland",
      "O": "Kubernetes",
      "OU": "Kubernetes The Hard Way",
      "ST": "Oregon"
    }
  ]
}
EOF

cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca-config.json \
  -profile=kubernetes \
  service-account-csr.json | cfssljson -bare service-account

}
```
```log
2019/12/21 22:26:50 [INFO] generate received request
2019/12/21 22:26:50 [INFO] received CSR
2019/12/21 22:26:50 [INFO] generating key: rsa-2048
2019/12/21 22:26:50 [INFO] encoded CSR
2019/12/21 22:26:50 [INFO] signed certificate with serial number 238519584149307287413523200683862818087111882082
2019/12/21 22:26:50 [WARNING] This certificate lacks a "hosts" field. This makes it unsuitable for
websites. For more information see the Baseline Requirements for the Issuance and Management
of Publicly-Trusted Certificates, v.1.1.6, from the CA/Browser Forum (https://cabforum.org);
specifically, section 10.2.3 ("Information Requirements").
```

```shell
ls -la ./service-account*
```
```log
-rw-r--r-- 1 localusername localusername 1041 дек 21 22:26 ./service-account.csr
-rw-rw-r-- 1 localusername localusername  238 дек 21 22:26 ./service-account-csr.json
-rw------- 1 localusername localusername 1679 дек 21 22:26 ./service-account-key.pem
-rw-rw-r-- 1 localusername localusername 1440 дек 21 22:26 ./service-account.pem
```

Results:
```
service-account-key.pem
service-account.pem
```

##### Distribute the Client and Server Certificates

Copy the appropriate certificates and private keys to each worker instance:

```shell
for instance in worker-0 worker-1 worker-2; do
  gcloud compute scp ca.pem ${instance}-key.pem ${instance}.pem ${instance}:~/
done
```
```log
Warning: Permanently added 'compute.378179509067968951' (ECDSA) to the list of known hosts.
ca.pem                                                                                                                             100% 1318     7.3KB/s   00:00    
worker-0-key.pem                                                                                                                   100% 1675     9.3KB/s   00:00    
worker-0.pem                                                                                                                       100% 1493     8.3KB/s   00:00    
Warning: Permanently added 'compute.2569981674759909813' (ECDSA) to the list of known hosts.
ca.pem                                                                                                                             100% 1318     7.0KB/s   00:00    
worker-1-key.pem                                                                                                                   100% 1679     9.0KB/s   00:00    
worker-1.pem                                                                                                                       100% 1493     8.0KB/s   00:00    
Warning: Permanently added 'compute.5185505402406826419' (ECDSA) to the list of known hosts.
ca.pem                                                                                                                             100% 1318     7.3KB/s   00:00    
worker-2-key.pem                                                                                                                   100% 1675     9.3KB/s   00:00    
worker-2.pem                                                                                                                       100% 1493     8.3KB/s   00:00
```

Copy the appropriate certificates and private keys to each controller instance:

```shell
for instance in controller-0 controller-1 controller-2; do
  gcloud compute scp ca.pem ca-key.pem kubernetes-key.pem kubernetes.pem \
    service-account-key.pem service-account.pem ${instance}:~/
done
```
```log
ca.pem                                                                                                                             100% 1318     7.2KB/s   00:00    
ca-key.pem                                                                                                                         100% 1679     9.2KB/s   00:00    
kubernetes-key.pem                                                                                                                 100% 1675     9.1KB/s   00:00    
kubernetes.pem                                                                                                                     100% 1663     9.1KB/s   00:00    
service-account-key.pem                                                                                                            100% 1679     9.2KB/s   00:00    
service-account.pem                                                                                                                100% 1440     7.9KB/s   00:00    
Warning: Permanently added 'compute.1676217272728023772' (ECDSA) to the list of known hosts.
ca.pem                                                                                                                             100% 1318     7.2KB/s   00:00    
ca-key.pem                                                                                                                         100% 1679     9.2KB/s   00:00    
kubernetes-key.pem                                                                                                                 100% 1675     9.1KB/s   00:00    
kubernetes.pem                                                                                                                     100% 1663     2.9KB/s   00:00    
service-account-key.pem                                                                                                            100% 1679     9.2KB/s   00:00    
service-account.pem                                                                                                                100% 1440     7.9KB/s   00:00    
Warning: Permanently added 'compute.1715075053035713242' (ECDSA) to the list of known hosts.
ca.pem                                                                                                                             100% 1318     7.1KB/s   00:00    
ca-key.pem                                                                                                                         100% 1679     9.0KB/s   00:00    
kubernetes-key.pem                                                                                                                 100% 1675     9.0KB/s   00:00    
kubernetes.pem                                                                                                                     100% 1663     8.9KB/s   00:00    
service-account-key.pem                                                                                                            100% 1679     9.0KB/s   00:00    
service-account.pem                                                                                                                100% 1440     7.7KB/s   00:00
```

> The kube-proxy, kube-controller-manager, kube-scheduler, and kubelet client certificates will be used to generate client authentication configuration files in the next lab.


### Generating Kubernetes Configuration Files for Authentication

#### Client Authentication Configs

In this section you will generate kubeconfig files for the controller manager, kubelet, kube-proxy, and scheduler clients and the admin user.

##### Kubernetes Public IP Address

Each kubeconfig requires a Kubernetes API Server to connect to. To support high availability the IP address assigned to the external load balancer fronting the Kubernetes API Servers will be used.

Retrieve the kubernetes-the-hard-way static IP address:

```shell
KUBERNETES_PUBLIC_ADDRESS=$(gcloud compute addresses describe kubernetes-the-hard-way \
  --region $(gcloud config get-value compute/region) \
  --format 'value(address)')
```
```shell
echo $KUBERNETES_PUBLIC_ADDRESS 
```
```log
35.199.170.187
```

##### The kubelet Kubernetes Configuration File

When generating kubeconfig files for Kubelets the client certificate matching the Kubelet's node name must be used. This will ensure Kubelets are properly authorized by the Kubernetes Node Authorizer.

> The following commands must be run in the same directory used to generate the SSL certificates during the Generating TLS Certificates lab.

Generate a kubeconfig file for each worker node:

```shell
for instance in worker-0 worker-1 worker-2; do
  kubectl config set-cluster kubernetes-the-hard-way \
    --certificate-authority=ca.pem \
    --embed-certs=true \
    --server=https://${KUBERNETES_PUBLIC_ADDRESS}:6443 \
    --kubeconfig=${instance}.kubeconfig

  kubectl config set-credentials system:node:${instance} \
    --client-certificate=${instance}.pem \
    --client-key=${instance}-key.pem \
    --embed-certs=true \
    --kubeconfig=${instance}.kubeconfig

  kubectl config set-context default \
    --cluster=kubernetes-the-hard-way \
    --user=system:node:${instance} \
    --kubeconfig=${instance}.kubeconfig

  kubectl config use-context default --kubeconfig=${instance}.kubeconfig
done
```
```log
Cluster "kubernetes-the-hard-way" set.
User "system:node:worker-0" set.
Context "default" created.
Switched to context "default".
Cluster "kubernetes-the-hard-way" set.
User "system:node:worker-1" set.
Context "default" created.
Switched to context "default".
Cluster "kubernetes-the-hard-way" set.
User "system:node:worker-2" set.
Context "default" created.
Switched to context "default".
```

```shell
ls -la ./worker-*.kubeconfig
```
```log
-rw------- 1 localusername localusername 6384 дек 21 22:40 ./worker-0.kubeconfig
-rw------- 1 localusername localusername 6388 дек 21 22:40 ./worker-1.kubeconfig
-rw------- 1 localusername localusername 6384 дек 21 22:40 ./worker-2.kubeconfig
```

##### The kube-proxy Kubernetes Configuration File

Generate a kubeconfig file for the kube-proxy service:

```shell
{
  kubectl config set-cluster kubernetes-the-hard-way \
    --certificate-authority=ca.pem \
    --embed-certs=true \
    --server=https://${KUBERNETES_PUBLIC_ADDRESS}:6443 \
    --kubeconfig=kube-proxy.kubeconfig

  kubectl config set-credentials system:kube-proxy \
    --client-certificate=kube-proxy.pem \
    --client-key=kube-proxy-key.pem \
    --embed-certs=true \
    --kubeconfig=kube-proxy.kubeconfig

  kubectl config set-context default \
    --cluster=kubernetes-the-hard-way \
    --user=system:kube-proxy \
    --kubeconfig=kube-proxy.kubeconfig

  kubectl config use-context default --kubeconfig=kube-proxy.kubeconfig
}
```
```log
Cluster "kubernetes-the-hard-way" set.
User "system:kube-proxy" set.
Context "default" created.
Switched to context "default".
```

```shell
ls -la ./kube-proxy.kubeconfig
```
```log
-rw------- 1 localusername localusername 6322 дек 21 22:42 ./kube-proxy.kubeconfig
```

Results:
```
kube-proxy.kubeconfig
```

##### The kube-controller-manager Kubernetes Configuration File

Generate a kubeconfig file for the kube-controller-manager service:

```shell
{
  kubectl config set-cluster kubernetes-the-hard-way \
    --certificate-authority=ca.pem \
    --embed-certs=true \
    --server=https://127.0.0.1:6443 \
    --kubeconfig=kube-controller-manager.kubeconfig

  kubectl config set-credentials system:kube-controller-manager \
    --client-certificate=kube-controller-manager.pem \
    --client-key=kube-controller-manager-key.pem \
    --embed-certs=true \
    --kubeconfig=kube-controller-manager.kubeconfig

  kubectl config set-context default \
    --cluster=kubernetes-the-hard-way \
    --user=system:kube-controller-manager \
    --kubeconfig=kube-controller-manager.kubeconfig

  kubectl config use-context default --kubeconfig=kube-controller-manager.kubeconfig
}
```
```log
Cluster "kubernetes-the-hard-way" set.
User "system:kube-controller-manager" set.
Context "default" created.
Switched to context "default".
```

```shell
ls -la kube-controller-manager.kubeconfig
```
```log
-rw------- 1 localusername localusername 6387 дек 21 22:44 kube-controller-manager.kubeconfig
```

Results:
```
kube-controller-manager.kubeconfig
```

##### The kube-scheduler Kubernetes Configuration File

Generate a kubeconfig file for the kube-scheduler service:

```shell
{
  kubectl config set-cluster kubernetes-the-hard-way \
    --certificate-authority=ca.pem \
    --embed-certs=true \
    --server=https://127.0.0.1:6443 \
    --kubeconfig=kube-scheduler.kubeconfig

  kubectl config set-credentials system:kube-scheduler \
    --client-certificate=kube-scheduler.pem \
    --client-key=kube-scheduler-key.pem \
    --embed-certs=true \
    --kubeconfig=kube-scheduler.kubeconfig

  kubectl config set-context default \
    --cluster=kubernetes-the-hard-way \
    --user=system:kube-scheduler \
    --kubeconfig=kube-scheduler.kubeconfig

  kubectl config use-context default --kubeconfig=kube-scheduler.kubeconfig
}
```
```log
Cluster "kubernetes-the-hard-way" set.
User "system:kube-scheduler" set.
Context "default" created.
Switched to context "default".
```

Results:
```
kube-scheduler.kubeconfig
```

##### The admin Kubernetes Configuration File

Generate a kubeconfig file for the admin user:

```shell
{
  kubectl config set-cluster kubernetes-the-hard-way \
    --certificate-authority=ca.pem \
    --embed-certs=true \
    --server=https://127.0.0.1:6443 \
    --kubeconfig=admin.kubeconfig

  kubectl config set-credentials admin \
    --client-certificate=admin.pem \
    --client-key=admin-key.pem \
    --embed-certs=true \
    --kubeconfig=admin.kubeconfig

  kubectl config set-context default \
    --cluster=kubernetes-the-hard-way \
    --user=admin \
    --kubeconfig=admin.kubeconfig

  kubectl config use-context default --kubeconfig=admin.kubeconfig
}
```
```log
Cluster "kubernetes-the-hard-way" set.
User "admin" set.
Context "default" created.
Switched to context "default".
```

```shell
ls -la admin.kubeconfig 
```
```log
-rw------- 1 localusername localusername 6261 дек 21 22:46 admin.kubeconfig
```

Results:
```
admin.kubeconfig
```

##### Distribute the Kubernetes Configuration Files

Copy the appropriate kubelet and kube-proxy kubeconfig files to each worker instance:

```shell
for instance in worker-0 worker-1 worker-2; do
  gcloud compute scp ${instance}.kubeconfig kube-proxy.kubeconfig ${instance}:~/
done
```
```log
worker-0.kubeconfig                                                                                                                100% 6384    34.3KB/s   00:00    
kube-proxy.kubeconfig                                                                                                              100% 6322    34.0KB/s   00:00    
worker-1.kubeconfig                                                                                                                100% 6388    35.2KB/s   00:00    
kube-proxy.kubeconfig                                                                                                              100% 6322    35.0KB/s   00:00    
worker-2.kubeconfig                                                                                                                100% 6384    32.9KB/s   00:00    
kube-proxy.kubeconfig                                                                                                              100% 6322    33.9KB/s   00:00
```

Copy the appropriate kube-controller-manager and kube-scheduler kubeconfig files to each controller instance:

```shell
for instance in controller-0 controller-1 controller-2; do
  gcloud compute scp admin.kubeconfig kube-controller-manager.kubeconfig kube-scheduler.kubeconfig ${instance}:~/
done
```
```log
admin.kubeconfig                                                                                                                   100% 6261    34.9KB/s   00:00    
kube-controller-manager.kubeconfig                                                                                                 100% 6387    35.6KB/s   00:00    
kube-scheduler.kubeconfig                                                                                                          100% 6337    35.3KB/s   00:00    
admin.kubeconfig                                                                                                                   100% 6261    33.7KB/s   00:00    
kube-controller-manager.kubeconfig                                                                                                 100% 6387    34.3KB/s   00:00    
kube-scheduler.kubeconfig                                                                                                          100% 6337    34.1KB/s   00:00    
admin.kubeconfig                                                                                                                   100% 6261    34.0KB/s   00:00    
kube-controller-manager.kubeconfig                                                                                                 100% 6387    34.7KB/s   00:00    
kube-scheduler.kubeconfig                                                                                                          100% 6337    34.5KB/s   00:00
```


### Generating the Data Encryption Config and Key

Kubernetes stores a variety of data including cluster state, application configurations, and secrets. Kubernetes supports the ability to encrypt cluster data at rest.

In this lab you will generate an encryption key and an encryption config suitable for encrypting Kubernetes Secrets.

#### The Encryption Key

Generate an encryption key:
```shell
ENCRYPTION_KEY=$(head -c 32 /dev/urandom | base64)
```

#### The Encryption Config File

Create the encryption-config.yaml encryption config file:

```shell
cat > encryption-config.yaml <<EOF
kind: EncryptionConfig
apiVersion: v1
resources:
  - resources:
      - secrets
    providers:
      - aescbc:
          keys:
            - name: key1
              secret: ${ENCRYPTION_KEY}
      - identity: {}
EOF
```
```shell
ls -la encryption-config.yaml 
```
```log
-rw-rw-r-- 1 localusername localusername 240 дек 21 22:50 encryption-config.yaml
```

Copy the encryption-config.yaml encryption config file to each controller instance:

```shell
for instance in controller-0 controller-1 controller-2; do
  gcloud compute scp encryption-config.yaml ${instance}:~/
done
```
```log
encryption-config.yaml                                                                                                             100%  240     1.3KB/s   00:00    
encryption-config.yaml                                                                                                             100%  240     1.3KB/s   00:00    
encryption-config.yaml                                                                                                             100%  240     1.3KB/s   00:00
```


### Bootstrapping the etcd Cluster

#### Prerequisites

The commands in this lab must be run on each controller instance: controller-0, controller-1, and controller-2. Login to each controller instance using the gcloud command. Example:
```shell
gcloud compute ssh controller-0
```

#### Running commands in parallel with tmux

https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/01-prerequisites.md#running-commands-in-parallel-with-tmux

Enable synchronize-panes by pressing `ctrl+b` followed by `shift+:`. Next type `set synchronize-panes on` at the prompt. To disable synchronization: `set synchronize-panes off`.

#### Bootstrapping an etcd Cluster Member

##### Download and Install the etcd Binaries

Download the official etcd release binaries from the etcd GitHub project:

```shell
wget -q --show-progress --https-only --timestamping \
  "https://github.com/etcd-io/etcd/releases/download/v3.4.0/etcd-v3.4.0-linux-amd64.tar.gz"
```

Extract and install the etcd server and the etcdctl command line utility:

```shell
{
  tar -xvf etcd-v3.4.0-linux-amd64.tar.gz
  sudo mv etcd-v3.4.0-linux-amd64/etcd* /usr/local/bin/
}
```

##### Configure the etcd Server

```shell
{
  sudo mkdir -p /etc/etcd /var/lib/etcd
  sudo cp ca.pem kubernetes-key.pem kubernetes.pem /etc/etcd/
}
```

The instance internal IP address will be used to serve client requests and communicate with etcd cluster peers. Retrieve the internal IP address for the current compute instance:

```shell
INTERNAL_IP=$(curl -s -H "Metadata-Flavor: Google" \
  http://metadata.google.internal/computeMetadata/v1/instance/network-interfaces/0/ip)
```

Each etcd member must have a unique name within an etcd cluster. Set the etcd name to match the hostname of the current compute instance:

```shell
ETCD_NAME=$(hostname -s)
```

Create the etcd.service systemd unit file:

```shell
cat <<EOF | sudo tee /etc/systemd/system/etcd.service
[Unit]
Description=etcd
Documentation=https://github.com/coreos

[Service]
Type=notify
ExecStart=/usr/local/bin/etcd \\
  --name ${ETCD_NAME} \\
  --cert-file=/etc/etcd/kubernetes.pem \\
  --key-file=/etc/etcd/kubernetes-key.pem \\
  --peer-cert-file=/etc/etcd/kubernetes.pem \\
  --peer-key-file=/etc/etcd/kubernetes-key.pem \\
  --trusted-ca-file=/etc/etcd/ca.pem \\
  --peer-trusted-ca-file=/etc/etcd/ca.pem \\
  --peer-client-cert-auth \\
  --client-cert-auth \\
  --initial-advertise-peer-urls https://${INTERNAL_IP}:2380 \\
  --listen-peer-urls https://${INTERNAL_IP}:2380 \\
  --listen-client-urls https://${INTERNAL_IP}:2379,https://127.0.0.1:2379 \\
  --advertise-client-urls https://${INTERNAL_IP}:2379 \\
  --initial-cluster-token etcd-cluster-0 \\
  --initial-cluster controller-0=https://10.240.0.10:2380,controller-1=https://10.240.0.11:2380,controller-2=https://10.240.0.12:2380 \\
  --initial-cluster-state new \\
  --data-dir=/var/lib/etcd
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF
```

Start the etcd Server

```shell
{
  sudo systemctl daemon-reload
  sudo systemctl enable etcd
  sudo systemctl start etcd
}
```


#### Verification

List the etcd cluster members:

```shell
sudo ETCDCTL_API=3 etcdctl member list \
  --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/etcd/ca.pem \
  --cert=/etc/etcd/kubernetes.pem \
  --key=/etc/etcd/kubernetes-key.pem
```
```log
3a57933972cb5131, started, controller-2, https://10.240.0.12:2380, https://10.240.0.12:2379, false
f98dc20bce6225a0, started, controller-0, https://10.240.0.10:2380, https://10.240.0.10:2379, false
ffed16798470cab5, started, controller-1, https://10.240.0.11:2380, https://10.240.0.11:2379, false
```


### Bootstrapping the Kubernetes Control Plane

In this lab you will bootstrap the Kubernetes control plane across three compute instances and configure it for high availability. You will also create an external load balancer that exposes the Kubernetes API Servers to remote clients. The following components will be installed on each node: Kubernetes API Server, Scheduler, and Controller Manager.+

#### Prerequisites

The commands in this lab must be run on each controller instance: controller-0, controller-1, and controller-2. Login to each controller instance using the gcloud command. Example:
```shell
gcloud compute ssh controller-0
```

#### Provision the Kubernetes Control Plane

Create the Kubernetes configuration directory:

```shell
sudo mkdir -p /etc/kubernetes/config
```

#### Download and Install the Kubernetes Controller Binaries

```shell
# Download the official Kubernetes release binaries:
wget -q --show-progress --https-only --timestamping \
  "https://storage.googleapis.com/kubernetes-release/release/v1.15.3/bin/linux/amd64/kube-apiserver" \
  "https://storage.googleapis.com/kubernetes-release/release/v1.15.3/bin/linux/amd64/kube-controller-manager" \
  "https://storage.googleapis.com/kubernetes-release/release/v1.15.3/bin/linux/amd64/kube-scheduler" \
  "https://storage.googleapis.com/kubernetes-release/release/v1.15.3/bin/linux/amd64/kubectl"

# Install the Kubernetes binaries:
{
  chmod +x kube-apiserver kube-controller-manager kube-scheduler kubectl
  sudo mv kube-apiserver kube-controller-manager kube-scheduler kubectl /usr/local/bin/
}
```

#### Configure the Kubernetes API Server

```shell
{
  sudo mkdir -p /var/lib/kubernetes/

  sudo mv ca.pem ca-key.pem kubernetes-key.pem kubernetes.pem \
    service-account-key.pem service-account.pem \
    encryption-config.yaml /var/lib/kubernetes/
}
# The instance internal IP address will be used to advertise the API Server to members of the cluster. Retrieve the internal IP address for the current compute instance:
INTERNAL_IP=$(curl -s -H "Metadata-Flavor: Google" \
  http://metadata.google.internal/computeMetadata/v1/instance/network-interfaces/0/ip)

# Create the kube-apiserver.service systemd unit file:
cat <<EOF | sudo tee /etc/systemd/system/kube-apiserver.service
[Unit]
Description=Kubernetes API Server
Documentation=https://github.com/kubernetes/kubernetes

[Service]
ExecStart=/usr/local/bin/kube-apiserver \\
  --advertise-address=${INTERNAL_IP} \\
  --allow-privileged=true \\
  --apiserver-count=3 \\
  --audit-log-maxage=30 \\
  --audit-log-maxbackup=3 \\
  --audit-log-maxsize=100 \\
  --audit-log-path=/var/log/audit.log \\
  --authorization-mode=Node,RBAC \\
  --bind-address=0.0.0.0 \\
  --client-ca-file=/var/lib/kubernetes/ca.pem \\
  --enable-admission-plugins=NamespaceLifecycle,NodeRestriction,LimitRanger,ServiceAccount,DefaultStorageClass,ResourceQuota \\
  --etcd-cafile=/var/lib/kubernetes/ca.pem \\
  --etcd-certfile=/var/lib/kubernetes/kubernetes.pem \\
  --etcd-keyfile=/var/lib/kubernetes/kubernetes-key.pem \\
  --etcd-servers=https://10.240.0.10:2379,https://10.240.0.11:2379,https://10.240.0.12:2379 \\
  --event-ttl=1h \\
  --encryption-provider-config=/var/lib/kubernetes/encryption-config.yaml \\
  --kubelet-certificate-authority=/var/lib/kubernetes/ca.pem \\
  --kubelet-client-certificate=/var/lib/kubernetes/kubernetes.pem \\
  --kubelet-client-key=/var/lib/kubernetes/kubernetes-key.pem \\
  --kubelet-https=true \\
  --runtime-config=api/all \\
  --service-account-key-file=/var/lib/kubernetes/service-account.pem \\
  --service-cluster-ip-range=10.32.0.0/24 \\
  --service-node-port-range=30000-32767 \\
  --tls-cert-file=/var/lib/kubernetes/kubernetes.pem \\
  --tls-private-key-file=/var/lib/kubernetes/kubernetes-key.pem \\
  --v=2
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF
```

#### Configure the Kubernetes Controller Manager

```shell
# Move the kube-controller-manager kubeconfig into place:
sudo mv kube-controller-manager.kubeconfig /var/lib/kubernetes/

# Create the kube-controller-manager.service systemd unit file:
cat <<EOF | sudo tee /etc/systemd/system/kube-controller-manager.service
[Unit]
Description=Kubernetes Controller Manager
Documentation=https://github.com/kubernetes/kubernetes

[Service]
ExecStart=/usr/local/bin/kube-controller-manager \\
  --address=0.0.0.0 \\
  --cluster-cidr=10.200.0.0/16 \\
  --cluster-name=kubernetes \\
  --cluster-signing-cert-file=/var/lib/kubernetes/ca.pem \\
  --cluster-signing-key-file=/var/lib/kubernetes/ca-key.pem \\
  --kubeconfig=/var/lib/kubernetes/kube-controller-manager.kubeconfig \\
  --leader-elect=true \\
  --root-ca-file=/var/lib/kubernetes/ca.pem \\
  --service-account-private-key-file=/var/lib/kubernetes/service-account-key.pem \\
  --service-cluster-ip-range=10.32.0.0/24 \\
  --use-service-account-credentials=true \\
  --v=2
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF
```

#### Configure the Kubernetes Scheduler

```shell
# Move the kube-scheduler kubeconfig into place:
sudo mv kube-scheduler.kubeconfig /var/lib/kubernetes/

# Create the kube-scheduler.yaml configuration file:
cat <<EOF | sudo tee /etc/kubernetes/config/kube-scheduler.yaml
apiVersion: kubescheduler.config.k8s.io/v1alpha1
kind: KubeSchedulerConfiguration
clientConnection:
  kubeconfig: "/var/lib/kubernetes/kube-scheduler.kubeconfig"
leaderElection:
  leaderElect: true
EOF

# Create the kube-scheduler.service systemd unit file:
cat <<EOF | sudo tee /etc/systemd/system/kube-scheduler.service
[Unit]
Description=Kubernetes Scheduler
Documentation=https://github.com/kubernetes/kubernetes

[Service]
ExecStart=/usr/local/bin/kube-scheduler \\
  --config=/etc/kubernetes/config/kube-scheduler.yaml \\
  --v=2
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF
```

#### Start the Controller Services

```shell
{
  sudo systemctl daemon-reload
  sudo systemctl enable kube-apiserver kube-controller-manager kube-scheduler
  sudo systemctl start kube-apiserver kube-controller-manager kube-scheduler
}
```

> Allow up to 10 seconds for the Kubernetes API Server to fully initialize.

#### Enable HTTP Health Checks

A Google Network Load Balancer will be used to distribute traffic across the three API servers and allow each API server to terminate TLS connections and validate client certificates. The network load balancer only supports HTTP health checks which means the HTTPS endpoint exposed by the API server cannot be used. As a workaround the nginx webserver can be used to proxy HTTP health checks. In this section nginx will be installed and configured to accept HTTP health checks on port 80 and proxy the connections to the API server on https://127.0.0.1:6443/healthz.

> The /healthz API server endpoint does not require authentication by default.

```shell
sudo apt-get update
sudo apt-get install -y nginx
```
```shell
cat > kubernetes.default.svc.cluster.local <<EOF
server {
  listen      80;
  server_name kubernetes.default.svc.cluster.local;

  location /healthz {
     proxy_pass                    https://127.0.0.1:6443/healthz;
     proxy_ssl_trusted_certificate /var/lib/kubernetes/ca.pem;
  }
}
EOF
{
  sudo mv kubernetes.default.svc.cluster.local \
    /etc/nginx/sites-available/kubernetes.default.svc.cluster.local

  sudo ln -s /etc/nginx/sites-available/kubernetes.default.svc.cluster.local /etc/nginx/sites-enabled/
}
sudo systemctl restart nginx
sudo systemctl enable nginx
```

#### Verification

```shell
kubectl get componentstatuses --kubeconfig admin.kubeconfig
```
На всех 3х мастерах
```log
NAME                 STATUS    MESSAGE             ERROR
scheduler            Healthy   ok                  
controller-manager   Healthy   ok                  
etcd-2               Healthy   {"health":"true"}   
etcd-1               Healthy   {"health":"true"}   
etcd-0               Healthy   {"health":"true"}
```

Test the nginx HTTP health check proxy:

```shell
curl -H "Host: kubernetes.default.svc.cluster.local" -i http://127.0.0.1/healthz
```
на всех 3х
```log
HTTP/1.1 200 OK
Server: nginx/1.14.0 (Ubuntu)
Date: Sat, 21 Dec 2019 21:21:04 GMT
Content-Type: text/plain; charset=utf-8
Content-Length: 2
Connection: keep-alive
X-Content-Type-Options: nosniff

ok
```

> Remember to run the above commands on each controller node: controller-0, controller-1, and controller-2.

#### RBAC for Kubelet Authorization

In this section you will configure RBAC permissions to allow the Kubernetes API Server to access the Kubelet API on each worker node. Access to the Kubelet API is required for retrieving metrics, logs, and executing commands in pods.

> This tutorial sets the Kubelet --authorization-mode flag to Webhook. Webhook mode uses the SubjectAccessReview API to determine authorization.

The commands in this section will effect the entire cluster and only need to be run once from one of the controller nodes.

```shell
gcloud compute ssh controller-0
```

Create the system:kube-apiserver-to-kubelet ClusterRole with permissions to access the Kubelet API and perform most common tasks associated with managing pods:

```shell
cat <<EOF | kubectl apply --kubeconfig admin.kubeconfig -f -
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRole
metadata:
  annotations:
    rbac.authorization.kubernetes.io/autoupdate: "true"
  labels:
    kubernetes.io/bootstrapping: rbac-defaults
  name: system:kube-apiserver-to-kubelet
rules:
  - apiGroups:
      - ""
    resources:
      - nodes/proxy
      - nodes/stats
      - nodes/log
      - nodes/spec
      - nodes/metrics
    verbs:
      - "*"
EOF
```
```log
clusterrole.rbac.authorization.k8s.io/system:kube-apiserver-to-kubelet created
```

The Kubernetes API Server authenticates to the Kubelet as the kubernetes user using the client certificate as defined by the --kubelet-client-certificate flag.

Bind the system:kube-apiserver-to-kubelet ClusterRole to the kubernetes user:

```shell
cat <<EOF | kubectl apply --kubeconfig admin.kubeconfig -f -
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRoleBinding
metadata:
  name: system:kube-apiserver
  namespace: ""
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: system:kube-apiserver-to-kubelet
subjects:
  - apiGroup: rbac.authorization.k8s.io
    kind: User
    name: kubernetes
EOF
```
```log
clusterrolebinding.rbac.authorization.k8s.io/system:kube-apiserver created
```

#### The Kubernetes Frontend Load Balancer

n this section you will provision an external load balancer to front the Kubernetes API Servers. The kubernetes-the-hard-way static IP address will be attached to the resulting load balancer.

> The compute instances created in this tutorial will not have permission to complete this section. **Run the following commands from the same machine used to create the compute instances.**

##### Provision a Network Load Balancer

Create the external load balancer network resources:

```shell
{
  KUBERNETES_PUBLIC_ADDRESS=$(gcloud compute addresses describe kubernetes-the-hard-way \
    --region $(gcloud config get-value compute/region) \
    --format 'value(address)')

  gcloud compute http-health-checks create kubernetes \
    --description "Kubernetes Health Check" \
    --host "kubernetes.default.svc.cluster.local" \
    --request-path "/healthz"

  gcloud compute firewall-rules create kubernetes-the-hard-way-allow-health-check \
    --network kubernetes-the-hard-way \
    --source-ranges 209.85.152.0/22,209.85.204.0/22,35.191.0.0/16 \
    --allow tcp

  gcloud compute target-pools create kubernetes-target-pool \
    --http-health-check kubernetes

  gcloud compute target-pools add-instances kubernetes-target-pool \
   --instances controller-0,controller-1,controller-2

  gcloud compute forwarding-rules create kubernetes-forwarding-rule \
    --address ${KUBERNETES_PUBLIC_ADDRESS} \
    --ports 6443 \
    --region $(gcloud config get-value compute/region) \
    --target-pool kubernetes-target-pool
}
```
```log
Created [https://www.googleapis.com/compute/v1/projects/<GCP_PROJECT_ID>/global/httpHealthChecks/kubernetes].
NAME        HOST                                  PORT  REQUEST_PATH
kubernetes  kubernetes.default.svc.cluster.local  80    /healthz
Creating firewall...⠶Created [https://www.googleapis.com/compute/v1/projects/<GCP_PROJECT_ID>/global/firewalls/kubernetes-the-hard-way-allow-health-check].                                                                                                             
Creating firewall...done.                                                                                                                                                                                                                                            
NAME                                        NETWORK                  DIRECTION  PRIORITY  ALLOW  DENY  DISABLED
kubernetes-the-hard-way-allow-health-check  kubernetes-the-hard-way  INGRESS    1000      tcp          False
Created [https://www.googleapis.com/compute/v1/projects/<GCP_PROJECT_ID>/regions/us-west1/targetPools/kubernetes-target-pool].
NAME                    REGION    SESSION_AFFINITY  BACKUP  HEALTH_CHECKS
kubernetes-target-pool  us-west1  NONE                      kubernetes
Updated [https://www.googleapis.com/compute/v1/projects/<GCP_PROJECT_ID>/regions/us-west1/targetPools/kubernetes-target-pool].
Created [https://www.googleapis.com/compute/v1/projects/<GCP_PROJECT_ID>/regions/us-west1/forwardingRules/kubernetes-forwarding-rule].
```

##### Verification

> The compute instances created in this tutorial will not have permission to complete this section. **Run the following commands from the same machine used to create the compute instances.**

Retrieve the kubernetes-the-hard-way static IP address:

```shell
KUBERNETES_PUBLIC_ADDRESS=$(gcloud compute addresses describe kubernetes-the-hard-way \
  --region $(gcloud config get-value compute/region) \
  --format 'value(address)')
```

Make a HTTP request for the Kubernetes version info:

```shell
curl --cacert ca.pem https://${KUBERNETES_PUBLIC_ADDRESS}:6443/version
```
```log
{
  "major": "1",
  "minor": "15",
  "gitVersion": "v1.15.3",
  "gitCommit": "2d3c76f9091b6bec110a5e63777c332469e0cba2",
  "gitTreeState": "clean",
  "buildDate": "2019-08-19T11:05:50Z",
  "goVersion": "go1.12.9",
  "compiler": "gc",
  "platform": "linux/amd64"
}
```


### Bootstrapping the Kubernetes Worker Nodes

In this lab you will bootstrap three Kubernetes worker nodes. The following components will be installed on each node: runc, container networking plugins, containerd, kubelet, and kube-proxy.

#### Prerequisites

The commands in this lab must be run on each worker instance: worker-0, worker-1, and worker-2. Login to each worker instance using the gcloud command. Example:

```shell
gcloud compute ssh worker-0
```

#### Provisioning a Kubernetes Worker Node

Install the OS dependencies:

```shell
{
  sudo apt-get update
  sudo apt-get -y install socat conntrack ipset
}
```

#### Disable Swap

By default the kubelet will fail to start if swap is enabled. It is recommended that swap be disabled to ensure Kubernetes can provide proper resource allocation and quality of service.

Verify if swap is enabled:

```shell
sudo swapon --show
```

If output is empthy then swap is not enabled. If swap is enabled run the following command to disable swap immediately:

```shell
sudo swapoff -a
```

> To ensure swap remains off after reboot consult your Linux distro documentation.

#### Download and Install Worker Binaries

```shell
wget -q --show-progress --https-only --timestamping \
  https://github.com/kubernetes-sigs/cri-tools/releases/download/v1.15.0/crictl-v1.15.0-linux-amd64.tar.gz \
  https://github.com/opencontainers/runc/releases/download/v1.0.0-rc8/runc.amd64 \
  https://github.com/containernetworking/plugins/releases/download/v0.8.2/cni-plugins-linux-amd64-v0.8.2.tgz \
  https://github.com/containerd/containerd/releases/download/v1.2.9/containerd-1.2.9.linux-amd64.tar.gz \
  https://storage.googleapis.com/kubernetes-release/release/v1.15.3/bin/linux/amd64/kubectl \
  https://storage.googleapis.com/kubernetes-release/release/v1.15.3/bin/linux/amd64/kube-proxy \
  https://storage.googleapis.com/kubernetes-release/release/v1.15.3/bin/linux/amd64/kubelet

# Create the installation directories:
sudo mkdir -p \
  /etc/cni/net.d \
  /opt/cni/bin \
  /var/lib/kubelet \
  /var/lib/kube-proxy \
  /var/lib/kubernetes \
  /var/run/kubernetes

# Install the worker binaries:
{
  mkdir containerd
  tar -xvf crictl-v1.15.0-linux-amd64.tar.gz
  tar -xvf containerd-1.2.9.linux-amd64.tar.gz -C containerd
  sudo tar -xvf cni-plugins-linux-amd64-v0.8.2.tgz -C /opt/cni/bin/
  sudo mv runc.amd64 runc
  chmod +x crictl kubectl kube-proxy kubelet runc 
  sudo mv crictl kubectl kube-proxy kubelet runc /usr/local/bin/
  sudo mv containerd/bin/* /bin/
}
```

#### Configure CNI Networking

```shell
# Retrieve the Pod CIDR range for the current compute instance:
POD_CIDR=$(curl -s -H "Metadata-Flavor: Google" \
  http://metadata.google.internal/computeMetadata/v1/instance/attributes/pod-cidr)

# Create the bridge network configuration file:
cat <<EOF | sudo tee /etc/cni/net.d/10-bridge.conf
{
    "cniVersion": "0.3.1",
    "name": "bridge",
    "type": "bridge",
    "bridge": "cnio0",
    "isGateway": true,
    "ipMasq": true,
    "ipam": {
        "type": "host-local",
        "ranges": [
          [{"subnet": "${POD_CIDR}"}]
        ],
        "routes": [{"dst": "0.0.0.0/0"}]
    }
}
EOF

# Create the loopback network configuration file:
cat <<EOF | sudo tee /etc/cni/net.d/99-loopback.conf
{
    "cniVersion": "0.3.1",
    "name": "lo",
    "type": "loopback"
}
EOF
```

#### Configure containerd

```shell
# Create the containerd configuration file:
sudo mkdir -p /etc/containerd/
cat << EOF | sudo tee /etc/containerd/config.toml
[plugins]
  [plugins.cri.containerd]
    snapshotter = "overlayfs"
    [plugins.cri.containerd.default_runtime]
      runtime_type = "io.containerd.runtime.v1.linux"
      runtime_engine = "/usr/local/bin/runc"
      runtime_root = ""
EOF

# Create the containerd.service systemd unit file:
cat <<EOF | sudo tee /etc/systemd/system/containerd.service
[Unit]
Description=containerd container runtime
Documentation=https://containerd.io
After=network.target

[Service]
ExecStartPre=/sbin/modprobe overlay
ExecStart=/bin/containerd
Restart=always
RestartSec=5
Delegate=yes
KillMode=process
OOMScoreAdjust=-999
LimitNOFILE=1048576
LimitNPROC=infinity
LimitCORE=infinity

[Install]
WantedBy=multi-user.target
EOF
```

#### Configure the Kubelet

```shell
{
  sudo mv ${HOSTNAME}-key.pem ${HOSTNAME}.pem /var/lib/kubelet/
  sudo mv ${HOSTNAME}.kubeconfig /var/lib/kubelet/kubeconfig
  sudo mv ca.pem /var/lib/kubernetes/
}

# Create the kubelet-config.yaml configuration file:
cat <<EOF | sudo tee /var/lib/kubelet/kubelet-config.yaml
kind: KubeletConfiguration
apiVersion: kubelet.config.k8s.io/v1beta1
authentication:
  anonymous:
    enabled: false
  webhook:
    enabled: true
  x509:
    clientCAFile: "/var/lib/kubernetes/ca.pem"
authorization:
  mode: Webhook
clusterDomain: "cluster.local"
clusterDNS:
  - "10.32.0.10"
podCIDR: "${POD_CIDR}"
resolvConf: "/run/systemd/resolve/resolv.conf"
runtimeRequestTimeout: "15m"
tlsCertFile: "/var/lib/kubelet/${HOSTNAME}.pem"
tlsPrivateKeyFile: "/var/lib/kubelet/${HOSTNAME}-key.pem"
EOF

# The resolvConf configuration is used to avoid loops when using CoreDNS for service discovery on systems running systemd-resolved.
# Create the kubelet.service systemd unit file:
cat <<EOF | sudo tee /etc/systemd/system/kubelet.service
[Unit]
Description=Kubernetes Kubelet
Documentation=https://github.com/kubernetes/kubernetes
After=containerd.service
Requires=containerd.service

[Service]
ExecStart=/usr/local/bin/kubelet \\
  --config=/var/lib/kubelet/kubelet-config.yaml \\
  --container-runtime=remote \\
  --container-runtime-endpoint=unix:///var/run/containerd/containerd.sock \\
  --image-pull-progress-deadline=2m \\
  --kubeconfig=/var/lib/kubelet/kubeconfig \\
  --network-plugin=cni \\
  --register-node=true \\
  --v=2
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF
```

#### Configure the Kubernetes Proxy

```shell
sudo mv kube-proxy.kubeconfig /var/lib/kube-proxy/kubeconfig

# Create the kube-proxy-config.yaml configuration file:
cat <<EOF | sudo tee /var/lib/kube-proxy/kube-proxy-config.yaml
kind: KubeProxyConfiguration
apiVersion: kubeproxy.config.k8s.io/v1alpha1
clientConnection:
  kubeconfig: "/var/lib/kube-proxy/kubeconfig"
mode: "iptables"
clusterCIDR: "10.200.0.0/16"
EOF

# Create the kube-proxy.service systemd unit file:
cat <<EOF | sudo tee /etc/systemd/system/kube-proxy.service
[Unit]
Description=Kubernetes Kube Proxy
Documentation=https://github.com/kubernetes/kubernetes

[Service]
ExecStart=/usr/local/bin/kube-proxy \\
  --config=/var/lib/kube-proxy/kube-proxy-config.yaml
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF
```

#### Start the Worker Services

```shell
{
  sudo systemctl daemon-reload
  sudo systemctl enable containerd kubelet kube-proxy
  sudo systemctl start containerd kubelet kube-proxy
}
```

#### Verification

> The compute instances created in this tutorial will not have permission to complete this section. Run the following commands from the same machine used to create the compute instances.

List the registered Kubernetes nodes:
```shell
gcloud compute ssh controller-0 \
  --command "kubectl get nodes --kubeconfig admin.kubeconfig"
```
```log
NAME       STATUS   ROLES    AGE   VERSION
worker-0   Ready    <none>   46s   v1.15.3
worker-1   Ready    <none>   46s   v1.15.3
worker-2   Ready    <none>   46s   v1.15.3
```



### Configuring kubectl for Remote Access

In this lab you will generate a kubeconfig file for the kubectl command line utility based on the admin user credentials.

> Run the commands in this lab from the same directory used to generate the admin client certificates.

#### The Admin Kubernetes Configuration File

Each kubeconfig requires a Kubernetes API Server to connect to. To support high availability the IP address assigned to the external load balancer fronting the Kubernetes API Servers will be used.

Generate a kubeconfig file suitable for authenticating as the admin user:
```shell
{
  KUBERNETES_PUBLIC_ADDRESS=$(gcloud compute addresses describe kubernetes-the-hard-way \
    --region $(gcloud config get-value compute/region) \
    --format 'value(address)')

  kubectl config set-cluster kubernetes-the-hard-way \
    --certificate-authority=ca.pem \
    --embed-certs=true \
    --server=https://${KUBERNETES_PUBLIC_ADDRESS}:6443

  kubectl config set-credentials admin \
    --client-certificate=admin.pem \
    --client-key=admin-key.pem

  kubectl config set-context kubernetes-the-hard-way \
    --cluster=kubernetes-the-hard-way \
    --user=admin

  kubectl config use-context kubernetes-the-hard-way
}
```
```log
Cluster "kubernetes-the-hard-way" set.
User "admin" set.
Context "kubernetes-the-hard-way" created.
Switched to context "kubernetes-the-hard-way".
```

#### Verification

Check the health of the remote Kubernetes cluster:

```shell
kubectl get componentstatuses
```
```log
NAME                 STATUS    MESSAGE             ERROR
etcd-2               Healthy   {"health":"true"}   
controller-manager   Healthy   ok                  
scheduler            Healthy   ok                  
etcd-1               Healthy   {"health":"true"}   
etcd-0               Healthy   {"health":"true"}
```

List the nodes in the remote Kubernetes cluster:
```shell
kubectl get nodes
```
```log
NAME       STATUS   ROLES    AGE     VERSION
worker-0   Ready    <none>   7m32s   v1.15.3
worker-1   Ready    <none>   7m32s   v1.15.3
worker-2   Ready    <none>   7m32s   v1.15.3
```


### Provisioning Pod Network Routes

Pods scheduled to a node receive an IP address from the node's Pod CIDR range. At this point pods can not communicate with other pods running on different nodes due to missing network routes.

In this lab you will create a route for each worker node that maps the node's Pod CIDR range to the node's internal IP address.

> There are other ways to implement the Kubernetes networking model.
Они это серьёзно??? О_о

#### The Routing Table

In this section you will gather the information required to create routes in the kubernetes-the-hard-way VPC network.

Print the internal IP address and Pod CIDR range for each worker instance:
```shell
for instance in worker-0 worker-1 worker-2; do
  gcloud compute instances describe ${instance} \
    --format 'value[separator=" "](networkInterfaces[0].networkIP,metadata.items[0].value)'
done
```
```log
10.240.0.20 10.200.0.0/24
10.240.0.21 10.200.1.0/24
10.240.0.22 10.200.2.0/24
```

#### Routes

Create network routes for each worker instance:

```shell
for i in 0 1 2; do
  gcloud compute routes create kubernetes-route-10-200-${i}-0-24 \
    --network kubernetes-the-hard-way \
    --next-hop-address 10.240.0.2${i} \
    --destination-range 10.200.${i}.0/24
done
```
```log
Created [https://www.googleapis.com/compute/v1/projects/<GCP_PROJECT_ID>/global/routes/kubernetes-route-10-200-0-0-24].
NAME                            NETWORK                  DEST_RANGE     NEXT_HOP     PRIORITY
kubernetes-route-10-200-0-0-24  kubernetes-the-hard-way  10.200.0.0/24  10.240.0.20  1000
Created [https://www.googleapis.com/compute/v1/projects/<GCP_PROJECT_ID>/global/routes/kubernetes-route-10-200-1-0-24].
NAME                            NETWORK                  DEST_RANGE     NEXT_HOP     PRIORITY
kubernetes-route-10-200-1-0-24  kubernetes-the-hard-way  10.200.1.0/24  10.240.0.21  1000
Created [https://www.googleapis.com/compute/v1/projects/<GCP_PROJECT_ID>/global/routes/kubernetes-route-10-200-2-0-24].
NAME                            NETWORK                  DEST_RANGE     NEXT_HOP     PRIORITY
kubernetes-route-10-200-2-0-24  kubernetes-the-hard-way  10.200.2.0/24  10.240.0.22  1000
```

List the routes in the kubernetes-the-hard-way VPC network:
```shell
gcloud compute routes list --filter "network: kubernetes-the-hard-way"
```
```log
NAME                            NETWORK                  DEST_RANGE     NEXT_HOP                  PRIORITY
default-route-118cfd194d80a4a4  kubernetes-the-hard-way  10.240.0.0/24  kubernetes-the-hard-way   1000
default-route-d3a438bf78933ad3  kubernetes-the-hard-way  0.0.0.0/0      default-internet-gateway  1000
kubernetes-route-10-200-0-0-24  kubernetes-the-hard-way  10.200.0.0/24  10.240.0.20               1000
kubernetes-route-10-200-1-0-24  kubernetes-the-hard-way  10.200.1.0/24  10.240.0.21               1000
kubernetes-route-10-200-2-0-24  kubernetes-the-hard-way  10.200.2.0/24  10.240.0.22               1000
```


### Deploying the DNS Cluster Add-on

In this lab you will deploy the DNS add-on which provides DNS based service discovery, backed by CoreDNS, to applications running inside the Kubernetes cluster.

#### The DNS Cluster Add-on

Deploy the coredns cluster add-on:
```shell
kubectl apply -f https://storage.googleapis.com/kubernetes-the-hard-way/coredns.yaml
```
```log
serviceaccount/coredns created
clusterrole.rbac.authorization.k8s.io/system:coredns created
clusterrolebinding.rbac.authorization.k8s.io/system:coredns created
configmap/coredns created
deployment.apps/coredns created
service/kube-dns created
```

List the pods created by the kube-dns deployment:
```shell
kubectl get pods -l k8s-app=kube-dns -n kube-system
```
```log
NAME                     READY   STATUS    RESTARTS   AGE
coredns-5fb99965-lhzqz   1/1     Running   0          36s
coredns-5fb99965-xfmzk   1/1     Running   0          36s
```

#### Verification

Create a busybox deployment:
```shell
kubectl run --generator=run-pod/v1 busybox --image=busybox:1.28 --command -- sleep 3600
```
```log
pod/busybox created
```

List the pod created by the busybox deployment:
```shell
kubectl get pods -l run=busybox
```
```log
NAME      READY   STATUS    RESTARTS   AGE
busybox   1/1     Running   0          26s
```

Retrieve the full name of the busybox pod:
```shell
POD_NAME=$(kubectl get pods -l run=busybox -o jsonpath="{.items[0].metadata.name}")

# Execute a DNS lookup for the kubernetes service inside the busybox pod:
kubectl exec -ti $POD_NAME -- nslookup kubernetes
```
```log
Server:    10.32.0.10
Address 1: 10.32.0.10 kube-dns.kube-system.svc.cluster.local

Name:      kubernetes
Address 1: 10.32.0.1 kubernetes.default.svc.cluster.local
```


### Smoke Test

In this lab you will complete a series of tasks to ensure your Kubernetes cluster is functioning correctly.

#### Data Encryption

In this section you will verify the ability to encrypt secret data at rest.

Create a generic secret:
```shell
kubectl create secret generic kubernetes-the-hard-way \
  --from-literal="mykey=mydata"
```

Print a hexdump of the kubernetes-the-hard-way secret stored in etcd:
```shell
gcloud compute ssh controller-0 \
  --command "sudo ETCDCTL_API=3 etcdctl get \
  --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/etcd/ca.pem \
  --cert=/etc/etcd/kubernetes.pem \
  --key=/etc/etcd/kubernetes-key.pem\
  /registry/secrets/default/kubernetes-the-hard-way | hexdump -C"
```
```log
00000000  2f 72 65 67 69 73 74 72  79 2f 73 65 63 72 65 74  |/registry/secret|
00000010  73 2f 64 65 66 61 75 6c  74 2f 6b 75 62 65 72 6e  |s/default/kubern|
00000020  65 74 65 73 2d 74 68 65  2d 68 61 72 64 2d 77 61  |etes-the-hard-wa|
00000030  79 0a 6b 38 73 3a 65 6e  63 3a 61 65 73 63 62 63  |y.k8s:enc:aescbc|
00000040  3a 76 31 3a 6b 65 79 31  3a 90 93 2a 47 45 63 9c  |:v1:key1:..*GEc.|
00000050  e0 64 cc 40 8c 24 ae b7  33 b0 ec 52 ee 52 5c 25  |.d.@.$..3..R.R\%|
00000060  cb 9d f0 ae 10 58 52 d6  ef 43 0f 3e 52 8a f8 d2  |.....XR..C.>R...|
00000070  c7 5d d9 22 ff 5e 23 7b  2b c2 38 b7 f7 11 b2 65  |.].".^#{+.8....e|
00000080  2f 4a 20 d3 f2 be a4 5f  85 f9 87 6c e0 4e fa e0  |/J ...._...l.N..|
00000090  12 9f ae ba 32 5a a2 a3  f4 27 0e a3 d1 20 d1 d3  |....2Z...'... ..|
000000a0  36 9c c9 fb 61 d0 41 31  4e e6 c4 01 e3 8f 9c 4c  |6...a.A1N......L|
000000b0  0d d8 95 f5 3d 8d ce ac  e8 8f ab 26 65 b8 e4 ca  |....=......&e...|
000000c0  8b 83 a7 38 df ab 9d f1  d0 e7 fd 3b bf a6 2f 08  |...8.......;../.|
000000d0  2e 90 41 5a 63 66 b0 26  4d 78 ef 9e f0 88 9f 1e  |..AZcf.&Mx......|
000000e0  ae ea 2d c9 2b 13 7e 71  82 0a                    |..-.+.~q..|
000000ea
```
The etcd key should be prefixed with k8s:enc:aescbc:v1:key1, which indicates the aescbc provider was used to encrypt the data with the key1 encryption key.

#### Deployments

In this section you will verify the ability to create and manage Deployments.

Create a deployment for the nginx web server:
```shell
kubectl create deployment nginx --image=nginx
```
```log
deployment.apps/nginx created
```

List the pod created by the nginx deployment:
```shell
kubectl get pods -l app=nginx
```
```log
NAME                     READY   STATUS    RESTARTS   AGE
nginx-554b9c67f9-zkpn2   1/1     Running   0          30s
```

#### Port Forwarding

In this section you will verify the ability to access applications remotely using port forwarding.

Retrieve the full name of the nginx pod:
```shell
POD_NAME=$(kubectl get pods -l app=nginx -o jsonpath="{.items[0].metadata.name}")

# Forward port 8080 on your local machine to port 80 of the nginx pod:
kubectl port-forward $POD_NAME 8080:80
```
```log
Forwarding from 127.0.0.1:8080 -> 80
Forwarding from [::1]:8080 -> 80
```

In a new terminal make an HTTP request using the forwarding address:
```shell
curl --head http://127.0.0.1:8080
```
```log
HTTP/1.1 200 OK
Server: nginx/1.17.6
Date: Sun, 22 Dec 2019 09:34:53 GMT
Content-Type: text/html
Content-Length: 612
Last-Modified: Tue, 19 Nov 2019 12:50:08 GMT
Connection: keep-alive
ETag: "5dd3e500-264"
Accept-Ranges: bytes
```

Switch back to the previous terminal and stop the port forwarding to the nginx pod:
```log
Forwarding from 127.0.0.1:8080 -> 80
Forwarding from [::1]:8080 -> 80
Handling connection for 8080
^C
```

#### Logs

In this section you will verify the ability to retrieve container logs.

Print the nginx pod logs:
```shell
kubectl logs $POD_NAME
```
```log
127.0.0.1 - - [22/Dec/2019:09:34:53 +0000] "HEAD / HTTP/1.1" 200 0 "-" "curl/7.58.0" "-"
```

#### Exec

In this section you will verify the ability to execute commands in a container.

Print the nginx version by executing the nginx -v command in the nginx container:
```shell
kubectl exec -ti $POD_NAME -- nginx -v
```
```log
nginx version: nginx/1.17.6
```

#### Services

In this section you will verify the ability to expose applications using a Service.

Expose the nginx deployment using a NodePort service:
```shell
kubectl expose deployment nginx --port 80 --type NodePort
```
```log
service/nginx exposed
```
> The LoadBalancer service type can not be used because your cluster is not configured with cloud provider integration. Setting up cloud provider integration is out of scope for this tutorial.

Retrieve the node port assigned to the nginx service:
```shell
NODE_PORT=$(kubectl get svc nginx \
  --output=jsonpath='{range .spec.ports[0]}{.nodePort}')

# Create a firewall rule that allows remote access to the nginx node port:
gcloud compute firewall-rules create kubernetes-the-hard-way-allow-nginx-service \
  --allow=tcp:${NODE_PORT} \
  --network kubernetes-the-hard-way

# Retrieve the external IP address of a worker instance:
EXTERNAL_IP=$(gcloud compute instances describe worker-0 \
  --format 'value(networkInterfaces[0].accessConfigs[0].natIP)')
```
```log
Creating firewall...⠶Created [https://www.googleapis.com/compute/v1/projects/<GCP_PROJECT_ID>/global/firewalls/kubernetes-the-hard-way-allow-nginx-service].                                                                                                            
Creating firewall...done.                                                                                                                                                                                                                                            
NAME                                         NETWORK                  DIRECTION  PRIORITY  ALLOW      DENY  DISABLED
kubernetes-the-hard-way-allow-nginx-service  kubernetes-the-hard-way  INGRESS    1000      tcp:30975        False
```

Make an HTTP request using the external IP address and the nginx node port:
```shell
curl -I http://${EXTERNAL_IP}:${NODE_PORT}
```
```log
HTTP/1.1 200 OK
Server: nginx/1.17.6
Date: Sun, 22 Dec 2019 09:41:20 GMT
Content-Type: text/html
Content-Length: 612
Last-Modified: Tue, 19 Nov 2019 12:50:08 GMT
Connection: keep-alive
ETag: "5dd3e500-264"
Accept-Ranges: bytes
```

### Проверка

Проверка деплоя созданных ранее подов будет описана в основном [README.md](../../README.md)

Проверка прошла успешно. Далее чистка

### Cleaning Up

In this lab you will delete the compute resources created during this tutorial.

#### Compute Instances

Delete the controller and worker compute instances:
```shell
gcloud -q compute instances delete \
  controller-0 controller-1 controller-2 \
  worker-0 worker-1 worker-2 \
  --zone $(gcloud config get-value compute/zone)
```
```log
Deleted [https://www.googleapis.com/compute/v1/projects/<GCP_PROJECT_ID>/zones/us-west1-c/instances/controller-0].
Deleted [https://www.googleapis.com/compute/v1/projects/<GCP_PROJECT_ID>/zones/us-west1-c/instances/controller-1].
Deleted [https://www.googleapis.com/compute/v1/projects/<GCP_PROJECT_ID>/zones/us-west1-c/instances/worker-0].
Deleted [https://www.googleapis.com/compute/v1/projects/<GCP_PROJECT_ID>/zones/us-west1-c/instances/worker-2].
Deleted [https://www.googleapis.com/compute/v1/projects/<GCP_PROJECT_ID>/zones/us-west1-c/instances/worker-1].
Deleted [https://www.googleapis.com/compute/v1/projects/<GCP_PROJECT_ID>/zones/us-west1-c/instances/controller-2].
```


#### Networking

Delete the external load balancer network resources:
```shell
{
  gcloud -q compute forwarding-rules delete kubernetes-forwarding-rule \
    --region $(gcloud config get-value compute/region)

  gcloud -q compute target-pools delete kubernetes-target-pool

  gcloud -q compute http-health-checks delete kubernetes

  gcloud -q compute addresses delete kubernetes-the-hard-way
}
```
```log
Deleted [https://www.googleapis.com/compute/v1/projects/<GCP_PROJECT_ID>/regions/us-west1/forwardingRules/kubernetes-forwarding-rule].
Deleted [https://www.googleapis.com/compute/v1/projects/<GCP_PROJECT_ID>/regions/us-west1/targetPools/kubernetes-target-pool].
Deleted [https://www.googleapis.com/compute/v1/projects/<GCP_PROJECT_ID>/global/httpHealthChecks/kubernetes].
Deleted [https://www.googleapis.com/compute/v1/projects/<GCP_PROJECT_ID>/regions/us-west1/addresses/kubernetes-the-hard-way].
```

Delete the kubernetes-the-hard-way firewall rules:
```shell
gcloud -q compute firewall-rules delete \
  kubernetes-the-hard-way-allow-nginx-service \
  kubernetes-the-hard-way-allow-internal \
  kubernetes-the-hard-way-allow-external \
  kubernetes-the-hard-way-allow-health-check
```
```log
Deleted [https://www.googleapis.com/compute/v1/projects/<GCP_PROJECT_ID>/global/firewalls/kubernetes-the-hard-way-allow-health-check].
Deleted [https://www.googleapis.com/compute/v1/projects/<GCP_PROJECT_ID>/global/firewalls/kubernetes-the-hard-way-allow-nginx-service].
Deleted [https://www.googleapis.com/compute/v1/projects/<GCP_PROJECT_ID>/global/firewalls/kubernetes-the-hard-way-allow-internal].
Deleted [https://www.googleapis.com/compute/v1/projects/<GCP_PROJECT_ID>/global/firewalls/kubernetes-the-hard-way-allow-external].
```

Delete the kubernetes-the-hard-way network VPC:
```shell
{
  gcloud -q compute routes delete \
    kubernetes-route-10-200-0-0-24 \
    kubernetes-route-10-200-1-0-24 \
    kubernetes-route-10-200-2-0-24

  gcloud -q compute networks subnets delete kubernetes

  gcloud -q compute networks delete kubernetes-the-hard-way
}
```
```log
Deleted [https://www.googleapis.com/compute/v1/projects/<GCP_PROJECT_ID>/global/routes/kubernetes-route-10-200-2-0-24].
Deleted [https://www.googleapis.com/compute/v1/projects/<GCP_PROJECT_ID>/global/routes/kubernetes-route-10-200-0-0-24].
Deleted [https://www.googleapis.com/compute/v1/projects/<GCP_PROJECT_ID>/global/routes/kubernetes-route-10-200-1-0-24].
Deleted [https://www.googleapis.com/compute/v1/projects/<GCP_PROJECT_ID>/regions/us-west1/subnetworks/kubernetes].
Deleted [https://www.googleapis.com/compute/v1/projects/<GCP_PROJECT_ID>/global/networks/kubernetes-the-hard-way].
```
