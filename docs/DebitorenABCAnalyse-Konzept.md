# Lösungskonzept Debitoren ABC-Analyse

## Ziel

Debitoren sollen anhand ihres Umsatzanteils (`Customer."Sales (LCY)"`) in die Klassen **A**, **B** und **C** eingeteilt werden, damit Vertrieb und Management die wichtigsten Kunden schnell erkennen.

## Fachlicher Zuschnitt

- **Datenbasis:** `Customer."Sales (LCY)"` über den gesamten verfügbaren Zeitraum
- **Klassifizierung:** feste Pareto-Schwellen
  - **A:** erste 50 % des kumulierten Gesamtumsatzes
  - **B:** nächste 30 %
  - **C:** letzte 20 %
- **Sonderfall:** Debitoren ohne Umsatz erhalten eine leere Klasse
- **Ausführung:** manuell über eine Aktion in der Debitorenliste sowie über die Berichtssuche

## Technisches Zielbild

Die Umsetzung orientiert sich an der im ursprünglichen Feature-Entwurf beschriebenen Struktur:

1. **Enum `ABC Class`**
   - Werte: leer, A, B, C
2. **Table Extension `Customer ABC`**
   - neues, nicht direkt editierbares Feld `ABC Class` am Debitor
3. **Temporäre Puffertabelle `Customer ABC Buffer`**
   - hält Debitor, Umsatz und Sortier-/Kumulierungshilfen für die Berechnung
4. **Processing-Only Report `Customer ABC Analysis`**
   - sammelt Debitoren mit Umsatz
   - sortiert nach Umsatz absteigend
   - berechnet den kumulierten Anteil
   - schreibt die ermittelte Klasse in den Debitor
   - setzt Debitoren ohne Umsatz auf leer
5. **Page Extension `Customer List`**
   - zeigt die Klasse
   - startet die Analyse per Aktion
6. **Page Extension `Customer Card`**
   - zeigt die Klasse auf der Karte

## Vorschlag für den Verarbeitungsablauf

1. Gesamtumsatz aller relevanten Debitoren bestimmen
2. Debitoren mit Umsatz in einen temporären Puffer schreiben
3. Puffer nach Umsatz absteigend verarbeiten
4. Kumulierten Umsatz laufend erhöhen
5. Klasse anhand der erreichten Schwelle bestimmen
6. Feld `ABC Class` am Debitor aktualisieren
7. Debitoren ohne Umsatz auf leere Klasse zurücksetzen

## Klärungsfragen

Vor der eigentlichen Implementierung sollten diese Punkte bestätigt werden:

1. **Persistenz**
   - Soll die Klasse dauerhaft im Debitor gespeichert werden oder nur bei Bedarf berechnet angezeigt werden?
2. **Ausführungszeitpunkt**
   - Reicht ein manueller Reportlauf oder wird zusätzlich ein geplanter Hintergrundlauf benötigt?
3. **Datenverständnis**
   - Soll `Sales (LCY)` bewusst den gesamten Zeitraum abdecken oder wird später doch ein Filter (z. B. Geschäftsjahr) benötigt?
4. **Transparenz**
   - Soll der Report am Ende nur eine Erfolgsmeldung zeigen oder zusätzlich Anzahl der aktualisierten Debitoren zurückmelden?
5. **Sperr- und Performance-Verhalten**
   - Ist die Verarbeitung für größere Debitorenbestände ausreichend, oder werden Batch-/Commit-Überlegungen benötigt?
6. **Manuelle Pflege**
   - Ist die Klasse ausschließlich systemseitig gepflegt oder soll es perspektivisch eine fachliche Übersteuerung geben?
7. **Testabdeckung**
   - Welche fachlichen Beispiele sollen mindestens automatisiert validiert werden (z. B. Grenzwerte 50/80/100 % und Debitoren ohne Umsatz)?

## Umsetzungs-Runbook

1. AL-Objekte gemäß Zielbild im Bereich 50000-50999 anlegen
2. Reportlogik mit temporärem Puffer implementieren
3. Klassenfeld auf Debitorenliste und Debitorenkarte anzeigen
4. Test-App um Szenarien für A/B/C-Zuordnung und Null-Umsatz erweitern
5. Pull-Request-Build in AL-Go ausführen

## Erwartetes Ergebnis nach Implementierung

- Debitorenliste und Debitorenkarte zeigen die ABC-Klasse an
- Eine Aktion startet die Analyse für alle Debitoren
- Die Klassifizierung folgt konsistent der 50/30/20-Logik
- Debitoren ohne Umsatz bleiben ungekennzeichnet
