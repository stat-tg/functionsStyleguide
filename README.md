
<!-- README.md is generated from README.Rmd. Please edit that file -->

# functionsStyleguide

<!-- badges: start -->

<!-- badges: end -->

Das Package **functionsStyleguide** enthält die Farbpalette gemäss
Styleguide des Amts für Daten und Statistik sowie einige Funktionen für
ggplot-Grafiken gemäss <a
href="https://posit-connect.tg.ch/content/cede7492-b81a-42f0-92f4-b0ecd3e16f56"
target="_blank">Styleguide</a>.

## Installation über Github

``` r
# install.packages("devtools")
devtools::install_github("https://github.com/stat-tg/functionsStyleguide.git")
```

## Nutzung der Farbpaletten

Im Package sind verschieden Palettensammlungen hinterlegt, die direkt in
den ggplot-Funktionen verwendet werden können, je für die Füllfarben und
die Farben für die Ränder (bei Balken, Säulen oder Flächen).

Hier ein Überblick über die verschiedenen Palettensammlungen mit den
jeweiligen Paletten:

### maincolors_discrete

Die Palettensammlung `maincolors_discrete`enthält die Hauptfarben für
kategoriale Variablen (`fillColor`) sowie eine Palette mit den
Highlight-Farben für Linien und Hervorhebungen (`fillHighlight`)sowie
eine Palette mit dem Hauptblau und verschiedenen Grautönen
(`fillBlueGreys`).

<iframe src="screenshots/maincolors_discrete.png" width="800" height="200" frameborder="0">

</iframe>

### border_discrete

Die Palettensammlung`border_discrete` ergänzt die Palette
`maincolors_discrete` für jene Grafiken, wo eine Umrandung in dunklerer
Farbe ergänzt wird (z.B. Balken, Säulen, Flächen): Umrissfarben für
kategoriale Variablen (`borderColor`), eine Palette mit den
Highlight-Farben für Linien und Hervorhebungen (`borderHighlight`)sowie
eine Palette mit dem Hauptblau und verschiedenen Grautönen
(`borderBlueGreys`).

<iframe src="screenshots/border_discrete.png" width="800" height="200" frameborder="0">

</iframe>

### colors_sequential

Die Palettensammlung`colors_sequential` ergänzt die Palette
`maincolors_discrete` für jene Grafiken, wo eine Umrandung in dunklerer
Farbe ergänzt wird (z.B. Balken, Säulen, Flächen): Umrissfarben für
kategoriale Variablen (`borderColor`), eine Palette mit den
Highlight-Farben für Linien und Hervorhebungen (`borderHighlight`)sowie
eine Palette mit dem Hauptblau und verschiedenen Grautönen
(`borderBlueGreys`).

<iframe src="screenshots/colors_sequential.png" width="800" height="200" frameborder="0">

</iframe>

### border_sequential

Die Palettensammlung`border_sequential` ergänzt die Palette
`maincolors_discrete` für jene Grafiken, wo eine Umrandung in dunklerer
Farbe ergänzt wird (z.B. Balken, Säulen, Flächen): Umrissfarben für
kategoriale Variablen (`borderColor`), eine Palette mit den
Highlight-Farben für Linien und Hervorhebungen (`borderHighlight`)sowie
eine Palette mit dem Hauptblau und verschiedenen Grautönen
(`borderBlueGreys`).

<iframe src="screenshots/border_sequential.png" width="800" height="200" frameborder="0">

</iframe>

### colors_divergent

Die Palettensammlung`colors_divergent` ergänzt die Palette
`maincolors_discrete` für jene Grafiken, wo eine Umrandung in dunklerer
Farbe ergänzt wird (z.B. Balken, Säulen, Flächen): Umrissfarben für
kategoriale Variablen (`borderColor`), eine Palette mit den
Highlight-Farben für Linien und Hervorhebungen (`borderHighlight`)sowie
eine Palette mit dem Hauptblau und verschiedenen Grautönen
(`borderBlueGreys`).

<iframe src="screenshots/colors_divergent.png" width="800" height="200" frameborder="0">

</iframe>

### border_divergent

Die Palettensammlung`border_divergent` ergänzt die Palette
`maincolors_discrete` für jene Grafiken, wo eine Umrandung in dunklerer
Farbe ergänzt wird (z.B. Balken, Säulen, Flächen): Umrissfarben für
kategoriale Variablen (`borderColor`), eine Palette mit den
Highlight-Farben für Linien und Hervorhebungen (`borderHighlight`)sowie
eine Palette mit dem Hauptblau und verschiedenen Grautönen
(`borderBlueGreys`).

<iframe src="screenshots/border_divergent.png" width="800" height="200" frameborder="0">

</iframe>

### party_colors

Die Palettensammlung`party_colors` ergänzt die Palette
`maincolors_discrete` für jene Grafiken, wo eine Umrandung in dunklerer
Farbe ergänzt wird (z.B. Balken, Säulen, Flächen): Umrissfarben für
kategoriale Variablen (`borderColor`), eine Palette mit den
Highlight-Farben für Linien und Hervorhebungen (`borderHighlight`)sowie
eine Palette mit dem Hauptblau und verschiedenen Grautönen
(`borderBlueGreys`).

<iframe src="screenshots/party_colors.png" width="800" height="200" frameborder="0">

</iframe>

### colors_gender

Die Palettensammlung`colors_gender` ergänzt die Palette
`maincolors_discrete` für jene Grafiken, wo eine Umrandung in dunklerer
Farbe ergänzt wird (z.B. Balken, Säulen, Flächen): Umrissfarben für
kategoriale Variablen (`borderColor`), eine Palette mit den
Highlight-Farben für Linien und Hervorhebungen (`borderHighlight`)sowie
eine Palette mit dem Hauptblau und verschiedenen Grautönen
(`borderBlueGreys`).

<iframe src="screenshots/colors_gender.png" width="800" height="200" frameborder="0">

</iframe>

### border_gender

Die Palettensammlung`border_gender` ergänzt die Palette
`maincolors_discrete` für jene Grafiken, wo eine Umrandung in dunklerer
Farbe ergänzt wird (z.B. Balken, Säulen, Flächen): Umrissfarben für
kategoriale Variablen (`borderColor`), eine Palette mit den
Highlight-Farben für Linien und Hervorhebungen (`borderHighlight`)sowie
eine Palette mit dem Hauptblau und verschiedenen Grautönen
(`borderBlueGreys`).

<iframe src="screenshots/border_gender.png" width="800" height="200" frameborder="0">

</iframe>

### colors_regions

Die Palettensammlung`colors_regions` ergänzt die Palette
`maincolors_discrete` für jene Grafiken, wo eine Umrandung in dunklerer
Farbe ergänzt wird (z.B. Balken, Säulen, Flächen): Umrissfarben für
kategoriale Variablen (`borderColor`), eine Palette mit den
Highlight-Farben für Linien und Hervorhebungen (`borderHighlight`)sowie
eine Palette mit dem Hauptblau und verschiedenen Grautönen
(`borderBlueGreys`).

<iframe src="screenshots/colors_regions.png" width="800" height="200" frameborder="0">

</iframe>

### border_regions

Die Palettensammlung`border_regions` ergänzt die Palette
`maincolors_discrete` für jene Grafiken, wo eine Umrandung in dunklerer
Farbe ergänzt wird (z.B. Balken, Säulen, Flächen): Umrissfarben für
kategoriale Variablen (`borderColor`), eine Palette mit den
Highlight-Farben für Linien und Hervorhebungen (`borderHighlight`)sowie
eine Palette mit dem Hauptblau und verschiedenen Grautönen
(`borderBlueGreys`).

<iframe src="screenshots/border_regions.png" width="800" height="200" frameborder="0">

</iframe>

<!-- ## Nutzung der ggplot-Funktionen -->

## Example

<!-- Hier noch Beispiele ergänzen -->

This is a basic example which shows you how to solve a common problem:

``` r
# library(functionsStyleguide)
## basic example code
```

------------------------------------------------------------------------

## Kontakt

**Entwicklung & Support** Amt für Daten und Statistik Kanton Thurgau
