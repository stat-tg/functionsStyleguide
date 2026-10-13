#' Horizontales Säulendiagramm mit optionalen Konfidenzintervallen erstellen
#'
#' Erstellt ein horizontales Säulendiagramm zur Darstellung numerischer Werte
#' nach Kategorien. Die Balken können einheitlich eingefärbt oder anhand einer
#' Gruppierungsvariable mit unterschiedlichen Füll- und Rahmenfarben dargestellt
#' werden. Optional lassen sich Konfidenzintervalle ergänzen.
#'
#' Die Farben werden aus benutzerdefinierten Farbpaletten ausgewählt.
#' Bei gruppierten Balken werden die Farben den Gruppen entsprechend ihrer
#' Reihenfolge zugewiesen. Die Kategorienachse kann bei Bedarf mit
#' Zeilenumbrüchen formatiert werden.
#'
#' @param data Ein Data Frame mit den darzustellenden Daten.
#' @param y Zeichenkette mit dem Namen der kategorialen Variable für die
#'   Kategorienachse, beispielsweise eine Bildungs- oder Alterskategorie.
#' @param x Zeichenkette mit dem Namen der numerischen Variable für die
#'   Balkenlängen.
#' @param ci_lower Optionaler Name der Variable mit den unteren Grenzen der
#'   Konfidenzintervalle. Muss zusammen mit \code{ci_upper} angegeben werden.
#'   Standardmässig \code{NULL}.
#' @param ci_upper Optionaler Name der Variable mit den oberen Grenzen der
#'   Konfidenzintervalle. Muss zusammen mit \code{ci_lower} angegeben werden.
#'   Standardmässig \code{NULL}.
#' @param group Optionale Zeichenkette mit dem Namen der Gruppierungsvariable.
#'   Die Gruppen werden durch unterschiedliche Füll- und Rahmenfarben
#'   dargestellt. Standardmässig \code{NULL}.
#' @param title Optionaler Titel des Diagramms. Standardmässig \code{NULL}.
#' @param subtitle Optionaler Untertitel des Diagramms. Standardmässig
#'   \code{NULL}.
#' @param source Optionale Angabe der Datenquelle. Wird in der Bildunterschrift
#'   zusammen mit dem Hinweis auf das Amt für Daten und Statistik ausgegeben.
#'   Standardmässig \code{NULL}.
#' @param fill_palette Liste mit Farbpaletten für die Balkenfüllung.
#'   Standardmässig \code{maincolors_discrete}.
#' @param fill_palette_name Zeichenkette mit dem Namen des Palettenelements,
#'   aus dem die Füllfarben ausgewählt werden. Standardmässig
#'   \code{"fillColor"}.
#' @param fill_color Optionaler Index oder Vektor von Indizes zur Auswahl
#'   bestimmter Füllfarben aus dem gewählten Palettenelement.
#'   Bei gruppierten Balken müssen genügend Farben für alle Gruppen vorhanden
#'   sein. Ohne Gruppierung wird nur die erste ausgewählte Farbe verwendet.
#'   Standardmässig \code{NULL}.
#' @param fill_reverse Logischer Wert. Wenn \code{TRUE}, wird die Reihenfolge
#'   der ausgewählten Füllfarben umgekehrt. Standardmässig \code{FALSE}.
#' @param border_palette Liste mit Farbpaletten für die Balkenrahmen.
#'   Standardmässig \code{border_discrete}.
#' @param border_palette_name Zeichenkette mit dem Namen des Palettenelements,
#'   aus dem die Rahmenfarben ausgewählt werden. Standardmässig
#'   \code{"borderColor"}.
#' @param border_color Optionaler Index oder Vektor von Indizes zur Auswahl
#'   bestimmter Rahmenfarben aus dem gewählten Palettenelement.
#'   Bei gruppierten Balken müssen genügend Farben für alle Gruppen vorhanden
#'   sein. Ohne Gruppierung wird nur die erste ausgewählte Farbe verwendet.
#'   Standardmässig \code{NULL}.
#' @param border_reverse Logischer Wert. Wenn \code{TRUE}, wird die Reihenfolge
#'   der ausgewählten Rahmenfarben umgekehrt. Standardmässig \code{FALSE}.
#' @param position Positionierung der Balken. Erlaubt sind \code{"dodge"}
#'   für nebeneinander angeordnete Balken und \code{"stack"} für gestapelte
#'   Balken. Standardmässig \code{"dodge"}. Bei gruppierten Balken mit
#'   Konfidenzintervallen ist ausschliesslich \code{"dodge"} zulässig.
#' @param errorbar_width Breite der Markierungen der Konfidenzintervalle.
#'   Standardmässig \code{0.2}.
#' @param x_expand Relativer Zuschlag zum maximalen x-Wert, um zusätzlichen
#'   Platz am Ende der Wertachse zu schaffen. Beispielsweise entspricht
#'   \code{0.10} einem Zuschlag von 10 Prozent. Standardmässig \code{0.10}.
#' @param y_label_wrap Optionale maximale Zeilenbreite für die Beschriftungen
#'   der Kategorienachse. Wird an \code{scales::label_wrap()} übergeben.
#'   Bei \code{NULL} werden die Kategorien ohne zusätzliche Umbrüche
#'   dargestellt. Standardmässig \code{NULL}.
#'
#' @return Ein \code{ggplot}-Objekt mit horizontal dargestellten Balken,
#'   optionalen Konfidenzintervallen, benutzerdefinierten Farbskalen und
#'   formatierter Beschriftung.
#'
#' @details
#' Die Funktion prüft, ob die angegebenen Variablen im Datensatz vorhanden
#' sind. Die Variablen für die unteren und oberen Konfidenzintervallgrenzen
#' müssen entweder beide angegeben werden oder beide fehlen.
#'
#' Bei gruppierten Balken werden die Faktorlevels beziehungsweise die
#' Reihenfolge der vorkommenden Gruppen zur Zuordnung der Farben verwendet.
#' Die Füll- und Rahmenfarbpaletten müssen genügend Farben für alle Gruppen
#' enthalten.
#'
#' Die Wertachse beginnt bei null und endet beim maximalen Wert der oberen
#' Konfidenzintervallgrenze, sofern diese angegeben ist, andernfalls beim
#' maximalen Wert von \code{x}, jeweils erweitert um den Faktor
#' \code{1 + x_expand}. Die Achsenbeschriftungen verwenden Apostrophe als
#' Tausendertrennzeichen.
#'
#' @examples
#' \dontrun{
#' # Balkendiagramm mit Konfidenzintervallen
#' ggplot_column_vi(
#'   data = tab_bildung_tot,
#'   y = "ausbildung_5cat",
#'   x = "anteil",
#'   ci_lower = "ci_l_pr",
#'   ci_upper = "ci_u_pr",
#'   title = "Bildung in der Bevölkerung",
#'   subtitle = "Kanton Thurgau",
#'   source = "Kantonale Bevölkerungsstatistik",
#'   fill_color = 2,
#'   border_color = 2,
#'   y_label_wrap = 20
#' )
#'
#' # Gruppierte Balken nach Geschlecht mit Konfidenzintervallen
#' ggplot_column_vi(
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
ggplot_column_vi <- function(
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
    theme_bar_grid_horizontal +
    ggplot2::theme(
      plot.caption = ggplot2::element_text(hjust = 0),
      plot.title.position = "plot",
      plot.caption.position = "plot",
      legend.position = "top",
      legend.justification = "left",
      legend.location = "plot"
    ) +
    ggplot2::scale_x_continuous(
      position = "bottom",
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
    ) +
    ggplot2::coord_flip()
}

# ggplot_column_vi(
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

# ggplot_column_vi(
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
