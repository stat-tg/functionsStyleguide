#' Säulendiagramm mit optionaler Gruppierung und Beschriftung erstellen
#'
#' Erstellt ein Säulendiagramm mit anpassbaren Füll- und Randfarben,
#' optionaler Gruppierung, konfigurierbarer Reihenfolge der Kategorien
#' sowie optionalen Wertbeschriftungen. Unterstützt gestapelte und
#' nebeneinander angeordnete Säulen.
#'
#' @param data Ein Data Frame, der die darzustellenden Variablen enthält.
#' @param y Ein Zeichenwert mit dem Namen der numerischen Variable,
#'   die auf der y-Achse dargestellt wird.
#' @param x Ein Zeichenwert mit dem Namen der Variable, die auf der
#'   x-Achse dargestellt wird.
#' @param fill Optionaler Zeichenwert mit dem Namen der Variable, nach
#'   der die Säulen eingefärbt werden. Bei `NULL` erhalten alle Säulen
#'   dieselbe Füllfarbe.
#' @param color Optionaler Zeichenwert mit dem Namen der Variable, nach
#'   der die Randfarben der Säulen bestimmt werden. Bei `NULL` erhalten
#'   alle Säulen dieselbe Randfarbe.
#' @param order Optionaler Zeichenwert mit dem Namen einer Variable,
#'   nach der die Kategorien von `fill` sortiert werden. Die Reihenfolge
#'   wird aufsteigend nach dieser Variable bestimmt.
#' @param fill_palette Ein Palettenobjekt mit den verfügbaren Füllfarben.
#'   Standardmässig wird `maincolors_discrete` verwendet.
#' @param fill_palette_name Ein Zeichenwert mit dem Namen des Eintrags
#'   in `fill_palette`, aus dem die Farben ausgewählt werden.
#'   Standardmässig `"fillColor"`.
#' @param fill_colors Optionaler Vektor mit explizit vorgegebenen
#'   Füllfarben für die Kategorien von `fill`. Wird an
#'   `scale_fill_custom()` übergeben.
#' @param fill_reverse Logischer Wert. Bei `TRUE` wird die Reihenfolge
#'   der Füllfarben umgekehrt. Standardmässig `FALSE`.
#' @param border_palette Ein Palettenobjekt mit den verfügbaren
#'   Randfarben. Standardmässig wird `border_discrete` verwendet.
#' @param border_palette_name Ein Zeichenwert mit dem Namen des Eintrags
#'   in `border_palette`, aus dem die Randfarben ausgewählt werden.
#'   Standardmässig `"borderColor"`.
#' @param border_colors Optionaler Vektor mit explizit vorgegebenen
#'   Randfarben für die Kategorien von `color`. Wird an
#'   `scale_colour_custom()` übergeben.
#' @param border_reverse Logischer Wert. Bei `TRUE` wird die Reihenfolge
#'   der Randfarben umgekehrt. Standardmässig `FALSE`.
#' @param fill_color Index oder Indizes zur Auswahl bestimmter Füllfarben
#'   aus der gewählten Palette, wenn `fill = NULL`.
#'   Standardmässig `1`.
#' @param border_color Index oder Indizes zur Auswahl bestimmter Randfarben
#'   aus der gewählten Palette, wenn `color = NULL`.
#'   Standardmässig `1`.
#' @param labels Logischer Wert. Bei `TRUE` werden die Werte innerhalb
#'   der Säulen angezeigt. Standardmässig `FALSE`.
#' @param label_color Farbe der Wertbeschriftungen. Standardmässig `"white"`.
#' @param label_size Schriftgrösse der Wertbeschriftungen.
#'   Standardmässig `4.5`.
#' @param label_fontface Schriftstil der Wertbeschriftungen, beispielsweise
#'   `"plain"`, `"bold"` oder `"italic"`. Standardmässig `"bold"`.
#' @param label_angle Winkel der Wertbeschriftungen in Grad.
#'   Standardmässig `0`.
#' @param label_hjust Optionale horizontale Ausrichtung der
#'   Wertbeschriftungen. Bei `NULL` wird die Ausrichtung abhängig von
#'   der Darstellung automatisch festgelegt.
#' @param label_vjust Optionale vertikale Ausrichtung der
#'   Wertbeschriftungen. Bei `NULL` wird der Standardwert der Funktion
#'   verwendet.
#' @param title Optionaler Titel des Diagramms.
#' @param subtitle Optionaler Untertitel des Diagramms.
#' @param source Optionale Angabe der Datenquelle, die in der Bildlegende
#'   unterhalb des Diagramms angezeigt wird.
#' @param position Anordnung der Säulen. `"stack"` stapelt die Kategorien,
#'   `"dodge"` stellt sie nebeneinander dar. Standardmässig `"stack"`.
#' @param reverse_stack Logischer Wert. Bei `TRUE` wird die Reihenfolge
#'   der Segmente innerhalb gestapelter Säulen umgekehrt.
#'   Standardmässig `TRUE`.
#'
#' @details
#' Die Funktion verwendet `theme_bar_grid_horizontal()` für die
#' Diagrammgestaltung und formatiert numerische Achsenbeschriftungen
#' mit einem Apostroph als Tausendertrennzeichen.
#'
#' Wenn `fill` angegeben wird, werden die Füllfarben anhand der
#' Kategorien dieser Variable zugewiesen. Wenn `color` angegeben wird,
#' werden die Randfarben unabhängig davon anhand der entsprechenden
#' Kategorien zugewiesen.
#'
#' Mit `position = "stack"` werden die Kategorien gestapelt dargestellt.
#' Mit `position = "dodge"` werden die Kategorien nebeneinander angeordnet.
#' Wertbeschriftungen können mit `labels = TRUE` aktiviert werden.
#'
#' @return Ein ggplot-Objekt.
#'
#' @examples
#' \dontrun{
#' # Einfaches Säulendiagramm mit Wertbeschriftungen
#' ggplot_column_full(
#'   data = tab_bev,
#'   y = "n",
#'   x = "jahr",
#'   title = "Bevölkerungsentwicklung",
#'   source = "Kantonale Bevölkerungsstatistik",
#'   labels = TRUE
#' )
#'
#' # Gestapeltes Säulendiagramm nach Alterskategorie
#' ggplot_column_full(
#'   data = tab_alterskat,
#'   y = "n",
#'   x = "jahr",
#'   fill = "alterskat_det",
#'   color = "alterskat_det",
#'   fill_palette = colors_sequential,
#'   fill_palette_name = "fillSeq5",
#'   border_palette = border_sequential,
#'   border_palette_name = "borderSeq5",
#'   position = "stack",
#'   labels = TRUE
#' )
#' }
#'
#' @export
ggplot_column_full <- function(
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
    label_angle = 0,
    label_hjust = NULL,
    label_vjust = NULL,

    # Plot text
    title = NULL,
    subtitle = NULL,
    source = NULL,

    # Positioning
    position = "stack",
    reverse_stack = TRUE
) {

  # ------------------------------------------------------------
  # Check position argument
  # ------------------------------------------------------------

  if (!position %in% c("stack", "dodge")) {
    stop(
      "`position` must be either 'stack' or 'dodge'."
    )
  }


  # ------------------------------------------------------------
  # Determine category order
  # ------------------------------------------------------------

  category_order <- NULL

  if (!is.null(fill)) {

    if (!fill %in% names(data)) {
      stop(
        "Fill variable '",
        fill,
        "' not found in data."
      )
    }

    if (!is.null(order)) {

      if (!order %in% names(data)) {
        stop(
          "Order variable '",
          order,
          "' not found in data."
        )
      }

      category_order <- data |>
        dplyr::select(
          dplyr::all_of(c(fill, order))
        ) |>
        dplyr::distinct() |>
        dplyr::arrange(
          .data[[order]]
        ) |>
        dplyr::pull(
          .data[[fill]]
        ) |>
        unique()

    } else {

      if (is.factor(data[[fill]])) {

        category_order <- levels(
          data[[fill]]
        )

      } else {

        category_order <- unique(
          data[[fill]]
        )

        category_order <- category_order[
          !is.na(category_order)
        ]
      }
    }

    # Apply category order to fill
    data[[fill]] <- factor(
      data[[fill]],
      levels = category_order
    )

    # If fill and colour use the same variable,
    # make sure they have exactly the same order
    if (!is.null(color) && color == fill) {

      data[[color]] <- factor(
        data[[color]],
        levels = category_order
      )
    }
  }


  # ------------------------------------------------------------
  # Basic ggplot
  # ------------------------------------------------------------

  p <- ggplot2::ggplot(
    data,
    ggplot2::aes(
      x = .data[[x]],
      y = .data[[y]]
    )
  )


  # ------------------------------------------------------------
  # Fill mapping
  # ------------------------------------------------------------

  if (!is.null(fill)) {

    p <- p +
      ggplot2::aes(
        fill = .data[[fill]]
      )
  }


  # ------------------------------------------------------------
  # Border / colour mapping
  # ------------------------------------------------------------

  if (!is.null(color)) {

    p <- p +
      ggplot2::aes(
        colour = .data[[color]]
      )
  }


  # ------------------------------------------------------------
  # Position
  # ------------------------------------------------------------

  if (position == "stack") {

    bar_position <- ggplot2::position_stack(
      reverse = reverse_stack
    )

  } else {

    bar_position <- ggplot2::position_dodge(
      width = 0.9
    )
  }


  # ------------------------------------------------------------
  # Fixed fill and border colours
  # ------------------------------------------------------------

  fixed_fill <- NULL
  fixed_border <- NULL

  if (is.null(fill)) {
    fixed_fill <- fill_palette[[fill_palette_name]][fill_color]
  }

  if (is.null(color)) {
    fixed_border <- border_palette[[border_palette_name]][border_color]
  }


  # ------------------------------------------------------------
  # Columns
  # ------------------------------------------------------------

  if (is.null(fill) && is.null(color)) {

    p <- p +
      ggplot2::geom_col(
        fill = fixed_fill,
        colour = fixed_border,
        position = bar_position
      )

  } else if (is.null(fill)) {

    p <- p +
      ggplot2::geom_col(
        fill = fixed_fill,
        position = bar_position
      )

  } else if (is.null(color)) {

    p <- p +
      ggplot2::geom_col(
        colour = fixed_border,
        position = bar_position
      )

  } else {

    p <- p +
      ggplot2::geom_col(
        position = bar_position
      )
  }


  # ------------------------------------------------------------
  # Fill scale
  # ------------------------------------------------------------

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


  # ------------------------------------------------------------
  # Border / colour scale
  # ------------------------------------------------------------

  if (!is.null(color)) {

    if (color == fill) {

      color_order <- category_order

    } else {

      if (is.factor(data[[color]])) {

        color_order <- levels(
          data[[color]]
        )

      } else {

        color_order <- unique(
          data[[color]]
        )

        color_order <- color_order[
          !is.na(color_order)
        ]
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


  # ------------------------------------------------------------
  # Value labels
  # ------------------------------------------------------------

  if (labels) {

    # Default justifications
    current_hjust <- if (is.null(label_hjust)) {
      if (is.null(fill)) 1.1 else 0.5
    } else {
      label_hjust
    }

    current_vjust <- if (is.null(label_vjust)) {
      if (is.null(fill)) 0.5 else 0.5
    } else {
      label_vjust
    }


    # ----------------------------------------------------------
    # Stacked bars
    # ----------------------------------------------------------

    if (!is.null(fill) && position == "stack") {

      p <- p +
        ggplot2::geom_text(
          ggplot2::aes(
            label = scales::label_comma(
              big.mark = "'"
            )(.data[[y]])
          ),
          position = ggplot2::position_stack(
            vjust = 0.5,
            reverse = reverse_stack
          ),
          angle = label_angle,
          hjust = current_hjust,
          vjust = current_vjust,
          colour = label_color,
          size = label_size,
          fontface = label_fontface
        )


      # ----------------------------------------------------------
      # Grouped / dodged bars
      # ----------------------------------------------------------

    } else if (!is.null(fill) && position == "dodge") {

      p <- p +
        ggplot2::geom_text(
          ggplot2::aes(
            label = scales::label_comma(
              big.mark = "'"
            )(.data[[y]])
          ),
          position = ggplot2::position_dodge(
            width = 0.9
          ),
          angle = label_angle,
          hjust = current_hjust,
          vjust = current_vjust,
          colour = label_color,
          size = label_size,
          fontface = label_fontface
        )


      # ----------------------------------------------------------
      # Ordinary bars
      # ----------------------------------------------------------

    } else {

      p <- p +
        ggplot2::geom_text(
          ggplot2::aes(
            label = scales::label_comma(
              big.mark = "'"
            )(.data[[y]])
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


  # ------------------------------------------------------------
  # Plot labels
  # ------------------------------------------------------------

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

  if (!is.null(fill)) {
    plot_labels$fill <- ""
  }

  if (!is.null(color)) {
    plot_labels$colour <- ""
  }


  # ------------------------------------------------------------
  # Final plot
  # ------------------------------------------------------------

  p +
    theme_bar_grid_horizontal +

    ggplot2::scale_y_continuous(
      labels = scales::label_comma(
        big.mark = "'"
      ),
      expand = c(0, 0)
    ) +

    ggplot2::scale_x_discrete(
      expand = c(0, 0)
    ) +

    ggplot2::labs(
      title = plot_labels$title,
      subtitle = plot_labels$subtitle,
      x = plot_labels$x,
      y = plot_labels$y,
      fill = plot_labels$fill,
      colour = plot_labels$colour,
      caption = plot_labels$caption
    )
}

# ggplot_column_full(
#   data = tab_bev,
#   y = "n",
#   x = "jahr",
#   title = "TITEL",
#   subtitle = "UNTERTITEL",
#   source = "Kantonale Bevölkerungserhebung",
#   labels = TRUE,
#   label_color = "white",
#   label_angle = 90,
#   label_hjust = 1.5,
#   label_vjust = 0.5
# )
#
# ggplot_column_full(
#   data = tab_alterskat,
#   y = "n",
#   x = "jahr",
#   fill = "alterskat_det",
#   color = "alterskat_det",
#   fill_palette = colors_sequential,
#   fill_palette_name = "fillSeq5",
#   border_palette = border_sequential,
#   border_palette_name = "borderSeq5",
#   position = "stack",
#   labels = TRUE
# )
#
# ggplot_column_full(
#   data = tab_alterskat,
#   y = "n",
#   x = "jahr",
#   fill = "alterskat_det",
#   color = "alterskat_det",
#   fill_palette = colors_sequential,
#   fill_palette_name = "fillSeq5",
#   border_palette = border_sequential,
#   border_palette_name = "borderSeq5",
#   position = "dodge"
# )
