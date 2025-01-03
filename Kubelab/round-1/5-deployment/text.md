## Aufgabe 5: Skalieren mit Deployment
Bis jetzt hätten wir die App auch auf nur einem Server laufen lassen können. Wir wollen aber, dass unsere App möglichst _ausfallsicher_ laufen kann.

> Wikipedia: Die Ausfallsicherheit ist die definierte Sicherheit gegen einen Ausfall. Sie wird meist durch den Einsatz von _Redundanzen_ erhöht.

Aha, wir brauchen also mehrere Instanzen der App. Und idealerweise sollten wir nicht dreimal Pods selbst erstellen und neustarten. Dafür gibt es **Deployments**.

<div style="background-color: #f8f9fa; border-left: 4px solid #0d6efd; padding: 16px; margin: 16px 0; border-radius: 4px;">
  <h3 style="margin-top: 0; color: #0d6efd;">🎯 Aufgabe 5</h3>
  <p>Erstelle ein Deployment mit folgenden Spezifikationen:</p>
  <ul>
    <li>Name: <code style="background-color: #e9ecef; padding: 2px 4px; border-radius: 3px;">kubelab-deployment</code></li>
    <li>replicas: <code style="background-color: #e9ecef; padding: 2px 4px; border-radius: 3px;">mindestens 3</code></li>
    <li>Image: <code style="background-color: #e9ecef; padding: 2px 4px; border-radius: 3px;">timlinsenmayer/kubelab-insights:latest</code></li>
    <li>Container Port: <code style="background-color: #e9ecef; padding: 2px 4px; border-radius: 3px;">3000</code></li>
    <li>Labels/matchLabels: <code style="background-color: #e9ecef; padding: 2px 4px; border-radius: 3px;">app: kubelab</code></li>
    <li>Namespace: <code style="background-color: #e9ecef; padding: 2px 4px; border-radius: 3px;">default</code></li>
  </ul>
</div>

Im Hintergrund haben wir dir `invalid-pod` und `kubelab-pod` gelöscht, damit dein Deployment nicht fehlschlägt.

<details>
  <summary>Hilfe/Hinweise</summary>

  Für diese Aufgabe musst du eine YAML-Datei (d.h. deklarativer Ansatz) erstellen. Diese kannst du dann mit `kubectl apply -f {dateiname}.yaml` anwenden. Wechsel hierfür in den Editor und erstelle eine neue Datei (rechtsklick in linken, leeren Bereich des Editors => "New File"), die du z.B. `pod.yaml` nennen kannst.

  Du kannst anhand der [offiziellen Dokumentation](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#creating-a-deployment) erfahren, wie du eine solche Datei erstellen kannst.

  Achte unbedingt drauf, dass du die labels/matchLabels korrekt setzt, ansonsten kann das Deployment und der Zugriff über einen Service nicht funktionieren!
</details>