## Aufgabe 3: Und wie komme ich dran?
Der Pod `kubelab-pod` besteht aus einer Webanwendung, die auf Port 3000 bereitgestellt wird. Das können wir übrigens auch überprüfen:

`kubectl logs kubelab-pod`{{exec}} - Wir sehen, dass die App läuft

`kubectl exec kubelab-pod -- curl localhost:3000`{{exec}} - Wir sehen, dass eine Website zurückgeliefert wird.

Kubernetes (bzw. die Container-Runtime) öffnet (exposed) allerdings nur die Ports, die in der Pod-Spezifikation definiert sind. Da wir dies noch nicht gemacht haben, können wir den Pod nicht von außen erreichen.

Um das zu ändern, müssen wir den Pod umkonfigurieren. Wir nutzen dafür den Editor vom Lab. Dazu erstellen wir eine neue YAML-Datei (z.B. `pod.yaml`) und fügen folgendes ein:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: kubelab-pod
  labels:
    app: kubelab
spec:
  containers:
    - name: kubelab-container
      image: timlinsenmayer/kubelab-insights:latest
      ports:
        - containerPort: 3000
```

Zuvor müssen wir aber den "alten" Pod löschen: `kubectl delete pod kubelab-pod`{{exec}}.
Erst dann können wir den neuen Pod erstellen: `kubectl apply -f pod.yaml`{{exec}}. 

Aber selbst dann können wir den Pod nicht von außen erreichen ([klick mich!]({{TRAFFIC_HOST1_3000}})). Dazu müssen wir einen Service erstellen.

Wir erstellen also einen Service, der den Pod auf Port 30000 exponiert. Dazu erstellen wir eine neue YAML-Datei (z.B. `service.yaml`) und fügen folgendes ein:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: kubelab-service
spec:
  type: NodePort
  selector:
    app: kubelab
  ports:
    - protocol: TCP
      port: 3000
      targetPort: 3000
      nodePort: 30000
```

Wir erstellen den Service mit `kubectl apply -f service.yaml`{{exec}}.
Jetzt können wir den Service auch "öffentlich" erreichen: [klick mich!]({{TRAFFIC_HOST1_30000}})
