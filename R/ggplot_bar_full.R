#' Vollständiges horizontales Balkendiagramm erstellen
#'
#' Erstellt ein horizontales Balkendiagramm mit anpassbaren Füll- und
#' Randfarben, optionaler Gruppierung nach Kategorien sowie Zahlenbeschriftungen.
#' Die Balken können gestapelt oder gruppiert dargestellt werden.
#'
#' Die Variable \code{x} wird bei Bedarf in einen Faktor umgewandelt, damit
#' numerische Werte wie Jahre als diskrete Kategorien dargestellt werden.
#' Die Reihenfolge der Füllkategorien kann über \code{order} gesteuert werden.
#'
#' @param data Ein Data Frame mit den darzustellenden Daten.
#' @param y Name der numerischen Variable für die Balkenlängen als Zeichenkette.
#' @param x Name der kategorialen Variable auf der Achse als Zeichenkette.
#' @param fill Optionale Variable für die Füllfarben der Balken als Zeichenkette.
#'   Wenn \code{NULL}, wird eine einheitliche Füllfarbe verwendet.
#' @param color Optionale Variable für die Randfarben der Balken als Zeichenkette.
#'   Wenn \code{NULL}, werden die Randfarben anhand von \code{fill} bestimmt.
#'   Ist auch \code{fill} gleich \code{NULL}, wird eine einheitliche Randfarbe
#'   verwendet.
#' @param order Optionale Variable zur Festlegung der Reihenfolge der
#'   Füllkategorien als Zeichenkette. Die Kategorien werden entsprechend dieser
#'   Variable aufsteigend sortiert.
#'
#' @param fill_palette Palette für die Füllfarben. Standardmässig wird
#'   \code{maincolors_discrete} verwendet.
#' @param fill_palette_name Name der innerhalb von \code{fill_palette}
#'   zu verwendenden Farbpalette. Standardmässig \code{"fillColor"}.
#' @param fill_colors Optionaler benannter Vektor mit individuellen Füllfarben
#'   für Kategorien. Wird an \code{scale_fill_custom()} übergeben.
#' @param fill_reverse Logischer Wert. Wenn \code{TRUE}, wird die Reihenfolge
#'   der Füllfarben umgekehrt.
#'
#' @param border_palette Palette für die Randfarben. Standardmässig wird
#'   \code{border_discrete} verwendet.
#' @param border_palette_name Name der innerhalb von \code{border_palette}
#'   zu verwendenden Farbpalette. Standardmässig \code{"borderColor"}.
#' @param border_colors Optionaler benannter Vektor mit individuellen Randfarben
#'   für Kategorien. Wird an \code{scale_colour_custom()} übergeben.
#' @param border_reverse Logischer Wert. Wenn \code{TRUE}, wird die Reihenfolge
#'   der Randfarben umgekehrt.
#'
#' @param fill_color Index der Füllfarbe innerhalb der gewählten Füllpalette,
#'   wenn keine Variable für die Füllfarben angegeben wurde.
#' @param border_color Index der Randfarbe innerhalb der gewählten Randpalette,
#'   wenn weder eine Variable für die Randfarben noch eine Füllvariable
#'   vorhanden ist.
#'
#' @param labels Logischer Wert. Wenn \code{TRUE}, werden die Werte der
#'   numerischen Variable innerhalb oder an den Balken angezeigt.
#' @param label_color Farbe der Zahlenbeschriftungen. Standardmässig
#'   \code{"white"}.
#' @param label_size Schriftgrösse der Zahlenbeschriftungen.
#'   Standardmässig \code{4.5}.
#' @param label_fontface Schriftstil der Zahlenbeschriftungen, beispielsweise
#'   \code{"bold"} oder \code{"plain"}.
#'
#' @param title Titel des Diagramms.
#' @param subtitle Untertitel des Diagramms.
#' @param source Quelle der dargestellten Daten. Wird in der Bildunterschrift
#'   zusammen mit dem Hinweis auf das Amt für Daten und Statistik Thurgau
#'   ausgegeben.
#'
#' @param position Positionierung der Balken. Zulässige Werte sind
#'   \code{"stack"} für gestapelte Balken und \code{"dodge"} für nebeneinander
#'   dargestellte Balken. Standardmässig \code{"stack"}.
#' @param reverse_stack Logischer Wert. Steuert bei gestapelten Balken die
#'   Reihenfolge der Kategorien. Standardmässig \code{TRUE}.
#'
#' @return Ein \code{ggplot}-Objekt, das weiter angepasst oder mit
#'   \code{print()} ausgegeben werden kann.
#'
#' @examples
#' \dontrun{
#' # Einfaches Balkendiagramm
#' ggplot_bar_full(
#'   data = tab_bev,
#'   y = "n",
#'   x = "jahr",
#'   title = "Bevölkerungsentwicklung",
#'   subtitle = "Bevölkerung nach Jahr",
#'   source = "Kantonale Bevölkerungserhebung",
#'   labels = TRUE
#' )
#'
#' # Gestapelte Balken nach Alterskategorie
#' ggplot_bar_full(
#'   data = tab_alterskat,
#'   y = "n",
#'   x = "jahr",
#'   fill = "alterskat_det",
#'   fill_palette = colors_sequential,
#'   fill_palette_name = "fillSeq5",
#'   position = "stack",
#'   labels = TRUE
#' )
#'
#' # Gruppierte Balken nach Alterskategorie
#' ggplot_bar_full(
#'   data = tab_alterskat,
#'   y = "n",
#'   x = "jahr",
#'   fill = "alterskat_det",
#'   fill_palette = colors_sequential,
#'   fill_palette_name = "fillSeq5",
#'   position = "dodge"
#' )
#' }
#'
#' @export
ggplot_bar_full <- function(
    data,
    y,
    x,
    fill = NULL,
    color = NULL,
    order = NULL,

    # Fill palette
    fill_palette = maincolors_discrete,
    fill_palette_name = "fillColor",
    fill_colors = NULL,
    fill_reverse = FALSE,

    # Border palette
    border_palette = border_discrete,
    border_palette_name = "borderColor",
    border_colors = NULL,
    border_reverse = FALSE,

    # Fixed colours when no categorical variable is mapped
    fill_color = 1,
    border_color = 1,

    # Labels
    labels = FALSE,
    label_color = "white",
    label_size = 4.5,
    label_fontface = "bold",

    # Plot text
    title = NULL,
    subtitle = NULL,
    source = NULL,

    # Positioning
    position = "stack",
    reverse_stack = TRUE
) {

  # Validate arguments -----------------------------------------------------

  if (!position %in% c("stack", "dodge")) {
    stop("`position` must be either 'stack' or 'dodge'.")
  }

  if (!x %in% names(data)) {
    stop("X variable '", x, "' not found in data.")
  }

  if (!y %in% names(data)) {
    stop("Y variable '", y, "' not found in data.")
  }

  if (!is.null(fill) && !fill %in% names(data)) {
    stop("Fill variable '", fill, "' not found in data.")
  }

  if (!is.null(color) && !color %in% names(data)) {
    stop("Colour variable '", color, "' not found in data.")
  }

  if (!is.null(order) && !order %in% names(data)) {
    stop("Order variable '", order, "' not found in data.")
  }

  # Convert x to a factor when it is numeric or character -----------------
  # This makes years appear as discrete categories in the plot.

  if (!is.factor(data[[x]])) {
    x_values <- unique(data[[x]])
    x_values <- x_values[!is.na(x_values)]

    if (is.numeric(x_values)) {
      x_values <- sort(x_values)
    } else {
      x_values <- sort(as.character(x_values))
    }

    data[[x]] <- factor(data[[x]], levels = x_values)
  }

  x_order <- levels(data[[x]])

  # Determine fill category order -----------------------------------------

  category_order <- NULL

  if (!is.null(fill)) {

    if (!is.null(order)) {

      category_order <- data |>
        dplyr::select(dplyr::all_of(c(fill, order))) |>
        dplyr::distinct() |>
        dplyr::arrange(.data[[order]]) |>
        dplyr::pull(.data[[fill]]) |>
        unique()

    } else if (is.factor(data[[fill]])) {

      category_order <- levels(data[[fill]])

    } else {

      category_order <- unique(data[[fill]])
      category_order <- category_order[!is.na(category_order)]

    }

    data[[fill]] <- factor(
      data[[fill]],
      levels = category_order
    )
  }

  # Determine border mapping -----------------------------------------------

  border_mapping <- if (!is.null(color)) {
    color
  } else {
    fill
  }

  # Build plot -------------------------------------------------------------

  p <- ggplot2::ggplot(
    data,
    ggplot2::aes(
      x = .data[[x]],
      y = .data[[y]]
    )
  )

  if (!is.null(fill)) {
    p <- p +
      ggplot2::aes(fill = .data[[fill]])
  }

  if (!is.null(border_mapping)) {
    p <- p +
      ggplot2::aes(colour = .data[[border_mapping]])
  }

  # Positioning ------------------------------------------------------------

  bar_position <- if (position == "stack") {
    ggplot2::position_stack(reverse = reverse_stack)
  } else {
    ggplot2::position_dodge(width = 0.9)
  }

  # Add bars without empty fixed aesthetics -------------------------------

  geom_args <- list(position = bar_position)

  if (is.null(fill)) {
    geom_args$fill <-
      fill_palette[[fill_palette_name]][fill_color]
  }

  if (is.null(border_mapping)) {
    geom_args$colour <-
      border_palette[[border_palette_name]][border_color]
  }

  p <- p +
    do.call(ggplot2::geom_col, geom_args)

  # Fill scale -------------------------------------------------------------

  if (!is.null(fill)) {
    p <- p +
      scale_fill_custom(
        palette = fill_palette,
        palette_name = fill_palette_name,
        colors = fill_colors,
        reverse = fill_reverse,
        breaks = category_order,
        limits = category_order
      )
  }

  # Border scale -----------------------------------------------------------

  if (!is.null(border_mapping)) {

    if (identical(border_mapping, fill)) {
      color_order <- category_order
    } else if (is.factor(data[[border_mapping]])) {
      color_order <- levels(data[[border_mapping]])
    } else {
      color_order <- unique(data[[border_mapping]])
      color_order <- color_order[!is.na(color_order)]
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

  # Labels inside bars -----------------------------------------------------

  if (labels) {

    label_mapping <- ggplot2::aes(
      label = scales::label_comma(big.mark = "'")(.data[[y]])
    )

    if (!is.null(fill) && position == "stack") {

      p <- p +
        ggplot2::geom_text(
          mapping = label_mapping,
          position = ggplot2::position_stack(
            vjust = 0.5,
            reverse = reverse_stack
          ),
          colour = label_color,
          size = label_size,
          fontface = label_fontface
        )

    } else if (!is.null(fill) && position == "dodge") {

      p <- p +
        ggplot2::geom_text(
          mapping = label_mapping,
          position = ggplot2::position_dodge(width = 0.9),
          vjust = 1.2,
          colour = label_color,
          size = label_size,
          fontface = label_fontface
        )

    } else {

      p <- p +
        ggplot2::geom_text(
          mapping = label_mapping,
          hjust = 1.1,
          colour = label_color,
          size = label_size,
          fontface = label_fontface
        )

    }
  }

  # Plot labels ------------------------------------------------------------

  plot_labels <- list(
    title = title,
    subtitle = subtitle,
    caption = paste(
      "Amt für Daten und Statistik Thurgau\nDatenquelle:",
      source
    )
  )

  # Final plot -------------------------------------------------------------

  p <- p +
    theme_bar_grid_vertical +
    ggplot2::scale_y_continuous(
      labels = scales::label_comma(big.mark = "'"),
      expand = c(0, 0),
      position = "right"
    ) +
    ggplot2::scale_x_discrete(
      breaks = x_order,
      labels = x_order,
      drop = FALSE,
      expand = ggplot2::expansion(add = 0.5)
    ) +
    ggplot2::labs(
      title = plot_labels$title,
      subtitle = plot_labels$subtitle,
      x = "",
      y = "",
      caption = plot_labels$caption
    ) +
    ggplot2::coord_flip(clip = "off") +
    ggplot2::theme(
      axis.text.y = ggplot2::element_text(
        colour = "black",
        size = 10,
        angle = 0,
        hjust = 1,
        margin = ggplot2::margin(r = 6)
      ),
      axis.ticks.y = ggplot2::element_line(
        colour = "grey"
      ),
      axis.text.x = ggplot2::element_text(
        colour = "black"
      ),
      axis.title.y = ggplot2::element_blank(),
      plot.margin = ggplot2::margin(
        t = 10,
        r = 15,
        b = 10,
        l = 25
      ),
      plot.caption = ggplot2::element_text(hjust = 0),
      plot.title.position = "plot",
      plot.caption.position = "plot",
      legend.position = "top",
      legend.justification = "left",
      legend.location = "plot"

    )

  if (!is.null(fill)) {
    p <- p +
      ggplot2::labs(fill = "")
  }

  if (!is.null(border_mapping)) {
    p <- p +
      ggplot2::labs(colour = "")
  }

  p
}

# ggplot_bar_full(
#   data = tab_bev,
#   y = "n",
#   x = "jahr",
#   title = "TITEL",
#   subtitle = "UNTERTITEL",
#   source = "Kantonale Bevölkerungserhebung",
#   labels = TRUE
# )
#
# ggplot_bar_full(
#   data = tab_alterskat,
#   y = "n",
#   x = "jahr",
#   fill = "alterskat_det",
#   fill_palette = colors_sequential,
#   fill_palette_name = "fillSeq5",
#   position = "stack",
#   labels = TRUE
# )
#
# ggplot_bar_full(
#   data = tab_alterskat,
#   y = "n",
#   x = "jahr",
#   fill = "alterskat_det",
#   fill_palette = colors_sequential,
#   fill_palette_name = "fillSeq5",
#   position = "dodge"
# )
