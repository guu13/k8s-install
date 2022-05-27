helm repo add clusternet https://clusternet.github.io/charts
helm install clusternet-hub -n clusternet-system --create-namespace clusternet/clusternet-hub
kubectl apply -f https://raw.githubusercontent.com/clusternet/clusternet/main/manifests/samples/cluster_bootstrap_token.yaml


kubectl get secret -n clusternet-system -o=jsonpath='{.items[?(@.metadata.annotations.kubernetes\.io/service-account\.name=="cluster-bootstrap-use")].data.token}' | base64 --decode; echo HERE WILL OUTPUTS A LONG STRING. PLEASE REMEMBER THIS.


eyJhbGciOiJSUzI1NiIsImtpZCI6Ims1TGdJcWtuVDQ4aXg2c2pnSFg0ZnB6MmgtOV9FblJNcmZLdkgwS3p4MlkifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJjbHVzdGVybmV0LXN5c3RlbSIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJjbHVzdGVyLWJvb3RzdHJhcC11c2UtdG9rZW4tMnE4eGMiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoiY2x1c3Rlci1ib290c3RyYXAtdXNlIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQudWlkIjoiNjNjOTE4NzUtOThlZi00NDQwLWE5ODMtODAxMWYyMzk4OGNhIiwic3ViIjoic3lzdGVtOnNlcnZpY2VhY2NvdW50OmNsdXN0ZXJuZXQtc3lzdGVtOmNsdXN0ZXItYm9vdHN0cmFwLXVzZSJ9.Xy7N7fp0rJur_VmoeLvZc3Ohnk6nh_avOp9ZtA5xdRGR3uaJaTIHnXlcW9S7WL9Ibg9oP5qVb__V5vr71aWpXcwXqVfdDLcrHnBgqqomJ2rUcd-L-psQAOHTzudeWA0WCe_vQrjId3AbMyoiWs4IIBZXzobekkn0IEmMfKzn7oBHMQZVHVc-8Vr0g_yV-OtBqwWxO0zdsJrM6zEGAaVtDlR8IAghajRa0f9lT8zq_TSFzDGsGTZFVSZM9mVhr8UGl00o_Qs6qpXHc_FgjgAZMzaeoq5NtbhggAiEWwA9mIWVAUbDSBu3BVC1twDkwfstLi6hvcNMEGgwxWIsGHcZEgHERE


helm delete clusternet-hub -n clusternet-system

-----------------

helm repo add clusternet https://clusternet.github.io/charts
helm install clusternet-scheduler -n clusternet-system --create-namespace clusternet/clusternet-scheduler

helm delete clusternet-scheduler -n clusternet-system

-----------------

helm repo add clusternet https://clusternet.github.io/charts

helm install clusternet-agent -n clusternet-system --create-namespace \
  --set parentURL=https://10.211.55.18:6443 \
  --set registrationToken=eyJhbGciOiJSUzI1NiIsImtpZCI6Ims1TGdJcWtuVDQ4aXg2c2pnSFg0ZnB6MmgtOV9FblJNcmZLdkgwS3p4MlkifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJjbHVzdGVybmV0LXN5c3RlbSIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJjbHVzdGVyLWJvb3RzdHJhcC11c2UtdG9rZW4tMnE4eGMiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoiY2x1c3Rlci1ib290c3RyYXAtdXNlIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQudWlkIjoiNjNjOTE4NzUtOThlZi00NDQwLWE5ODMtODAxMWYyMzk4OGNhIiwic3ViIjoic3lzdGVtOnNlcnZpY2VhY2NvdW50OmNsdXN0ZXJuZXQtc3lzdGVtOmNsdXN0ZXItYm9vdHN0cmFwLXVzZSJ9.Xy7N7fp0rJur_VmoeLvZc3Ohnk6nh_avOp9ZtA5xdRGR3uaJaTIHnXlcW9S7WL9Ibg9oP5qVb__V5vr71aWpXcwXqVfdDLcrHnBgqqomJ2rUcd-L-psQAOHTzudeWA0WCe_vQrjId3AbMyoiWs4IIBZXzobekkn0IEmMfKzn7oBHMQZVHVc-8Vr0g_yV-OtBqwWxO0zdsJrM6zEGAaVtDlR8IAghajRa0f9lT8zq_TSFzDGsGTZFVSZM9mVhr8UGl00o_Qs6qpXHc_FgjgAZMzaeoq5NtbhggAiEWwA9mIWVAUbDSBu3BVC1twDkwfstLi6hvcNMEGgwxWIsGHcZEgHERE \
  clusternet/clusternet-agent


------------------





   --- 达到 什么 程度。----- 