#' Einfaches gestapeltes Säulendiagramm gemäss Styleguide
#'
#' Erstellt ein Säulendiagramm mit `ggplot2` gemäss dem Styleguide des
#' Kantons Thurgau. Die Säulen können nach einer Kategorie eingefärbt
#' und mit kategorienabhängigen Umrissfarben versehen werden. Alternativ
#' können feste Füll- und Umrissfarben aus den Styleguide-Paletten
#' verwendet werden.
#'
#' Die Füllfarben werden aus `maincolors_discrete$fillColor`, die
#' Umrissfarben aus `border_discrete$borderColor` ausgewählt. Wenn
#' Kategorien für Füllung oder Umriss angegeben werden, prüft die
#' Funktion, ob genügend Farben in der jeweiligen Palette vorhanden sind.
#'
#' Die Darstellung verwendet die Formatierung des Styleguides,
#' eine horizontal ausgerichtete Gitternetzgestaltung sowie eine
#' numerische y-Achse mit Tausendertrennzeichen. Titel, Untertitel
#' und Datenquelle können optional angegeben werden.
#'
#' @param data Data Frame mit den darzustellenden Daten.
#' @param y Name der Spalte in `data`, welche die numerischen Werte
#'   für die Höhe der Säulen enthält.
#' @param x Name der Spalte in `data`, welche die Kategorien der
#'   x-Achse enthält.
#' @param fill Optionaler Name einer Spalte in `data`, nach deren
#'   Kategorien die Säulen eingefärbt werden. Bei `NULL` wird eine
#'   einheitliche Füllfarbe verwendet.
#' @param color Optionaler Name einer Spalte in `data`, nach deren
#'   Kategorien die Umrisse der Säulen eingefärbt werden. Bei `NULL`
#'   wird eine einheitliche Umrissfarbe verwendet.
#' @param title Optionaler Titel des Diagramms.
#' @param subtitle Optionaler Untertitel des Diagramms.
#' @param source Optionale Angabe der Datenquelle. Sie wird in der
#'   Bildunterschrift zusammen mit dem Hinweis auf das Amt für Daten
#'   und Statistik Thurgau ausgegeben.
#' @param fill_color Index der Farbe aus
#'   `maincolors_discrete$fillColor`, die für eine feste Füllfarbe
#'   verwendet wird, wenn `fill = NULL`. Standardmässig `1` aus der
#'   Palette `"fillcolor"` aus den Hauptfarben..
#' @param border_color Index der Farbe aus
#'   `border_discrete$borderColor`, die für eine feste Umrissfarbe
#'   verwendet wird, wenn `color = NULL`. Standardmässig `1` aus der
#'   Palette `"borderColor"` aus den Hauptfarben..
#' @param position Positionierungsargument für die Säulen.
#'   Standardmässig `"stack"`.
#'
#' @return Ein `ggplot`-Objekt mit dem formatierten Säulendiagramm.
#'
#' @examples
#' \dontrun
#' ggplot_grouped_column(
#'  data = tab_alterskat %>% mutate(jahr=as.character(jahr)),
#'  x = "jahr",
#'  y = "n",
#'  fill = "alterskat_det",
#'  color = "alterskat_det",
#'  title = "TITEL",
#'  subtitle = "UNTERTITEL",
#'  source = "Kantonale Bevölkerungsstatistik"
#'  )

#' @export
ggplot_grouped_column <- function(
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
        position="dodge", stat="identity"
      )

  } else if (is.null(fill)) {

    # Fixed fill + categorical border
    p <- p +
      ggplot2::geom_col(
        fill = maincolors_discrete$fillColor[fill_color],
        position="dodge", stat="identity"
      )

  } else if (is.null(color)) {

    # Categorical fill + fixed border
    p <- p +
      ggplot2::geom_col(
        colour = border_discrete$borderColor[border_color],
        position="dodge", stat="identity"
      )

  } else {

    # Both categorical
    p <- p +
      ggplot2::geom_col(
        position="dodge", stat="identity"
      )
  }


  # --------------------------------------------------
  # Common formatting
  # --------------------------------------------------

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
      fill = "",
      colour = "",
      caption = paste(
        "Amt für Daten und Statistik Thurgau\nDatenquelle:",
        source
      )
    )
}

# ggplot_grouped_column(
#   data = tab_alterskat %>% mutate(jahr=as.character(jahr)),
#   x = "jahr",
#   y = "n",
#   fill = "alterskat_det",
#   color = "alterskat_det",
#   title = "TITEL",
#   subtitle = "UNTERTITEL",
#   source = "Kantonale Bevölkerungsstatistik"
# )
