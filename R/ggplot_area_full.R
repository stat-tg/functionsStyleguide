#' Flächendiagramm (Area) gemäss Styleguide
#'
#' Funktion zur Darstellung von Daten als Flächen- resp. Area-Charts mit ggplot2 gemäss dem Design Styleguide des
#' Amts für Daten und Statistik
#'
#' @param data Datensatz, der dargestellt werden soll (vorzugsweise im Long-Format mit je Spalten zu den Kategorien und der Anzahl, je nachdem auch einer Sortierungsvariable)
#' @param y Name der Variable mit den Werten, bspw. Anzahl.
#' @param x Name der Variable, die auf der x-Achse abgebildet werden soll, bspw. Jahreszahl.
#' @param group Name der Variable, deren Kategorien dargestellt werden sollen, z.B. Altersklassen.
#' @param order Optionale Variable für die Sortierung der Kategorien.
#'
#' @param group_palette Palettensammlung für die Flächenfüllung, bspw. maincolors_discrete für die Hauptfarben gemäss Styleguide.
#' @param group_palette_name Name der Palette innerhalb der Palettensammlun, z.B. fillColor für die Hauptfarben oder fillHighlight für Highlightfarben.
#' @param group_colors Optionale Auswahl einer Farbe innerhalb der Palette, bspw. 1 für erste Farbe in der Palette
#' @param group_reverse `TRUE` ermöglicht eine Umkehrung der Reihenfolge der Palettenfarbe, Default ist `FALSE`.
#'
#' @param border_palette Palettensammlung für die Randfarbe (Linie oberhalb der jeweiligen Fläche)
#' @param border_palette_name Name der Palette innerhalb der Palettensammlung für die Randfarben
#' @param border_colors Optionale Auswahl einer Farbe innerhalb der Palette, sollte immer der Auswahl über group_colors entsprechen
#' @param border_reverse `TRUE` ermöglicht eine Umkehrung der Reihenfolge der Palettenfarbe, Default ist `FALSE`, sollte immer der Definition in group_reverse entsprechen
#'
#' @param area_labels Zeigt die Kategorien-Labels innerhalb der jeweiligen Fläche an.
#' @param area_label_position Relative horizontale Position der Kategorien-Labels.
#' @param area_label_color Farbe der Kategorien-Labels
#' @param area_label_size Schriftgrösse der Kategorien-Labels
#' @param area_label_fontface Schrifttyp der Kategorien-Labels, Default ist "bold" (weitere Optionen: "plain", "italic", "bold.italic")
#' @param area_label_angle Ausrichtung der Kategorien-Labels, Default ist 0 (horizontal)
#' @param area_label_hjust Horizontale Ausrichtung der Labels (negativer Wert: Verschiebung nach rechts, positiver Wert: Verschiebung nach links)
#' @param area_label_vjust Vertikale Ausrichtung der Labels (negativer Wert: Verschiebung nach oben, positiver Wert: Verschiebung nach unten)
#' @param area_label_nudge_x Horizontale Justierung der Kategorien-Labels zum Datenpunkt.
#' @param area_label_nudge_y Vertikale Justierung der Kategorien-Labels zum Datenpunkt.
#'
#' @param title Diagrammtitel
#' @param subtitle Diagrammuntertitel
#' @param source Datenquelle
#'
#' @return ggplot Flächen-Diagramm.
#'
#' #' @examples
#' \dontrun{
#'
#' # ggplot_area_full(
#'   data = tab_alterskat,
#'   x = "jahr",
#'   y = "n",
#'   order = "order",
#'   group = "alterskat_det",
#'   area_labels = TRUE,
#'   area_label_size = 4,
#'   area_label_nudge_x = 0.2,
#'   group_palette = maincolors_discrete,
#'   group_palette_name = "fillColor",
#'   title = "Bevölkerung nach Alterskategorie",
#'   subtitle = "Entwicklung über die Zeit",
#'   source = "Kantonale Bevölkerungserhebung",
#'
#' )
#'
#' ggplot_area_full(
#'   data = tab_alterskat,
#'   x = "jahr",
#'   y = "n",
#'   order = "order",
#'   group = "alterskat_det",
#'   area_labels = TRUE,
#'   area_label_size = 4,
#'   area_label_position = 0.5,
#'   area_label_nudge_x = -1,
#'   area_label_nudge_y = -1,
#'   group_palette = colors_sequential,
#'   group_palette_name = "fillSeq5",
#'   border_palette = border_sequential,
#'   border_palette_name = "borderSeq5",
#'   title = "Bevölkerung nach Alterskategorie",
#'   subtitle = "Entwicklung über die Zeit",
#'   source = "Kantonale Bevölkerungserhebung"
#' )
#' }

#' @export
ggplot_area_full <- function(
    data,
    y,
    x,
    group,

    order = NULL,

    group_palette = maincolors_discrete,
    group_palette_name = "fillColor",
    group_colors = NULL,
    group_reverse = FALSE,

    border_palette = border_discrete,
    border_palette_name = "borderColor",
    border_colors = NULL,
    border_reverse = FALSE,

    area_labels = FALSE,
    area_label_position = 0.5,
    area_label_color = "white",
    area_label_size = 4,
    area_label_fontface = "bold",
    area_label_angle = 0,
    area_label_hjust = 0.5,
    area_label_vjust = 0.5,
    area_label_nudge_x = 0,
    area_label_nudge_y = 0,

    title = NULL,
    subtitle = NULL,
    source = NULL
) {

  # ------------------------------------------------------------
  # Check variables
  # ------------------------------------------------------------

  if (!y %in% names(data)) {
    stop(
      "Y variable '",
      y,
      "' not found in data."
    )
  }

  if (!x %in% names(data)) {
    stop(
      "X variable '",
      x,
      "' not found in data."
    )
  }

  if (!group %in% names(data)) {
    stop(
      "Group variable '",
      group,
      "' not found in data."
    )
  }

  if (!is.null(order) && !order %in% names(data)) {
    stop(
      "Order variable '",
      order,
      "' not found in data."
    )
  }


  # ------------------------------------------------------------
  # Check label position
  # ------------------------------------------------------------

  if (
    length(area_label_position) != 1 ||
    !is.numeric(area_label_position) ||
    area_label_position < 0 ||
    area_label_position > 1
  ) {

    stop(
      "area_label_position must be a single number between 0 and 1."
    )
  }


  # ------------------------------------------------------------
  # Determine group order
  # ------------------------------------------------------------

  if (!is.null(order)) {

    group_order <- data |>
      dplyr::select(
        dplyr::all_of(c(group, order))
      ) |>
      dplyr::distinct() |>
      dplyr::arrange(.data[[order]]) |>
      dplyr::pull(.data[[group]]) |>
      unique()

  } else {

    if (is.factor(data[[group]])) {

      group_order <- levels(
        data[[group]]
      )

    } else {

      group_order <- unique(
        data[[group]]
      )

      group_order <- group_order[
        !is.na(group_order)
      ]
    }
  }


  # ------------------------------------------------------------
  # Convert group to ordered factor
  # ------------------------------------------------------------

  data[[group]] <- factor(
    data[[group]],
    levels = group_order
  )


  # ------------------------------------------------------------
  # Reverse group order
  # ------------------------------------------------------------

  if (group_reverse) {

    group_order <- rev(
      group_order
    )

    data[[group]] <- factor(
      data[[group]],
      levels = group_order
    )
  }


  # ------------------------------------------------------------
  # Check y variable
  # ------------------------------------------------------------

  if (!is.numeric(data[[y]])) {

    stop(
      "Y variable '",
      y,
      "' must be numeric."
    )
  }


  # ------------------------------------------------------------
  # Create fill colours
  # ------------------------------------------------------------

  fill_values <- group_palette[[group_palette_name]]

  if (is.null(fill_values)) {

    stop(
      "Palette '",
      group_palette_name,
      "' was not found."
    )
  }

  if (!is.null(group_colors)) {

    fill_values <- fill_values[
      group_colors
    ]
  }

  if (length(fill_values) < length(group_order)) {

    stop(
      "The selected fill palette contains ",
      length(fill_values),
      " colours, but ",
      length(group_order),
      " groups are required."
    )
  }

  fill_values <- fill_values[
    seq_len(length(group_order))
  ]

  if (group_reverse) {
    fill_values <- rev(fill_values)
  }


  # ------------------------------------------------------------
  # Create border colours
  # ------------------------------------------------------------

  border_values <- border_palette[[border_palette_name]]

  if (is.null(border_values)) {

    stop(
      "Palette '",
      border_palette_name,
      "' was not found."
    )
  }

  if (!is.null(border_colors)) {

    border_values <- border_values[
      border_colors
    ]
  }

  if (length(border_values) < length(group_order)) {

    stop(
      "The selected border palette contains ",
      length(border_values),
      " colours, but ",
      length(group_order),
      " groups are required."
    )
  }

  border_values <- border_values[
    seq_len(length(group_order))
  ]

  if (border_reverse) {
    border_values <- rev(border_values)
  }


  # ------------------------------------------------------------
  # Create lookup tables for colours
  # ------------------------------------------------------------

  fill_lookup <- stats::setNames(
    fill_values,
    group_order
  )

  border_lookup <- stats::setNames(
    border_values,
    group_order
  )


  # ------------------------------------------------------------
  # Base plot
  # ------------------------------------------------------------

  p <- ggplot2::ggplot(
    data,
    ggplot2::aes(
      x = .data[[x]],
      y = .data[[y]],
      group = .data[[group]]
    )
  )


  # ------------------------------------------------------------
  # Area geometry
  # ------------------------------------------------------------

  p <- p +
    ggplot2::geom_area(
      ggplot2::aes(
        fill = .data[[group]]
      ),
      position = ggplot2::position_stack(
        reverse = TRUE
      ),
      colour = NA
    )


  # ------------------------------------------------------------
  # Fill scale
  # ------------------------------------------------------------

  p <- p +
    ggplot2::scale_fill_manual(
      values = fill_lookup,
      breaks = group_order,
      limits = group_order,
      name = ""
    )


  # ------------------------------------------------------------
  # Calculate stacked boundaries
  # ------------------------------------------------------------

  border_data <- data |>
    dplyr::arrange(
      .data[[x]],
      .data[[group]]
    ) |>
    dplyr::group_by(
      .data[[x]]
    ) |>
    dplyr::mutate(
      cumulative = cumsum(
        .data[[y]]
      )
    ) |>
    dplyr::ungroup()


  # ------------------------------------------------------------
  # Draw border lines
  #
  # Each group boundary gets the border colour of the
  # corresponding group.
  # ------------------------------------------------------------

  for (i in seq_along(group_order)) {

    current_group <- group_order[i]

    boundary_data <- border_data |>
      dplyr::filter(
        .data[[group]] == current_group
      )

    p <- p +
      ggplot2::geom_line(
        data = boundary_data,
        ggplot2::aes(
          x = .data[[x]],
          y = cumulative
        ),
        inherit.aes = FALSE,
        colour = border_lookup[
          current_group
        ],
        linewidth = 0.5,
        lineend = "round"
      )
  }


  # ------------------------------------------------------------
  # Area labels
  # ------------------------------------------------------------

  if (area_labels) {

    x_values <- data[[x]]

    if (is.numeric(x_values)) {

      label_x <- min(x_values) +
        area_label_position *
        (max(x_values) - min(x_values))

    } else {

      x_levels <- unique(x_values)

      label_index <- round(
        1 +
          area_label_position *
          (length(x_levels) - 1)
      )

      label_index <- max(
        1,
        min(
          label_index,
          length(x_levels)
        )
      )

      label_x <- x_levels[
        label_index
      ]
    }


    # ----------------------------------------------------------
    # Find observations closest to label position
    # ----------------------------------------------------------

    if (is.numeric(x_values)) {

      label_data <- data |>
        dplyr::mutate(
          .x_distance = abs(
            .data[[x]] - label_x
          )
        )

    } else {

      label_data <- data |>
        dplyr::mutate(
          .x_distance = abs(
            as.numeric(
              factor(
                .data[[x]],
                levels = x_levels
              )
            ) -
              as.numeric(
                factor(
                  label_x,
                  levels = x_levels
                )
              )
          )
        )
    }


    label_data <- label_data |>
      dplyr::group_by(
        .data[[group]]
      ) |>
      dplyr::slice_min(
        .x_distance,
        n = 1,
        with_ties = FALSE
      ) |>
      dplyr::ungroup() |>
      dplyr::select(
        -.x_distance
      )


    # ----------------------------------------------------------
    # Calculate label midpoints
    # ----------------------------------------------------------

    label_data <- label_data |>
      dplyr::arrange(
        .data[[group]]
      ) |>
      dplyr::mutate(
        cumulative = cumsum(
          .data[[y]]
        ),
        midpoint = cumulative -
          .data[[y]] / 2
      )


    # ----------------------------------------------------------
    # Add labels
    # ----------------------------------------------------------

    p <- p +
      ggplot2::geom_text(
        data = label_data,
        ggplot2::aes(
          x = .data[[x]],
          y = midpoint,
          label = .data[[group]]
        ),
        inherit.aes = FALSE,
        colour = area_label_color,
        size = area_label_size,
        fontface = area_label_fontface,
        angle = area_label_angle,
        hjust = area_label_hjust,
        vjust = area_label_vjust,
        nudge_x = area_label_nudge_x,
        nudge_y = area_label_nudge_y,
        show.legend = FALSE
      )
  }


  # ------------------------------------------------------------
  # Formatting
  # ------------------------------------------------------------

  p +
    theme_bar_grid_vertical +

    ggplot2::scale_y_continuous(
      labels = scales::label_comma(
        big.mark = "'"
      ),
      expand = c(0, 0)
    ) +

    ggplot2::labs(
      title = title,
      subtitle = subtitle,
      x = "",
      y = "",
      fill = "",
      caption = paste(
        "Amt für Daten und Statistik Thurgau\nDatenquelle:",
        source
      )
    )
}

# ggplot_area_full(
#   data = tab_alterskat,
#   x = "jahr",
#   y = "n",
#   order = "order",
#   group = "alterskat_det",
#   area_labels = TRUE,
#   area_label_size = 4,
#   area_label_nudge_x = 0.2,
#   group_palette = maincolors_discrete,
#   group_palette_name = "fillColor",
#   title = "Bevölkerung nach Alterskategorie",
#   subtitle = "Entwicklung über die Zeit",
#   source = "Kantonale Bevölkerungserhebung",
#
# )
#
# ggplot_area_full(
#   data = tab_alterskat,
#   x = "jahr",
#   y = "n",
#   order = "order",
#   group = "alterskat_det",
#   area_labels = TRUE,
#   area_label_size = 4,
#   area_label_position = 0.5,
#   area_label_nudge_x = -1,
#   area_label_nudge_y = -1,
#   group_palette = colors_sequential,
#   group_palette_name = "fillSeq5",
#   border_palette = border_sequential,
#   border_palette_name = "borderSeq5",
#   title = "Bevölkerung nach Alterskategorie",
#   subtitle = "Entwicklung über die Zeit",
#   source = "Kantonale Bevölkerungserhebung"
# )
