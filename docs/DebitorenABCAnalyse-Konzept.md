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

## Bestätigte Rahmenbedingungen

Die fachliche Abstimmung hat für die erste Ausbaustufe folgende Entscheidungen bestätigt:

1. **Persistenz**
   - Die Klasse wird auf Tabellenebene dauerhaft am Debitor gespeichert.
2. **Ausführungszeitpunkt**
   - Die Analyse wird zunächst manuell gestartet.
   - Eine spätere Automatisierung soll möglich bleiben.
3. **Zeitraum**
   - `Sales (LCY)` wird über den gesamten Zeitraum ausgewertet.
4. **Rückmeldung des Reports**
   - Der Report liefert keine zusätzliche Rückmeldung nach der Verarbeitung.
5. **Performance- und Sperrverhalten**
   - Für die erste Version sind hierzu keine besonderen Maßnahmen erforderlich.
6. **Testumfang**
   - Es sind einfache Tests für die Kernlogik vorgesehen.
7. **Manuelle Pflege**
   - Die Klasse wird ausschließlich systemseitig gepflegt.
   - Eine manuelle Überschreibung ist nicht zulässig.

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
