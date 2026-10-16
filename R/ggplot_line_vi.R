#' Liniendiagramm mit Konfidenzintervallen gemäss Styleguide
#'
#' Erstellt ein Liniendiagramm mit optionalen Konfidenzintervallen,
#' anpassbaren Farbpaletten und zusätzlichen Beschriftungsmöglichkeiten.
#' Die Funktion unterstützt einzelne Linien sowie mehrere nach Kategorien
#' gruppierte Linien.
#'
#' Konfidenzintervalle werden als halbtransparente Flächen um die Linien
#' dargestellt. Die Farben dieser Flächen orientieren sich an den Farben
#' der jeweiligen Linien beziehungsweise Gruppen. Die Gruppierungsreihenfolge
#' kann über eine Sortiervariable gesteuert werden.
#'
#' Zusätzlich können numerische Werte direkt im Diagramm angezeigt und
#' die einzelnen Linien mit ihren Kategorienamen beschriftet werden.
#' Die Grenzen der vertikalen Achse lassen sich bei Bedarf manuell festlegen.
#'
#' @param data Ein Data Frame mit den darzustellenden Daten.
#' @param y Name der numerischen Variable für die vertikale Achse als
#'   Zeichenkette.
#' @param x Name der Variable für die horizontale Achse als Zeichenkette,
#'   beispielsweise eine Jahresvariable.
#' @param ci_lower Optionale Variable mit den unteren Grenzen der
#'   Konfidenzintervalle als Zeichenkette.
#' @param ci_upper Optionale Variable mit den oberen Grenzen der
#'   Konfidenzintervalle als Zeichenkette.
#' @param group Optionale kategoriale Variable zur Gruppierung der Linien
#'   als Zeichenkette. Wenn angegeben, erhält jede Gruppe eine eigene Linie
#'   und eine eigene Farbe.
#' @param color Optionale Variable zur separaten Zuordnung der Linien- und
#'   Konfidenzintervallfarben als Zeichenkette. Wenn angegeben, werden die
#'   Farben anhand dieser Variable bestimmt.
#' @param order Optionale Variable zur Festlegung der Reihenfolge der Gruppen
#'   als Zeichenkette. Die Gruppen werden anhand dieser Variable aufsteigend
#'   sortiert.
#' @param errorbar_width Breite der Fehlerbalken. Dieses Argument ist in der
#'   aktuellen Implementierung nicht in der Darstellung eingebunden.
#' @param x_expand Relativer Erweiterungsfaktor für die obere Grenze der
#'   horizontalen Achse. Der grösste Wert von \code{ci_upper} oder, falls
#'   nicht angegeben, von \code{x} wird um diesen Faktor erweitert.
#'   Standardmässig \code{0.10}.
#'
#' @param group_palette Farbpalette für die Liniengruppen. Standardmässig
#'   wird \code{maincolors_discrete} verwendet.
#' @param group_palette_name Name des Eintrags innerhalb von
#'   \code{group_palette}, aus dem die Gruppenfarben ausgewählt werden.
#'   Standardmässig \code{"fillHighlight"}.
#' @param group_colors Optionale numerische Indizes zur Auswahl bestimmter
#'   Farben aus der Gruppenpalette.
#' @param group_reverse Logischer Wert. Wenn \code{TRUE}, wird die Reihenfolge
#'   der ausgewählten Gruppenfarben umgekehrt.
#'
#' @param border_palette Farbpalette für die Linienfarben, wenn eine separate
#'   Farbvariable über \code{color} angegeben wird. Standardmässig wird
#'   \code{border_discrete} verwendet.
#' @param border_palette_name Name des Eintrags innerhalb von
#'   \code{border_palette}. Standardmässig \code{"borderHighligt"}.
#' @param border_colors Optionale numerische Indizes zur Auswahl bestimmter
#'   Farben aus der Randfarbpalette.
#' @param border_reverse Logischer Wert. Wenn \code{TRUE}, wird die Reihenfolge
#'   der ausgewählten Randfarben umgekehrt.
#'
#' @param line_color Index der Linienfarbe innerhalb der ausgewählten
#'   Gruppenpalette, wenn weder \code{group} noch \code{color} angegeben ist.
#'   Standardmässig \code{1}.
#' @param ribbon_alpha Transparenz der Konfidenzintervallflächen.
#'   Zulässige Werte liegen zwischen \code{0} (vollständig transparent)
#'   und \code{1} (vollständig deckend). Standardmässig \code{0.30}.
#'
#' @param y_min Optionale untere Grenze der vertikalen Achse. Wenn
#'   \code{NULL}, wird standardmässig \code{0} verwendet.
#' @param y_max Optionale obere Grenze der vertikalen Achse. Wenn
#'   \code{NULL}, wird standardmässig das 1,1-Fache des grössten Wertes
#'   von \code{y} verwendet. In der aktuellen Implementierung werden
#'   anschliessend zusätzlich 10 Einheiten zur oberen Grenze addiert.
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
#' # Liniendiagramm mit Konfidenzintervallen nach Geschlecht
#' ggplot_line_vi(
#'   data = tab_erwerbsquote |>
#'     dplyr::mutate(jahr = as.character(jahr)) |>
#'     dplyr::filter(sex != "Total"),
#'   x = "jahr",
#'   y = "anteil",
#'   group = "sex",
#'   group_palette = colors_gender,
#'   group_palette_name = "fillColor",
#'   title = "Erwerbsquote nach Geschlecht",
#'   subtitle = "Entwicklung über die Zeit",
#'   source = "Kantonale Bevölkerungserhebung",
#'   ci_lower = "ci_l_pr",
#'   ci_upper = "ci_u_pr",
#'   ribbon_alpha = 0.10
#' )
#'
#' # Liniendiagramm mit zusätzlichen Linienbeschriftungen
#' ggplot_line_vi(
#'   data = tab_erwerbsquote |>
#'     dplyr::mutate(jahr = as.character(jahr)) |>
#'     dplyr::filter(sex != "Total"),
#'   x = "jahr",
#'   y = "anteil",
#'   group = "sex",
#'   group_palette = colors_gender,
#'   group_palette_name = "fillColor",
#'   title = "Erwerbsquote nach Geschlecht",
#'   subtitle = "Entwicklung über die Zeit",
#'   source = "Kantonale Bevölkerungserhebung",
#'   ci_lower = "ci_l_pr",
#'   ci_upper = "ci_u_pr",
#'   ribbon_alpha = 0.10,
#'   line_labels = TRUE
#' )
#' }
#'
#' @export
ggplot_line_vi <- function(
    data,
    y,
    x,
    ci_lower = NULL,
    ci_upper = NULL,
    group = NULL,
    color = NULL,
    order = NULL,
    errorbar_width = 0.2,
    x_expand = 0.10,

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

    # Confidence interval ribbon
    ribbon_alpha = 0.30,

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

  if (!is.null(ci_lower) && !ci_lower %in% names(data)) {
    stop("CI lower variable '", ci_lower, "' not found in data.")
  }

  if (!is.null(ci_upper) && !ci_upper %in% names(data)) {
    stop("CI upper variable '", ci_upper, "' not found in data.")
  }

  if (line_labels && is.null(group)) {
    stop(
      "'line_labels = TRUE' requires a grouping variable in 'group'."
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
  # Check ribbon alpha
  # ---------------------------------------------------------

  if (!is.numeric(ribbon_alpha) ||
      length(ribbon_alpha) != 1 ||
      ribbon_alpha < 0 ||
      ribbon_alpha > 1) {
    stop(
      "'ribbon_alpha' must be a single number between 0 and 1."
    )
  }


  # ---------------------------------------------------------
  # Determine maximum X value
  # ---------------------------------------------------------

  if (!is.null(ci_upper)) {

    x_max <- max(
      data[[ci_upper]],
      na.rm = TRUE
    )

  } else {

    x_max <- max(
      data[[x]],
      na.rm = TRUE
    )
  }

  x_upper <- x_max * (1 + x_expand)


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
  # Create colour order
  # ---------------------------------------------------------

  color_order <- NULL

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
  }


  # ---------------------------------------------------------
  # Select group palette colours
  # ---------------------------------------------------------

  selected_group_colors <- NULL

  if (!is.null(group)) {

    selected_group_colors <-
      group_palette[[group_palette_name]]

    if (is.null(selected_group_colors)) {
      stop(
        "Palette 'group_palette_name = \"",
        group_palette_name,
        "\"' was not found in group_palette."
      )
    }

    if (!is.null(group_colors)) {
      selected_group_colors <-
        selected_group_colors[group_colors]
    }

    if (group_reverse) {
      selected_group_colors <-
        rev(selected_group_colors)
    }

    if (length(selected_group_colors) < length(category_order)) {
      stop(
        "The selected group palette contains ",
        length(selected_group_colors),
        " colour(s), but ",
        length(category_order),
        " group(s) are present in the data. ",
        "Please select more colours with 'group_colors'."
      )
    }

    selected_group_colors <-
      selected_group_colors[seq_along(category_order)]

    names(selected_group_colors) <-
      as.character(category_order)
  }


  # ---------------------------------------------------------
  # Select separate colour palette
  # ---------------------------------------------------------

  selected_border_colors <- NULL

  if (!is.null(color)) {

    selected_border_colors <-
      border_palette[[border_palette_name]]

    if (is.null(selected_border_colors)) {
      stop(
        "Palette 'border_palette_name = \"",
        border_palette_name,
        "\"' was not found in border_palette."
      )
    }

    if (!is.null(border_colors)) {
      selected_border_colors <-
        selected_border_colors[border_colors]
    }

    if (border_reverse) {
      selected_border_colors <-
        rev(selected_border_colors)
    }

    if (length(selected_border_colors) < length(color_order)) {
      stop(
        "The selected border palette contains ",
        length(selected_border_colors),
        " colour(s), but ",
        length(color_order),
        " colour categories are present in the data. ",
        "Please select more colours with 'border_colors'."
      )
    }

    selected_border_colors <-
      selected_border_colors[seq_along(color_order)]

    names(selected_border_colors) <-
      as.character(color_order)
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

    label_data <- data |>
      dplyr::filter(
        !is.na(.data[[x]]),
        !is.na(.data[[y]]),
        !is.na(.data[[group]])
      )

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
  # Base plot
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

    fixed_colour <-
      group_palette[[group_palette_name]][line_color]

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
  # Confidence interval ribbon
  # ---------------------------------------------------------

  if (!is.null(ci_lower) && !is.null(ci_upper)) {

    if (!is.null(color)) {

      p <- p +
        ggplot2::geom_ribbon(
          ggplot2::aes(
            ymin = .data[[ci_lower]],
            ymax = .data[[ci_upper]],
            fill = .data[[color]]
          ),
          alpha = ribbon_alpha,
          colour = NA,
          show.legend=FALSE
        )

    } else if (!is.null(group)) {

      p <- p +
        ggplot2::geom_ribbon(
          ggplot2::aes(
            ymin = .data[[ci_lower]],
            ymax = .data[[ci_upper]],
            fill = .data[[group]]
          ),
          alpha = ribbon_alpha,
          colour = NA,
          show.legend=FALSE
        )

    } else {

      fixed_colour <-
        group_palette[[group_palette_name]][line_color]

      p <- p +
        ggplot2::geom_ribbon(
          ggplot2::aes(
            ymin = .data[[ci_lower]],
            ymax = .data[[ci_upper]]
          ),
          fill = fixed_colour,
          alpha = ribbon_alpha,
          colour = NA,
          show.legend=FALSE
        )
    }
  }


  # ---------------------------------------------------------
  # Apply group colour scales
  # ---------------------------------------------------------

  if (!is.null(group)) {

    p <- p +
      ggplot2::scale_colour_manual(
        values = selected_group_colors,
        breaks = category_order,
        limits = category_order
      ) +
      ggplot2::scale_fill_manual(
        values = selected_group_colors,
        breaks = category_order,
        limits = category_order
      )
  }


  # ---------------------------------------------------------
  # Apply separate colour scales
  # ---------------------------------------------------------

  if (!is.null(color)) {

    p <- p +
      ggplot2::scale_colour_manual(
        values = selected_border_colors,
        breaks = color_order,
        limits = color_order
      ) +
      ggplot2::scale_fill_manual(
        values = selected_border_colors,
        breaks = color_order,
        limits = color_order,
        show.legend=FALSE
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
        y_max + 10
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

# ggplot_line_vi(
#   data = tab_erwerbsquote %>%
#     dplyr::mutate(jahr = as.character(jahr)) %>% filter(sex!="Total"),
#   x = "jahr",
#   y = "anteil",
#   group = "sex",
#
#   group_palette = colors_gender,
#   group_palette_name = "fillColor",
#
#   title = "Bevölkerung",
#   subtitle = "Entwicklung über die Zeit",
#   source = "Kantonale Bevölkerungserhebung",
#
#   ci_lower = "ci_l_pr",
#   ci_upper = "ci_u_pr",
#
#   ribbon_alpha = 0.10
# )
#
#
# ggplot_line_vi(
#   data = tab_erwerbsquote %>%
#     dplyr::mutate(jahr = as.character(jahr)) %>% filter(sex!="Total"),
#   x = "jahr",
#   y = "anteil",
#   group = "sex",
#
#   group_palette = colors_gender,
#   group_palette_name = "fillColor",
#
#   title = "Bevölkerung",
#   subtitle = "Entwicklung über die Zeit",
#   source = "Kantonale Bevölkerungserhebung",
#
#   ci_lower = "ci_l_pr",
#   ci_upper = "ci_u_pr",
#
#   ribbon_alpha = 0.10,
#   line_labels = TRUE
# )
