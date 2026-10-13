#' Nutzung Palette Hauptfarben für Linien / Highlighting
#'
#' Funktion zur Nutzung der Palette mit den Hauptfarben unabhängig von der Anzahl Kategorien für die Einfärbung von Linien in Grafiken
#'
#'
#' @return Einfarbung gemäss Palette
#' @export
# scale_fill_maincolors <- function(...) {
#   ggplot2::discrete_scale(
#     aesthetics = "fill",
#     scale_name = "maincolors",
#     palette = function(n) {
#       maincolors_discrete$fillColor[seq_len(n)]
#     },
#     ...
#   )
# }

scale_fill_maincolors <- function(reverse = FALSE, ...) {

  ggplot2::discrete_scale(
    aesthetics = "fill",
    scale_name = "maincolors",
    palette = function(n) {

      cols <- maincolors_discrete$fillColor[seq_len(n)]

      if (reverse) {
        cols <- rev(cols)
      }

      cols
    },
    ...
  )
}
