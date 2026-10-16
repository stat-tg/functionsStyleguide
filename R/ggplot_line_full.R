#' Liniendiagramm gemäss Styleguide
#'
#' Erstellt ein Liniendiagramm mit anpassbaren Farben, optionaler Gruppierung
#' und verschiedenen Beschriftungsmöglichkeiten. Die Funktion unterstützt
#' sowohl eine einzelne Linie als auch mehrere Linien, die anhand einer
#' Gruppierungsvariable dargestellt werden.
#'
#' Die Reihenfolge der Gruppen kann über eine Sortiervariable gesteuert werden.
#' Für die Linienfarben können benutzerdefinierte Farbpaletten verwendet werden.
#' Zusätzlich lassen sich numerische Werte direkt im Diagramm anzeigen und
#' die einzelnen Linien mit ihren Kategorienamen beschriften.
#'
#' Die Grenzen der vertikalen Achse können über \code{y_min} und \code{y_max}
#' festgelegt werden. Als Standard beginnt die Achse bei null und reicht bis
#' 110 Prozent des grössten dargestellten Wertes.
#'
#' @param data Ein Data Frame mit den darzustellenden Daten.
#' @param y Name der numerischen Variable für die vertikale Achse.
#' @param x Name der Variable für die horizontale Achse,
#'   beispielsweise eine Jahresvariable.
#' @param group Optionale kategoriale Variable zur Gruppierung der Linien.
#'   Wenn \code{NULL}, wird eine einzelne Linie dargestellt,
#'   sofern auch \code{color} gleich \code{NULL} ist.
#' @param color Optionale Variable zur Zuordnung der Linienfarben als
#'   Zeichenkette. Wenn \code{NULL} und \code{group} nicht \code{NULL} ist,
#'   werden die Gruppen anhand von \code{group_palette} eingefärbt.
#' @param order Optionale Variable zur Festlegung der Reihenfolge der Gruppen.
#'   Die Gruppen werden anhand dieser Variable aufsteigend
#'   sortiert.
#'
#' @param group_palette Farbpalette für die Liniengruppen. Standardmässig
#'   wird \code{maincolors_discrete} verwendet.
#' @param group_palette_name Name des Eintrags innerhalb von
#'   \code{group_palette}, aus dem die Linienfarben ausgewählt werden.
#'   Standardmässig \code{"fillHighlight"}.
#' @param group_colors Optionaler benannter Vektor mit benutzerdefinierten
#'   Farben für die Liniengruppen. Wird an \code{scale_colour_custom()}
#'   übergeben.
#' @param group_reverse Logischer Wert. Wenn \code{TRUE}, wird die Reihenfolge
#'   der Gruppenfarben umgekehrt.
#'
#' @param border_palette Farbpalette für die Linienfarben, wenn eine separate
#'   Farbvariable über \code{color} angegeben wird. Standardmässig wird
#'   \code{border_discrete} verwendet.
#' @param border_palette_name Name des Eintrags innerhalb von
#'   \code{border_palette}. Standardmässig \code{"borderHighligt"}.
#' @param border_colors Optionaler benannter Vektor mit benutzerdefinierten
#'   Farben für die Kategorien der Variable \code{color}. Wird an
#'   \code{scale_colour_custom()} übergeben.
#' @param border_reverse Logischer Wert. Wenn \code{TRUE}, wird die Reihenfolge
#'   der Farben aus \code{border_palette} umgekehrt.
#'
#' @param line_color Index der Linienfarbe innerhalb von
#'   \code{group_palette[[group_palette_name]]}, wenn weder \code{group}
#'   noch \code{color} angegeben ist. Standardmässig \code{1}.
#'
#' @param y_min Optionale untere Grenze der vertikalen Achse. Wenn \code{NULL},
#'   wird standardmässig \code{0} verwendet.
#' @param y_max Optionale obere Grenze der vertikalen Achse. Wenn \code{NULL},
#'   wird standardmässig das 1,1-Fache des grössten Wertes von \code{y}
#'   verwendet.
#'
#' @param theme ggplot2-Theme für die Gestaltung des Diagramms.
#'   Standardmässig \code{theme_opts_line}.
#'
#' @param labels Logischer Wert. Wenn \code{TRUE}, werden die numerischen Werte
#'   der Variable \code{y} direkt im Diagramm beschriftet.
#' @param label_color Farbe der Wertbeschriftungen. Standardmässig
#'   \code{"white"}.
#' @param label_size Schriftgrösse der Wertbeschriftungen.
#'   Standardmässig \code{4.5}.
#' @param label_fontface Schriftstil der Wertbeschriftungen, beispielsweise
#'   \code{"plain"} oder \code{"bold"}. Standardmässig \code{"bold"}.
#' @param label_angle Drehwinkel der Wertbeschriftungen in Grad.
#'   Standardmässig \code{0}.
#' @param label_hjust Horizontale Ausrichtung der Wertbeschriftungen.
#'   Wenn \code{NULL}, wird standardmässig \code{0.5} verwendet.
#' @param label_vjust Vertikale Ausrichtung der Wertbeschriftungen.
#'   Wenn \code{NULL}, wird standardmässig \code{-0.5} verwendet.
#'
#' @param line_labels Logischer Wert. Wenn \code{TRUE}, werden die Linien
#'   zusätzlich mit dem Namen ihrer Gruppenkategorie beschriftet. Dafür muss
#'   \code{group} angegeben sein.
#' @param line_label_position Numerischer Wert zwischen \code{0} und \code{1},
#'   der die ungefähre Position der Linienbeschriftung entlang der jeweiligen
#'   Linie bestimmt. \code{0} entspricht dem Anfang und \code{1} dem Ende.
#'   Standardmässig \code{0.5}.
#' @param line_label_size Schriftgrösse der Linienbeschriftungen.
#'   Standardmässig \code{4}.
#' @param line_label_fontface Schriftstil der Linienbeschriftungen.
#'   Standardmässig \code{"bold"}.
#' @param line_label_hjust Horizontale Ausrichtung der Linienbeschriftungen.
#'   Standardmässig \code{0.5}.
#' @param line_label_vjust Vertikale Ausrichtung der Linienbeschriftungen.
#'   Standardmässig \code{-0.5}.
#' @param line_label_nudge_x Numerische Verschiebung der Linienbeschriftungen
#'   in horizontaler Richtung. Standardmässig \code{0}.
#' @param line_label_nudge_y Numerische Verschiebung der Linienbeschriftungen
#'   in vertikaler Richtung. Standardmässig \code{0}.
#'
#' @param title Titel des Diagramms.
#' @param subtitle Untertitel des Diagramms.
#' @param source Quelle der dargestellten Daten. Wird in der Bildunterschrift
#'   zusammen mit dem Hinweis auf das Amt für Daten und Statistik Thurgau
#'   ausgegeben.
#'
#' @return Ein \code{ggplot}-Objekt, das weiter angepasst oder mit
#'   \code{print()} ausgegeben werden kann.
#'
#' @examples
#' \dontrun{
#' # Einzelne Linie mit benutzerdefinierter Achsenskalierung
#' ggplot_line_full(
#'   data = tab_bev,
#'   x = "jahr",
#'   y = "n",
#'   line_color = 1,
#'   title = "Bevölkerung",
#'   subtitle = "Entwicklung über die Zeit",
#'   source = "Kantonale Bevölkerungserhebung",
#'   y_min = 0,
#'   y_max = 350000
#' )
#'
#' # Mehrere Linien mit Beschriftung der Kategorien
#' ggplot_line_full(
#'   data = tab_alterskat,
#'   x = "jahr",
#'   y = "n",
#'   order = "order",
#'   group = "alterskat_det",
#'   line_labels = TRUE,
#'   line_label_size = 4,
#'   line_label_nudge_x = 0.2,
#'   group_palette = colors_sequential,
#'   group_palette_name = "fillSeq5",
#'   title = "Bevölkerung nach Alterskategorie",
#'   subtitle = "Entwicklung über die Zeit",
#'   source = "Kantonale Bevölkerungserhebung"
#' )
#' }
#'
#' @export

ggplot_line_full <- function(
    data,
    y,
    x,
    group = NULL,
    color = NULL,
    order = NULL,

    # Group / line palette
    group_palette = maincolors_discrete,
    group_palette_name = "fillHighlight",
    group_colors = NULL,
    group_reverse = FALSE,

    # Colour palette when colour is mapped separately
    border_palette = border_discrete,
    border_palette_name = "borderHighligt",
    border_colors = NULL,
    border_reverse = FALSE,

    # Fixed colour for a single line
    line_color = 1,

    # Y-axis limits
    y_min = NULL,
    y_max = NULL,

    # Theme
    theme = theme_opts_line,

    # Value labels
    labels = FALSE,
    label_color = "white",
    label_size = 4.5,
    label_fontface = "bold",
    label_angle = 0,
    label_hjust = NULL,
    label_vjust = NULL,

    # Line category labels
    line_labels = FALSE,
    line_label_position = 0.5,
    line_label_size = 4,
    line_label_fontface = "bold",
    line_label_hjust = 0.5,
    line_label_vjust = -0.5,
    line_label_nudge_x = 0,
    line_label_nudge_y = 0,

    # Plot text
    title = NULL,
    subtitle = NULL,
    source = NULL
) {

  # ---------------------------------------------------------
  # Check variables
  # ---------------------------------------------------------

  if (!y %in% names(data)) {
    stop("Y variable '", y, "' not found in data.")
  }

  if (!x %in% names(data)) {
    stop("X variable '", x, "' not found in data.")
  }

  if (!is.null(group) && !group %in% names(data)) {
    stop("Group variable '", group, "' not found in data.")
  }

  if (!is.null(color) && !color %in% names(data)) {
    stop("Colour variable '", color, "' not found in data.")
  }

  if (!is.null(order) && !order %in% names(data)) {
    stop("Order variable '", order, "' not found in data.")
  }

  if (line_labels && is.null(group)) {
    stop(
      "'line_labels = TRUE' requires a grouping variable in 'group'."
    )
  }

  if (!is.numeric(line_label_position) ||
      length(line_label_position) != 1 ||
      line_label_position < 0 ||
      line_label_position > 1) {
    stop(
      "'line_label_position' must be a single number between 0 and 1."
    )
  }


  # ---------------------------------------------------------
  # Check Y variable and limits
  # ---------------------------------------------------------

  if (!is.numeric(data[[y]])) {
    stop("Y variable '", y, "' must be numeric.")
  }

  if (!is.null(y_min) && !is.numeric(y_min)) {
    stop("'y_min' must be numeric or NULL.")
  }

  if (!is.null(y_max) && !is.numeric(y_max)) {
    stop("'y_max' must be numeric or NULL.")
  }

  if (!is.null(y_min) &&
      !is.null(y_max) &&
      y_min >= y_max) {
    stop("'y_min' must be smaller than 'y_max'.")
  }


  # ---------------------------------------------------------
  # Determine group order
  # ---------------------------------------------------------

  category_order <- NULL

  if (!is.null(group)) {

    if (!is.null(order)) {

      category_order <- data |>
        dplyr::select(
          dplyr::all_of(c(group, order))
        ) |>
        dplyr::distinct() |>
        dplyr::arrange(.data[[order]]) |>
        dplyr::pull(.data[[group]]) |>
        unique()

    } else {

      if (is.factor(data[[group]])) {

        category_order <- levels(data[[group]])

      } else {

        category_order <- unique(data[[group]])
        category_order <- category_order[!is.na(category_order)]
      }
    }

    data[[group]] <- factor(
      data[[group]],
      levels = category_order
    )

    if (!is.null(color) && color == group) {

      data[[color]] <- factor(
        data[[color]],
        levels = category_order
      )
    }
  }


  # ---------------------------------------------------------
  # Create formatted value labels
  # ---------------------------------------------------------

  if (labels) {

    data$label_value <- scales::label_comma(
      big.mark = "'"
    )(data[[y]])
  }


  # ---------------------------------------------------------
  # Determine Y-axis limits
  # ---------------------------------------------------------

  data_y_max <- max(
    data[[y]],
    na.rm = TRUE
  )

  if (is.null(y_min)) {
    y_min <- 0
  }

  if (is.null(y_max)) {
    y_max <- data_y_max * 1.1
  }


  # ---------------------------------------------------------
  # Create line label data
  # ---------------------------------------------------------

  line_label_data <- NULL

  if (line_labels) {

    # Remove incomplete observations
    label_data <- data |>
      dplyr::filter(
        !is.na(.data[[x]]),
        !is.na(.data[[y]]),
        !is.na(.data[[group]])
      )

    # Determine the position separately for every group
    line_label_data <- label_data |>
      dplyr::group_by(
        .data[[group]]
      ) |>
      dplyr::arrange(
        .data[[x]],
        .by_group = TRUE
      ) |>
      dplyr::mutate(
        .line_position = dplyr::row_number(),
        .line_n = dplyr::n(),
        .target_position = round(
          1 + (.line_n - 1) * line_label_position
        )
      ) |>
      dplyr::slice(
        which.min(
          abs(
            .line_position - .target_position
          )
        )
      ) |>
      dplyr::ungroup()
  }


  # ---------------------------------------------------------
  # Create base plot
  # ---------------------------------------------------------

  p <- ggplot2::ggplot(
    data,
    ggplot2::aes(
      x = .data[[x]],
      y = .data[[y]]
    )
  )


  # ---------------------------------------------------------
  # Group mapping
  # ---------------------------------------------------------

  if (!is.null(group)) {

    p <- p +
      ggplot2::aes(
        group = .data[[group]]
      )
  }


  # ---------------------------------------------------------
  # Colour mapping
  # ---------------------------------------------------------

  if (!is.null(color)) {

    p <- p +
      ggplot2::aes(
        colour = .data[[color]]
      )

  } else if (!is.null(group)) {

    p <- p +
      ggplot2::aes(
        colour = .data[[group]]
      )
  }


  # ---------------------------------------------------------
  # Line
  # ---------------------------------------------------------

  if (is.null(group) && is.null(color)) {

    fixed_colour <- group_palette[[group_palette_name]][line_color]

    p <- p +
      ggplot2::geom_line(
        ggplot2::aes(group = 1),
        colour = fixed_colour,
        linewidth = 1
      )

  } else {

    p <- p +
      ggplot2::geom_line(
        linewidth = 1
      )
  }


  # ---------------------------------------------------------
  # Group colour scale
  # ---------------------------------------------------------

  if (!is.null(group) && is.null(color)) {

    p <- p +
      scale_colour_custom(
        palette = group_palette,
        palette_name = group_palette_name,
        colors = group_colors,
        reverse = group_reverse,
        breaks = category_order,
        limits = category_order
      )
  }


  # ---------------------------------------------------------
  # Separate colour scale
  # ---------------------------------------------------------

  if (!is.null(color)) {

    if (!is.null(group) && color == group) {

      color_order <- category_order

    } else {

      if (is.factor(data[[color]])) {

        color_order <- levels(data[[color]])

      } else {

        color_order <- unique(data[[color]])
        color_order <- color_order[!is.na(color_order)]
      }
    }

    p <- p +
      scale_colour_custom(
        palette = border_palette,
        palette_name = border_palette_name,
        colors = border_colors,
        reverse = border_reverse,
        breaks = color_order,
        limits = color_order
      )
  }


  # ---------------------------------------------------------
  # Value labels
  # ---------------------------------------------------------

  if (labels) {

    current_hjust <- if (is.null(label_hjust)) {
      0.5
    } else {
      label_hjust
    }

    current_vjust <- if (is.null(label_vjust)) {
      -0.5
    } else {
      label_vjust
    }

    if (!is.null(group)) {

      p <- p +
        ggplot2::geom_text(
          ggplot2::aes(
            label = .data$label_value,
            group = .data[[group]]
          ),
          angle = label_angle,
          hjust = current_hjust,
          vjust = current_vjust,
          colour = label_color,
          size = label_size,
          fontface = label_fontface
        )

    } else {

      p <- p +
        ggplot2::geom_text(
          ggplot2::aes(
            label = .data$label_value,
            group = 1
          ),
          angle = label_angle,
          hjust = current_hjust,
          vjust = current_vjust,
          colour = label_color,
          size = label_size,
          fontface = label_fontface
        )
    }
  }


  # ---------------------------------------------------------
  # Line category labels
  # ---------------------------------------------------------

  if (line_labels) {

    p <- p +
      ggplot2::geom_text(
        data = line_label_data,
        ggplot2::aes(
          x = .data[[x]],
          y = .data[[y]],
          label = .data[[group]],
          colour = .data[[group]]
        ),
        inherit.aes = FALSE,

        # IMPORTANT:
        # Do not let the category labels modify
        # the legend keys.
        show.legend = FALSE,

        hjust = line_label_hjust,
        vjust = line_label_vjust,
        nudge_x = line_label_nudge_x,
        nudge_y = line_label_nudge_y,
        size = line_label_size,
        fontface = line_label_fontface
      )
  }


  # ---------------------------------------------------------
  # Plot labels
  # ---------------------------------------------------------

  plot_labels <- list(
    title = title,
    subtitle = subtitle,
    x = "",
    y = "",
    caption = paste(
      "Amt für Daten und Statistik Thurgau\nDatenquelle:",
      source
    )
  )

  if (!is.null(group) || !is.null(color)) {
    plot_labels$colour <- ""
  }


  # ---------------------------------------------------------
  # Final plot
  # ---------------------------------------------------------

  p +
    theme +
    ggplot2::theme(
      plot.caption = ggplot2::element_text(hjust = 0),
      plot.title.position = "plot",
      plot.caption.position = "plot",
      legend.position = "top",
      legend.justification = "left",
      legend.location = "plot"
    ) +
    ggplot2::scale_y_continuous(
      labels = scales::label_comma(
        big.mark = "'"
      ),
      expand = ggplot2::expansion(
        mult = c(0, 0.02)
      )
    ) +
    ggplot2::coord_cartesian(
      ylim = c(
        y_min,
        y_max
      )
    ) +
    ggplot2::labs(
      title = plot_labels$title,
      subtitle = plot_labels$subtitle,
      x = plot_labels$x,
      y = plot_labels$y,
      colour = plot_labels$colour,
      caption = plot_labels$caption
    )
}
# ggplot_line_full(
#   data = tab_bev,
#   x = "jahr",
#   y = "n",
#   line_color = 1,
#   title = "Bevölkerung",
#   subtitle = "Entwicklung über die Zeit",
#   source = "Kantonale Bevölkerungserhebung"
# )
#
# ggplot_line_full(
#   data = tab_bev,
#   x = "jahr",
#   y = "n",
#   line_color = 1,
#   title = "Bevölkerung",
#   subtitle = "Entwicklung über die Zeit",
#   source = "Kantonale Bevölkerungserhebung",
#   y_min = 0,
#   y_max = 350000,
#   theme = theme_opts_line_minor_grid
# )
#
# ggplot_line_full(
#   data = tab_alterskat,
#   x = "jahr",
#   y = "n",
#   order = "order",
#   group = "alterskat_det",
#   line_labels = TRUE,
#   line_label_size = 4,
#   line_label_nudge_x = 0.2,
#   group_palette = colors_sequential,
#   group_palette_name = "fillSeq5",
#   title = "Bevölkerung nach Alterskategorie",
#   subtitle = "Entwicklung über die Zeit",
#   source = "Kantonale Bevölkerungserhebung",
#
# )
