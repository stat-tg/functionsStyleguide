#' Hauptfarben-Palette für Füllungen
#'
#' Erstellt eine diskrete Füllskala mit den Hauptfarben der
#' Styleguide-Palette. Die Farben werden unabhängig von der Anzahl
#' der Kategorien verwendet. Mit reverse = TRUE wird die Reihenfolge
#' der Farben umgekehrt.
#'
#' @param reverse Logisch. Wenn TRUE, wird die Reihenfolge der
#'   Farben umgekehrt. Standardmässig FALSE.
#' @param ... Weitere Argumente, die an
#'   [ggplot2::discrete_scale()] übergeben werden.
#'
#' @return Eine diskrete Füllskala für ggplot2.
#' @export


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
