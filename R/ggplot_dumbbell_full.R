#' Dumbbell-Diagramm zum Vergleich zweier Zeitpunkte erstellen
#'
#' Erstellt ein Dumbbell-Diagramm, um die Werte einer Variable für zwei
#' ausgewählte Zeitpunkte miteinander zu vergleichen. Für jede Kategorie
#' werden die beiden Werte als Punkte dargestellt und durch eine Linie
#' verbunden. Dadurch lassen sich Veränderungen zwischen den Zeitpunkten
#' auf einen Blick erkennen.
#'
#' Die beiden Zeitpunkte werden über \code{x_min} und \code{x_max} ausgewählt.
#' Die Punkte werden mit unterschiedlichen Farben aus
#' \code{colors_regions} dargestellt. Optional können die Werte direkt
#' beschriftet werden. Die Beschriftungen können entweder die Farben der
#' zugehörigen Punkte übernehmen oder in einer festen Farbe angezeigt werden.
#'
#' @param data Ein Data Frame mit den darzustellenden Daten. Erwartet werden
#'   mindestens die Variablen \code{jahr}, die Vergleichsvariable sowie die
#'   Kategorievariable.
#' @param x Zeichenkette mit dem Namen der numerischen Variable, deren Werte
#'   zwischen den beiden Zeitpunkten verglichen werden.
#' @param y Zeichenkette mit dem Namen der Kategorievariable, beispielsweise
#'   Gemeindenamen.
#' @param x_min Zeichenkette mit dem ersten zu vergleichenden Zeitpunkt,
#'   beispielsweise \code{"2025"}. Muss als Wert in der Variable \code{jahr}
#'   vorkommen.
#' @param x_max Zeichenkette mit dem zweiten zu vergleichenden Zeitpunkt,
#'   beispielsweise \code{"2026"}. Muss als Wert in der Variable \code{jahr}
#'   vorkommen.
#' @param source Angabe der Datenquelle. Wird zusammen mit dem Hinweis auf
#'   das Amt für Daten und Statistik Thurgau in der Bildunterschrift ausgegeben.
#' @param title Optionaler Titel des Diagramms. Standardmässig \code{NULL}.
#' @param subtitle Optionaler Untertitel des Diagramms. Standardmässig
#'   \code{NULL}.
#' @param label Optionaler Name einer Variable mit den Beschriftungen für
#'   die beiden Vergleichspunkte. Bei \code{NULL} werden keine Beschriftungen
#'   hinzugefügt. Die Variable wird anhand der Werte in \code{jahr} und der
#'   Kategorievariable den Punkten zugeordnet.
#' @param label_colour Farbe der Beschriftungen. Bei \code{"point"} übernehmen
#'   die Beschriftungen die Farben der jeweiligen Punkte. Andernfalls wird
#'   die angegebene feste Farbe verwendet. Standardmässig \code{"black"}.
#' @param label_size Grösse der Beschriftungen. Standardmässig \code{4}.
#' @param label_nudge_x Horizontale Verschiebung der Beschriftungen.
#'   Standardmässig \code{0}.
#' @param label_nudge_y Vertikale Verschiebung der Beschriftungen.
#'   Standardmässig \code{0}.
#' @param x_expand Relativer Zuschlag zum maximalen dargestellten Wert, um
#'   zusätzlichen Platz am oberen Ende der Wertachse zu schaffen.
#'   Beispielsweise entspricht \code{0.20} einem Zuschlag von 20 Prozent.
#'   Standardmässig \code{0.20}.
#'
#' @return Ein \code{ggplot}-Objekt mit den Verbindungslinien, den beiden
#'   Vergleichspunkten pro Kategorie, einer Legende für die Zeitpunkte und
#'   optionalen Wertbeschriftungen.
#'
#' @details
#' Die Funktion filtert den Datensatz auf die beiden ausgewählten Zeitpunkte
#' und bringt die Werte anschliessend in ein breites Datenformat, sodass für
#' jeden Zeitpunkt eine eigene Spalte entsteht. Fehlt einer der angegebenen
#' Zeitpunkte im resultierenden Datensatz, wird ein Fehler ausgelöst.
#'
#' Die Verbindungslinien verwenden die Farbe
#' \code{colors_regions$fillKantoneLine}. Die Punkte für \code{x_min} und
#' \code{x_max} verwenden die Farben \code{colors_regions$fillOstschweizLine}
#' beziehungsweise \code{colors_regions$fillSchweizLine}.
#'
#' Die Wertachse wird oberhalb des Diagramms positioniert und beginnt bei null.
#' Die obere Grenze wird anhand des maximalen Wertes beider Zeitpunkte und
#' des Parameters \code{x_expand} berechnet.
#'
#' Wenn \code{label} angegeben ist, wird die entsprechende Variable für beide
#' ausgewählten Zeitpunkte aus den ursprünglichen Daten übernommen und als
#' Punktbeschriftung verwendet.
#'
#' @examples
#' \dontrun{
#' ggplot_dumbbell(
#'   data = tab_steuerfuss_change_long,
#'   x = "gemeindesteuerfuss",
#'   y = "gemeinde_name",
#'   x_min = "2025",
#'   x_max = "2026",
#'   source = "Steuerverwaltung Thurgau",
#'   title = "Steuerfuss der Gemeinden",
#'   subtitle = "Veränderung zwischen 2025 und 2026",
#'   label = "gemeindesteuerfuss",
#'   label_colour = "point",
#'   label_size = 4
#' )
#' }
#'
#' @export
ggplot_dumbbell <- function(
    data,
    x,
    y,
    x_min,
    x_max,
    source,
    title = NULL,
    subtitle = NULL,
    label = NULL,
    label_colour = "black",
    label_size = 4,
    label_nudge_x = 0,
    label_nudge_y = 0,
    x_expand = 0.20
) {

  # Remove backticks if they are supplied
  x_min <- gsub("`", "", x_min)
  x_max <- gsub("`", "", x_max)

  # Create wide data: one column for each selected year
  data_wide <- data |>
    dplyr::filter(
      as.character(.data[["jahr"]]) %in% c(x_min, x_max)
    ) |>
    dplyr::select(
      dplyr::all_of(y),
      jahr = .data[["jahr"]],
      value = .data[[x]]
    ) |>
    tidyr::pivot_wider(
      names_from = jahr,
      values_from = value
    )

  # Check that both requested years exist
  if (!x_min %in% names(data_wide)) {
    stop("x_min was not found in the data: ", x_min)
  }

  if (!x_max %in% names(data_wide)) {
    stop("x_max was not found in the data: ", x_max)
  }

  # Create long data for the two endpoint points
  points <- data_wide |>
    dplyr::select(
      dplyr::all_of(y),
      dplyr::all_of(c(x_min, x_max))
    ) |>
    tidyr::pivot_longer(
      cols = dplyr::all_of(c(x_min, x_max)),
      names_to = "jahr",
      values_to = "value"
    )

  # Named colour vector for the two points
  point_colours <- stats::setNames(
    c(
      colors_regions$fillOstschweizLine,
      colors_regions$fillSchweizLine
    ),
    c(x_min, x_max)
  )

  # Calculate dynamic x-axis limits
  x_values <- c(
    data_wide[[x_min]],
    data_wide[[x_max]]
  )

  x_max_value <- max(
    x_values,
    na.rm = TRUE
  )

  x_upper <- x_max_value * (1 + x_expand)

  # Base plot
  p <- ggplot(
    data_wide,
    aes(
      y = .data[[y]]
    )
  ) +

    # Connecting line
    geom_segment(
      aes(
        x = .data[[x_min]],
        xend = .data[[x_max]],
        yend = .data[[y]]
      ),
      colour = colors_regions$fillKantoneLine,
      linewidth = 1
    ) +

    # Endpoint points
    geom_point(
      data = points,
      aes(
        x = value,
        colour = jahr
      ),
      size = 4
    ) +

    # Colours for the two years
    scale_colour_manual(
      values = point_colours,
      breaks = c(x_min, x_max),
      labels = c(x_min, x_max)
    ) +

    theme_bar_grid_vertical +

    theme(
      plot.caption = element_text(hjust = 0),
      plot.title.position = "plot",
      plot.caption.position = "plot",
      legend.position = "top",
      legend.justification = "left",
      legend.location = "plot"
    ) +

    # Dynamic x-axis
    scale_x_continuous(
      position = "top",
      limits = c(0, x_upper),
      expand = c(0, 0)
    ) +

    labs(
      title = title,
      subtitle = subtitle,
      x = "",
      y = "",
      colour = "",
      caption = paste(
        "Amt für Daten und Statistik Thurgau\nDatenquelle:",
        source
      )
    )

  # Add labels only when requested
  if (!is.null(label)) {

    points <- data |>
      dplyr::filter(
        as.character(.data[["jahr"]]) %in% c(x_min, x_max)
      ) |>
      dplyr::select(
        dplyr::all_of(y),
        jahr = .data[["jahr"]],
        value = .data[[x]],
        label_value = .data[[label]]
      )

    # Labels use the point colours
    if (label_colour == "point") {

      p <- p +
        geom_text(
          data = points,
          aes(
            x = value,
            y = .data[[y]],
            label = label_value,
            colour = jahr
          ),
          inherit.aes = FALSE,
          hjust = 0.6,
          vjust = -1,
          nudge_x = label_nudge_x,
          nudge_y = label_nudge_y,
          size = label_size,
          show.legend = FALSE,
          fontface = "bold"
        )

    } else {

      # Labels use a fixed colour
      p <- p +
        geom_text(
          data = points,
          aes(
            x = value,
            y = .data[[y]],
            label = label_value
          ),
          inherit.aes = FALSE,
          colour = label_colour,
          hjust = 0.6,
          vjust = -1,
          nudge_x = label_nudge_x,
          nudge_y = label_nudge_y,
          size = label_size,
          fontface = "bold"
        )
    }
  }

  p
}
# ggplot_dumbbell(
#   data = tab_steuerfuss_change_long,
#   x = "gemeindesteuerfuss",
#   y = "gemeinde_name",
#   x_min = "2025",
#   x_max = "2026",
#   source = "Steuerverwaltung Thurgau",
#   title = "Steuerfuss der Gemeinden",
#   subtitle = "Veränderung zwischen 2025 und 2026",
#   label = "gemeindesteuerfuss"
# )
#
#
# ggplot_dumbbell(
#   data = tab_steuerfuss_change_long,
#   x = "gemeindesteuerfuss",
#   y = "gemeinde_name",
#   x_min = "2025",
#   x_max = "2026",
#   source = "Steuerverwaltung Thurgau",
#   title = "Steuerfuss der Gemeinden",
#   subtitle = "Veränderung zwischen 2025 und 2026",
#   label = "gemeindesteuerfuss",
#   label_colour = "point",
#   label_size = 4
# )

