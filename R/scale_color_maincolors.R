#' Hauptfarben-Palette für Linien und Umrisse
#'
#' Erstellt eine diskrete Farbskala mit den Highlight-Farben der
#' Hauptfarben-Palette. Die Farben werden unabhängig von der Anzahl
#' der Kategorien für Linien und Umrisse in ggplot2 verwendet.
#'
#' @param ... Weitere Argumente, die an
#'   [ggplot2::discrete_scale()] übergeben werden.
#'
#' @return Eine diskrete Farbskala für die `colour`-Ästhetik in ggplot2.
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
