#' Hauptfarben-Palette für Umrissfarben
#'
#' Erstellt eine diskrete Farbskala mit den Umrissfarben der
#' Styleguide-Palette. Die Farben werden unabhängig von der Anzahl
#' der Kategorien für die Umrisse von Flächen und andere Linien in
#' ggplot2 verwendet. Mit `reverse = TRUE` wird die Reihenfolge
#' der Farben umgekehrt.
#'
#' @param reverse Logisch. Wenn `TRUE`, wird die Reihenfolge der
#'   Farben umgekehrt. Standardmässig `FALSE`.
#' @param ... Weitere Argumente, die an
#'   [ggplot2::discrete_scale()] übergeben werden.
#'
#' @return Eine diskrete Farbskala für die `colour`-Ästhetik in ggplot2.
#' @export

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
