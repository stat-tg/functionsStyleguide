#' Gruppiertes oder gestapeltes Balkendiagramm mit benutzerdefinierten Farben erstellen
#'
#' Erstellt ein horizontales Balkendiagramm, bei dem Balken nach einer
#' Kategorie eingefärbt und optional mit kategorienabhängigen Rahmenfarben
#' versehen werden. Die Farbgebung erfolgt über benutzerdefinierte Farbpaletten.
#'
#' Die Reihenfolge der Füllkategorien kann über eine zusätzliche Sortiervariable
#' gesteuert werden. Die Balken können gestapelt oder nebeneinander angeordnet
#' werden. Bei gestapelten Balken lässt sich zusätzlich die Stapelreihenfolge
#' umkehren.
#'
#' @param data Ein Data Frame mit den darzustellenden Daten.
#' @param y Zeichenkette mit dem Namen der numerischen Variable für die
#'   Balkenlängen.
#' @param x Zeichenkette mit dem Namen der kategorialen Variable für die
#'   Kategorienachse.
#' @param fill Optionale Zeichenkette mit dem Namen der Variable, anhand derer
#'   die Balkenfüllung kategorisiert wird. Bei \code{NULL} wird eine feste
#'   Füllfarbe verwendet.
#' @param color Optionale Zeichenkette mit dem Namen der Variable, anhand derer
#'   die Rahmenfarben der Balken kategorisiert werden. Bei \code{NULL} wird
#'   eine feste Rahmenfarbe verwendet.
#' @param order Optionale Zeichenkette mit dem Namen einer Variable, anhand
#'   derer die Kategorien von \code{fill} sortiert werden. Standardmässig
#'   \code{NULL}; in diesem Fall wird die Reihenfolge aus den Faktorlevels
#'   oder aus dem Auftreten der Kategorien im Datensatz übernommen.
#' @param fill_palette Liste mit Farbpaletten für die Balkenfüllung.
#'   Standardmässig \code{maincolors_discrete}.
#' @param fill_palette_name Zeichenkette mit dem Namen des Palettenelements,
#'   aus dem die Füllfarben ausgewählt werden. Standardmässig
#'   \code{"fillColor"}.
#' @param fill_colors Optionaler Index oder Vektor von Indizes zur Auswahl
#'   bestimmter Füllfarben aus dem gewählten Palettenelement.
#'   Standardmässig \code{NULL}.
#' @param fill_reverse Logischer Wert. Wenn \code{TRUE}, wird die Reihenfolge
#'   der ausgewählten Füllfarben umgekehrt. Standardmässig \code{FALSE}.
#' @param border_palette Liste mit Farbpaletten für die Balkenrahmen.
#'   Standardmässig \code{border_discrete}.
#' @param border_palette_name Zeichenkette mit dem Namen des Palettenelements,
#'   aus dem die Rahmenfarben ausgewählt werden. Standardmässig
#'   \code{"borderColor"}.
#' @param border_colors Optionaler Index oder Vektor von Indizes zur Auswahl
#'   bestimmter Rahmenfarben aus dem gewählten Palettenelement.
#'   Standardmässig \code{NULL}.
#' @param border_reverse Logischer Wert. Wenn \code{TRUE}, wird die Reihenfolge
#'   der ausgewählten Rahmenfarben umgekehrt. Standardmässig \code{FALSE}.
#' @param fill_color Index der Füllfarbe aus dem gewählten Palettenelement,
#'   die verwendet wird, wenn \code{fill = NULL}. Standardmässig \code{1}.
#' @param border_color Index der Rahmenfarbe aus dem gewählten Palettenelement,
#'   die verwendet wird, wenn \code{color = NULL}. Standardmässig \code{1}.
#' @param title Optionaler Titel des Diagramms. Standardmässig \code{NULL}.
#' @param subtitle Optionaler Untertitel des Diagramms. Standardmässig
#'   \code{NULL}.
#' @param source Optionale Angabe der Datenquelle. Wird zusammen mit dem
#'   Hinweis auf das Amt für Daten und Statistik Thurgau in der Bildunterschrift
#'   ausgegeben. Standardmässig \code{NULL}.
#' @param position Positionierung der Balken. Bei \code{"stack"} werden die
#'   Balken gestapelt, bei \code{"dodge"} nebeneinander angeordnet.
#'   Andere Werte werden direkt an die Positionsberechnung von
#'   \code{geom_col()} übergeben. Standardmässig \code{"stack"}.
#' @param reverse_stack Logischer Wert zur Umkehrung der Stapelreihenfolge,
#'   wenn \code{position = "stack"} verwendet wird. Standardmässig \code{TRUE}.
#'
#' @return Ein \code{ggplot}-Objekt mit horizontal dargestellten Balken,
#'   benutzerdefinierten Füll- und Rahmenfarben sowie formatierter Beschriftung.
#'
#' @details
#' Wenn \code{fill} angegeben ist und \code{order} nicht \code{NULL} ist,
#' werden die Kategorien anhand der Sortiervariable geordnet. Dazu werden
#' eindeutige Kombinationen der Füllkategorie und der Sortiervariable nach
#' \code{order} sortiert. Die resultierende Reihenfolge wird als Faktorstufen
#' für die Füllvariable verwendet.
#'
#' Wenn \code{color} und \code{fill} identisch sind, wird dieselbe
#' Kategorienreihenfolge auch für die Rahmenfarben verwendet. Andernfalls
#' richtet sich die Reihenfolge der Rahmenkategorien nach den Faktorlevels
#' oder ihrem Auftreten im Datensatz.
#'
#' Füll- und Rahmenfarben werden über \code{scale_fill_custom()} und
#' \code{scale_colour_custom()} zugewiesen. Diese Funktionen müssen im
#' Paket verfügbar sein.
#'
#' Die numerische Achse wird rechts angeordnet und verwendet Apostrophe als
#' Tausendertrennzeichen. Die Kategorienachse und die Formatierung des
#' Diagramms werden durch \code{theme_bar_grid_vertical} und
#' \code{coord_flip()} gestaltet.
#'
#' @examples
#' \dontrun{
#' ggplot_grouped_bar_palette(
#'   data = tab_alterskat |>
#'     dplyr::mutate(jahr = as.character(jahr)),
#'   x = "jahr",
#'   y = "n",
#'   fill = "alterskat_det",
#'   color = "alterskat_det",
#'   order = "order",
#'   fill_palette = colors_sequential,
#'   fill_palette_name = "fillSeq5",
#'   border_palette = border_sequential,
#'   border_palette_name = "borderSeq5",
#'   title = "Bevölkerung wird älter",
#'   subtitle = paste(
#'     "Kanton Thurgau, Ständige Wohnbevölkerung",
#'     "nach Altersklassen, 2015–2025"
#'   ),
#'   source = "Kantonale Bevölkerungsstatistik"
#' )
#' }
#'
#' @export
ggplot_grouped_bar_palette <- function(
    data,
    y,
    x,

    fill = NULL,
    color = NULL,

    order = NULL,

    fill_palette = maincolors_discrete,
    fill_palette_name = "fillColor",
    fill_colors = NULL,
    fill_reverse = FALSE,

    border_palette = border_discrete,
    border_palette_name = "borderColor",
    border_colors = NULL,
    border_reverse = FALSE,

    fill_color = 1,
    border_color = 1,

    title = NULL,
    subtitle = NULL,
    source = NULL,

    position = "stack",
    reverse_stack = TRUE
) {

  # --------------------------------------------------
  # Determine category order
  # --------------------------------------------------

  category_order <- NULL

  if (!is.null(fill)) {

    if (!is.null(order)) {

      category_order <- data |>
        dplyr::select(
          dplyr::all_of(c(fill, order))
        ) |>
        dplyr::distinct() |>
        dplyr::arrange(.data[[order]]) |>
        dplyr::pull(.data[[fill]]) |>
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

    data[[fill]] <- factor(
      data[[fill]],
      levels = category_order
    )

    # Keep colour categories in the same order
    # when fill and colour use the same variable
    if (!is.null(color) && color == fill) {

      data[[color]] <- factor(
        data[[color]],
        levels = category_order
      )
    }
  }


  # --------------------------------------------------
  # Base plot
  # --------------------------------------------------

  p <- ggplot2::ggplot(
    data,
    ggplot2::aes(
      x = .data[[x]],
      y = .data[[y]]
    )
  )


  # --------------------------------------------------
  # Fill mapping
  # --------------------------------------------------

  if (!is.null(fill)) {

    p <- p +
      ggplot2::aes(
        fill = .data[[fill]]
      )
  }


  # --------------------------------------------------
  # Colour mapping
  # --------------------------------------------------

  if (!is.null(color)) {

    p <- p +
      ggplot2::aes(
        colour = .data[[color]]
      )
  }


  # --------------------------------------------------
  # Position
  # --------------------------------------------------

  if (position == "stack") {

    bar_position <- ggplot2::position_stack(
      reverse = reverse_stack
    )

  } else if (position == "dodge") {

    bar_position <- ggplot2::position_dodge()

  } else {

    bar_position <- position
  }


  # --------------------------------------------------
  # Fixed colours
  # --------------------------------------------------

  fixed_fill <- NULL
  fixed_border <- NULL

  if (is.null(fill)) {

    fixed_fill <- fill_palette[[fill_palette_name]][fill_color]
  }

  if (is.null(color)) {

    fixed_border <- border_palette[[border_palette_name]][border_color]
  }


  # --------------------------------------------------
  # Geometry
  # --------------------------------------------------

  # If fill is mapped, do NOT supply fill to geom_col().
  # The fill scale will control the colours.
  #
  # If fill is NULL, use the fixed fill colour.
  #
  # The same applies to colour.

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


  # --------------------------------------------------
  # Fill scale
  # --------------------------------------------------

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


  # --------------------------------------------------
  # Border scale
  # --------------------------------------------------

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


  # --------------------------------------------------
  # Formatting
  # --------------------------------------------------

  p +
    theme_bar_grid_vertical +
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
      position = "right",
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
    ) +

    ggplot2::coord_flip()
}

# ggplot_grouped_bar_palette(
#   data = tab_alterskat %>%
#     dplyr::mutate(jahr = as.character(jahr)),
#   x = "jahr",
#   y = "n",
#   fill = "alterskat_det",
#   color = "alterskat_det",
#   order = "order",
#   fill_palette = colors_sequential,
#   fill_palette_name = "fillSeq5",
#   border_palette = border_sequential,
#   border_palette_name = "borderSeq5",
#   title = "Bevölkerung wird älter",
#   subtitle = "Kanton Thurgau, Ständige Wohnbevölkerung nach Altersklassen, 2015-2025",
#   source = "Kantonale Bevölkerungsstatistik"
# )
