#' Gemeindedaten für die kartografische Darstellung vorbereiten
#'
#' Bereitet räumliche Gemeindedaten für die Darstellung auf einer Karte vor.
#' Dazu werden die Geometriedaten mit einer Datentabelle anhand der
#' Gemeindenummer verknüpft und zusätzliche Variablen für die Gestaltung
#' der Gemeindelabels erstellt.
#'
#' Die Funktion bestimmt anhand des Gemeindenamens die Ausrichtung der
#' Labels (`angle`) und passt bei ausgewählten Gemeindenamen die
#' Zeilenumbrüche an, damit die Beschriftungen innerhalb der Kartenflächen
#' besser dargestellt werden können. Zusätzlich wird anhand der angegebenen
#' Kategorien festgelegt, ob die Textfarbe weiss oder schwarz sein soll.
#'
#' @param data_map Räumlicher Data Frame mit den Geometrien der Gemeinden.
#'   Muss die Variable `gemeinde_b` mit den Gemeindenummern enthalten.
#' @param data_table Data Frame mit den zusätzlichen Daten, die den
#'   Gemeinden zugeordnet werden sollen. Muss die Variable `bfs_nr`
#'   mit den Gemeindenummern enthalten.
#' @param input_col Name der Spalte mit den Gemeindenamen. Wird als
#'   unquoted Spaltenname übergeben und für die Bestimmung der
#'   Labelausrichtung sowie der angezeigten Gemeindebezeichnung verwendet.
#' @param value_white_1 Erste Kategorie, für welche die Textfarbe weiss
#'   gesetzt wird.
#' @param value_white_2 Zweite Kategorie, für welche die Textfarbe weiss
#'   gesetzt wird.
#' @param value_white_3 Dritte Kategorie, für welche die Textfarbe weiss
#'   gesetzt wird.
#'
#' @return Ein Data Frame mit den ursprünglichen Geometriedaten und den
#'   verknüpften Tabellendaten. Zusätzlich enthält das Ergebnis die
#'   Variablen `angle` für die Ausrichtung der Labels, `colortext` für
#'   die Textfarbe und `gemeinde` für die aufbereitete Gemeindebezeichnung.
#'
#' @export
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


