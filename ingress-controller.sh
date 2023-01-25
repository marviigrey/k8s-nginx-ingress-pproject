#next is to configure or install our nginx-ingress-controller.
#clone the nginxinc repo
git clone https://github.com/nginxinc/kubernetes-ingress.git --branch v3.0.0
cd kubernetes-ingress
 #create service accounts and a namespace
k create -f common/ns-and-sa.yaml
#Create roles.rolebindings,clusterroles and clusterrolebinding for the service accounts
kubectl apply -f rbac/rbac.yaml
kubectl apply -f rbac/ap-rbac.yaml
kubectl apply -f rbac/apdos-rbac.yaml
#Create a secret with a TLS certificate and a key for the default server in NGINX:
 kubectl apply -f common/default-server-secret.yaml
 #Create a config map for customizing NGINX configuration
 kubectl apply -f common/nginx-config.yaml
 #Create an IngressClass resource
 kubectl apply -f common/ingress-class.yaml
 #Create custom resource definitions for VirtualServer and VirtualServerRoute, TransportServer and Policy resources
 kubectl apply -f common/crds/k8s.nginx.org_virtualservers.yaml
 kubectl apply -f common/crds/k8s.nginx.org_virtualserverroutes.yaml
 kubectl apply -f common/crds/k8s.nginx.org_transportservers.yaml
 kubectl apply -f common/crds/k8s.nginx.org_policies.yaml
 #Create a custom resource definition for GlobalConfiguration resource
 kubectl apply -f common/crds/k8s.nginx.org_globalconfigurations.yaml
 #Create a custom resource definition for APPolicy, APLogConf and APUserSig
 
 kubectl apply -f common/crds/appprotect.f5.com_aplogconfs.yaml
 kubectl apply -f common/crds/appprotect.f5.com_appolicies.yaml
 kubectl apply -f common/crds/appprotect.f5.com_apusersigs.yaml
 kubectl apply -f common/crds/appprotectdos.f5.com_apdoslogconfs.yaml
 kubectl apply -f common/crds/appprotectdos.f5.com_apdospolicy.yaml
 kubectl apply -f common/crds/appprotectdos.f5.com_dosprotectedresources.yaml
 #Deploy Arbitrator for NGINX App Protect DoS
 kubectl apply -f deployment/appprotect-dos-arb.yaml
 kubectl apply -f service/appprotect-dos-arb-svc.yaml
 #Deploy the ingress controller
 kubectl apply -f deployment/nginx-ingress.yaml
 kubectl create -f service/nodeport.yaml
