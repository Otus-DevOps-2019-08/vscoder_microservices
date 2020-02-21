NS?=default

update_deps: clean_deps
	cd ./reddit && helm dep update
	cd ./ingress-nginx && helm dep update

clean_deps:
	rm -rf ./reddit/charts || true
	rm -rf ./ingress-nginx/charts || true

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
