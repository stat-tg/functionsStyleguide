#' Gemeindekarte mit kategorisierten Werten gemäss Styleguide
#'
#' Erstellt eine thematische Karte der Gemeinden des Kantons Thurgau.
#' Die Gemeinden werden anhand einer numerischen oder kategorialen Variable
#' in Kategorien eingeteilt und entsprechend eingefärbt. Die Farbpalette,
#' die Zuordnung der Farben zu den Kategorien sowie die Beschriftungen der
#' Legende können individuell angepasst werden.
#'
#' Die Gemeindekarte basiert auf einem räumlichen \code{sf}-Datensatz.
#' Die übergebenen Daten werden anhand der Gemeindeinformationen mit den
#' Kartengeometrien verknüpft. Die Beschriftungen und ihre Positionen werden
#' automatisch mithilfe vorbereiteter Koordinaten und Drehwinkel ermittelt.
#'
#' @param data Ein Data Frame mit den darzustellenden Gemeindedaten.
#' @param var_bfs Name der Variable, welche die
#'   BFS-Gemeindenummer enthält. Standardmässig \code{"bfs_nr"}.
#' @param var_gemeinde Name der Gemeindevariable.
#'   Standardmässig \code{"gemeinde"}.
#' @param var_jahr Optionaler Name der Jahresvariable. Wird auf ihre Existenz
#'   im Datensatz geprüft. Standardmässig \code{NULL}.
#' @param var_value Zeichenkette mit dem Namen der Variable, deren Werte
#'   auf der Karte dargestellt und für die Beschriftungsfarbe verwendet werden.
#' @param label_value Optionale Beschriftung des dargestellten Wertes.
#'   Standardmässig \code{NULL}.
#' @param palette Farbpalette als Liste, aus der die Farben ausgewählt werden.
#'   Standardmässig \code{maincolors_discrete}.
#' @param palette_name Zeichenkette mit dem Namen des Palettenelements,
#'   das verwendet werden soll. Standardmässig \code{"fillColor"}.
#' @param colors Optionaler numerischer Vektor mit den Indizes der Farben,
#'   die aus dem gewählten Palettenelement ausgewählt werden sollen.
#'   Die Indizes müssen gültige positive ganze Zahlen innerhalb der
#'   verfügbaren Palette sein. Standardmässig \code{NULL}.
#' @param reverse Logischer Wert. Wenn \code{TRUE}, wird die Reihenfolge
#'   der ausgewählten Farben umgekehrt. Standardmässig \code{FALSE}.
#' @param category_labels Optionaler Zeichenvektor mit den Bezeichnungen
#'   der Kategorien für die Legende. Muss bei Angabe genau so viele Elemente
#'   enthalten, wie Kategorien vorhanden sind. Standardmässig \code{NULL};
#'   in diesem Fall werden die Kategorien selbst als Bezeichnungen verwendet.
#' @param legend_ncol Anzahl der Spalten in der Kartenlegende. Muss eine
#'   positive ganze Zahl sein. Standardmässig \code{2}.
#' @param title Optionaler Titel der Karte. Standardmässig \code{NULL}.
#' @param subtitle Optionaler Untertitel der Karte. Standardmässig \code{NULL}.
#' @param source Optionale Angabe der Datenquelle. Wird in der Bildunterschrift
#'   zusammen mit dem Hinweis auf das Amt für Daten und Statistik Thurgau
#'   ausgegeben. Standardmässig \code{NULL}.
#'
#' @return Ein \code{ggplot}-Objekt mit der eingefärbten Gemeindekarte,
#'   den Gemeindebeschriftungen und einer Legende mit Kategorien und
#'   der jeweiligen Anzahl Gemeinden.
#'
#' @details
#' Die Gemeindekartengeometrien werden aus der Datei
#' \code{"inst/extdata/maps/Gemeinden_TG.shp"} geladen. Diese Datei muss unter dem
#' angegebenen relativen Pfad verfügbar sein.
#'
#' Die Daten werden über die Gemeindevariable mit den Kartengeometrien
#' verknüpft. Die BFS-Nummer wird als Eingabevariable geprüft, während die
#' Standardisierung der Spaltennamen für die weitere Verarbeitung erfolgt.
#' Die Jahresvariable wird, sofern angegeben, auf ihre Existenz geprüft,
#' aber nicht für die Verknüpfung oder die Kartendarstellung verwendet.
#'
#' Die Kategorien werden aus der Variable \code{kategorie} ermittelt und
#' sortiert. Die Anzahl Gemeinden pro Kategorie wird in der Legende ergänzt.
#' Nicht zugeordnete Kategorien werden bei der Zählung nicht berücksichtigt.
#'
#' Die Farben stammen aus dem über \code{palette_name} ausgewählten Element
#' von \code{palette}. Mit \code{colors} können gezielt Farben ausgewählt
#' werden; mit \code{reverse} lässt sich ihre Reihenfolge umkehren.
#' Die gewählte Palette muss mindestens so viele Farben enthalten, wie
#' Kategorien dargestellt werden.
#'
#' @examples
#' \dontrun{
#' # Karte der Gemeindesteuerfüsse
#' ggplot_map(
#'   data = tab_steuerfuss,
#'   var_value = "gemeindesteuerfuss",
#'   label_value = "Gemeindesteuerfuss in %",
#'   palette = colors_divergent,
#'   palette_name = "fillDiv5",
#'   category_labels = c(
#'     "30–39 %",
#'     "40–49 %",
#'     "50–59 %",
#'     "60–69 %",
#'     "70–72 %"
#'   ),
#'   title = "Wenige Steuerfüsse über 70 %",
#'   subtitle = paste(
#'     "Kanton Thurgau, 2026,",
#'     "Gemeindesteuerfüsse nach Kategorien"
#'   ),
#'   source = "Steuerverwaltung Thurgau"
#' )
#'
#' # Karte mit abweichenden Spaltennamen
#' ggplot_map(
#'   data = data_konf,
#'   var_gemeinde = "gemeinde_name",
#'   var_bfs = "bfs_nr_gemeinde",
#'   var_value = "prop_ev",
#'   label_value = "Anteil Evangelisch-reformiert",
#'   category_labels = c(
#'     "unter 10",
#'     "zwischen 10 und 20",
#'     "über 20"
#'   ),
#'   source = "Kantonale Bevölkerungsstatistik"
#' )
#' }
#'
#' @export
ggplot_map <- function(
    data,
    var_bfs = "bfs_nr",
    var_gemeinde = "gemeinde",
    var_jahr = NULL,
    var_value,
    label_value = NULL,
    palette = maincolors_discrete,
    palette_name = "fillColor",
    colors = NULL,
    reverse = FALSE,
    category_labels = NULL,
    legend_ncol = 2,
    title = NULL,
    subtitle = NULL,
    source = NULL
) {

  map_path <- system.file(
    "extdata", "maps", "Gemeinden_TG.shp",
    package = "functionsStyleguide"
  )

  # Validate legend column count
  if (
    length(legend_ncol) != 1 ||
    is.na(legend_ncol) ||
    !is.numeric(legend_ncol) ||
    legend_ncol < 1 ||
    legend_ncol != as.integer(legend_ncol)
  ) {
    stop("'legend_ncol' must be a positive integer.")
  }

  # Read municipality map
  map_sf <- sf::st_read(
    map_path,
    options = "ENCODING=WINDOWS-1252",
    quiet = TRUE
  )

  # Validate input variables
  if (!var_bfs %in% names(data)) {
    stop("BFS variable '", var_bfs, "' not found in data.")
  }

  if (!var_gemeinde %in% names(data)) {
    stop("Gemeinde variable '", var_gemeinde, "' not found in data.")
  }

  if (!var_value %in% names(data)) {
    stop("Value variable '", var_value, "' not found in data.")
  }

  if (!is.null(var_jahr) && !var_jahr %in% names(data)) {
    stop("Jahr variable '", var_jahr, "' not found in data.")
  }

  # Standardize input column names
  data_map <- data

  if (var_bfs != "bfs_nr") {
    data_map <- data_map |>
      dplyr::rename(
        bfs_nr = dplyr::all_of(var_bfs)
      )
  }

  if (var_gemeinde != "gemeinde") {
    data_map <- data_map |>
      dplyr::rename(
        gemeinde = dplyr::all_of(var_gemeinde)
      )
  }

  # Prepare municipality map data
  gmddata <- prep_data_map_sf(
    data_map = map_sf,
    data_table = data_map,
    input_col = gemeinde,
    value_white_1 = 1,
    value_white_2 = 1,
    value_white_3 = 5
  )

  # Add value and label columns
  if (!var_value %in% names(gmddata)) {
    stop(
      "Value variable '", var_value,
      "' is missing after joining the map and data. ",
      "Check whether the join created suffixed column names."
    )
  }

  gmddata <- gmddata |>
    dplyr::mutate(
      value = .data[[var_value]],
      label = label_value
    )

  # Determine categories
  categories <- sort(
    unique(
      gmddata$kategorie[!is.na(gmddata$kategorie)]
    )
  )

  n_categories <- length(categories)

  if (n_categories == 0) {
    stop("No categories found in 'kategorie'.")
  }

  # Count municipalities per category
  tab_count <- gmddata |>
    sf::st_drop_geometry() |>
    dplyr::filter(!is.na(kategorie)) |>
    dplyr::count(
      kategorie,
      name = "count"
    )

  category_counts <- tab_count$count[
    match(categories, tab_count$kategorie)
  ]

  # Set category labels
  if (is.null(category_labels)) {
    category_labels <- as.character(categories)
  } else if (length(category_labels) != n_categories) {
    stop(
      "category_labels must contain exactly ",
      n_categories,
      " labels."
    )
  }

  # Convert category to ordered factor
  gmddata$kategorie <- factor(
    gmddata$kategorie,
    levels = categories,
    labels = category_labels,
    ordered = TRUE
  )

  # Calculate label coordinates
  angle_data <- def_angle_map_sf(gmddata)

  # Select palette colours
  palette_colors <- palette[[palette_name]]

  if (is.null(palette_colors)) {
    stop(
      "Palette entry '", palette_name,
      "' was not found."
    )
  }

  # Optionally select specific palette colours
  if (!is.null(colors)) {

    if (
      !is.numeric(colors) ||
      anyNA(colors) ||
      any(colors != as.integer(colors)) ||
      any(colors < 1) ||
      any(colors > length(palette_colors))
    ) {
      stop("'colors' must contain valid integer palette indices.")
    }

    palette_colors <- palette_colors[colors]
  }

  # Check that enough colours are available
  if (length(palette_colors) < n_categories) {
    stop(
      "The selected palette contains ",
      length(palette_colors),
      " colours, but the data contains ",
      n_categories,
      " categories."
    )
  }

  palette_colors <- palette_colors[
    seq_len(n_categories)
  ]

  if (reverse) {
    palette_colors <- rev(palette_colors)
  }

  # Build legend labels
  legend_labels <- paste0(
    category_labels,
    " (",
    category_counts,
    " Gemeinden)"
  )

  # Create map and pass the configurable legend column count
  map <- map_variable_sf(
    gmd_data = gmddata,
    angle_data = angle_data,
    legend_ncol = legend_ncol
  ) +
    ggplot2::labs(
      title = title,
      subtitle = subtitle,
      caption = if (is.null(source)) {
        "Amt für Daten und Statistik Thurgau"
      } else {
        paste0(
          "Amt für Daten und Statistik Thurgau\n",
          "Datenquelle: ",
          source
        )
      }
    ) +
    ggplot2::scale_fill_manual(
      values = stats::setNames(
        palette_colors,
        category_labels
      ),
      name = "",
      breaks = category_labels,
      labels = legend_labels
    )

  return(map)
}
# ggplot_map(
#   data = tab_steuerfuss,
#   # var_gemeinde = "gemeinde",
#   # var_bfs = "bfs_nr",
#   var_value = "gemeindesteuerfuss",
#   label_value = "Gemeindesteuerfuss in %",
#   palette = colors_divergent,
#   palette_name = "fillDiv5",
#   category_labels = c(
#     "30-39 %",
#     "40–49 %",
#     "50–59 %",
#     "60–69 %",
#     "70–72 %"
#   ),
#   title = "Wenige Steuerfüsse über 70 %",
#   subtitle = "Kanton Thurgau, 2026, Gemeindesteuerfüsse nach Kategorien",
#   source = "Steuerverwaltung Thurgau"
# )
#
# ggplot_map(
#   data = tab_steuerfuss,
#   var_gemeinde = "gemeinde",
#   var_value = "gemeindesteuerfuss",
#   label_value = "Gemeindesteuerfuss in %",
#   palette = colors_sequential,
#   palette_name = "fillSeq5",
#   category_labels = c(
#     "kat 1",
#     "40–49 %",
#     "50–59 %",
#     "60–69 %",
#     "70–72 %"
#   ),
#   source = "Steuerverwaltung Thurgau"
#
# )

# ggplot_map(data = data_konf,
#            var_gemeinde = "gemeinde_name",
#            var_bfs = "bfs_nr_gemeinde",
#            var_value = "prop_ev",
#            label_value = "Anteil Evangelisch-reformiert",
#            category_labels = c(
#              "unter 10",
#              "zw. 10 und 20",
#              "über 20"
#            ),
#            source = "Kantonale Bevölkerungsstatistik"
#
# )
# map.steuerfuss <- map_variable_sf(gmddata) +
#   scale_fill_manual(values=c("#eaf3fa", "#96c2e8", "#4391d6","#205b92","#123454"),
#                     name="",
#                     breaks=c("30-39 %", "40-49 %", "50-59 %", "60-69 %", "70-72 %"))
#
# map.steuerfuss
