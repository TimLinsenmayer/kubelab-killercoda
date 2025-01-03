# Los geht's!
Neben diesem Infotext findest du das Terminal. Hier kannst du Befehle eingeben und ausführen.

Hauptsächlich werden wir mit `kubectl`{{exec}} arbeiten. Dies ist der Kubernetes-Befehlszeilenclient.
Alle möglichen Befehle siehst du, wenn du `kubectl`{{exec}} ausführst.

> Tipp: Im Lab kannst du häufig auf Befehle klicken, um sie direkt auszuführen.

## Aufgabe #1: Pod erstellen
Pods sind die kleinsten Einheiten in Kubernetes. Sie bestehen aus einem oder mehreren Containern.
Zunächst erstellen wir einen Pod, den wir später benötigen.

<div style="background-color: #f8f9fa; border-left: 4px solid #0d6efd; padding: 16px; margin: 16px 0; border-radius: 4px;">
  <h3 style="margin-top: 0; color: #0d6efd;">🎯 Aufgabe 1</h3>
  <p>Erstelle einen Pod mit folgenden Spezifikationen:</p>
  <ul>
    <li>Name: <code style="background-color: #e9ecef; padding: 2px 4px; border-radius: 3px;">kubelab-pod</code></li>
    <li>Image: <code style="background-color: #e9ecef; padding: 2px 4px; border-radius: 3px;">timlinsenmayer/kubelab-insights:latest</code></li>
    <li>Namespace: <code style="background-color: #e9ecef; padding: 2px 4px; border-radius: 3px;">default</code></li>
  </ul>
</div>

Den Status von Pods kannst du mit `kubectl get pods`{{exec}} überprüfen.

Sobald du den Pod erstellt hast, kannst du mit "CHECK" überprüfen, ob du die Aufgabe erfolgreich erledigt hast. Da das Container-Image erst noch heruntergeladen werden muss, kann es bis zu einer Minute dauern, bis der Pod gestartet ist.

<details>
  <summary>Hilfe/Hinweise</summary>

  ### Imperativer Ansatz   
  Einen (kaum konfigurierten) Pod zu erstellen ist mit dem Befehl `kubectl run {podname} --image={image}` möglich.

  ### Deklarativer Ansatz
  Du kannst den Wunschzustand des Pods in einer YAML-Datei festlegen. Diese kannst du dann mit `kubectl apply -f {dateiname}.yaml` anwenden. Wechsel hierfür in den Editor und erstelle eine neue Datei (rechtsklick in linken, leeren Bereich des Editors => "New File"), die du z.B. `pod.yaml` nennen kannst.

  In diese Datei kannst du folgenden Inhalt einfügen:
  ```yaml
  apiVersion: v1
  kind: Pod
  metadata:
    name: kubelab-pod
  spec:
    containers:
    - name: kubelab-pod
      image: timlinsenmayer/kubelab-insights:latest
  ```

  Wenn du fertig bist, kannst du die Datei speichern und den Befehl `kubectl apply -f pod.yaml` (innerhalb des Editors!) ausführen.
</details>