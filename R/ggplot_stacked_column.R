#' Gestapeltes Säulendiagramm gemäss Styleguide
#'
#' Erstellt ein gestapeltes Säulendiagramm auf Basis eines Datensatzes.
#' Die Säulen können nach einer Kategorie eingefärbt und mit kategorienabhängigen
#' Rahmenfarben versehen werden. Die Farben werden aus den definierten
#' Farbpaletten \code{maincolors_discrete$fillColor} und
#' \code{border_discrete$borderColor} ausgewählt.
#'
#' Über den Parameter \code{position} kann gesteuert werden, ob die Säulen
#' gestapelt oder beispielsweise nebeneinander dargestellt werden.
#' Titel, Untertitel und Datenquelle können optional angegeben werden.
#'
#' @param data Ein Data Frame mit den darzustellenden Daten.
#' @param y Name der numerischen Variable für die
#'   Säulenhöhe.
#' @param x Name der Variable für die x-Achse.
#' @param fill Optionaler Name der Variable, nach der
#'   die Säulenfüllung kategorisiert wird. Die Kategorien werden mit Farben
#'   aus \code{maincolors_discrete$fillColor} dargestellt.
#' @param color Optionaler Name der Variable, nach der
#'   die Rahmenfarben der Säulen kategorisiert werden. Die Kategorien werden
#'   mit Farben aus \code{border_discrete$borderColor} dargestellt.
#' @param title Optionaler Titel des Diagramms.
#' @param subtitle Optionaler Untertitel des Diagramms.
#' @param source Optionale Angabe der Datenquelle. Wird in der Bildunterschrift
#'   zusammen mit dem Hinweis auf das Amt für Daten und Statistik Thurgau
#'   ausgegeben.
#' @param fill_color Index der Farbe aus
#'   \code{maincolors_discrete$fillColor}, die verwendet wird, wenn
#'   \code{fill = NULL}. Standardmässig \code{1}.
#' @param border_color Index der Farbe aus
#'   \code{border_discrete$borderColor}, die verwendet wird, wenn
#'   \code{color = NULL}. Standardmässig \code{1}.
#' @param position Positionierungsverfahren für die Säulen, das an
#'   \code{ggplot2::geom_col()} übergeben wird. Standardmässig
#'   \code{"stack"} für gestapelte Säulen. Weitere mögliche Werte sind
#'   beispielsweise \code{"dodge"} für nebeneinander angeordnete Säulen.
#'
#' @return Ein \code{ggplot}-Objekt mit dem Säulendiagramm, der konfigurierten
#'   Farbgebung und der formatierten Beschriftung.
#'
#' @details
#' Wenn \code{fill} angegeben ist, werden die Füllfarben den Kategorien
#' entsprechend ihrer Reihenfolge im Datensatz beziehungsweise den Faktorlevels
#' zugewiesen. Faktorlevels bleiben auch dann in der Farbskala erhalten, wenn
#' sie in den dargestellten Daten nicht vorkommen.
#'
#' Entsprechend werden bei Angabe von \code{color} die Rahmenfarben den
#' Kategorien der angegebenen Variable zugewiesen. Sind mehr Kategorien
#' vorhanden als Farben in der jeweiligen Palette, wird ein Fehler ausgelöst.
#'
#' Wenn \code{fill} oder \code{color} nicht angegeben ist, wird eine feste
#' Farbe anhand des jeweiligen Indexparameters verwendet.
#'
#' Die y-Achse verwendet Tausendertrennzeichen mit Apostrophen und beginnt
#' ohne zusätzlichen Abstand bei null. Auch die x-Achse erhält keinen
#' zusätzlichen Rand. Die Formatierung wird durch
#' \code{theme_bar_grid_horizontal} ergänzt.
#'
#' @examples
#' \dontrun{
#' ggplot_stacked_column(
#'   data = tab_alterskat |>
#'     dplyr::mutate(jahr = as.character(jahr)),
#'   x = "jahr",
#'   y = "n",
#'   fill = "alterskat",
#'   color = "alterskat",
#'   title = "Bevölkerung nach Alterskategorie",
#'   subtitle = "Entwicklung im Zeitverlauf",
#'   source = "Kantonale Bevölkerungsstatistik"
#' )
#' }
#'
#' @export
ggplot_stacked_column <- function(
    data,
    y,
    x,
    fill = NULL,
    color = NULL,
    title = NULL,
    subtitle = NULL,
    source = NULL,
    fill_color = 1,
    border_color = 1,
    position = "stack"
) {

  # --------------------------------------------------
  # Basic plot
  # --------------------------------------------------

  p <- ggplot2::ggplot(
    data,
    ggplot2::aes(
      x = .data[[x]],
      y = .data[[y]]
    )
  )


  # --------------------------------------------------
  # Fill
  # --------------------------------------------------

  if (!is.null(fill)) {

    # Get fill categories
    if (is.factor(data[[fill]])) {
      fill_categories <- levels(data[[fill]])
    } else {
      fill_categories <- unique(data[[fill]])
      fill_categories <- fill_categories[!is.na(fill_categories)]
    }

    n_fill <- length(fill_categories)

    # Check fill palette
    if (n_fill > length(maincolors_discrete$fillColor)) {
      stop(
        "Not enough fill colors in maincolors_discrete$fillColor. ",
        "There are ", n_fill, " categories but only ",
        length(maincolors_discrete$fillColor), " colors."
      )
    }

    # Select fill colors
    fill_values <- maincolors_discrete$fillColor[
      seq_len(n_fill)
    ]

    # Match colors to categories
    names(fill_values) <- fill_categories

    # Map fill
    p <- p +
      ggplot2::aes(
        fill = .data[[fill]]
      ) +
      ggplot2::scale_fill_manual(
        values = fill_values,
        drop = FALSE
      )

  } else {

    # Fixed fill color
    p <- p +
      ggplot2::aes(
        fill = NULL
      )
  }


  # --------------------------------------------------
  # Border / colour
  # --------------------------------------------------

  if (!is.null(color)) {

    # Get border categories
    if (is.factor(data[[color]])) {
      color_categories <- levels(data[[color]])
    } else {
      color_categories <- unique(data[[color]])
      color_categories <- color_categories[!is.na(color_categories)]
    }

    n_color <- length(color_categories)

    # Check border palette
    if (n_color > length(border_discrete$borderColor)) {
      stop(
        "Not enough border colors in border_discrete$borderColor. ",
        "There are ", n_color, " categories but only ",
        length(border_discrete$borderColor), " colors."
      )
    }

    # Select border colors
    border_values <- border_discrete$borderColor[
      seq_len(n_color)
    ]

    # Match colors to categories
    names(border_values) <- color_categories

    # Map border color
    p <- p +
      ggplot2::aes(
        colour = .data[[color]]
      ) +
      ggplot2::scale_colour_manual(
        values = border_values,
        drop = FALSE
      )

  } else {

    # Fixed border color
    p <- p +
      ggplot2::aes(
        colour = NULL
      )
  }


  # --------------------------------------------------
  # Geometry
  # --------------------------------------------------

  if (is.null(fill) && is.null(color)) {

    p <- p +
      ggplot2::geom_col(
        fill = maincolors_discrete$fillColor[fill_color],
        colour = border_discrete$borderColor[border_color],
        position = position
      )

  } else if (is.null(fill)) {

    # Fixed fill + categorical border
    p <- p +
      ggplot2::geom_col(
        fill = maincolors_discrete$fillColor[fill_color],
        position = position
      )

  } else if (is.null(color)) {

    # Categorical fill + fixed border
    p <- p +
      ggplot2::geom_col(
        colour = border_discrete$borderColor[border_color],
        position = position
      )

  } else {

    # Both categorical
    p <- p +
      ggplot2::geom_col(
        position = position
      )
  }


  # --------------------------------------------------
  # Common formatting
  # --------------------------------------------------

  p +
    theme_bar_grid_horizontal +
    ggplot2::theme(
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
      fill = "",
      colour = "",
      caption = paste(
        "Amt für Daten und Statistik Thurgau\nDatenquelle:",
        source
      )
    )
}
# ggplot_stacked_column(
#   data = tab_alterskat %>% mutate(jahr=as.character(jahr)),
#   x = "jahr",
#   y = "n",
#   fill = "alterskat",
#   color = "alterskat",
#   title = "TITEL",
#   subtitle = "UNTERTITEL",
#   source = "Kantonale Bevölkerungsstatistik"
# )
