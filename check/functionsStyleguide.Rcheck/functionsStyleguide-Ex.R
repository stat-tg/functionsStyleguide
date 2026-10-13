pkgname <- "functionsStyleguide"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
base::assign(".ExTimings", "functionsStyleguide-Ex.timings", pos = 'CheckExEnv')
base::cat("name\tuser\tsystem\telapsed\n", file=base::get(".ExTimings", pos = 'CheckExEnv'))
base::assign(".format_ptime",
function(x) {
  if(!is.na(x[4L])) x[1L] <- x[1L] + x[4L]
  if(!is.na(x[5L])) x[2L] <- x[2L] + x[5L]
  options(OutDec = '.')
  format(x[1L:3L], digits = 7L)
},
pos = 'CheckExEnv')

### * </HEADER>
library('functionsStyleguide')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("ggplot_bar")
### * ggplot_bar

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: ggplot_bar
### Title: Einfache Balkengrafik
### Aliases: ggplot_bar

### ** Examples

## Not run: 
##D # Use the default fill and border colours
##D ggplot_bar(
##D   data = tab_bev,
##D   x = "jahr",
##D   y = "n",
##D   title = "Bevölkerungsentwicklung"
##D )
##D 
##D # Specify individual fill and border colours
##D ggplot_bar(
##D   data = tab_bev,
##D   x = "jahr",
##D   y = "n",
##D   fill_colors = c(
##D     "2019" = "#4477AA",
##D     "2020" = "#EE6677",
##D     "2021" = "#228833"
##D   ),
##D   border_colors = c(
##D     "2019" = "#222222",
##D     "2020" = "#222222",
##D     "2021" = "#555555"
##D   )
##D )
## End(Not run)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("ggplot_bar", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("ggplot_bar_full")
### * ggplot_bar_full

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: ggplot_bar_full
### Title: Vollständiges horizontales Balkendiagramm erstellen
### Aliases: ggplot_bar_full

### ** Examples

## Not run: 
##D # Einfaches Balkendiagramm
##D ggplot_bar_full(
##D   data = tab_bev,
##D   y = "n",
##D   x = "jahr",
##D   title = "Bevölkerungsentwicklung",
##D   subtitle = "Bevölkerung nach Jahr",
##D   source = "Kantonale Bevölkerungserhebung",
##D   labels = TRUE
##D )
##D 
##D # Gestapelte Balken nach Alterskategorie
##D ggplot_bar_full(
##D   data = tab_alterskat,
##D   y = "n",
##D   x = "jahr",
##D   fill = "alterskat_det",
##D   fill_palette = colors_sequential,
##D   fill_palette_name = "fillSeq5",
##D   position = "stack",
##D   labels = TRUE
##D )
##D 
##D # Gruppierte Balken nach Alterskategorie
##D ggplot_bar_full(
##D   data = tab_alterskat,
##D   y = "n",
##D   x = "jahr",
##D   fill = "alterskat_det",
##D   fill_palette = colors_sequential,
##D   fill_palette_name = "fillSeq5",
##D   position = "dodge"
##D )
## End(Not run)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("ggplot_bar_full", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("ggplot_bar_vi")
### * ggplot_bar_vi

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: ggplot_bar_vi
### Title: Balkengrafik mit Vertrauensintervallen
### Aliases: ggplot_bar_vi

### ** Examples

## Not run: 
##D # Horizontales Balkendiagramm mit Konfidenzintervallen
##D ggplot_bar_vi(
##D   data = tab_bildung_tot,
##D   y = "ausbildung_5cat",
##D   x = "anteil",
##D   ci_lower = "ci_l_pr",
##D   ci_upper = "ci_u_pr",
##D   title = "Bildung nach Ausbildungsstufe",
##D   source = "Kantonale Bevölkerungsstatistik",
##D   fill_color = 2,
##D   border_color = 2,
##D   y_label_wrap = 20
##D )
##D 
##D # Grouped horizontal bars by sex
##D ggplot_bar_vi(
##D   data = tab_bildung_sex_full,
##D   y = "ausbildung_5cat",
##D   x = "anteil",
##D   group = "sex",
##D   ci_lower = "ci_l_pr",
##D   ci_upper = "ci_u_pr",
##D   title = "Bildung nach Geschlecht",
##D   subtitle = "Kanton Thurgau",
##D   source = "Kantonale Bevölkerungsstatistik",
##D   y_label_wrap = 20
##D )
## End(Not run)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("ggplot_bar_vi", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("ggplot_column")
### * ggplot_column

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: ggplot_column
### Title: Säulendiagramm erstellen
### Aliases: ggplot_column

### ** Examples

## Not run: 
##D # Einfaches Säulendiagramm
##D ggplot_column(
##D   data = tab_bev |> dplyr::mutate(jahr = as.character(jahr)),
##D   x = "jahr",
##D   y = "n",
##D   title = "Bevölkerungsentwicklung",
##D   subtitle = "Bevölkerung nach Jahr",
##D   source = "Kantonale Bevölkerungsstatistik",
##D   fill_color = 1,
##D   border_color = 1
##D )
## End(Not run)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("ggplot_column", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("ggplot_column_full")
### * ggplot_column_full

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: ggplot_column_full
### Title: Säulendiagramm mit optionaler Gruppierung und Beschriftung
###   erstellen
### Aliases: ggplot_column_full

### ** Examples

## Not run: 
##D # Einfaches Säulendiagramm mit Wertbeschriftungen
##D ggplot_column_full(
##D   data = tab_bev,
##D   y = "n",
##D   x = "jahr",
##D   title = "Bevölkerungsentwicklung",
##D   source = "Kantonale Bevölkerungsstatistik",
##D   labels = TRUE
##D )
##D 
##D # Gestapeltes Säulendiagramm nach Alterskategorie
##D ggplot_column_full(
##D   data = tab_alterskat,
##D   y = "n",
##D   x = "jahr",
##D   fill = "alterskat_det",
##D   color = "alterskat_det",
##D   fill_palette = colors_sequential,
##D   fill_palette_name = "fillSeq5",
##D   border_palette = border_sequential,
##D   border_palette_name = "borderSeq5",
##D   position = "stack",
##D   labels = TRUE
##D )
## End(Not run)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("ggplot_column_full", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("ggplot_column_vi")
### * ggplot_column_vi

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: ggplot_column_vi
### Title: Horizontales Säulendiagramm mit optionalen Konfidenzintervallen
###   erstellen
### Aliases: ggplot_column_vi

### ** Examples

## Not run: 
##D # Balkendiagramm mit Konfidenzintervallen
##D ggplot_column_vi(
##D   data = tab_bildung_tot,
##D   y = "ausbildung_5cat",
##D   x = "anteil",
##D   ci_lower = "ci_l_pr",
##D   ci_upper = "ci_u_pr",
##D   title = "Bildung in der Bevölkerung",
##D   subtitle = "Kanton Thurgau",
##D   source = "Kantonale Bevölkerungsstatistik",
##D   fill_color = 2,
##D   border_color = 2,
##D   y_label_wrap = 20
##D )
##D 
##D # Gruppierte Balken nach Geschlecht mit Konfidenzintervallen
##D ggplot_column_vi(
##D   data = tab_bildung_sex_full,
##D   y = "ausbildung_5cat",
##D   x = "anteil",
##D   group = "sex",
##D   ci_lower = "ci_l_pr",
##D   ci_upper = "ci_u_pr",
##D   title = "Bildung nach Geschlecht",
##D   subtitle = "Kanton Thurgau",
##D   source = "Kantonale Bevölkerungsstatistik",
##D   y_label_wrap = 20
##D )
## End(Not run)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("ggplot_column_vi", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("ggplot_donut_full")
### * ggplot_donut_full

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: ggplot_donut_full
### Title: Vollständiges Donutdiagramm erstellen
### Aliases: ggplot_donut_full

### ** Examples

## Not run: 
##D # Donutdiagramm für ein bestimmtes Jahr
##D ggplot_donut_full(
##D   data = tab_alterskat,
##D   filter_value = "2025",
##D   x = "jahr",
##D   y = "n",
##D   fill_cat = "alterskat_det",
##D   title = "Bevölkerung nach Alterskategorien",
##D   subtitle = "Kanton Thurgau, 2025",
##D   hsize = 1,
##D   order = "order",
##D   source = "Kantonale Bevölkerungsstatistik"
##D )
##D 
##D # Donutdiagramm mit benutzerdefinierter Farbpalette und Startkategorie
##D ggplot_donut_full(
##D   data = tab_alterskat,
##D   filter_value = "2025",
##D   x = "jahr",
##D   y = "n",
##D   fill_cat = "alterskat_det",
##D   title = "Bevölkerung nach Alterskategorien",
##D   subtitle = "Kanton Thurgau, 2025",
##D   hsize = 1,
##D   order = "order",
##D   start_category = "unter 25",
##D   palette = colors_sequential,
##D   palette_name = "fillSeq5",
##D   source = "Kantonale Bevölkerungsstatistik"
##D )
## End(Not run)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("ggplot_donut_full", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("ggplot_dumbbell")
### * ggplot_dumbbell

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: ggplot_dumbbell
### Title: Dumbbell-Diagramm zum Vergleich zweier Zeitpunkte erstellen
### Aliases: ggplot_dumbbell

### ** Examples

## Not run: 
##D ggplot_dumbbell(
##D   data = tab_steuerfuss_change_long,
##D   x = "gemeindesteuerfuss",
##D   y = "gemeinde_name",
##D   x_min = "2025",
##D   x_max = "2026",
##D   source = "Steuerverwaltung Thurgau",
##D   title = "Steuerfuss der Gemeinden",
##D   subtitle = "Veränderung zwischen 2025 und 2026",
##D   label = "gemeindesteuerfuss",
##D   label_colour = "point",
##D   label_size = 4
##D )
## End(Not run)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("ggplot_dumbbell", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("ggplot_grouped_bar_palette")
### * ggplot_grouped_bar_palette

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: ggplot_grouped_bar_palette
### Title: Gruppiertes oder gestapeltes Balkendiagramm mit
###   benutzerdefinierten Farben erstellen
### Aliases: ggplot_grouped_bar_palette

### ** Examples

## Not run: 
##D ggplot_grouped_bar_palette(
##D   data = tab_alterskat |>
##D     dplyr::mutate(jahr = as.character(jahr)),
##D   x = "jahr",
##D   y = "n",
##D   fill = "alterskat_det",
##D   color = "alterskat_det",
##D   order = "order",
##D   fill_palette = colors_sequential,
##D   fill_palette_name = "fillSeq5",
##D   border_palette = border_sequential,
##D   border_palette_name = "borderSeq5",
##D   title = "Bevölkerung wird älter",
##D   subtitle = paste(
##D     "Kanton Thurgau, Ständige Wohnbevölkerung",
##D     "nach Altersklassen, 2015–2025"
##D   ),
##D   source = "Kantonale Bevölkerungsstatistik"
##D )
## End(Not run)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("ggplot_grouped_bar_palette", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("ggplot_line_full")
### * ggplot_line_full

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: ggplot_line_full
### Title: Vollständiges Liniendiagramm erstellen
### Aliases: ggplot_line_full

### ** Examples

## Not run: 
##D # Einzelne Linie mit benutzerdefinierter Achsenskalierung
##D ggplot_line_full(
##D   data = tab_bev,
##D   x = "jahr",
##D   y = "n",
##D   line_color = 1,
##D   title = "Bevölkerung",
##D   subtitle = "Entwicklung über die Zeit",
##D   source = "Kantonale Bevölkerungserhebung",
##D   y_min = 0,
##D   y_max = 350000
##D )
##D 
##D # Mehrere Linien mit Beschriftung der Kategorien
##D ggplot_line_full(
##D   data = tab_alterskat,
##D   x = "jahr",
##D   y = "n",
##D   order = "order",
##D   group = "alterskat_det",
##D   line_labels = TRUE,
##D   line_label_size = 4,
##D   line_label_nudge_x = 0.2,
##D   group_palette = colors_sequential,
##D   group_palette_name = "fillSeq5",
##D   title = "Bevölkerung nach Alterskategorie",
##D   subtitle = "Entwicklung über die Zeit",
##D   source = "Kantonale Bevölkerungserhebung"
##D )
## End(Not run)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("ggplot_line_full", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("ggplot_line_vi")
### * ggplot_line_vi

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: ggplot_line_vi
### Title: Liniendiagramm mit Konfidenzintervallen erstellen
### Aliases: ggplot_line_vi

### ** Examples

## Not run: 
##D # Liniendiagramm mit Konfidenzintervallen nach Geschlecht
##D ggplot_line_vi(
##D   data = tab_erwerbsquote |>
##D     dplyr::mutate(jahr = as.character(jahr)) |>
##D     dplyr::filter(sex != "Total"),
##D   x = "jahr",
##D   y = "anteil",
##D   group = "sex",
##D   group_palette = colors_gender,
##D   group_palette_name = "fillColor",
##D   title = "Erwerbsquote nach Geschlecht",
##D   subtitle = "Entwicklung über die Zeit",
##D   source = "Kantonale Bevölkerungserhebung",
##D   ci_lower = "ci_l_pr",
##D   ci_upper = "ci_u_pr",
##D   ribbon_alpha = 0.10
##D )
##D 
##D # Liniendiagramm mit zusätzlichen Linienbeschriftungen
##D ggplot_line_vi(
##D   data = tab_erwerbsquote |>
##D     dplyr::mutate(jahr = as.character(jahr)) |>
##D     dplyr::filter(sex != "Total"),
##D   x = "jahr",
##D   y = "anteil",
##D   group = "sex",
##D   group_palette = colors_gender,
##D   group_palette_name = "fillColor",
##D   title = "Erwerbsquote nach Geschlecht",
##D   subtitle = "Entwicklung über die Zeit",
##D   source = "Kantonale Bevölkerungserhebung",
##D   ci_lower = "ci_l_pr",
##D   ci_upper = "ci_u_pr",
##D   ribbon_alpha = 0.10,
##D   line_labels = TRUE
##D )
## End(Not run)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("ggplot_line_vi", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("ggplot_lollipop")
### * ggplot_lollipop

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: ggplot_lollipop
### Title: Lollipop-Diagramm erstellen
### Aliases: ggplot_lollipop

### ** Examples

## Not run: 
##D ggplot_lollipop(
##D   data = tab_steuerfuss_aktuell,
##D   x = "gemeinde_name",
##D   y = "gemeindesteuerfuss",
##D   title = "Gemeindesteuerfüsse im Vergleich",
##D   subtitle = "Kanton Thurgau",
##D   source = "Steuerverwaltung Thurgau",
##D   size_point = 6,
##D   fill_palette = colors_gender,
##D   fill_palette_name = "fillColor",
##D   fill_colors = 2,
##D   border_palette = border_gender,
##D   border_palette_name = "borderColor",
##D   border_colors = 2,
##D   label = TRUE,
##D   label_colour = "point",
##D   label_size = 4
##D )
## End(Not run)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("ggplot_lollipop", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("ggplot_map")
### * ggplot_map

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: ggplot_map
### Title: Gemeindekarte mit kategorisierten Werten erstellen
### Aliases: ggplot_map

### ** Examples

## Not run: 
##D # Karte der Gemeindesteuerfüsse
##D ggplot_map(
##D   data = tab_steuerfuss,
##D   var_value = "gemeindesteuerfuss",
##D   label_value = "Gemeindesteuerfuss in %",
##D   palette = colors_divergent,
##D   palette_name = "fillDiv5",
##D   category_labels = c(
##D     "30–39 %",
##D     "40–49 %",
##D     "50–59 %",
##D     "60–69 %",
##D     "70–72 %"
##D   ),
##D   title = "Wenige Steuerfüsse über 70 %",
##D   subtitle = paste(
##D     "Kanton Thurgau, 2026,",
##D     "Gemeindesteuerfüsse nach Kategorien"
##D   ),
##D   source = "Steuerverwaltung Thurgau"
##D )
##D 
##D # Karte mit abweichenden Spaltennamen
##D ggplot_map(
##D   data = data_konf,
##D   var_gemeinde = "gemeinde_name",
##D   var_bfs = "bfs_nr_gemeinde",
##D   var_value = "prop_ev",
##D   label_value = "Anteil Evangelisch-reformiert",
##D   category_labels = c(
##D     "unter 10",
##D     "zwischen 10 und 20",
##D     "über 20"
##D   ),
##D   source = "Kantonale Bevölkerungsstatistik"
##D )
## End(Not run)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("ggplot_map", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("ggplot_stacked_bar")
### * ggplot_stacked_bar

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: ggplot_stacked_bar
### Title: Gestapeltes horizontales Balkendiagramm erstellen
### Aliases: ggplot_stacked_bar

### ** Examples

## Not run: 
##D ggplot_stacked_bar(
##D   data = tab_alterskat |>
##D     dplyr::mutate(jahr = as.character(jahr)),
##D   y = "jahr",
##D   x = "n",
##D   fill = "alterskat_det",
##D   colour = "alterskat_det",
##D   title = "Bevölkerung wird älter",
##D   subtitle = paste(
##D     "Kanton Thurgau, Ständige Wohnbevölkerung",
##D     "nach Altersklassen, 2015–2025"
##D   ),
##D   source = "Kantonale Bevölkerungsstatistik",
##D   order_by = "order",
##D   decreasing = TRUE,
##D   reverse_fill = TRUE,
##D   reverse_color = TRUE
##D )
## End(Not run)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("ggplot_stacked_bar", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("ggplot_stacked_column")
### * ggplot_stacked_column

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: ggplot_stacked_column
### Title: Gestapeltes Säulendiagramm erstellen
### Aliases: ggplot_stacked_column

### ** Examples

## Not run: 
##D ggplot_stacked_column(
##D   data = tab_alterskat |>
##D     dplyr::mutate(jahr = as.character(jahr)),
##D   x = "jahr",
##D   y = "n",
##D   fill = "alterskat",
##D   color = "alterskat",
##D   title = "Bevölkerung nach Alterskategorie",
##D   subtitle = "Entwicklung im Zeitverlauf",
##D   source = "Kantonale Bevölkerungsstatistik"
##D )
## End(Not run)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("ggplot_stacked_column", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("map_variable_sf")
### * map_variable_sf

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: map_variable_sf
### Title: Gemeindekarte mit beschrifteten Gemeinden erstellen
### Aliases: map_variable_sf

### ** Examples

## Not run: 
##D # Gemeindekarte mit zweispaltiger Legende
##D map_variable_sf(
##D   gmd_data = gemeinde_sf,
##D   angle_data = angle_data,
##D   legend_ncol = 2
##D )
##D 
##D # Gemeindekarte mit einspaltiger Legende
##D map_variable_sf(
##D   gmd_data = gemeinde_sf,
##D   angle_data = angle_data,
##D   legend_ncol = 1
##D )
## End(Not run)




base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("map_variable_sf", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("styleguide_palettes")
### * styleguide_palettes

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: styleguide_palettes
### Title: Styleguide palettes
### Aliases: styleguide_palettes maincolors_discrete border_discrete
###   colors_divergent border_divergent colors_sequential border_sequential
###   colors_gender border_gender colors_regions border_regions
###   party_colors
### Keywords: datasets

### ** Examples

# Get all palettes by name.
names(styleguide_palettes)

# Plot all palettes.
plot(styleguide_palettes)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("styleguide_palettes", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
