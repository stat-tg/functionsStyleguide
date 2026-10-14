#' Vollständiges Donutdiagramm erstellen
#'
#' Erstellt ein Donutdiagramm mit anpassbaren Farben, Prozentbeschriftungen
#' und einem einstellbaren Startwinkel. Die Daten können optional anhand
#' eines bestimmten Wertes einer Variablen gefiltert werden.
#'
#' Die Reihenfolge der Segmente kann über eine Sortiervariable und eine
#' Startkategorie gesteuert werden. Die Startkategorie bestimmt, welches
#' Segment zuerst dargestellt wird. Die Prozentwerte werden anhand der
#' Summe der dargestellten Werte berechnet.
#'
#' @param data Ein Data Frame mit den darzustellenden Daten.
#' @param filter_value Optionaler Wert, nach dem die Daten gefiltert werden.
#'   Der Wert wird mit der Variable \code{x} verglichen. Wenn \code{NULL},
#'   werden alle Beobachtungen verwendet.
#' @param x Name der Variable, anhand derer die Daten optional gefiltert werden,
#'   angegeben als Zeichenkette.
#' @param y Name der numerischen Variable mit den Werten, die durch die
#'   Segmente dargestellt werden, angegeben als Zeichenkette.
#' @param fill_cat Name der kategorialen Variable, anhand derer die Segmente
#'   eingefärbt werden, angegeben als Zeichenkette.
#' @param hsize Numerischer Wert für die Grösse des inneren Lochs des
#'   Donutdiagramms. Wird zur Festlegung der Position und des sichtbaren
#'   Innenbereichs verwendet.
#' @param title Titel des Diagramms.
#' @param subtitle Untertitel des Diagramms.
#' @param source Quelle der dargestellten Daten. Wird in der Bildunterschrift
#'   zusammen mit dem Hinweis auf das Amt für Daten und Statistik Thurgau
#'   ausgegeben.
#' @param order Optionale Variable zur Sortierung der Daten vor der Erstellung
#'   des Diagramms, angegeben als Zeichenkette. Die Beobachtungen werden
#'   anhand dieser Variable aufsteigend sortiert.
#' @param start_category Optionale Kategorie aus \code{fill_cat}, die als
#'   erstes Segment dargestellt werden soll. Die übrigen Kategorien folgen
#'   anschliessend in ihrer bestehenden Reihenfolge.
#' @param start_angle Numerischer Startwinkel in Grad für das erste Segment.
#'   Der Winkel wird modulo 360 Grad umgerechnet. Standardmässig \code{0}.
#'   Ein Winkel von 0 Grad entspricht der 12-Uhr-Position, 90 Grad der
#'   3-Uhr-Position, 180 Grad der 6-Uhr-Position und 270 Grad der
#'   9-Uhr-Position.
#' @param palette Farbpalette für die Segmente. Standardmässig wird
#'   \code{maincolors_discrete} verwendet.
#' @param palette_name Name des Eintrags innerhalb von \code{palette},
#'   aus dem die Farben ausgewählt werden. Standardmässig \code{"fillColor"}.
#' @param colors Optionaler Vektor mit benutzerdefinierten Farben für die
#'   Segmente. Wird an \code{scale_fill_custom()} übergeben.
#' @param reverse Logischer Wert. Wenn \code{TRUE}, wird die Reihenfolge der
#'   Farben umgekehrt.
#' @param label_color Farbe der Prozentbeschriftungen innerhalb der Segmente.
#'   Standardmässig \code{"white"}.
#' @param label_size Schriftgrösse der Prozentbeschriftungen.
#'   Standardmässig \code{4.5}.
#' @param label_fontface Schriftstil der Prozentbeschriftungen. Zulässige
#'   Werte sind \code{"plain"}, \code{"bold"}, \code{"italic"} und
#'   \code{"bold.italic"}. Standardmässig \code{"bold"}.
#'
#' @return Ein \code{ggplot}-Objekt, das weiter angepasst oder mit
#'   \code{print()} ausgegeben werden kann.
#'
#' @examples
#' \dontrun{
#' # Donutdiagramm für ein bestimmtes Jahr
#' ggplot_donut_full(
#'   data = tab_alterskat,
#'   filter_value = "2025",
#'   x = "jahr",
#'   y = "n",
#'   fill_cat = "alterskat_det",
#'   title = "Bevölkerung nach Alterskategorien",
#'   subtitle = "Kanton Thurgau, 2025",
#'   hsize = 1,
#'   order = "order",
#'   source = "Kantonale Bevölkerungsstatistik"
#' )
#'
#' # Donutdiagramm mit benutzerdefinierter Farbpalette und Startkategorie
#' ggplot_donut_full(
#'   data = tab_alterskat,
#'   filter_value = "2025",
#'   x = "jahr",
#'   y = "n",
#'   fill_cat = "alterskat_det",
#'   title = "Bevölkerung nach Alterskategorien",
#'   subtitle = "Kanton Thurgau, 2025",
#'   hsize = 1,
#'   order = "order",
#'   start_category = "unter 25",
#'   palette = colors_sequential,
#'   palette_name = "fillSeq5",
#'   source = "Kantonale Bevölkerungsstatistik"
#' )
#' }
#'
#' @export
ggplot_donut_full <- function(
    data,
    filter_value = NULL,
    x,
    y,
    fill_cat,
    hsize,
    title,
    subtitle,
    source,
    order = NULL,
    start_category = NULL,
    start_angle = 0,
    palette = maincolors_discrete,
    palette_name = "fillColor",
    colors = NULL,
    reverse = FALSE,
    label_color = "white",
    label_size = 4.5,
    label_fontface = "bold"
) {

  # Check variables
  if (!x %in% names(data)) {
    stop("X variable '", x, "' not found in data.")
  }

  if (!y %in% names(data)) {
    stop("Y variable '", y, "' not found in data.")
  }

  if (!fill_cat %in% names(data)) {
    stop("Fill variable '", fill_cat, "' not found in data.")
  }

  if (!is.null(order) && !order %in% names(data)) {
    stop("Order variable '", order, "' not found in data.")
  }

  # Filter data
  if (!is.null(filter_value)) {

    data_donut <- data |>
      dplyr::filter(
        .data[[x]] == filter_value
      )

  } else {

    data_donut <- data
  }

  # Check data
  if (nrow(data_donut) == 0) {

    stop(
      "No observations found for ",
      x,
      " = '",
      filter_value,
      "'."
    )
  }

  # Check y variable
  if (!is.numeric(data_donut[[y]])) {

    stop(
      "Y variable '",
      y,
      "' must be numeric."
    )
  }

  # Check start angle
  if (!is.numeric(start_angle) ||
      length(start_angle) != 1 ||
      is.na(start_angle)) {

    stop(
      "start_angle must be a single numeric value."
    )
  }

  # Check label fontface
  if (!label_fontface %in%
      c("plain", "bold", "italic", "bold.italic")) {

    stop(
      "label_fontface must be one of: ",
      "'plain', 'bold', 'italic', 'bold.italic'."
    )
  }

  # ------------------------------------------------------------
  # Arrange data according to order variable
  # ------------------------------------------------------------

  if (!is.null(order)) {

    data_donut <- data_donut |>
      dplyr::arrange(
        .data[[order]]
      )
  }

  # ------------------------------------------------------------
  # Determine category order
  # ------------------------------------------------------------

  category_order <- unique(
    data_donut[[fill_cat]]
  )

  # ------------------------------------------------------------
  # Move start category to first position
  # ------------------------------------------------------------

  if (!is.null(start_category)) {

    if (!start_category %in% category_order) {

      stop(
        "Start category '",
        start_category,
        "' not found in '",
        fill_cat,
        "'."
      )
    }

    start_index <- match(
      start_category,
      category_order
    )

    category_order <- c(
      category_order[start_index:length(category_order)],
      category_order[seq_len(start_index - 1)]
    )
  }

  # Apply category order
  data_donut[[fill_cat]] <- factor(
    data_donut[[fill_cat]],
    levels = category_order
  )

  # ------------------------------------------------------------
  # Calculate percentages
  # ------------------------------------------------------------

  data_donut <- data_donut |>
    dplyr::mutate(
      percentage =
        .data[[y]] /
        sum(.data[[y]], na.rm = TRUE) *
        100
    )

  # ------------------------------------------------------------
  # Polar angle
  #
  # start_angle:
  #
  #   0   = 12 o'clock
  #   90  = 3 o'clock
  #   180 = 6 o'clock
  #   270 = 9 o'clock
  #
  # direction = -1 means clockwise
  #
  # The angle defines the START/BORDER of the
  # first segment, not its centre.
  # ------------------------------------------------------------

  polar_start <- (
    start_angle %% 360
    ) * pi / 180

  # ------------------------------------------------------------
  # Create plot
  # ------------------------------------------------------------

  ggplot2::ggplot(
    data_donut,
    ggplot2::aes(
      x = hsize,
      y = .data[[y]],
      fill = .data[[fill_cat]]
    )
  ) +

    ggplot2::geom_col(
      position = ggplot2::position_stack(
        reverse = TRUE
      )
    ) +

    ggplot2::geom_text(
      ggplot2::aes(
        label = paste0(
          round(percentage, 1),
          " %"
        )
      ),
      position = ggplot2::position_stack(
        vjust = 0.5,
        reverse = TRUE
      ),
      colour = label_color,
      size = label_size,
      fontface = label_fontface
    ) +

    ggplot2::coord_polar(
      theta = "y",
      start = polar_start,
      direction = 1
    ) +

    ggplot2::xlim(
      c(
        0.2,
        hsize + 0.5
      )
    ) +

    theme_opts_map +
    ggplot2::theme(
      plot.caption = ggplot2::element_text(hjust = 0),
      plot.title.position = "plot",
      plot.caption.position = "plot",
      legend.position = "top",
      legend.justification = "left",
      legend.location = "plot"
    ) +

    scale_fill_custom(
      palette = palette,
      palette_name = palette_name,
      colors = colors,
      reverse = reverse
    ) +

    ggplot2::labs(
      title = title,
      subtitle = subtitle,
      caption = paste(
        "Amt für Daten und Statistik Thurgau\nDatenquelle:",
        source
      )
    )
}
# ggplot_donut_full(data = tab_alterskat,
#              filter_value = "2025",
#              x = "jahr",
#              y = "n",
#              fill_cat = "alterskat_det",
#              title = "TITEL",
#              subtitle = "Untertitel",
#              hsize = 1,
#              # start_angle = 0,
#              order = "order",
#              source = "Kantonale Bevölkerungsstatistik")

# ggplot_donut(data = tab_alterskat,
#              filter_value = "2025",
#              x = "jahr",
#              y = "n",
#              fill_cat = "alterskat_det",
#              title = "TITEL",
#              subtitle = "Untertitel",
#              hsize = 1,
#              palette = colors_sequential,
#              palette_name = "fillSeq5",
#              source = "Kantonale Bevölkerungsstatistik")
#
# ggplot_donut(data = tab_alterskat,
#              filter_value = "2025",
#              x = "jahr",
#              y = "n",
#              order = "order",
#              start_category = "unter 25",
#              fill_cat = "alterskat_det",
#              title = "TITEL",
#              subtitle = "Untertitel",
#              hsize = 1,
#              palette = maincolors_discrete,
#              palette_name = "fillBlueGreys",
#              source = "Kantonale Bevölkerungsstatistik")

