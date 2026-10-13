#' Einfaches gestapeltes Säulendiagramm gemäss Styleguide
#'
#' Mit dieser Funktion können einfach gestapelte Säulendiagramme mit ggplot gemäss Styleguide erstellt werden
#'
#' @param x The first number.
#' @param y The second number.
#'
#' @return ggplot bar chart.
#' @export
ggplot_grouped_bar <- function(
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
    theme_bar_grid_vertical +

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
    ) + coord_flip()
}

# ggplot_grouped_bar(
#   data = tab_alterskat %>% mutate(jahr=as.character(jahr)),
#   x = "jahr",
#   y = "n",
#   fill = "alterskat_det",
#   color = "alterskat_det",
#   title = "TITEL",
#   subtitle = "UNTERTITEL",
#   source = "Kantonale Bevölkerungsstatistik"
# )
