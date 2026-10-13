#' Nutzung Palette für Füllfarben
#'
#' Funktion zur Nutzung der Palette mit den Hauptfarben unabhängig von der Anzahl Kategorien für die Einfärbung von Flächen in Grafiken
#'

#'
#' @return Einfarbung gemäss Palette
#' @export
scale_fill_custom <- function(
    palette = maincolors_discrete,
    palette_name = "fillColor",
    colors = NULL,
    reverse = FALSE,
    ...
) {

  ggplot2::discrete_scale(
    aesthetics = "fill",
    scale_name = "custom_fill",
    palette = function(n) {

      cols <- palette[[palette_name]]

      if (!is.null(colors)) {
        cols <- cols[colors]
      }

      cols <- cols[seq_len(n)]

      if (reverse) {
        cols <- rev(cols)
      }

      cols
    },
    ...
  )
}
