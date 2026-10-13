# Beispiele
# Daten für Beispiele
library(functionsStyleguide)
library(tidyverse)
data_bev <- readRDS("data/data_bev.rds")
data_bev_gmd <- readRDS("data/data_bev_gmd.rds")
data_steuerfuss <- readRDS("data/data_steuerfuss.rds")
data_bildung_tot <- readRDS("data/data_bildung_tot.rds")
data_bildung_sex <- readRDS("data/data_bildung_sex.rds")
data_erwerbsquote <- readRDS("data/data_erwerbsquote.rds")
data_konf <- readRDS("data/data_konf.rds")

# Beispieldaten: Bevölkerungsstand nach Altersklassen und Jahren
tab_alterskat <- data_bev %>%
  type.convert(as.is=TRUE) %>%
  mutate(alterskat=case_when(alter_code<25 ~ "unter 25",
                             alter_code>=25 & alter_code<65 ~ "25-64",
                             alter_code>=65 ~ "über 65"),
         alterskat_det=case_when(alter_code<25 ~ "unter 25",
                                 alter_code>=25 & alter_code<40 ~ "25-39",
                                 alter_code>=40 & alter_code<65 ~ "40-64",
                                 alter_code>=65 & alter_code<=75 ~ "65-75",
                                 TRUE ~ "über 75"),
         order=case_when(alter_code<25 ~ 1,
                         alter_code>=25 & alter_code<40 ~ 2,
                         alter_code>=40 & alter_code<65 ~ 3,
                         alter_code>=65 & alter_code<=75 ~ 4,
                         TRUE ~ 5)) %>%
  group_by(jahr, alterskat_det, order) %>%
  summarise(n = sum(anzahl_personen)) %>%
  ungroup()

tab_alterskat_3cat <- data_bev %>%
  type.convert(as.is=TRUE) %>%
  mutate(alterskat=case_when(alter_code<25 ~ "unter 25",
                             alter_code>=25 & alter_code<65 ~ "25-64",
                             alter_code>=65 ~ "über 65"),
         alterskat_det=case_when(alter_code<25 ~ "unter 25",
                                 alter_code>=25 & alter_code<40 ~ "25-39",
                                 alter_code>=40 & alter_code<65 ~ "40-64",
                                 alter_code>=65 & alter_code<=75 ~ "65-75",
                                 TRUE ~ "über 75"),
         order=case_when(alter_code<25 ~ 1,
                         alter_code>=25 & alter_code<40 ~ 2,
                         alter_code>=40 & alter_code<65 ~ 3,
                         alter_code>=65 & alter_code<=75 ~ 4,
                         TRUE ~ 5)) %>%
  group_by(jahr, alterskat) %>%
  summarise(n = sum(anzahl_personen)) %>%
  ungroup()

# Beispieldaten: Bevölkerungstand nach Jahren
tab_bev <- data_bev %>%
  type.convert(as.is=TRUE) %>%
  group_by(jahr) %>%
  summarise(n = sum(anzahl_personen)) %>%
  ungroup()
options(scipen=10000)

# Beispieldaten: Bevölkerungsstand fürs aktuelle Jahr nach Gemeinden
tab_bev_gmd <- data_bev_gmd %>%
  type.convert(as.is = TRUE) %>%
  filter(jahr==max(jahr))

# Beispieldaten: Gemeindesteuerfüsse
data_steuerfuss <- data_steuerfuss %>%
  type.convert(as.is = TRUE) %>%
  # filter(jahr==max(jahr)) %>%
  mutate(kategorie=case_when(gemeindesteuerfuss<=39 ~ 1,
                             gemeindesteuerfuss>=40 & gemeindesteuerfuss<=49 ~ 2,
                             gemeindesteuerfuss>=50 & gemeindesteuerfuss<=59 ~ 3,
                             gemeindesteuerfuss>=60 & gemeindesteuerfuss<=69 ~ 4,
                             gemeindesteuerfuss>=70 & gemeindesteuerfuss<=79 ~ 5))

# Beispiel: Gemeindesteuerfüsse für das aktuellste Jahr für Karte
tab_steuerfuss <- data_steuerfuss %>%
  filter(jahr==max(jahr)) %>%
  rename(bfs_nr=bfs_nr_gemeinde,
         gemeinde=gemeinde_name)

# Beispiel: Gemeindesteuerfüsse (nur Gemeinden mit einer Veränderung bei den Gemeindesteuerfüssen zwischen aktuellem und Vorjahr)
df_steuerfuss <- data_steuerfuss %>%
  arrange(jahr, gemeinde_name) %>%
  group_by(gemeinde_name) %>%
  mutate(change=gemeindesteuerfuss-lag(gemeindesteuerfuss)) %>%
  ungroup() %>%
  mutate(change_aktuell=case_when(jahr==2026 & change!=0 ~ 1,
                                  TRUE ~ 0))

filter_gmd <- df_steuerfuss %>% filter(change_aktuell==1) %>%
  dplyr::select(gemeinde_name) %>%
  t()

tab_steuerfuss_change <- df_steuerfuss %>%
  filter(gemeinde_name %in% c(filter_gmd) & jahr %in% c(2025, 2026)) %>%
  dplyr::select(gemeinde_name, jahr, gemeindesteuerfuss) %>%
  pivot_wider(names_from = jahr, values_from = gemeindesteuerfuss)


tab_steuerfuss_change_long <- df_steuerfuss %>%
  filter(gemeinde_name %in% c(filter_gmd) & jahr %in% c(2025, 2026)) %>%
  mutate(jahr=as.character(jahr))


# Beispiel: 10 Gemeinden mit den aktuell tiefsten Gemeindesteuerfüssen
tab_steuerfuss_aktuell <- data_steuerfuss %>%
  filter(jahr==max(jahr)) %>%
  arrange(gemeindesteuerfuss) %>%
  head(10)

# Beispieldaten für Karte mit drei Kategorien zum Anteil evangelisch-reformierter Einwohner/innen
data_konf <- get_dataset(dataset_id = "sk-stat-62") %>%
  type.convert(as.is = TRUE) %>%
  rename(bfs_nr=bfs_nr_gemeinde,
         gemeinde=gemeinde_name)

tab_prop_ev <- data_konf %>%
  filter(jahr==max(jahr)) %>%
  group_by(gemeinde, bfs_nr) %>%
  mutate(proportion = anzahl_personen / sum(anzahl_personen)*100) %>%  ungroup() %>%
  filter(konfession_bezeichnung=="Evangelisch-reformiert") %>%
  mutate(kategorie=case_when(proportion<20 ~ "Anteil unter 20 %",
                               proportion>=20 & proportion<35 ~ "Anteil zw. 20 und 35 %",
                               TRUE ~ "Anteil über 35 %"))


# Beispieldaten mit Vertrauensintervallen: Bildungsstand insgesamt und nach Geschlecht
tab_bildung_tot <- data_bildung_tot %>%
  rename(ausbildung_3cat=HIGHESTCOMPLEDUAGGI,
         ausbildung_5cat=HIGHESTCOMPLEDUAGGIII,
         anteil=prop) %>%
  dplyr::select(ausbildung_3cat, ausbildung_5cat, anteil, ci_l_pr, ci_u_pr, order_bildung_det) %>%
  mutate(ausbildung_5cat=case_when(ausbildung_3cat=="Ohne nachobligatorische Ausbildung"~ "Ohne nachobligatorische Ausbildung",
                                   TRUE ~ ausbildung_5cat)) %>%
  filter(ausbildung_5cat!="Total") %>%
  type.convert(as.is = TRUE)

tab_bildung_sex <- data_bildung_sex %>%
  rename(ausbildung_3cat=HIGHESTCOMPLEDUAGGI,
         ausbildung_5cat=HIGHESTCOMPLEDUAGGIII,
         anteil=prop,
         sex=SEX) %>%
  mutate(ausbildung_5cat=case_when(ausbildung_3cat=="Ohne nachobligatorische Ausbildung"~ "Ohne nachobligatorische Ausbildung",
                                   TRUE ~ ausbildung_5cat)) %>%
  dplyr::select(ausbildung_3cat, ausbildung_5cat, anteil, ci_l_pr, ci_u_pr, order_bildung_det, sex) %>%
  filter(sex!="Total" & ausbildung_5cat!="Total") %>%
  type.convert(as.is = TRUE)

tab_bildung_sex_full <- data_bildung_sex %>%
  rename(ausbildung_3cat=HIGHESTCOMPLEDUAGGI,
         ausbildung_5cat=HIGHESTCOMPLEDUAGGIII,
         anteil=prop,
         sex=SEX) %>%
  mutate(ausbildung_5cat=case_when(ausbildung_3cat=="Ohne nachobligatorische Ausbildung"~ "Ohne nachobligatorische Ausbildung",
                                   TRUE ~ ausbildung_5cat)) %>%
  dplyr::select(ausbildung_3cat, ausbildung_5cat, anteil, ci_l_pr, ci_u_pr, order_bildung_det, sex) %>%
  filter(ausbildung_5cat!="Total") %>%
  type.convert(as.is = TRUE)


# Beispieldaten: Zeitreihe mit Vertrauensintervallen
tab_erwerbsquote <- data_erwerbsquote

########################################################################################################
### Balkendiagramme
# Einfaches Balkendiagramm mit einfacher Funktion
ggplot_bar(data = tab_bev %>% mutate(jahr=as.character(jahr)), y = "n", x = "jahr",
           title = "Bevölkerung wird älter", subtitle = "Kanton Thurgau, Ständige Wohnbevölkerung nach Altersklassen, 2015-2025",
           source = "Kantonale Bevölkerungsstatistik", fill_color = 2, border_color = 2)

# Mit Highlight-Farbe für ein Jahr
ggplot_bar(data=tab_bev %>% mutate(jahr=as.character(jahr)),
           x = "jahr", y = "n",
           title = "Bevölkerung wird älter", subtitle = "Kanton Thurgau, Ständige Wohnbevölkerung nach Altersklassen, 2015-2025",
           source = "Kantonale Bevölkerungsstatistik",
           fill_colors = c(
             "2015" = "#bebebe",
             "2016" = "#bebebe",
             "2017" = "#bebebe",
             "2018" = "#bebebe",
             "2019" = "#bebebe",
             "2020" = "#bebebe",
             "2021" = "#0355ac",
             "2022" = "#bebebe",
             "2023" = "#bebebe",
             "2024" = "#bebebe",
             "2025" = "#bebebe"
           ),
           border_colors = c(
             "2015" = "#989898",
             "2016" = "#989898",
             "2017" = "#989898",
             "2018" = "#989898",
             "2019" = "#989898",
             "2020" = "#989898",
             "2021" = "#02448a",
             "2022" = "#989898",
             "2023" = "#989898",
             "2024" = "#989898",
             "2025" = "#989898"
           )
)

# Einfaches Balkendiagramm mit der erweiterten Funktion
ggplot_bar_full(data = tab_bev %>% mutate(jahr=as.character(jahr)), y = "n", x = "jahr",
           title = "Bevölkerung wird älter", subtitle = "Kanton Thurgau, Ständige Wohnbevölkerung nach Altersklassen, 2015-2025",
           source = "Kantonale Bevölkerungsstatistik", fill_color = 1, border_color = 1)

# Balkendiagramm mit Auswahl zwischen gruppiert und gestapelt
# Gestapelt mit Labels
ggplot_bar_full(
  data = tab_alterskat %>% filter(alterskat_det=="25-39"),
  y = "n",
  x = "jahr",
  fill = NULL,
  color = NULL,
  fill_colors = 3,
  border_colors = 1,
  # position = "stack",
  labels = TRUE
)

# Gruppiert mit Hauptfarben
ggplot_bar_full(
  data = tab_alterskat,
  y = "n",
  x = "jahr",
  fill = "alterskat_det",
  fill_palette = maincolors_discrete,
  fill_palette_name = "fillColor",
  border_palette = border_discrete,
  border_palette_name = "borderColor",
  position = "dodge"
)

# Gestapeltes Balkendiagramme mit weiteren Farben
ggplot_bar_full(
  data = tab_alterskat,
  y = "n",
  x = "jahr",
  fill = "alterskat_det",
  fill_colors = c(
    "unter 25" = "#bebebe",
    "25-39" = "#bebebe",
    "40-64" = "#1D6AA2",
    "65-75" = "#bebebe",
    "über 75" = "#bebebe"
  ),
  border_colors = c(
    "unter 25" = "#989898",
    "25-39" = "#989898",
    "40-64" = "#175582",
    "65-75" = "#989898",
    "über 75" = "#989898"
  )
)
# Gestapeltes Balkendiagramm
# ggplot_stacked_bar(data = tab_alterskat %>% mutate(jahr=as.character(jahr)), y = "jahr", x = "n", fill = "alterskat_det", colour = "alterskat_det",
#                    title = "Bevölkerung wird älter", subtitle = "Kanton Thurgau, Ständige Wohnbevölkerung nach Altersklassen, 2015-2025",
#                    source = "Kantonale Bevölkerungsstatistik", order_by = "order", decreasing = FALSE,
#                    reverse_fill = TRUE, reverse_color = TRUE)
#
#
# Gruppiertes Balkendiagramm mit Hauptfarben
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


# Gruppierte Balkendiagramm mit Option zu Auswahl der Palette
# ggplot_grouped_bar_palette(
#   data = tab_alterskat %>% mutate(jahr=as.character(jahr)),
#   x = "jahr",
#   y = "n",
#   fill = "alterskat_det",
#   color = "alterskat_det",
#   order = "order",
#   fill_palette = colors_sequential,
#   fill_palette_name = "fillSeq5",
#   border_palette = border_sequential,
#   border_palette_name = "borderSeq5",
#   title = "Bevölkerung wird älter", subtitle = "Kanton Thurgau, Ständige Wohnbevölkerung nach Altersklassen, 2015-2025",
#   source = "Kantonale Bevölkerungsstatistik"
# )

# Balkendiagramm mit Vertrauensintervallen
ggplot_bar_vi(
  data = tab_bildung_tot,
  y = "ausbildung_5cat",
  x = "anteil",
  ci_lower = "ci_l_pr",
  ci_upper = "ci_u_pr",
  title = "Bevölkerung wird älter",
  subtitle = "Kanton Thurgau, Ständige Wohnbevölkerung nach Altersklassen, 2015–2025",
  source = "Kantonale Bevölkerungsstatistik",
  fill_color = 2,
  border_color = 2,
  y_label_wrap = 20
)

# Balkendiagramm mit gruppierten Balken und Vertrauensintervallen
ggplot_bar_vi(
  data = tab_bildung_sex_full %>% filter(sex!="Total"),
  y = "ausbildung_5cat",
  x = "anteil",
  group = "sex",
  ci_lower = "ci_l_pr",
  ci_upper = "ci_u_pr",
  title = "Bildung nach Geschlecht",
  subtitle = "Kanton Thurgau",
  source = "Kantonale Bevölkerungsstatistik",
  fill_palette = colors_gender,
  fill_palette_name = "fillColor",
  border_palette = border_gender,
  border_palette_name = "borderColor",
  y_label_wrap = 20
)

#######################################################################################
### Säulendiagramme
# Einfaches Säulendiagramm
# ggplot_column(data = tab_bev,
#               x = "jahr",
#               y = "n",
#               title = "TITEL",
#               subtitle = "UNTERTITEL",
#               source = "Kantonale Bevölkerungsstatistik",
#               fill_color = 1,
#               border_color = 1)

# Gestapeltes Säulendiagramm
ggplot_stacked_column(
  data = tab_alterskat_3cat %>% mutate(jahr=as.character(jahr)),
  x = "jahr",
  y = "n",
  fill = "alterskat",
  color = "alterskat",
  title = "TITEL",
  subtitle = "UNTERTITEL",
  source = "Kantonale Bevölkerungsstatistik"
)


# Gruppiertes Säulendiagramm
ggplot_grouped_column(
  data = tab_alterskat %>% mutate(jahr=as.character(jahr)),
  x = "jahr",
  y = "n",
  fill = "alterskat_det",
  color = "alterskat_det",
  title = "TITEL",
  subtitle = "UNTERTITEL",
  source = "Kantonale Bevölkerungsstatistik"
)

# Umfängliche Funktion für Säulendiagramme - einfach, gestapelt oder gruppiert, mit ohne ohne Labels
ggplot_column_full(
  data = tab_bev,
  y = "n",
  x = "jahr",
  title = "TITEL",
  subtitle = "UNTERTITEL",
  source = "Kantonale Bevölkerungserhebung",
  labels = TRUE,
  label_color = "white",
  label_angle = 90,
  label_hjust = 1.5,
  label_vjust = 0.5
)

ggplot_column_full(
  data = tab_alterskat,
  y = "n",
  x = "jahr",
  fill = "alterskat_det",
  color = "alterskat_det",
  fill_palette = colors_sequential,
  fill_palette_name = "fillSeq5",
  border_palette = border_sequential,
  border_palette_name = "borderSeq5",
  position = "stack",
  labels = TRUE
)

ggplot_column_full(
  data = tab_alterskat,
  y = "n",
  x = "jahr",
  fill = "alterskat_det",
  color = "alterskat_det",
  fill_palette = colors_sequential,
  fill_palette_name = "fillSeq5",
  border_palette = border_sequential,
  border_palette_name = "borderSeq5",
  position = "dodge"
)

# Säulendiagramm mit Vertrauensintervallen
ggplot_column_vi(
  data = tab_bildung_tot,
  y = "ausbildung_5cat",
  x = "anteil",
  ci_lower = "ci_l_pr",
  ci_upper = "ci_u_pr",
  title = "Bevölkerung wird älter",
  subtitle = "Kanton Thurgau, Ständige Wohnbevölkerung nach Altersklassen, 2015-2025",
  source = "Kantonale Bevölkerungsstatistik",
  fill_color = 2,
  border_color = 2,
  y_label_wrap = 20
)

# Säulendigramm mit gruppierten Balken und Vertrauensintervallen
ggplot_column_vi(
  data = tab_bildung_sex_full, #%>% filter(sex!="Total"),
  y = "ausbildung_5cat",
  x = "anteil",
  group = "sex",
  ci_lower = "ci_l_pr",
  ci_upper = "ci_u_pr",
  title = "Bildung nach Geschlecht",
  subtitle = "Kanton Thurgau",
  source = "Kantonale Bevölkerungsstatistik",
  fill_palette = maincolors_discrete,
  fill_palette_name = "fillColor",
  border_palette = border_discrete,
  border_palette_name = "borderColor",
  y_label_wrap = 20
)

#######################################################################################
### Liniengrafiken
# Liniengrafik mit einer Linie
ggplot_line_full(
  data = tab_bev,
  x = "jahr",
  y = "n",
  line_color = 1,
  title = "Bevölkerung",
  subtitle = "Entwicklung über die Zeit",
  source = "Kantonale Bevölkerungserhebung"
)

# Liniengrafik mit unterschiedlichen Kategorien
ggplot_line_full(
  data = tab_bev,
  x = "jahr",
  y = "n",
  line_color = 1,
  title = "Bevölkerung",
  subtitle = "Entwicklung über die Zeit",
  source = "Kantonale Bevölkerungserhebung",
  y_min = 0,
  y_max = 350000,
  theme = theme_opts_line_minor_grid
)

# Liniengrafik mit unterschiedlichen Kategorien und Labels
ggplot_line_full(
  data = tab_alterskat,
  x = "jahr",
  y = "n",
  order = "order",
  group = "alterskat_det",
  line_labels = TRUE,
  line_label_size = 4,
  line_label_nudge_x = 0.2,
  group_palette = colors_sequential,
  group_palette_name = "fillSeq5",
  title = "Bevölkerung nach Alterskategorie",
  subtitle = "Entwicklung über die Zeit",
  source = "Kantonale Bevölkerungserhebung",

)

# Liniengrafik mit Vertrauensintervallen
ggplot_line_vi(
  data = tab_erwerbsquote %>%
    dplyr::mutate(jahr = as.character(jahr)) %>% filter(sex!="Total"),
  x = "jahr",
  y = "anteil",
  group = "sex",

  group_palette = colors_gender,
  group_palette_name = "fillColor",

  title = "Bevölkerung",
  subtitle = "Entwicklung über die Zeit",
  source = "Kantonale Bevölkerungserhebung",

  ci_lower = "ci_l_pr",
  ci_upper = "ci_u_pr",

  ribbon_alpha = 0.30
)

# Liniengrafik mit Vertrauensintervallen und Labels
ggplot_line_vi(
  data = tab_erwerbsquote %>%
    dplyr::mutate(jahr = as.character(jahr)) %>% filter(sex!="Total"),
  x = "jahr",
  y = "anteil",
  group = "sex",

  group_palette = colors_gender,
  group_palette_name = "fillColor",

  title = "Bevölkerung",
  subtitle = "Entwicklung über die Zeit",
  source = "Kantonale Bevölkerungserhebung",

  ci_lower = "ci_l_pr",
  ci_upper = "ci_u_pr",

  ribbon_alpha = 0.30,
  line_labels = TRUE
)

#######################################################################################
### Donut-Grafiken
# Einfache Donut-Grafik mit Hauptfarben
ggplot_donut_full(data = tab_alterskat,
                  filter_value = "2025",
                  x = "jahr",
                  y = "n",
                  fill_cat = "alterskat_det",
                  title = "TITEL",
                  subtitle = "Untertitel",
                  hsize = 1,
                  # start_angle = 0,
                  order = "order",
                  source = "Kantonale Bevölkerungsstatistik")

# Einfache Donut-Grafik mit sequentieller Farbpalette
ggplot_donut_full(data = tab_alterskat,
             filter_value = "2025",
             x = "jahr",
             y = "n",
             fill_cat = "alterskat_det",
             title = "TITEL",
             subtitle = "Untertitel",
             hsize = 1,
             palette = colors_sequential,
             palette_name = "fillSeq5",
             source = "Kantonale Bevölkerungsstatistik")

# Einfache Donut-Grafik mit Highlightfarbe für Hauptkategorie und Grautönen für übrige Kategorien
ggplot_donut_full(data = tab_alterskat,
             filter_value = "2025",
             x = "jahr",
             y = "n",
             order = "order",
             start_category = "unter 25",
             fill_cat = "alterskat_det",
             title = "TITEL",
             subtitle = "Untertitel",
             hsize = 1,
             palette = maincolors_discrete,
             palette_name = "fillBlueGreys",
             source = "Kantonale Bevölkerungsstatistik")


#######################################################################################
### Karten auf Ebene Gemeinden
# Karte für kategorische Variablen mit divergierender Farbpalette
ggplot_map(
  data = tab_steuerfuss,
  # var_gemeinde = "gemeinde",
  # var_bfs = "bfs_nr",
  var_value = "gemeindesteuerfuss",
  label_value = "Gemeindesteuerfuss in %",
  palette = colors_divergent,
  palette_name = "fillDiv5",
  category_labels = c(
    "30-39 %",
    "40–49 %",
    "50–59 %",
    "60–69 %",
    "70–72 %"
  ),
  title = "Wenige Steuerfüsse über 70 %",
  subtitle = "Kanton Thurgau, 2026, Gemeindesteuerfüsse nach Kategorien",
  source = "Steuerverwaltung Thurgau"
)

# Karte für kategorische Variablen mit sequentieller Farbpalette
ggplot_map(
  data = tab_steuerfuss,
  var_gemeinde = "gemeinde",
  var_value = "gemeindesteuerfuss",
  label_value = "Gemeindesteuerfuss in %",
  palette = colors_sequential,
  palette_name = "fillSeq5",
  category_labels = c(
    "30-39 %",
    "40–49 %",
    "50–59 %",
    "60–69 %",
    "70–72 %"
  ),
  source = "Steuerverwaltung Thurgau"

)

# Karte für kategorische Variablen drei Kategorien und Hauptfarben
ggplot_map(data = tab_prop_ev,
           # var_gemeinde = "gemeinde_name",
           # var_bfs = "bfs_nr_gemeinde",
           var_value = "proportion",
           label_value = "Anteil Evangelisch-reformiert",
           category_labels = c(
             "Anteil unter 20 %",
             "Anteil zw. 20 und 35 %",
             "Anteil über 35 %"
           ),
           source = "Kantonale Bevölkerungsstatistik",
           legend_ncol = 1

)

#######################################################################################
### Area-Grafik
# Area-Chart mit sequentieller Farbpalette
ggplot_area_full(
  data = tab_alterskat,
  x = "jahr",
  y = "n",
  order = "order",
  group = "alterskat_det",
  area_labels = TRUE,
  area_label_size = 4,
  area_label_nudge_x = 0.2,
  group_palette = colors_sequential,
  group_palette_name = "fillSeq5",
  border_palette = border_sequential,
  border_palette_name = "borderSeq5",
  title = "Bevölkerung nach Alterskategorie",
  subtitle = "Entwicklung über die Zeit",
  source = "Kantonale Bevölkerungserhebung",

)

# Area-Chart mit Hauptfarben
ggplot_area_full(
  data = tab_alterskat,
  x = "jahr",
  y = "n",
  order = "order",
  group = "alterskat_det",
  area_labels = TRUE,
  area_label_size = 4,
  area_label_nudge_x = 0.2,
  group_palette = maincolors_discrete,
  group_palette_name = "fillColor",
  title = "Bevölkerung nach Alterskategorie",
  subtitle = "Entwicklung über die Zeit",
  source = "Kantonale Bevölkerungserhebung",

)

#######################################################################################
### Dubmbell-Grafik
# Dubmbell-Chart ohne Labels
ggplot_dumbbell(
  data = tab_steuerfuss_change_long,
  x = "gemeindesteuerfuss",
  y = "gemeinde_name",
  x_min = "2025",
  x_max = "2026",
  source = "Steuerverwaltung Thurgau",
  title = "Steuerfuss der Gemeinden",
  subtitle = "Veränderung zwischen 2025 und 2026"
)

# Dubmbell-Chart mit schwarzen Labels
ggplot_dumbbell(
  data = tab_steuerfuss_change_long,
  x = "gemeindesteuerfuss",
  y = "gemeinde_name",
  x_min = "2025",
  x_max = "2026",
  source = "Steuerverwaltung Thurgau",
  title = "Steuerfuss der Gemeinden",
  subtitle = "Veränderung zwischen 2025 und 2026",
  label = "gemeindesteuerfuss"
)

# Dubmbell-Chart mit farbigen Labels
ggplot_dumbbell(
  data = tab_steuerfuss_change_long,
  x = "gemeindesteuerfuss",
  y = "gemeinde_name",
  x_min = "2025",
  x_max = "2026",
  source = "Steuerverwaltung Thurgau",
  title = "Steuerfuss der Gemeinden",
  subtitle = "Veränderung zwischen 2025 und 2026",
  label = "gemeindesteuerfuss",
  label_colour = "point",
  label_size = 4
)

#######################################################################################
### Lollipop-Grafik
# Lollipop-Chart ohne Labels
ggplot_lollipop(data = tab_steuerfuss_aktuell,
                x = "gemeinde_name",
                y = "gemeindesteuerfuss",
                title = "TITEL",
                subtitle = "UNTERTITEL",
                source = "Steuerverwaltung Thurgau",
                size_point = 6,
                fill_palette = maincolors_discrete,
                fill_palette_name = "fillColor",
                fill_colors = 2,
                border_palette = border_discrete,
                border_palette_name = "borderColor",
                border_colors = 2)

ggplot_lollipop(data = tab_steuerfuss_aktuell,
                x = "gemeinde_name",
                y = "gemeindesteuerfuss",
                title = "TITEL",
                subtitle = "UNTERTITEL",
                source = "Steuerverwaltung Thurgau",
                size_point = 6,
                fill_palette = maincolors_discrete,
                fill_palette_name = "fillColor",
                fill_colors = 1,
                border_palette = border_discrete,
                border_palette_name = "borderColor",
                border_colors = 1,
                label = TRUE,
                label_colour = "point",
                label_size = 4)

