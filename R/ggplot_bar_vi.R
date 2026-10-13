#' Balkengrafik mit Vertrauensintervallen
#'
#' Funktion zur Darstellung von Daten mit Vertrauensintervallen als Balkengrafiken mit ggplot2 gemäss dem Design Styleguide des
#' Amts für Daten und Statistik
#'
#' @param data Datensatz, der als Balkengrafik dargestellt werden soll
#' @param y Variable, die auf der y-Achse dargestellt werden soll
#' @param x Variable, die auf der x-Achse dargestellt werden soll (bspw. das Jahr)
#' @param ci_lower Optionale variable zur Untergrenze des 95%-Vertrauensintervall
#' @param ci_upper Optionale variable zur Obergrenze des 95%-Vertrauensintervall
#' @param group Optionale kategoriale Variable für die gruppierte Darstellung
#' @param title Titel
#' @param subtitle Untertitel
#' @param source Datenquelle
#' @param fill_palette Palettenobjekt, das die Füllfarben enthält.
#'   Standardwert ist `maincolors_discrete`.
#' @param fill_palette_name Zeichenkette, die den Eintrag der Füllpalette angibt,
#'   der verwendet werden soll. Standardwert ist `"fillColor"`.
#' @param fill_color Optionale Indizes zur Auswahl von Farben aus der ausgewählten
#'   Füllpalette. Wenn `group` angegeben wird, müssen genügend Farben ausgewählt werden,
#'   um alle Gruppen abzudecken. Ist der Wert `NULL`, wird der gesamte Paletteneintrag verwendet.
#' @param fill_reverse Logischer Wert. Wenn `TRUE`, werden die ausgewählten Füllfarben umgekehrt.
#'   Standardwert ist `FALSE`.
#' @param border_palette Palettenobjekt, das die Rahmenfarben enthält.
#'   Standardwert ist `border_discrete`.
#' @param border_palette_name Zeichenkette, die den Eintrag der Rahmenpalette angibt,
#'   der verwendet werden soll. Standardwert ist `"borderColor"`.
#' @param border_color Optionale Indizes zur Auswahl von Farben aus der ausgewählten
#'   Rahmenpalette. Wenn `group` angegeben wird, müssen genügend Farben ausgewählt werden,
#'   um alle Gruppen abzudecken. Ist der Wert `NULL`, wird der gesamte Paletteneintrag verwendet.
#' @param border_reverse Logischer Wert. Bei `TRUE` werden die ausgewählten Rahmenfarben
#'   umgekehrt. Standardwert ist `FALSE`.
#' @param position Zeichenkette zur Angabe der Positionierungsmethode für die Balken:
#'   `"dodge"` oder `"stack"`. Standardwert ist `"dodge"`. Gruppierte Balken mit
#'   Konfidenzintervall erfordern `dodge`.
#' @param errorbar_width Numerischer Wert, der die Breite der
#'   Endpunkte des Konfidenzintervalls steuert. Standardwert ist `0,2`.
#' @param x_expand Numerischer Anteil, der verwendet wird, um die Obergrenze der
#'   numerischen Achse über den maximalen beobachteten Wert hinaus zu erweitern. Standardwert ist `0,10`.
#' @param y_label_wrap Optionaler numerischer Wert, der die ungefähre
#'   Breite in Zeichen angibt, bei der Kategoriebezeichnungen umgebrochen werden. Bei `NULL`
#'   werden Bezeichnungen nicht umgebrochen.
#'
#' @details
#' Die Funktion verwendet `theme_bar_grid_vertical()` und formatiert die numerische
#' Achse mit einem Apostroph als Tausendertrennzeichen. Die numerische Achse
#' wird am oberen Rand des Diagramms positioniert.
#'
#' Wenn `group` angegeben wird, werden die Balken je nach Gruppe unter Verwendung der ausgewählten
#' Füll- und Rahmenpaletten eingefärbt. Wenn keine Gruppierungsvariable angegeben wird, werden eine einzige
#' Füllfarbe und eine einzige Rahmenfarbe verwendet.
#'
#' Konfidenzintervalle werden gezeichnet, wenn sowohl `ci_lower` als auch `ci_upper`
#' angegeben sind. Die Intervallvariablen müssen numerische Unter- und
#' Obergrenzen auf derselben Skala wie `x` enthalten.
#'
#' @return Eine ggplot Balkengrafik mit VIs
#'
#' @examples
#' \dontrun{
#' # Horizontales Balkendiagramm mit Konfidenzintervallen
#' ggplot_bar_vi(
#'   data = tab_bildung_tot,
#'   y = "ausbildung_5cat",
#'   x = "anteil",
#'   ci_lower = "ci_l_pr",
#'   ci_upper = "ci_u_pr",
#'   title = "Bildung nach Ausbildungsstufe",
#'   source = "Kantonale Bevölkerungsstatistik",
#'   fill_color = 2,
#'   border_color = 2,
#'   y_label_wrap = 20
#' )
#'
#' # Grouped horizontal bars by sex
#' ggplot_bar_vi(
#'   data = tab_bildung_sex_full,
#'   y = "ausbildung_5cat",
#'   x = "anteil",
#'   group = "sex",
#'   ci_lower = "ci_l_pr",
#'   ci_upper = "ci_u_pr",
#'   title = "Bildung nach Geschlecht",
#'   subtitle = "Kanton Thurgau",
#'   source = "Kantonale Bevölkerungsstatistik",
#'   y_label_wrap = 20
#' )
#' }
#'
#' @export
ggplot_bar_vi <- function(
    data,
    y,
    x,
    ci_lower = NULL,
    ci_upper = NULL,
    group = NULL,
    title = NULL,
    subtitle = NULL,
    source = NULL,

    # Fill palette
    fill_palette = maincolors_discrete,
    fill_palette_name = "fillColor",
    fill_color = NULL,
    fill_reverse = FALSE,

    # Border palette
    border_palette = border_discrete,
    border_palette_name = "borderColor",
    border_color = NULL,
    border_reverse = FALSE,

    # Grouped bars
    position = "dodge",

    # Error bars and axes
    errorbar_width = 0.2,
    x_expand = 0.10,
    y_label_wrap = NULL
) {

  # Check variables
  if (!x %in% names(data)) {
    stop("X variable '", x, "' not found in data.")
  }

  if (!y %in% names(data)) {
    stop("Y variable '", y, "' not found in data.")
  }

  if (!is.null(group) && !group %in% names(data)) {
    stop("Group variable '", group, "' not found in data.")
  }

  if (!is.null(ci_lower) && !ci_lower %in% names(data)) {
    stop("CI lower variable '", ci_lower, "' not found in data.")
  }

  if (!is.null(ci_upper) && !ci_upper %in% names(data)) {
    stop("CI upper variable '", ci_upper, "' not found in data.")
  }

  if (xor(is.null(ci_lower), is.null(ci_upper))) {
    stop("Supply both 'ci_lower' and 'ci_upper', or neither.")
  }

  if (!position %in% c("dodge", "stack")) {
    stop("'position' must be either 'dodge' or 'stack'.")
  }

  if (!is.null(group) &&
      !is.null(ci_lower) &&
      position != "dodge") {
    stop(
      "Grouped bars with confidence intervals require position = 'dodge'."
    )
  }

  # Determine group order
  group_order <- NULL

  if (!is.null(group)) {

    if (is.factor(data[[group]])) {
      group_order <- levels(data[[group]])
      group_order <- group_order[
        group_order %in% as.character(data[[group]])
      ]
    } else {
      group_order <- unique(as.character(data[[group]]))
      group_order <- group_order[!is.na(group_order)]
    }

    data[[group]] <- factor(
      data[[group]],
      levels = group_order
    )
  }

  # Select fill colours
  fill_values <- fill_palette[[fill_palette_name]]

  if (is.null(fill_values)) {
    stop(
      "Palette entry '", fill_palette_name,
      "' was not found in fill_palette."
    )
  }

  if (!is.null(fill_color)) {
    fill_values <- fill_values[fill_color]
  }

  if (fill_reverse) {
    fill_values <- rev(fill_values)
  }

  # Select border colours
  border_values <- border_palette[[border_palette_name]]

  if (is.null(border_values)) {
    stop(
      "Palette entry '", border_palette_name,
      "' was not found in border_palette."
    )
  }

  if (!is.null(border_color)) {
    border_values <- border_values[border_color]
  }

  if (border_reverse) {
    border_values <- rev(border_values)
  }

  # Validate and name palette colours for groups
  if (!is.null(group)) {

    n_groups <- length(group_order)

    if (length(fill_values) < n_groups) {
      stop(
        "The fill palette contains ", length(fill_values),
        " colour(s), but there are ", n_groups,
        " groups. Select more colours with 'fill_color'."
      )
    }

    if (length(border_values) < n_groups) {
      stop(
        "The border palette contains ", length(border_values),
        " colour(s), but there are ", n_groups,
        " groups. Select more colours with 'border_color'."
      )
    }

    fill_values <- stats::setNames(
      fill_values[seq_len(n_groups)],
      group_order
    )

    border_values <- stats::setNames(
      border_values[seq_len(n_groups)],
      group_order
    )

  } else {

    fill_values <- fill_values[1]
    border_values <- border_values[1]
  }

  # Determine X-axis maximum
  if (!is.null(ci_upper)) {
    x_max <- max(data[[ci_upper]], na.rm = TRUE)
  } else {
    x_max <- max(data[[x]], na.rm = TRUE)
  }

  if (!is.finite(x_max)) {
    stop("Could not determine a finite maximum for the X-axis.")
  }

  x_upper <- x_max * (1 + x_expand)

  # Bar position
  bar_position <- if (!is.null(group)) {
    ggplot2::position_dodge(width = 0.8)
  } else if (position == "stack") {
    ggplot2::position_stack()
  } else {
    "identity"
  }

  # Base plot
  p <- ggplot2::ggplot(
    data,
    ggplot2::aes(
      x = .data[[x]],
      y = .data[[y]]
    )
  )

  # Bars
  if (!is.null(group)) {

    p <- p +
      ggplot2::geom_col(
        ggplot2::aes(
          fill = .data[[group]],
          colour = .data[[group]]
        ),
        position = bar_position,
        width = 0.8
      ) +
      ggplot2::scale_fill_manual(
        values = fill_values,
        breaks = group_order,
        limits = group_order
      ) +
      ggplot2::scale_colour_manual(
        values = border_values,
        breaks = group_order,
        limits = group_order
      )

  } else {

    p <- p +
      ggplot2::geom_col(
        fill = fill_values[1],
        colour = border_values[1],
        position = bar_position,
        width = 0.8
      )
  }

  # Horizontal confidence intervals
  if (!is.null(ci_lower) && !is.null(ci_upper)) {

    if (!is.null(group)) {

      p <- p +
        ggplot2::geom_errorbar(
          ggplot2::aes(
            xmin = .data[[ci_lower]],
            xmax = .data[[ci_upper]],
            group = .data[[group]]
          ),
          position = bar_position,
          width = errorbar_width,
          orientation = "y"
        )

    } else {

      p <- p +
        ggplot2::geom_errorbar(
          ggplot2::aes(
            xmin = .data[[ci_lower]],
            xmax = .data[[ci_upper]]
          ),
          width = errorbar_width,
          orientation = "y"
        )
    }
  }

  # Theme and X-axis
  p <- p +
    theme_bar_grid_vertical +
    ggplot2::theme(
      plot.caption = ggplot2::element_text(hjust = 0),
      plot.title.position = "plot",
      plot.caption.position = "plot",
      legend.position = "top",
      legend.justification = "left",
      legend.location = "plot"
    ) +
    ggplot2::scale_x_continuous(
      position = "top",
      limits = c(0, x_upper),
      labels = scales::label_comma(big.mark = "'"),
      expand = c(0, 0)
    )

  # Y-axis with optional label wrapping
  if (!is.null(y_label_wrap)) {

    p <- p +
      ggplot2::scale_y_discrete(
        labels = scales::label_wrap(y_label_wrap),
        # expand = c(0, 0)
      )

  } else {

    p <- p +
      ggplot2::scale_y_discrete(
        # expand = c(0, 0)
      )
  }

  # Final plot
  p +
    ggplot2::labs(
      title = title,
      subtitle = subtitle,
      x = "",
      y = "",
      fill = if (!is.null(group)) "" else NULL,
      colour = if (!is.null(group)) "" else NULL,
      caption = paste(
        "Amt für Daten und Statistik\nDatenquelle:",
        source
      )
    )
}

# ggplot_bar_vi(
#   data = tab_bildung_tot,
#   y = "ausbildung_5cat",
#   x = "anteil",
#   ci_lower = "ci_l_pr",
#   ci_upper = "ci_u_pr",
#   title = "Bevölkerung wird älter",
#   subtitle = "Kanton Thurgau, Ständige Wohnbevölkerung nach Altersklassen, 2015–2025",
#   source = "Kantonale Bevölkerungsstatistik",
#   fill_color = 2,
#   border_color = 2,
#   y_label_wrap = 20
# )
#
# ggplot_bar_vi(
#   data = tab_bildung_sex_full, #%>% filter(sex!="Total"),
#   y = "ausbildung_5cat",
#   x = "anteil",
#   group = "sex",
#   ci_lower = "ci_l_pr",
#   ci_upper = "ci_u_pr",
#   title = "Bildung nach Geschlecht",
#   subtitle = "Kanton Thurgau",
#   source = "Kantonale Bevölkerungsstatistik",
#   fill_palette = maincolors_discrete,
#   fill_palette_name = "fillColor",
#   border_palette = border_discrete,
#   border_palette_name = "borderColor",
#   y_label_wrap = 20
# )
