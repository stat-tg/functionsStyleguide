#' Einfache Balkengrafik
#'
#' Funktion zur Darstellung von Daten als Balkengrafik mit ggplot2 gemäss dem Design Styleguide des
#' Amts für Daten und Statistik
#'
#' @param data Datensatz, der als Balkengrafik dargestellt werden soll
#' @param y Variable, die auf der y-Achse dargestellt werden soll
#' @param x Variable, die auf der x-Achse dargestellt werden soll (bspw. das Jahr)
#' @param title Titel
#' @param subtitle Untertitel
#' @param source Datenquelle
#' @param fill_color Erlaubt die Auswahl einer Füllfarber aus der Palette mit den Hauptfarben
#' #'   `maincolors_discrete$fillColor`. Wird verwendet, wenn `fill_colors` auf `NULL` gesetzt ist.
#'   Default ist `1` sprich '#1D6AA22'.
#' @param border_color Erlaubt die Auswahl einer Farbe für den Umriss aus der Palette mit den Hauptfarben
#'    `border_discrete$borderColor`. Wird verwendet, wenn `border_colors` auf
#'   `NULL` gesetzt ist. Default ist `1` resp. '#175582'.
#' @param fill_colors Optionale Möglichkeit, die Füllfarben pro Balken zu wählen, bspw. um einen Balken speziell
#'   hervorzuheben.
#'   Balken ohne Definition entsprechen der ersten Farbe von `fill_color`.
#' @param border_colors Optionale Möglichkeit, die Farben für die Umrisse pro Balken zu wählen, bspw. um einen Balken speziell
#'   hervorzuheben.
#'   Balken ohne Definition entsprechen der ersten Farbe von `border_color`.
#'

#' @return ggplot Balkengrafik
#'
#' @examples
#' \dontrun{
#' # Use the default fill and border colours
#' ggplot_bar(
#'   data = tab_bev,
#'   x = "jahr",
#'   y = "n",
#'   title = "Bevölkerungsentwicklung"
#' )
#'
#' # Specify individual fill and border colours
#' ggplot_bar(
#'   data = tab_bev,
#'   x = "jahr",
#'   y = "n",
#'   fill_colors = c(
#'     "2019" = "#4477AA",
#'     "2020" = "#EE6677",
#'     "2021" = "#228833"
#'   ),
#'   border_colors = c(
#'     "2019" = "#222222",
#'     "2020" = "#222222",
#'     "2021" = "#555555"
#'   )
#' )
#' }
#'
#' @export
#'
ggplot_bar <- function(
    data,
    y,
    x,
    title = NULL,
    subtitle = NULL,
    source = NULL,
    fill_color = 1,
    border_color = 1,
    fill_colors = NULL,
    border_colors = NULL
) {

  # Identify all categories on the x-axis
  x_values <- unique(as.character(data[[x]]))

  # Fill colours: use the supplied colours where available,
  # and the default palette colour for all other categories
  if (!is.null(fill_colors)) {
    default_fill <- maincolors_discrete$fillColor[fill_color]

    all_fill_colors <- stats::setNames(
      rep(default_fill, length(x_values)),
      x_values
    )

    matched_fill <- intersect(names(fill_colors), x_values)
    all_fill_colors[matched_fill] <- fill_colors[matched_fill]
  }

  # Border colours: use the supplied colours where available,
  # and the default palette colour for all other categories
  if (!is.null(border_colors)) {
    default_border <- border_discrete$borderColor[border_color]

    all_border_colors <- stats::setNames(
      rep(default_border, length(x_values)),
      x_values
    )

    matched_border <- intersect(names(border_colors), x_values)
    all_border_colors[matched_border] <- border_colors[matched_border]
  }

  # Build plot
  p <- ggplot2::ggplot(
    data,
    ggplot2::aes(
      x = .data[[x]],
      y = .data[[y]]
    )
  )

  # Map fill only if individual fill colours are supplied
  if (!is.null(fill_colors)) {
    p <- p +
      ggplot2::aes(fill = .data[[x]])
  }

  # Map border only if individual border colours are supplied
  if (!is.null(border_colors)) {
    p <- p +
      ggplot2::aes(colour = .data[[x]])
  }

  # Draw bars once
  geom_args <- list()

  if (is.null(fill_colors)) {
    geom_args$fill <-
      maincolors_discrete$fillColor[fill_color]
  }

  if (is.null(border_colors)) {
    geom_args$colour <-
      border_discrete$borderColor[border_color]
  }

  p <- p +
    do.call(ggplot2::geom_col, geom_args)

  # Apply complete fill scale
  if (!is.null(fill_colors)) {
    p <- p +
      ggplot2::scale_fill_manual(
        values = all_fill_colors,
        drop = FALSE,
        guide = "none"
      )
  }

  # Apply complete border scale
  if (!is.null(border_colors)) {
    p <- p +
      ggplot2::scale_colour_manual(
        values = all_border_colors,
        drop = FALSE,
        guide = "none"
      )
  }

  # Theme, axes and labels
  p +
    theme_bar_grid_vertical +
    ggplot2::scale_x_discrete(
      expand = c(0, 0)
    ) +
    ggplot2::scale_y_continuous(
      labels = scales::label_comma(big.mark = "'"),
      position = "right",
      expand = ggplot2::expansion(mult = c(0, 0.05))
    ) +
    ggplot2::labs(
      title = title,
      subtitle = subtitle,
      x = "",
      y = "",
      caption = paste(
        "Amt für Daten und Statistik\nDatenquelle:",
        source
      )
    ) +
    ggplot2::coord_flip(clip = "off") +
    ggplot2::theme(
      plot.margin = ggplot2::margin(
        t = 10,
        r = 15,
        b = 10,
        l = 10
      ),
      plot.caption = ggplot2::element_text(hjust = 0),
      plot.title.position = "plot",
      plot.caption.position = "plot",
      legend.position = "top",
      legend.justification = "left",
      legend.location = "plot"
    )
}
# ggplot_bar(data = tab_bev %>% mutate(jahr=as.character(jahr)), y = "n", x = "jahr",
#            title = "Bevölkerung wird älter", subtitle = "Kanton Thurgau, Ständige Wohnbevölkerung nach Altersklassen, 2015-2025",
#            source = "Kantonale Bevölkerungsstatistik", fill_color = 2, border_color = 2)
#
# ggplot_bar(data=tab_bev %>% mutate(jahr=as.character(jahr)),
#            x = "jahr", y = "n",
#            title = "Bevölkerung wird älter", subtitle = "Kanton Thurgau, Ständige Wohnbevölkerung nach Altersklassen, 2015-2025",
#            source = "Kantonale Bevölkerungsstatistik",
#            fill_colors = c(
#              "2015" = "#bebebe",
#              "2016" = "#bebebe",
#              "2017" = "#bebebe",
#              "2018" = "#bebebe",
#              "2019" = "#bebebe",
#              "2020" = "#bebebe",
#              "2021" = "#0355ac",
#              "2022" = "#bebebe",
#              "2023" = "#bebebe",
#              "2024" = "#bebebe",
#              "2025" = "#bebebe"
#            ),
#            border_colors = c(
#              "2015" = "#989898",
#              "2016" = "#989898",
#              "2017" = "#989898",
#              "2018" = "#989898",
#              "2019" = "#989898",
#              "2020" = "#989898",
#              "2021" = "#02448a",
#              "2022" = "#989898",
#              "2023" = "#989898",
#              "2024" = "#989898",
#              "2025" = "#989898"
#            )
#            )
