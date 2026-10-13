#' Nutzung Palette Hauptfarben für Border-Farben
#'
#' Funktion zur Nutzung der Palette mit den Hauptfarben unabhängig von der Anzahl Kategorien für die Einfärbung der Umrisse von Flächen in Grafiken
#'

#'
#' @return Einfarbung gemäss Palette
#' @export
# scale_colour_main_borders <- function(...) {
#   ggplot2::discrete_scale(
#     aesthetics = "colour",
#     palette = function(n) {
#       border_discrete$borderColor[seq_len(n)]
#     },
#     ...
#   )
# }
scale_colour_main_borders <- function(reverse = FALSE, ...) {

  ggplot2::discrete_scale(
    aesthetics = "colour",
    palette = function(n) {

      cols <- border_discrete$borderColor[seq_len(n)]

      if (reverse) {
        cols <- rev(cols)
      }

      cols
    },
    ...
  )
}
