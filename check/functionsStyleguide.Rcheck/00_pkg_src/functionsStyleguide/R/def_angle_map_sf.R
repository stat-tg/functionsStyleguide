#' Vorbereitungsfunktion für grafische Darstellung von Gemeindedaten als Karte
#'
#' Mit dieser Funktion werden die Gemeindelabels auf kartografischen Darstellungen vorbereitet, sodass deren Ausrichtung
#' eine bestmögliche Lesbarkeit garantiert. Die Funktion muss nicht separat ausgeführt werden, sondern wird innerhalb der
#' Funktion ggplot_map verwendet.
#'
#' @param data Daten
#'
#' @return Definition der Ausrichtung der Gemeindelabels für Karten
#' @export
#'
#
def_angle_map_sf <- function(data) {

  # Normalize municipality names for matching.
  # This allows matching labels with inserted line breaks or hyphens.
  normalize_name <- function(x) {
    gsub("[-\n]", "", as.character(x))
  }

  special_vjust_names <- c(
    "Diessenhofen",
    "Weinfelden",
    "Homburg",
    "Sirnach",
    "Fischingen",
    "Egnach",
    "Affeltrangen",
    "Lommis",
    "Wigoltingen",
    "Schönholzerswilen",
    "Eschlikon",
    "Wängi",
    "Uttwil"
  )

  # Return the coordinate data frame for a selected group.
  make_coords <- function(data_subset) {

    points <- sf::st_point_on_surface(data_subset)

    coords <- as.data.frame(
      sf::st_coordinates(points)
    )

    coords$gemeinde <- data_subset$gemeinde
    coords$kategorie <- data_subset$kategorie
    coords$value <- data_subset$value

    coords
  }

  # Split municipalities into groups based on angle.
  data_20  <- dplyr::filter(data, angle == 20)
  data_45  <- dplyr::filter(data, angle == 45)
  data_60  <- dplyr::filter(data, angle == 60)
  data_70  <- dplyr::filter(data, angle == 70)
  data_295 <- dplyr::filter(data, angle == 295)
  data_315 <- dplyr::filter(data, angle == 315)
  data_330 <- dplyr::filter(data, angle == 330)

  # Municipalities whose labels use angle 0.
  name_normalized <- normalize_name(data$gemeinde)
  special_normalized <- normalize_name(special_vjust_names)

  is_rickenbach <- name_normalized == "Rickenbach"
  is_vjust <- name_normalized %in% special_normalized

  data_0_rick <- data[
    data$angle == 0 & is_rickenbach,
  ]

  data_vjust_0 <- data[
    data$angle == 0 & is_vjust,
  ]

  data_0 <- data[
    data$angle == 0 & !is_rickenbach & !is_vjust,
  ]

  # Calculate label coordinates.
  coords_0       <- make_coords(data_0)
  coords_0_rick  <- make_coords(data_0_rick)
  coords_vjust_0 <- make_coords(data_vjust_0)
  coords_20      <- make_coords(data_20)
  coords_45      <- make_coords(data_45)
  coords_60      <- make_coords(data_60)
  coords_70      <- make_coords(data_70)
  coords_295     <- make_coords(data_295)
  coords_315     <- make_coords(data_315)
  coords_330     <- make_coords(data_330)

  # Return the data, point geometries, and coordinates
  # using the named structure expected by map_variable_sf().
  result_list <- list(
    data_vjust_0 = data_vjust_0,
    points_vjust_0 = sf::st_point_on_surface(data_vjust_0),
    coords_vjust_0 = coords_vjust_0,

    data_0_rick = data_0_rick,
    points_0_rick = sf::st_point_on_surface(data_0_rick),
    coords_0_rick = coords_0_rick,

    data_0 = data_0,
    points_0 = sf::st_point_on_surface(data_0),
    coords_0 = coords_0,

    data_20 = data_20,
    points_20 = sf::st_point_on_surface(data_20),
    coords_20 = coords_20,

    data_45 = data_45,
    points_45 = sf::st_point_on_surface(data_45),
    coords_45 = coords_45,

    data_60 = data_60,
    points_60 = sf::st_point_on_surface(data_60),
    coords_60 = coords_60,

    data_70 = data_70,
    points_70 = sf::st_point_on_surface(data_70),
    coords_70 = coords_70,

    data_295 = data_295,
    points_295 = sf::st_point_on_surface(data_295),
    coords_295 = coords_295,

    data_315 = data_315,
    points_315 = sf::st_point_on_surface(data_315),
    coords_315 = coords_315,

    data_330 = data_330,
    points_330 = sf::st_point_on_surface(data_330),
    coords_330 = coords_330
  )

  result_list
}
