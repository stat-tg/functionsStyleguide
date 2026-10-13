#' Gestapeltes horizontales Balkendiagramm erstellen
#'
#' Erstellt ein horizontales Balkendiagramm mit gestapelten Balken auf Basis
#' eines Datensatzes. Die Balken werden anhand einer Kategorie eingefärbt
#' und können zusätzlich über eine separate Variable mit kategorisierten
#' Rahmenfarben versehen werden.
#'
#' Die Reihenfolge der Kategorien kann optional anhand einer weiteren
#' Variable festgelegt werden. Über \code{decreasing} lässt sich diese
#' Reihenfolge umkehren. Die Füll- und Rahmenfarben werden über die
#' benutzerdefinierten Farbskalen \code{scale_fill_maincolors()} und
#' \code{scale_colour_main_borders()} zugewiesen.
#'
#' @param data Ein Data Frame mit den darzustellenden Daten.
#' @param y Zeichenkette mit dem Namen der Variable für die y-Achse.
#'   Diese Variable wird als diskrete Achse dargestellt.
#' @param x Zeichenkette mit dem Namen der numerischen Variable für die
#'   x-Achse.
#' @param fill Zeichenkette mit dem Namen der Variable, anhand derer die
#'   Balkenfüllung kategorisiert wird.
#' @param colour Zeichenkette mit dem Namen der Variable, anhand derer die
#'   Rahmenfarben der Balken kategorisiert werden.
#' @param title Titel des Diagramms.
#' @param subtitle Untertitel des Diagramms.
#' @param source Angabe der Datenquelle. Wird zusammen mit dem Hinweis auf
#'   das Amt für Daten und Statistik Thurgau in der Bildunterschrift ausgegeben.
#' @param order_by Optionale Zeichenkette mit dem Namen einer Variable,
#'   anhand derer die Kategorien von \code{fill} sortiert werden.
#'   Standardmässig \code{NULL}; in diesem Fall wird die ursprüngliche
#'   Kategorienreihenfolge beibehalten.
#' @param decreasing Logischer Wert. Wenn \code{TRUE}, wird die anhand von
#'   \code{order_by} ermittelte Reihenfolge umgekehrt. Wird nur verwendet,
#'   wenn \code{order_by} nicht \code{NULL} ist. Standardmässig \code{FALSE}.
#' @param reverse_fill Optionaler logischer Wert zur Umkehrung der
#'   Füllfarbskala. Wird an \code{scale_fill_maincolors()} übergeben.
#'   Standardmässig \code{NULL}.
#' @param reverse_color Optionaler logischer Wert zur Umkehrung der
#'   Rahmenfarbskala. Wird an \code{scale_colour_main_borders()} übergeben.
#'   Standardmässig \code{NULL}.
#'
#' @return Ein \code{ggplot}-Objekt mit gestapelten horizontalen Balken,
#'   benutzerdefinierten Farbskalen und formatierter Beschriftung.
#'
#' @details
#' Wenn \code{order_by} angegeben ist, wird die Reihenfolge der Kategorien
#' anhand der eindeutigen Kombinationen der Variablen \code{fill} und
#' \code{order_by} bestimmt. Die Daten werden nach \code{order_by} sortiert
#' und die resultierende Reihenfolge wird als Faktorstufen für die Variablen
#' \code{fill} und \code{colour} verwendet. Daher sollten die Kategorien
#' beider Variablen zueinander passen.
#'
#' Die x-Achse wird oberhalb des Diagramms angezeigt und verwendet
#' Tausendertrennzeichen mit Apostrophen. Beide Achsen erhalten keinen
#' zusätzlichen Rand. Die Formatierung wird durch
#' \code{theme_bar_grid_vertical} ergänzt.
#'
#' Die Legenden für Füllung und Rahmenfarbe werden unabhängig von den
#' Farbskalen jeweils in umgekehrter Reihenfolge dargestellt.
#'
#' @examples
#' \dontrun{
#' ggplot_stacked_bar(
#'   data = tab_alterskat |>
#'     dplyr::mutate(jahr = as.character(jahr)),
#'   y = "jahr",
#'   x = "n",
#'   fill = "alterskat_det",
#'   colour = "alterskat_det",
#'   title = "Bevölkerung wird älter",
#'   subtitle = paste(
#'     "Kanton Thurgau, Ständige Wohnbevölkerung",
#'     "nach Altersklassen, 2015–2025"
#'   ),
#'   source = "Kantonale Bevölkerungsstatistik",
#'   order_by = "order",
#'   decreasing = TRUE,
#'   reverse_fill = TRUE,
#'   reverse_color = TRUE
#' )
#' }
#'
#' @export
ggplot_stacked_bar <- function(data, y, x, fill, colour, title, subtitle, source, order_by=NULL, decreasing=FALSE,
                               reverse_fill=NULL, reverse_color=NULL){

  if (!is.null(order_by)) {

    category_order <- data |>
      dplyr::distinct(
        .data[[fill]],
        .data[[order_by]]
      ) |>
      dplyr::arrange(.data[[order_by]]) |>
      dplyr::pull(.data[[fill]])

    if (decreasing) {
      category_order <- rev(category_order)
    }

    data[[fill]] <- factor(
      data[[fill]],
      levels = category_order
    )

    # Keep colour categories in the same order as fill
    data[[colour]] <- factor(
      data[[colour]],
      levels = category_order
    )
  }

  ggplot(data,
         aes(
           x = .data[[x]],
           y = .data[[y]],
           fill = .data[[fill]],
           colour = .data[[colour]]
         )) +
    geom_col() +
    theme_bar_grid_vertical +
    scale_fill_maincolors(reverse = reverse_fill) +
    scale_colour_main_borders(reverse = reverse_color) +
    scale_x_continuous(position = "top",
                       labels = scales::label_comma(big.mark = "'"),
                       expand=c(0,0)) +
    scale_y_discrete(expand=c(0,0)) +
    labs(
      title = title,
      subtitle = subtitle,
      x="", y="",
      caption = paste("Amt für Daten und Statistik Thurgau\nDatenquelle:", source)
    ) +
    guides(
      fill = guide_legend(reverse = TRUE),
      colour = guide_legend(reverse = TRUE)
    )
}
# ggplot_stacked_bar(data = tab_alterskat %>% mutate(jahr=as.character(jahr)), y = "jahr", x = "n", fill = "alterskat_det", colour = "alterskat_det",
#                    title = "Bevölkerung wird älter", subtitle = "Kanton Thurgau, Ständige Wohnbevölkerung nach Altersklassen, 2015-2025",
#                    source = "Kantonale Bevölkerungsstatistik", order_by = "order", decreasing = TRUE,
#                    reverse_fill = TRUE, reverse_color = TRUE)
#
