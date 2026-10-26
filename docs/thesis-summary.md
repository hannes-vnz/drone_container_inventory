# Zusammenfassung der Bachelorarbeit

**Drohnengestützte Behälterinventur mittels KI-basierter Segmentierung und Photogrammetrie**
Ostfalia Hochschule für angewandte Wissenschaften, Digital Engineering Maschinenbau (Praxisverbund), 2026.

## Problem

Die Inventur leerer Ladungsträger auf Werksarealen erfolgt manuell: zeitaufwändig, personalintensiv und schnell veraltet. Aus der Luft ist je Stapel nur der oberste Behälter sichtbar. Eine Zählung allein über Bildsegmentierung würde Stapel als einen einzigen Behälter erfassen und den Bestand systematisch unterschätzen.

## Ansatz (hybrid)

1. **Befliegung** mit einer Kleindrohne (DJI Mini 2, 30 m Höhe, Doppelgitter-Wegpunktmission).
2. **Photogrammetrie** mit OpenDroneMap (Docker, Version 3.5.4, auf werkseigener Hardware): georeferenziertes True-Orthophoto und digitales Oberflächenmodell (DSM).
3. **Segmentierung** der Stellflächen auf dem Orthophoto (Segment Anything, automatisch oder per Klickpunkt) über ein überlappendes Fenster, mit globaler Entdopplung im Objektraum.
4. **Fusion:** Die Höhe über Grund aus dem DSM löst die Stapelung auf (Höhe ÷ Nennhöhe = Lagenzahl). Der Boden wird auf der ebenen Lagerfläche einheitlich aus den freien Flächen geschätzt, damit auch im Inneren großer Blöcke eine gültige Höhe entsteht.
5. **Plausibilität:** Abstand der Lagenzahl zur nächsten ganzen Zahl markiert unsichere Stapel zur manuellen Nachprüfung.

Ein rein höhenbasierter Ansatz wurde als Zwischenschritt erprobt. Er verschmilzt dicht gepackte Stellflächen gleicher Höhe und erfasst offenes Gitterleergut nicht. Daraus folgt die Aufgabenteilung: Bild trennt, Höhe stapelt.

## Ergebnisse (Validierungsflug, ein Block mit geschlossenen Behältern)

- 145 von 152 Bildern rekonstruiert, Bodenauflösung 1,0 cm, rund 7.835 m² erfasst.
- Segmentierung: 80 erkannte Instanzen, 79 davon korrekt, keine übersehen. Trefferquote 100 %, Genauigkeit 98,8 %, F1 99,4 %, Zählgenauigkeit 98,7 %.
- Mengenbestimmung: 316 geschätzt gegen 313 von Hand gezählt (Übereinstimmung ca. 99 %). Zwei Stellflächen weichen um eine Lage ab, eine Falscherkennung liegt auf Blattwerk.
- Lagegenauigkeit ohne Passpunkte: 0,73 m (gefordert 0,5 m, **verfehlt**), relative Genauigkeit des Modells 0,08 m. Die Ursache liegt im absoluten Raumbezug über das Bordsignal und ist über signalisierte Passpunkte behebbar.
- Erfassungsdauer: ca. 15 Minuten Feldzeit (reiner Flug ca. 8 Minuten).

## Grenzen

- Die Nennhöhe von 1,5 m wurde aus dem Median (6 m bei vier Lagen) zurückgerechnet, nicht aus Stammdaten. Die Mengenableitung ist damit in sich konsistent, aber nicht unabhängig belegt.
- Offenes, durchsichtiges Gitterleergut wird von beiden Verfahren nicht zuverlässig erfasst (kaum Höhe, optisch zu einer Fläche verschmolzen). Das folgt aus dem Behältertyp und der passiven Sensorik.
- Sehr dicht und ohne sichtbare Fuge stehende Behälter sind aus der Aufsicht nur begrenzt trennbar.
- Ein einzelnes Erfassungsgebiet: Die Ergebnisse zeigen Machbarkeit, keine abschließende Betriebstauglichkeit.

## Ausblick

Ein auf die Behälter trainiertes Modell (Maskenvorschläge aus SAM als Trainingsgrundlage) soll gerade das Gitterleergut und dicht gepackte Gleichteile erfassen. Dazu kommen Passpunkte für den absoluten Raumbezug, hinterlegte Nennhöhen aus den Behälterstammdaten und die Absicherung über mehrere Flächen und Bedingungen.
