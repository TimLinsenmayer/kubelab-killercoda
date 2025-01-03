## Aufgabe #2: Pod ansehen & Kubernetes-CLI
Da der Pod jetzt gestartet ist, können wir ihn uns genauer ansehen.

```bash
kubectl describe pod kubelab-pod
```{{exec}}

Mit diesem Befehl kannst du alle Informationen zu einem Kubernetes-Objekt (wie unseren Pod) ansehen. Lass dich nicht von den vielen Informationen verwirren, die du siehst. Für uns sind überwiegend `Status`, `Containers` und `Events` relevant.

In `Containers` findest du Informationen zu den Containern, die im Pod laufen (bei unserem Pod ist das nur ein Container). 
```
Containers:
  kubelab-pod:
    Container ID:   containerd://b3b25b76e7a0a1b4f3d35b87755f7a2a3609d27e9ff0251c16500f789d95cf0f
    Image:          timlinsenmayer/kubelab-insights:latest
    Image ID:       docker.io/timlinsenmayer/kubelab-insights@sha256:dc157b2c5592820e8de5c79febd70e927c9c3b6e1e27e05468f199ef984ca362
    [... weitere Informationen ...]
```
Anhand der `Container ID` siehst du, dass die Runtime `containerd` verwendet wird. (containerd ist eine Runtime, die von Kubernetes unterstützt wird und Docker implementiert.)

Docker-Images werden in der Regel von einer Container-Registry bereitgestellt. In unserem Fall ist das `docker.io` (Docker Hub) und werden durch den SHA-256 Hash identifiziert. Da viele Nutzer nicht den Hash kennen oder sich den Hash merken können, werden Images oft mit einem Tag versehen. In unserem Fall ist das `latest`.

Wird ein ungültiger Tag verwendet, wird das Image nicht gefunden und der Pod startet nicht. Das sehen wir uns mal an:

`kubectl run invalid-pod --image timlinsenmayer/kubelab-insights:invalid-tag`{{exec}}

`kubectl get pod invalid-pod`{{exec}}

`kubectl describe pod invalid-pod`{{exec}}

Wir sehen, dass der Pod nicht gestartet ist (Status `ErrImagePull`) und die Events zeigen, dass das Image nicht gefunden werden konnte. Da aber das "nicht auffinden" auch an der Registry liegen kann, versucht es Kubernetes mehrmals. Wird das Image immer noch nicht gefunden, wird der Pod in den Status `ImagePullBackOff` versetzt.

Ein weiterer, häufiger Fehler ist `CrashLoopBackOff`. Dieser tritt auf, wenn der Container mehrfach abstürzt und nicht korrekt startet. Dies hängt häufig mit fehlender/falscher Konfiguration des Containers oder Anwendungsfehlern zusammen.