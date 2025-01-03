## "Aufgabe" 4: Intermezzo

Bevor wir weiter machen, sehen wir uns die bereitgestellte App an. Falls du den Tab schon geschlossen hast, kannst du ihn wieder öffnen: [Klick mich!]({{TRAFFIC_HOST1_30000}}).

Die Anwendung dient dazu, möglichst einfach Kubernetes-Optionen testen zu können. Im Detail gibt es folgende Funktionen:

- **Farbleiste oben**: Die Farbe der Leiste wird zu Beginn zufällig ausgewählt. Wir werden die Leiste später nutzen, um zu wissen, auf welchem Pod wir gelandet sind.
- **Umgebungsvariablen**: Dies sind alle Umgebungsvariablen, die zur Laufzeit der App verfügbar sind. Kubernetes hat eigene Umgebungsvariablen hinzugefügt, die z.B. Verbindungsinformationen enthalten.
- **Secrets**: Dies sind alle Secrets, welche per Definition als Kubernetes-Secret angebunden wurden.
- **Terminal**: Mithilfe des Terminals können Befehle innerhalb des Containers ausgeführt werden. Das Terminal läuft mit Root-Rechten mit den bekannten Bash-Befehlen.
    - z.B. ist eine Eingabe von `curl localhost:3000` äquivalent zum Befehl `kubectl exec kubelab-pod -- curl localhost:3000`{{exec}}.
    - weitere nützliche Befehle sind `ls`, `cd`, `cat`, `echo` und `clear`.

Für weitere Aufgaben, z.B. auch in der anderen Runde, kannst du jederzeit die App im Cluster aufnehmen.

<ul>
    <li>Name: <code style="background-color: #e9ecef; padding: 2px 4px; border-radius: 3px;">kubelab-pod</code></li>
    <li>Image: <code style="background-color: #e9ecef; padding: 2px 4px; border-radius: 3px;">timlinsenmayer/kubelab-insights:latest</code></li>
</ul>