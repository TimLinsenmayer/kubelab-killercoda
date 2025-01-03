## Aufgabe 6: ☢️ Nuke
Jetzt, wo das Deployment aktiv ist... Simulieren wir mal einen Ausfall eines Pods.
In der Kommandozeile kannst du mit `kubectl get pods`{{exec}} die Pods anzeigen. Hier sollten nun mindestens 3 Pods zu sehen sein. Dies sind die 3+ Replikas, die du im Deployment definiert hast.

Davon darfst du einen frei wählen und löschen. Hierfür kannst du folgende Befehle nutzen:
`POD_NAME=$(kubectl get pods | grep kubelab-deployment | head -n 1 | awk '{print $1}')`{{exec}} - wählt den ersten Pod aus.

`kubectl delete pod $POD_NAME`{{exec}} - löscht den ausgewählten Pod.

`echo "Pod $POD_NAME gelöscht"`{{exec}} - gibt eine Nachricht aus, dass der Pod gelöscht wurde.

Rufe nun `kubectl get pods`{{exec}} erneut auf und überprüfe, ob der Pod gelöscht wurde. Es sollten 3 Pods zu sehen sein, einer davon sollte neu sein und einen anderen Namen haben, als der gelöschte Pod.

Mittels des Deployments (welches wiederum ein ReplicaSet erzeugt) ist sichergestellt, dass immer 3 Pods laufen bzw. erzeugt werden.
