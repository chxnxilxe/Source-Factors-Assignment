# Source Factors Assignment
Abgabe für den Kurs *'Informationsverhalten verstehen und verarbeiten'*.

Hier wurden die Daten für und von der Studie dokumentiert (nachträglich).

## Overleaf-Projekt
[Link zum Overleaf-Projekt](https://www.overleaf.com/read/fcmmprhfprfn#de472f
)


## Studie
### Appscript Projekt
[Link zum Appscript-Projekt](https://script.google.com/d/12qTPKH99RxdrZaPnrXIHR_y1fZ7tqdMHAH6OesRuVW47habvdjR_W8pN/edit?usp=sharing
)

Die Web-App wurde mit *Google-Appscript* erstellt, die die Teilnehmenden zu einem der 8 Google Forms weiterleitet (zufällig).
Inhaltlicher Aufbau:
- Willkommensseite
- Einverständniserklärung
- Weiterleitung zu einem der 8 Google-Forms

### Verlinkung zu Google-Forms
[Link zum Google-Forms + Einverständniserklärung](https://drive.google.com/drive/folders/1Qjl_7AUZGGmSOF9uxcONkYxvLVjTEcDF?usp=sharing
)

Die Einverständniserklärung wurde mit dem [Informed Consent Generator](https://hci-studies.org/informed-consent-generator/) generiert.

Inhaltlicher Aufbau eines Formulars:
- Bewertung von 8 Artikeln (*Artikel 1*: 1 von 8 Reizen für den 1. Inputartikel, *Artikel 2*: 1 von 8 Reizen für den 2. Inputartikel)
- Demographische Daten
- Fragen zur Selbsteinschätzung (Grant, A. M.et al., 2002 und )

## Daten für die Studie
### Artikelgenerierung mit R-Studio (s. *Project*)
Das R-Studio Projekt enthält
- Bilder für alle 8 Inputartikel (related_images_1 = Bilder vom 1. Inputartikel; 1.=Titelbild, 2.-4.=Related Images)
- Bilder für Werbung
- CSV-Datei (articles.csv) mit Artikeltitel, Text, Quelle und Titel der weiterführenden Artikel: 8 Inputartikel manipuliert in low/high/fake/true language
- Code für die Generierung (überarbeitet)
Der Code ordnet die 8 Templates für high- und low-quality in zufälliger Reihenfolge und erstellt jeweils 8 Artikel (jede Iteration des ganzen Codes: 16 Artikel) mit den Texten von articles.csv.
Der Index muss von 1-8, 9-16, 17-24, 25-32 angepasst werden, um alle 32 Texte von articles.csv zu verwenden - jede Iteration verwendet 8 Artikel mit 2 manipulierten Inputartikel - Bilder wurden entsprechend indiziert

### Generierte Artikel
Die 64 fertigen Artikel wurden gescreenshottet und nach den Reizen in separaten Ordnern auf [Google Drive](https://drive.google.com/drive/folders/12vB-Tb_2l3PmFyk5MX5HoP9em54jEKbd?usp=sharing) geordnet.


## Ergebnisse der Datenauswertung (s. *SPSS*)
Für die Datenauswertung haben wir *SPSS* verwendet.
Der Ordner enthält
- Datensatz (Ergebnisse der Forms von Google Sheets)
- Datenausgabe
