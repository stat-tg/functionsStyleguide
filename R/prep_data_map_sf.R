#' Vorbereitungsfunktion für grafische Darstellung von Gemeindedaten als Karte
#'
#' Mit dieser Funktion werden die Gemeindelabels auf kartografischen Darstellungen vorbereitet
#'
#' @param x The first number.
#' @param y The second number.
#'
#' @return ggplot bar chart.
#' @export
#'
#

prep_data_map_sf <- function(
    data_map,
    data_table,
    input_col,
    value_white_1,
    value_white_2,
    value_white_3
) {

  input_col <- rlang::enquo(input_col)

  data_map |>
    dplyr::left_join(
      data_table,
      by = c("gemeinde_b" = "bfs_nr")
    ) |>
    dplyr::mutate(
      angle = dplyr::case_when(
        !!input_col == "Bettwiesen" ~ 330,
        !!input_col %in% c(
          "Berlingen",
          "Hefenhofen",
          "Salenstein",
          "Wagenhausen"
        ) ~ 315,
        !!input_col == "Langrickenbach" ~ 295,
        !!input_col %in% c("Hohentannen", "Wilen") ~ 70,
        !!input_col == "Matzingen" ~ 60,
        !!input_col %in% c(
          "Bottighofen",
          "Güttingen",
          "Kesswil",
          "Romanshorn",
          "Tägerwilen"
        ) ~ 45,
        !!input_col %in% c(
          "Braunau",
          "Mammern",
          "Raperswilen",
          "Salmsach",
          "Sommeri",
          "Warth-Weiningen"
        ) ~ 20,
        TRUE ~ 0
      ),

      colortext = dplyr::if_else(
        kategorie %in% c(
          value_white_1,
          value_white_2,
          value_white_3
        ),
        "#FFFFFF",
        "#000000"
      ),

      gemeinde = dplyr::case_when(
        !!input_col == "Bischofszell" ~ "Bischofs-\nzell",
        !!input_col == "Hefenhofen" ~ "Hefen-\nhofen",
        !!input_col == "Münsterlingen" ~ "Münster-\nlingen",
        !!input_col == "Wigoltingen" ~ "Wigol-\ntingen",
        !!input_col == "Schönholzerswilen" ~ "Schönholzers-\nwilen",
        !!input_col == "Hauptwil-Gottshaus" ~ "Hauptwil-\nGottshaus",
        !!input_col == "Bichelsee-Balterswil" ~ "Bichelsee-\nBalterswil",
        !!input_col == "Basadingen-Schlattingen" ~ "Basadingen-\nSchlattingen",
        !!input_col == "Felben-Wellhausen" ~ "Felben-\nWellhausen",
        !!input_col == "Tobel-Tägerschen" ~ "Tobel-\nTägerschen",
        !!input_col == "Kradolf-Schönenberg" ~ "Kradolf-\nSchönenberg",
        !!input_col == "Zihlschlacht-Sitterdorf" ~ "Zihlschlacht-\nSitterdorf",
        TRUE ~ as.character(!!input_col)
      )
    )
}


