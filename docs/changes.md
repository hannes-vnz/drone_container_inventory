# Änderungen gegenüber dem Code der Arbeit

Die Logik der Pipeline ist unverändert. Geändert wurde, was sie ausführbar, testbar und portabel macht.

| Bereich | Vorher | Jetzt |
|---|---|---|
| Struktur | lose Skripte, `from config import ...` | installierbares Paket `containerinv`, CLI `containerinv <befehl>` |
| Pfade | fester Pfad `D:\Bachelor2` in `config.py` | `--project`, `--ortho`, `--dsm` oder `CONTAINERINV_PROJECT`; Standard `./data` |
| Selbsttest | `_selftest.py`, schreibt Dateien ins Arbeitsverzeichnis | `containerinv demo` und `pytest` (tmp-Verzeichnisse), CI über GitHub Actions |
| Evaluation | manuell beschrieben (Abschnitt 8.2) | `evaluate.py` setzt Zuordnung, Trefferquote, Genauigkeit, F1, Zählgenauigkeit und Mengenvergleich um; ein Test reproduziert die Zahlen der Arbeit (80/79, 316/313) |
| `sample_polygon` | Maske über das gesamte Raster je Instanz | Maske nur im Fenster um die Geometrie (gleiches Ergebnis, im Test gegen die volle Maske geprüft) |
| `detect` | Bodenfläche im Feinraster (bei 1-2 cm sehr langsam) | Bodenfläche auf grobem Raster (`ground_downsample_m`, Standard 0,25 m); Test: gleiche Anzahl und Höhen innerhalb 0,1 m |
| Kachel-PNG | OpenCV | Pillow (eine Abhängigkeit weniger) |
| GUI-Werkzeuge | je eigene `_read_ortho` | gemeinsame `read_ortho_preview` in `geo_utils` |
| `attach_height` / `sample_metrics` / `tile_orthophoto` | – | umbenannt zu `heights` / `estimate` / `tiling`; `estimate` nimmt die Nennhöhe per `--nominal-height` |

Nicht im Repository: Rohbilder, Orthophoto, DSM und die Arbeit als PDF.
