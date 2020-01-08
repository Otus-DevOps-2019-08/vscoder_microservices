# gcp project id
PROJECT_ID?=docker-257914
# gcp zone
ZONE?=us-central1-a
# gke cluster name
CLUSTER_NAME?=reddit-public
# namespace
NS?=dev

create_cluster:
	cd ./terraform \
	&& $(MAKE) apply

configure_kubectl:
	gcloud container clusters get-credentials $(CLUSTER_NAME) --zone $(ZONE) --project $(PROJECT_ID)

apply_namespaces:
	cd ./reddit \
	&& kubectl apply -f *-namespace.yml

apply_reddit:
	cd ./reddit \
	&& kubectl apply -f ./ -n $(NS)

get_https_link:
	export INGRESS_IP=$(shell kubectl get ingresses ui -n $(NS) -o json | jq '.status.loadBalancer.ingress[0].ip' | xargs) \
	&& echo https://$${INGRESS_IP}

gen_cert:
	cd ./reddit/secrets \
	&& export INGRESS_IP=$(shell kubectl get ingresses ui -n $(NS) -o json | jq '.status.loadBalancer.ingress[0].ip' | xargs) \
	&& openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout tls.key -out tls.crt -subj "/CN=reddit"

upload_cert:
	cd ./reddit/secrets \
	&& kubectl apply -k ./ -n $(NS)

# Create infrastructure
infra: create_cluster configure_kubectl

# Deploy app
deploy: apply_namespaces apply_reddit

# Make ssl cert
cert: gen_cert upload_cert

# All from scratch
all: infra deploy cert
