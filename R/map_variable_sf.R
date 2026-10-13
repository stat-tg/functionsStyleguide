#' Gemeindekarte mit beschrifteten Gemeinden erstellen
#'
#' Erstellt eine Karte der Gemeinden des Kantons Thurgau auf Grundlage eines
#' räumlichen \code{sf}-Objekts. Die Gemeinden werden anhand der Variable
#' \code{kategorie} eingefärbt und mit ihren Namen beschriftet.
#'
#' Die Position, Drehung sowie horizontale und vertikale Ausrichtung der
#' Gemeindebeschriftungen werden über vorbereitete Koordinatendatensätze
#' gesteuert. Dadurch können die Beschriftungen individuell positioniert
#' werden, um die Lesbarkeit der Karte zu verbessern.
#'
#' Zusätzlich wird der Bodensee als Hintergrundgeometrie dargestellt.
#' Die Anzahl der Spalten in der Legende kann über \code{legend_ncol}
#' festgelegt werden.
#'
#' @param gmd_data Ein räumliches \code{sf}-Objekt mit den Gemeindegeometrien.
#'   Es muss mindestens die Variable \code{kategorie} enthalten, anhand derer
#'   die Gemeinden eingefärbt werden.
#' @param angle_data Eine Liste mit vorbereiteten Koordinatendatensätzen für
#'   die Gemeindebeschriftungen. Erwartet werden die Elemente
#'   \code{coords_0}, \code{coords_0_rick}, \code{coords_vjust_0},
#'   \code{coords_20}, \code{coords_45}, \code{coords_60}, \code{coords_70},
#'   \code{coords_295}, \code{coords_315} und \code{coords_330}.
#'   Jeder Datensatz muss mindestens die Variablen \code{X}, \code{Y},
#'   \code{gemeinde} und \code{value} enthalten.
#' @param legend_ncol Anzahl der Spalten in der Kartenlegende. Muss eine
#'   positive ganze Zahl sein. Standardmässig \code{2}.
#'
#' @return Ein \code{ggplot}-Objekt mit der Gemeindekarte, den
#'   Gemeindebeschriftungen und der Legende.
#'
#' @details
#' Die Hintergrundgeometrie des Bodensees wird aus der Datei
#' \code{"data/maps/Bodensee.shp"} geladen. Diese Datei muss unter dem
#' angegebenen relativen Pfad verfügbar sein.
#'
#' Die Gemeindebeschriftungen werden in mehreren Ebenen hinzugefügt.
#' Je nach Koordinatendatensatz unterscheiden sich Drehwinkel sowie die
#' horizontale und vertikale Ausrichtung der Beschriftungen.
#'
#' Die Beschriftungsfarbe richtet sich nach der Variable \code{value}:
#' Werte ab 3000 werden weiss, kleinere Werte schwarz dargestellt.
#' Die Karten- und Legendenformatierung wird teilweise durch
#' \code{theme_opts_map} bestimmt.
#'
#' @examples
#' \dontrun{
#' # Gemeindekarte mit zweispaltiger Legende
#' map_variable_sf(
#'   gmd_data = gemeinde_sf,
#'   angle_data = angle_data,
#'   legend_ncol = 2
#' )
#'
#' # Gemeindekarte mit einspaltiger Legende
#' map_variable_sf(
#'   gmd_data = gemeinde_sf,
#'   angle_data = angle_data,
#'   legend_ncol = 1
#' )
#' }
#'
#' @export
#
map_variable_sf <- function(
    gmd_data,
    angle_data,
    legend_ncol = 2
) {

  map_path_lake <- system.file(
    "extdata", "maps", "Bodensee.shp",
    package = "functionsStyleguide"
  )

  if (
    length(legend_ncol) != 1 ||
    is.na(legend_ncol) ||
    !is.numeric(legend_ncol) ||
    legend_ncol < 1 ||
    legend_ncol != as.integer(legend_ncol)
  ) {
    stop("'legend_ncol' must be a positive integer.")
  }

  bodensee <- sf::st_read(
    map_path_lake,
    quiet = TRUE
  )

  # Helper function for municipality labels
  add_label_layer <- function(
    plot,
    coords,
    angle = 0,
    vjust = 0.5,
    hjust = 0.5
  ) {
    plot +
      ggplot2::geom_text(
        data = coords,
        mapping = ggplot2::aes(
          x = X,
          y = Y,
          label = stringr::str_wrap(gemeinde, 5),
          vjust = vjust,
          hjust = hjust
        ),
        color = ifelse(
          coords$value >= 3000,
          "white",
          "black"
        ),
        size = 1.7,
        angle = angle
      )
  }

  # Base map
  map <- ggplot2::ggplot() +
    ggplot2::geom_sf(
      data = bodensee,
      fill = "#E8E8E9"
    ) +
    ggplot2::geom_sf(
      data = gmd_data,
      mapping = ggplot2::aes(fill = kategorie)
    ) +
    theme_opts_map +
    ggplot2::theme(
      panel.background = ggplot2::element_rect(
        fill = "transparent",
        color = "transparent"
      ),
      plot.background = ggplot2::element_rect(
        fill = "transparent",
        color = "transparent"
      ),
      legend.background = ggplot2::element_rect(
        fill = "transparent",
        color = "transparent"
      ),
      legend.position = c(0.65, 0.16),
      legend.justification = c(0.5, 0),
      legend.text = ggplot2::element_text(size = 7),
      legend.key.size = grid::unit(0.35, "cm"),
      legend.spacing.x = grid::unit(0.15, "cm"),
      legend.margin = ggplot2::margin(2, 2, 2, 2),
      plot.caption = ggplot2::element_text(
        hjust = 0,
        vjust = -2
      )
    ) +
    ggplot2::guides(
      fill = ggplot2::guide_legend(
        reverse = FALSE,
        ncol = legend_ncol,
        byrow = FALSE
      )
    )

  # Add municipality labels
  map <- add_label_layer(
    map,
    angle_data$coords_0
  )

  map <- add_label_layer(
    map,
    angle_data$coords_0_rick,
    vjust = 0.6,
    hjust = 0.2
  )

  map <- add_label_layer(
    map,
    angle_data$coords_vjust_0,
    vjust = -0.2
  )

  map <- add_label_layer(
    map,
    angle_data$coords_20,
    angle = 20,
    vjust = 0.3
  )

  map <- add_label_layer(
    map,
    angle_data$coords_45,
    angle = 45,
    vjust = 0.6
  )

  map <- add_label_layer(
    map,
    angle_data$coords_60,
    angle = 60,
    vjust = 0.3
  )

  map <- add_label_layer(
    map,
    angle_data$coords_70,
    angle = 70,
    vjust = 0.6
  )

  map <- add_label_layer(
    map,
    angle_data$coords_295,
    angle = 295,
    vjust = 0.6
  )

  map <- add_label_layer(
    map,
    angle_data$coords_315,
    angle = 315,
    vjust = 0.4
  )

  map <- add_label_layer(
    map,
    angle_data$coords_330,
    angle = 330,
    vjust = 0.6,
    hjust = 0.2
  )

  map
}
