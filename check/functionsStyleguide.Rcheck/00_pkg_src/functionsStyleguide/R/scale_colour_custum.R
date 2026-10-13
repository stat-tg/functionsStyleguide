#' Nutzung Palette für Border-Farben
#'
#' Funktion zur Nutzung der Palette mit den Hauptfarben unabhängig von der Anzahl Kategorien für die Einfärbung von Umrissen der Flächen in Grafiken
#'

#'
#' @return Einfarbung gemäss Palette
#' @export
scale_colour_custom <- function(
    palette = border_discrete,
    palette_name = "borderColor",
    colors = NULL,
    reverse = FALSE,
    ...
) {

  ggplot2::discrete_scale(
    aesthetics = "colour",
    # scale_name = "custom_colour",
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
