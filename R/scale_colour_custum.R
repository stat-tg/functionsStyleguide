#' Benutzerdefinierte Palette für Umrissfarben
#'
#' Erstellt eine diskrete Farbskala für Umrisse und Linien in ggplot2
#' auf Basis einer benutzerdefinierten Palette. Die Farben werden
#' unabhängig von der Anzahl der Kategorien verwendet. Optional können
#' bestimmte Farben ausgewählt und ihre Reihenfolge umgekehrt werden.
#'
#' @param palette Palette mit den verfügbaren Farben. Standardmässig
#'   wird `border_discrete` verwendet.
#' @param palette_name Name des Elements in `palette`, das die
#'   Farben enthält. Standardmässig `"borderColor"`.
#' @param colors Optionaler Vektor zur Auswahl bestimmter Farben aus
#'   der Palette. Wird `NULL` übergeben, werden alle verfügbaren Farben
#'   verwendet.
#' @param reverse Logisch. Wenn `TRUE`, wird die Reihenfolge der
#'   ausgewählten Farben umgekehrt. Standardmässig `FALSE`.
#' @param ... Weitere Argumente, die an
#'   [ggplot2::discrete_scale()] übergeben werden.
#'
#' @return Eine diskrete Farbskala für die `colour`-Ästhetik in ggplot2.
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
