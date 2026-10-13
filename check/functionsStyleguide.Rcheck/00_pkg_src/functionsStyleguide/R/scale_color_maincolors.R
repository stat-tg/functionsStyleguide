#' Nutzung Palette Hauptfarben
#'
#' Funktion zur Nutzung der Palette mit den Hauptfarben unabhängig von der Anzahl Kategorien für die Füllung von Flächen in Grafiken
#'

#'
#' @return Einfarbung gemäss Palette
#' @export
scale_colour_maincolors <- function(...) {
  ggplot2::discrete_scale(
    aesthetics = "colour",
    scale_name = "maincolors",
    palette = function(n) {
      maincolors_discrete$fillHighlight[seq_len(n)]
    },
    ...
  )
}
