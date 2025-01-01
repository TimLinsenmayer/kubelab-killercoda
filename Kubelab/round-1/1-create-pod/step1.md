To complete this challenge, you need to create a Pod running nginx.

You can do this in one of two ways:

1. Using an imperative command:
```bash
kubectl run my-nginx --image=nginx
```

2. Or by creating and applying a YAML manifest:
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-nginx
spec:
  containers:
  - name: nginx
    image: nginx
```

Save this as `pod.yaml` and apply it with:
```bash
kubectl apply -f pod.yaml
```

Check the Pod status with:
```bash
kubectl get pods
```

The challenge will be marked as complete when the Pod is running successfully. 