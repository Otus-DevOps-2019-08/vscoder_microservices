FROM alpine:3

# variable "HELM_VERSION" must be passed as docker environment variables during the image build
# docker build --no-cache --build-arg HELM_VERSION=2.13.1 -t vscoder/helm:2.13.1 .

ARG HELM_VERSION

RUN apk add --update --no-cache openssl curl tar gzip bash ca-certificates git && \
    wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.23-r3/glibc-2.23-r3.apk && \
    apk add glibc-2.23-r3.apk && \
    curl https://storage.googleapis.com/pub/gsutil.tar.gz | tar -xz -C $HOME && \
    export PATH=${PATH}:$HOME/gsutil && \
    curl https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz | tar zx && \
    mv linux-amd64/helm /usr/bin/ && \
    helm version --client && \
    curl  -o /usr/bin/sync-repo.sh https://raw.githubusercontent.com/kubernetes/helm/master/scripts/sync-repo.sh && \
    chmod a+x /usr/bin/sync-repo.sh && \
    curl -L -o /usr/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    chmod +x /usr/bin/kubectl && \
    kubectl version --client && \
    rm -rf linux-amd64 && \
    apk del tar gzip && \
    rm -f /var/cache/apk/*

CMD ["bash"]
