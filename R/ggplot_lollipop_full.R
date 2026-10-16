#' Lollipop-Diagramm gemäss Styleguide
#'
#' Erstellt ein Lollipop-Diagramm zur Darstellung numerischer Werte nach
#' Kategorien. Jeder Wert wird durch einen Punkt dargestellt, der über eine
#' vertikale Linie mit dem Nullpunkt verbunden ist. Durch die Verwendung von
#' \code{coord_flip()} werden die Kategorien horizontal und die Werte auf
#' einer horizontalen Achse dargestellt.
#'
#' Die Füll- und Rahmenfarben der Punkte werden aus benutzerdefinierten
#' Farbpaletten ausgewählt. Optional können die dargestellten Werte direkt
#' neben den Punkten beschriftet werden. Der obere Achsenbereich wird
#' automatisch anhand des maximalen Wertes und des Parameters
#' \code{y_expand} festgelegt.
#'
#' @param data Ein Data Frame mit den darzustellenden Daten.
#' @param x Kategorialen Variable für die
#'   Kategorienachse, beispielsweise Gemeindenamen.
#' @param y Numerische Variable, deren Werte
#'   dargestellt werden sollen.
#' @param title Titel des Diagramms.
#' @param subtitle Untertitel des Diagramms.
#' @param source Angabe der Datenquelle. Wird zusammen mit dem Hinweis auf
#'   das Amt für Daten und Statistik Thurgau in der Bildunterschrift ausgegeben.
#' @param size_point Grösse der Punkte im Diagramm. Standardmässig \code{4}.
#' @param y_expand Relativer Zuschlag zum maximalen Wert von \code{y}, um
#'   zusätzlichen Platz am oberen Ende der Wertachse zu schaffen.
#'   Beispielsweise entspricht \code{0.10} einem Zuschlag von 10 Prozent.
#'   Standardmässig \code{0.10}.
#' @param label Logischer Wert, der angibt, ob die Werte beschriftet werden
#'   sollen. Bei \code{TRUE} werden die Werte der Variable \code{y} neben
#'   den Punkten angezeigt. Standardmässig \code{NULL}, wodurch keine
#'   Beschriftungen hinzugefügt werden.
#' @param label_colour Farbe der Beschriftungen. Bei \code{"point"} wird
#'   die Füllfarbe der Punkte verwendet; andernfalls kann eine feste Farbe
#'   angegeben werden. Standardmässig \code{"black"}.
#' @param label_size Grösse der Wertbeschriftungen. Standardmässig \code{4}.
#' @param label_nudge_y Abstand der Beschriftungen in Richtung der
#'   Wertachse. Wird an \code{geom_text()} als \code{nudge_y} übergeben.
#'   Standardmässig \code{0.5}.
#' @param label_fontface Schriftstil der Beschriftungen, beispielsweise
#'   \code{"plain"} oder \code{"bold"}. Standardmässig \code{"bold"}.
#' @param fill_palette Liste mit Farbpaletten für die Punktfüllung.
#'   Standardmässig \code{maincolors_discrete}.
#' @param fill_palette_name Zeichenkette mit dem Namen des Palettenelements,
#'   aus dem die Füllfarben ausgewählt werden. Standardmässig
#'   \code{"fillColor"}.
#' @param fill_colors Optionaler Index oder Vektor von Indizes zur Auswahl
#'   bestimmter Farben aus dem gewählten Füllfarben-Palettenelement.
#'   Verwendet wird die erste ausgewählte Farbe. Bei \code{NULL} wird die
#'   gesamte Palette berücksichtigt. Standardmässig \code{1}.
#' @param fill_reverse Logischer Wert. Wenn \code{TRUE}, wird die Reihenfolge
#'   der ausgewählten Füllfarben umgekehrt. Standardmässig \code{FALSE}.
#' @param border_palette Liste mit Farbpaletten für die Punktränder.
#'   Standardmässig \code{border_discrete}.
#' @param border_palette_name Zeichenkette mit dem Namen des Palettenelements,
#'   aus dem die Rahmenfarben ausgewählt werden. Standardmässig
#'   \code{"borderColor"}.
#' @param border_colors Optionaler Index oder Vektor von Indizes zur Auswahl
#'   bestimmter Farben aus dem gewählten Rahmenfarben-Palettenelement.
#'   Verwendet wird die erste ausgewählte Farbe. Bei \code{NULL} wird die
#'   gesamte Palette berücksichtigt. Standardmässig \code{1}.
#' @param border_reverse Logischer Wert. Wenn \code{TRUE}, wird die Reihenfolge
#'   der ausgewählten Rahmenfarben umgekehrt. Standardmässig \code{FALSE}.
#'
#' @return Ein \code{ggplot}-Objekt mit den Lollipop-Linien, den Punkten,
#'   optionalen Wertbeschriftungen und der formatierten Achsen- und
#'   Diagrammbeschriftung.
#'
#' @details
#' Die Linien der Lollipops beginnen beim Wert null und enden beim jeweiligen
#' Wert der Variable \code{y}. Die Wertachse wird nach rechts verschoben
#' und reicht von null bis zum maximalen Wert multipliziert mit
#' \code{1 + y_expand}. Der Achsenbereich wird ohne zusätzlichen Rand
#' dargestellt.
#'
#' Die Punktfüllung und der Punktrand verwenden jeweils die erste Farbe,
#' die nach Auswahl und gegebenenfalls Umkehrung der entsprechenden Palette
#' verfügbar ist. Die übrigen ausgewählten Farben werden nicht verwendet.
#'
#' Wenn \code{label = TRUE} gesetzt ist, werden die Werte der Variable
#' \code{y} beschriftet. Mit \code{label_colour = "point"} wird dafür die
#' Füllfarbe der Punkte verwendet; andernfalls wird die angegebene feste
#' Beschriftungsfarbe eingesetzt.
#'
#' @examples
#' \dontrun{
#' ggplot_lollipop(
#'   data = tab_steuerfuss_aktuell,
#'   x = "gemeinde_name",
#'   y = "gemeindesteuerfuss",
#'   title = "Gemeindesteuerfüsse im Vergleich",
#'   subtitle = "Kanton Thurgau",
#'   source = "Steuerverwaltung Thurgau",
#'   size_point = 6,
#'   fill_palette = colors_gender,
#'   fill_palette_name = "fillColor",
#'   fill_colors = 2,
#'   border_palette = border_gender,
#'   border_palette_name = "borderColor",
#'   border_colors = 2,
#'   label = TRUE,
#'   label_colour = "point",
#'   label_size = 4
#' )
#' }
#'
#' @export

ggplot_lollipop <- function(
    data,
    x,
    y,
    title,
    subtitle,
    source,
    size_point = 4,
    y_expand = 0.10,

    # Labels
    label = NULL,
    label_colour = "black",
    label_size = 4,
    label_nudge_y = 0.5,
    label_fontface = "bold",

    # Fill palette
    fill_palette = maincolors_discrete,
    fill_palette_name = "fillColor",
    fill_colors = 1,
    fill_reverse = FALSE,

    # Border palette
    border_palette = border_discrete,
    border_palette_name = "borderColor",
    border_colors = 1,
    border_reverse = FALSE
) {

  # Calculate the maximum value of the y variable
  y_max <- max(
    data[[y]],
    na.rm = TRUE
  )

  # Dynamic upper limit
  y_upper <- y_max * (1 + y_expand)

  # Get fill colours from the selected palette
  fill_values <- fill_palette[[fill_palette_name]]

  if (!is.null(fill_colors)) {
    fill_values <- fill_values[fill_colors]
  }

  if (fill_reverse) {
    fill_values <- rev(fill_values)
  }

  # Get border colours from the selected palette
  border_values <- border_palette[[border_palette_name]]

  if (!is.null(border_colors)) {
    border_values <- border_values[border_colors]
  }

  if (border_reverse) {
    border_values <- rev(border_values)
  }

  # Use the first selected colour for all points
  fill_value <- fill_values[1]
  border_value <- border_values[1]

  # Base plot
  p <- ggplot(
    data,
    aes(
      x = .data[[x]],
      y = .data[[y]]
    )
  ) +

    # Lollipop stems
    geom_segment(
      aes(
        x = .data[[x]],
        xend = .data[[x]],
        y = 0,
        yend = .data[[y]]
      ),
      colour = "#979797",
      linewidth = 1
    ) +

    # Points
    geom_point(
      size = size_point,
      shape = 21,
      fill = fill_value,
      colour = border_value
    ) +

    labs(
      title = title,
      subtitle = subtitle,
      x = "",
      y = "",
      caption = paste(
        "Amt für Daten und Statistik Thurgau\nDatenquelle:",
        source
      )
    ) +

    coord_flip() +

    scale_y_continuous(
      position = "right",
      limits = c(0, y_upper),
      expand = c(0, 0)
    ) +

    theme_lollipop_grid_vertical +

    theme(
      plot.caption = element_text(hjust = 0),
      plot.title.position = "plot",
      plot.caption.position = "plot",
      legend.position = "top",
      legend.justification = "left",
      legend.location = "plot"
    )

  # Add labels only when requested
  if (!is.null(label) && isTRUE(label)) {

    # Labels in the point colour
    if (label_colour == "point") {

      p <- p +
        geom_text(
          aes(
            label = .data[[y]]
          ),
          colour = fill_value,
          hjust = -0.5,
          vjust = 0.5,
          nudge_y = label_nudge_y,
          size = label_size,
          fontface = label_fontface
        )

    } else {

      # Labels in a fixed colour
      p <- p +
        geom_text(
          aes(
            label = .data[[y]]
          ),
          colour = label_colour,
          hjust = -0.5,
          vjust = 0.5,
          nudge_y = label_nudge_y,
          size = label_size,
          fontface = label_fontface
        )
    }
  }

  p
}
#
# ggplot_lollipop(data = tab_steuerfuss_aktuell,
#                 x = "gemeinde_name",
#                 y = "gemeindesteuerfuss",
#                 title = "TITEL",
#                 subtitle = "UNTERTITEL",
#                 source = "Steuerverwaltung Thurgau",
#                 size_point = 6,
#                 fill_palette = colors_gender,
#                 fill_palette_name = "fillColor",
#                 fill_colors = 2,
#                 border_palette = border_gender,
#                 border_palette_name = "borderColor",
#                 border_colors = 2,
#                 label = TRUE,
#                 label_colour = "point",
#                 label_size = 4)
