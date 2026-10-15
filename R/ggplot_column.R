#' Säulendiagramm erstellen
#'
#' Erstellt ein Säulendiagramm mit anpassbaren Füll- und Randfarben sowie
#' optionaler Kategorisierung über eine Füllvariable. Die Werte werden auf
#' der numerischen Achse mit Tausendertrennzeichen dargestellt.
#'
#' Wenn eine Füllvariable angegeben wird, werden die Säulen anhand ihrer
#' Kategorien eingefärbt. Andernfalls erhalten alle Säulen eine einheitliche
#' Füllfarbe. Die Randfarbe kann unabhängig davon festgelegt werden.
#'
#' @param data Ein Data Frame mit den darzustellenden Daten.
#' @param y Name der numerischen Variable für die Säulenhöhe.
#' @param x Name der kategorialen Variable auf der horizontalen Achse als
#'   Zeichenkette.
#' @param fill Optionale kategoriale Variable zur Zuordnung der Füllfarben,
#'   angegeben. Wenn \code{NULL}, wird eine einheitliche
#'   Füllfarbe verwendet.
#' @param color Optionale Variable zur Zuordnung der Randfarben als
#'   Zeichenkette. In der aktuellen Implementierung wird dieses Argument
#'   nicht für die Farbzuweisung verwendet.
#' @param title Titel des Diagramms.
#' @param subtitle Untertitel des Diagramms.
#' @param source Quelle der dargestellten Daten. Wird in der Bildunterschrift
#'   zusammen mit dem Hinweis auf das Amt für Daten und Statistik Thurgau
#'   ausgegeben.
#' @param fill_color Index der Füllfarbe aus
#'   \code{maincolors_discrete$fillColor}, wenn keine Füllvariable angegeben ist.
#'   Standardmässig \code{1}.
#' @param border_color Index der Randfarbe aus
#'   \code{border_discrete$borderColor}. Standardmässig \code{1}.
#'
#' @return Ein \code{ggplot}-Objekt, das weiter angepasst oder mit
#'   \code{print()} ausgegeben werden kann.
#'
#' @examples
#' \dontrun{
#' # Einfaches Säulendiagramm
#' ggplot_column(
#'   data = tab_bev |> dplyr::mutate(jahr = as.character(jahr)),
#'   x = "jahr",
#'   y = "n",
#'   title = "Bevölkerungsentwicklung",
#'   subtitle = "Bevölkerung nach Jahr",
#'   source = "Kantonale Bevölkerungsstatistik",
#'   fill_color = 1,
#'   border_color = 1
#' )
#' }
#'
#' @export
ggplot_column <- function(
    data,
    y,
    x,
    fill = NULL,
    color = NULL,
    title = NULL,
    subtitle = NULL,
    source = NULL,
    fill_color = 1,
    border_color = 1
) {

  # Basic plot
  p <- ggplot2::ggplot(
    data,
    ggplot2::aes(
      x = .data[[x]],
      y = .data[[y]]
    )
  )

  # Add fill mapping only if a categorical variable is supplied
  if (!is.null(fill)) {
    p <- p +
      ggplot2::aes(fill = .data[[fill]]) +
      ggplot2::geom_col(
        colour = border_discrete$borderColor[border_color]
      ) +
      ggplot2::scale_fill_manual(
        values = maincolors_discrete$fillColor
      ) +
      ggplot2::scale_color_manual(
        values = border_discrete$borderColor[border_color]
      )
  } else {
    p <- p +
      ggplot2::geom_col(
        fill = maincolors_discrete$fillColor[fill_color],
        colour = border_discrete$borderColor[border_color]
      )
  }

  p +

    theme_bar_grid_horizontal +
    theme(
      plot.caption = ggplot2::element_text(hjust = 0),
      plot.title.position = "plot",
      plot.caption.position = "plot",
      legend.position = "top",
      legend.justification = "left",
      legend.location = "plot"
    ) +
    ggplot2::scale_y_continuous(
      labels = scales::label_comma(big.mark = "'"),
      expand = c(0, 0)
    ) +
    ggplot2::scale_x_discrete(
      expand = c(0, 0)
    ) +
    ggplot2::labs(
      title = title,
      subtitle = subtitle,
      x = "",
      y = "",
      caption = paste(
        "Amt für Daten und Statistik Thurgau\nDatenquelle:",
        source
      )
    ) + geom_text(aes(label = scales::comma(jahr, big.mark = "'")),
                            hjust=1.5, color="white", size=4.5, fontface="bold")
}
# ggplot_column(data = tab_bev %>% mutate(jahr=as.character(jahr)),
#               x = "jahr",
#               y = "n",
#               title = "TITEL",
#               subtitle = "UNTERTITEL",
#               source = "Kantonale Bevölkerungsstatistik",
#               fill_color = 1,
#               border_color = 1)
