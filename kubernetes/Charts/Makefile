NS?=default

update_deps: clean_deps
	cd ./reddit && helm dep update
	cd ./ingress-nginx && helm dep update
	cd ./prometheus-operator && helm dep update

clean_deps:
	rm -rf ./reddit/charts || true
	rm -rf ./ingress-nginx/charts || true
	rm -rf ./prometheus-operator/charts || true

# install nginx-ingress
install_nginx:
	helm upgrade \
		--install \
		--set nginx-ingress.controller.scope.enabled=true \
		--set nginx-ingress.controller.scope.namespace=$(NS) \
		--namespace $(NS) \
		nginx-ingress-$(NS) \
		./ingress-nginx

# uninstall nginx-ingress
uninstall_nginx:
	helm uninstall --namespace $(NS) nginx-ingress-$(NS)

# deploy prometheus
deploy_prometheus:
	helm upgrade \
		--install \
		-f ./prometheus/custom_values.yml \
		--namespace default \
		prom \
		./prometheus

# uninstall prometheus
uninstall_prometheus:
	helm uninstall --namespace default prom

# deploy prometheus operator
deploy_prometheus_operator: install_prometheus_operator_crds
	helm upgrade \
		--install \
		--set prometheus-operator.prometheusOperator.createCustomResource=false \
		--namespace default \
		prometheus-operator \
		./prometheus-operator

# uninstall prometheus operator
uninstall_prometheus_operator:
	helm uninstall --namespace default prometheus-operator
	$(MAKE) uninstall_prometheus_operator_crds

# install prometheus operator CRDs
install_prometheus_operator_crds:
	kubectl apply -n default -f https://raw.githubusercontent.com/coreos/prometheus-operator/release-0.35/example/prometheus-operator-crd/monitoring.coreos.com_alertmanagers.yaml
	kubectl apply -n default -f https://raw.githubusercontent.com/coreos/prometheus-operator/release-0.35/example/prometheus-operator-crd/monitoring.coreos.com_podmonitors.yaml
	kubectl apply -n default -f https://raw.githubusercontent.com/coreos/prometheus-operator/release-0.35/example/prometheus-operator-crd/monitoring.coreos.com_prometheuses.yaml
	kubectl apply -n default -f https://raw.githubusercontent.com/coreos/prometheus-operator/release-0.35/example/prometheus-operator-crd/monitoring.coreos.com_prometheusrules.yaml
	kubectl apply -n default -f https://raw.githubusercontent.com/coreos/prometheus-operator/release-0.35/example/prometheus-operator-crd/monitoring.coreos.com_servicemonitors.yaml

# uninstall prometheus operator CRDs
uninstall_prometheus_operator_crds:
	kubectl delete -n default -f https://raw.githubusercontent.com/coreos/prometheus-operator/release-0.35/example/prometheus-operator-crd/monitoring.coreos.com_alertmanagers.yaml
	kubectl delete -n default -f https://raw.githubusercontent.com/coreos/prometheus-operator/release-0.35/example/prometheus-operator-crd/monitoring.coreos.com_podmonitors.yaml
	kubectl delete -n default -f https://raw.githubusercontent.com/coreos/prometheus-operator/release-0.35/example/prometheus-operator-crd/monitoring.coreos.com_prometheuses.yaml
	kubectl delete -n default -f https://raw.githubusercontent.com/coreos/prometheus-operator/release-0.35/example/prometheus-operator-crd/monitoring.coreos.com_prometheusrules.yaml
	kubectl delete -n default -f https://raw.githubusercontent.com/coreos/prometheus-operator/release-0.35/example/prometheus-operator-crd/monitoring.coreos.com_servicemonitors.yaml
