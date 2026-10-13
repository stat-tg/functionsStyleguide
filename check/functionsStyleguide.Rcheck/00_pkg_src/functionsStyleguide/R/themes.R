# Definitionen für die Gestaltung der Grafiken (Hintergrund, Gridlines etc.)

##########################
## Definition Hintergrund
library(ggplot2)
# Weisser Hintergrund, graue horizontale Gridline für Hauptskala, schwarze Achsen
theme_grid_horizontal <- list(theme(panel.grid.minor.x = element_line(color = "transparent"),
                            panel.grid.major.x = element_line(color = "transparent"),
                            panel.grid.minor = element_line(color = "transparent"),
                            panel.grid.major = element_line(color = "grey"),
                            panel.background = element_blank(),
                            plot.background = element_rect(),
                            panel.border = element_blank(),
                            axis.line = element_line(colour = "black")))


# Weisser Hintergrund, graue vertikale Gridline für Hauptskala, schwarze Achsen
theme_grid_vertical <- list(theme(panel.grid.minor.x = element_line(color = "transparent"),
                                panel.grid.major.x = element_line(color = "grey"),
                                panel.grid.minor = element_line(color = "transparent"),
                                panel.grid.major = element_line(color = "transparent"),
                                panel.background = element_blank(),
                                plot.background = element_rect(),
                                panel.border = element_blank(),
                                axis.line = element_line(colour = "black")))


# Weisser Hintergrund, graue vertikale Gridline für Hauptskala, eingefärbte x-Achse für Balkendiagramme
theme_bar_grid_vertical <- list(theme(panel.grid.minor.x = element_line(color = "transparent"),
                                  panel.grid.major.x = element_line(color = "grey"),
                                  panel.grid.minor = element_line(color = "transparent"),
                                  panel.grid.major = element_line(color = "transparent"),
                                  panel.background = element_blank(),
                                  plot.background = element_rect(),
                                  panel.border = element_blank(),
                                  axis.ticks = element_blank(),
                                  axis.line.y = element_line(colour = "grey"),
                                  axis.line.x = element_line(colour = "transparent"),
                                  legend.title = element_blank(),
                                  legend.position="top",
                                  legend.justification="left",
                                  legend.direction="horizontal",
                                  plot.caption = element_text(hjust = 0, vjust=-2))
)

# Weisser Hintergrund, graue vertikale Gridline für Hauptskala, eingefärbte x-Achse für Balkendiagramme
theme_lollipop_grid_vertical <- list(theme(panel.grid.minor.x = element_line(color = "transparent"),
                                      panel.grid.major.x = element_line(color = "grey"),
                                      panel.grid.minor = element_line(color = "transparent"),
                                      panel.grid.major = element_line(color = "transparent"),
                                      panel.background = element_blank(),
                                      plot.background = element_rect(),
                                      panel.border = element_blank(),
                                      axis.ticks = element_blank(),
                                      axis.line.y = element_line(colour = "grey"),
                                      axis.line.x = element_line(colour = "transparent"),
                                      legend.title = element_blank(),
                                      legend.position="top",
                                      legend.justification="left",
                                      legend.direction="horizontal",
                                      plot.caption = element_text(hjust = 0, vjust=-2))
)

# Weisser Hintergrund, graue horizontalen Gridline für Hauptskala, eingefärbte x-Achse für Balkendiagramme
theme_bar_grid_horizontal <- list(theme(panel.grid.minor.x = element_line(color = "transparent"),
                                      panel.grid.major.x = element_line(color = "transparent"),
                                      panel.grid.minor = element_line(color = "transparent"),
                                      panel.grid.major = element_line(color = "grey"),
                                      panel.background = element_blank(),
                                      plot.background = element_rect(),
                                      panel.border = element_blank(),
                                      axis.ticks = element_blank(),
                                      axis.line.y = element_line(colour = "grey"),
                                      axis.line.x = element_line(colour = "transparent"),
                                      legend.title = element_blank(),
                                      legend.position="top",
                                      legend.justification="left",
                                      legend.direction="horizontal",
                                      plot.caption = element_text(hjust = 0, vjust=-1))
)

# Weisser Hintergrund, nur Legende
theme_opts_map <- list(theme(panel.grid.minor = element_blank(),
                             panel.grid.major = element_blank(),
                             panel.background = element_blank(),
                             plot.background = element_rect(),
                             panel.border = element_blank(),
                             axis.line = element_blank(),
                             axis.text.x = element_blank(),
                             axis.text.y = element_blank(),
                             axis.ticks = element_blank(),
                             axis.title.x = element_blank(),
                             axis.title.y = element_blank(),
                             plot.caption = element_text(hjust = 0)))

# Weisser Hintergrund, keine Gridlines und keine Achsen
theme_opts_transparent <- list(theme(panel.grid.minor.x = element_line(color = "transparent"),
                                         panel.grid.major.x = element_line(color = "transparent"),
                                         panel.grid.minor = element_line(color = "transparent"),
                                         panel.grid.major = element_line(color = "transparent"),
                                         panel.background = element_blank(),
                                         axis.text.x = element_blank(),
                                         axis.text.y=element_text(size=11),
                                         plot.background = element_rect(),
                                         panel.border = element_blank(),
                                         axis.line = element_line(colour = "transparent"),
                                         axis.ticks = element_blank()))

# Weisser Hintergrund, keine Gridlines, schwarze Achsen
theme_opts_bar <- list(theme(panel.grid.minor.x = element_line(color = "transparent"),
                             panel.grid.major.x = element_line(color = "transparent"),
                             panel.grid.minor = element_line(color = "transparent"),
                             panel.grid.major = element_line(color = "transparent"),
                             panel.background = element_blank(),
                             plot.background = element_rect(),
                             panel.border = element_blank(),
                             axis.line = element_line(colour = "black")))



# Weisser Hintergrund, keine Gridlines, keine Achsen, mit Achsenbeschriftung und Tick-Beschriftungen
theme_opts_line <- list(theme(panel.grid.minor.x = element_line(color = "transparent"),
                              panel.grid.major.x = element_line(color = "transparent"),
                              panel.grid.minor.y = element_line(color = "transparent"),
                              panel.grid.major.y = element_line(color = "grey"),
                              panel.background = element_blank(),
                              plot.background = element_rect(),
                              panel.border = element_blank(),
                              axis.line.x = element_line(colour = "black"),
                              axis.line.y = element_line(colour = "white"),
                              axis.ticks = element_line(color = "white"),
                              legend.title = element_blank(),
                              legend.position="top",
                              legend.justification="left",
                              legend.direction="horizontal",
                              plot.caption = element_text(hjust = 0, vjust=-1)))


# Weisser Hintergrund, keine Gridlines, keine Achsen, mit Achsenbeschriftung und Tick-Beschriftungen und minor gridlines
theme_opts_line_minor_grid <- list(theme(panel.grid.minor.x = element_line(color = "transparent"),
                              panel.grid.major.x = element_line(color = "transparent"),
                              panel.grid.minor.y = element_line(color = "grey"),
                              panel.grid.major.y = element_line(color = "grey"),
                              panel.background = element_blank(),
                              plot.background = element_rect(),
                              panel.border = element_blank(),
                              axis.line.x = element_line(colour = "black"),
                              axis.line.y = element_line(colour = "white"),
                              axis.ticks = element_line(color = "white"),
                              legend.title = element_blank(),
                              legend.position="top",
                              legend.justification="left",
                              legend.direction="horizontal",
                              plot.caption = element_text(hjust = 0, vjust=-1)))

# Weisser Hintergrund, keine Gridlines, keine Achsen, mit Achsenbeschriftung und Tick-Beschriftungen
theme_opts_area <- list(theme(panel.grid.minor.x = element_line(color = "transparent"),
                              panel.grid.major.x = element_line(color = "transparent"),
                              panel.grid.minor.y = element_line(color = "transparent"),
                              panel.grid.major.y = element_line(color = "grey"),
                              panel.background = element_blank(),
                              plot.background = element_rect(),
                              panel.border = element_blank(),
                              axis.line.x = element_line(colour = "black"),
                              axis.line.y = element_line(colour = "white"),
                              axis.ticks = element_line(color = "white"),
                              legend.title = element_blank(),
                              legend.position="top",
                              legend.justification="left",
                              legend.direction="horizontal",
                              plot.caption = element_text(hjust = 0, vjust=-1)))

# Weisser Hintergrund
theme_opts_map <- list(theme(panel.grid.minor = element_blank(),
                             panel.grid.major = element_blank(),
                             panel.background = element_blank(),
                             plot.background = element_rect(),
                             panel.border = element_blank(),
                             axis.line = element_blank(),
                             axis.text.x = element_blank(),
                             axis.text.y = element_blank(),
                             axis.ticks = element_blank(),
                             axis.title.x = element_blank(),
                             axis.title.y = element_blank(),
                             legend.title = element_blank(),
                             legend.position="top",
                             legend.justification="left",
                             legend.direction="horizontal",
                             plot.caption = element_text(hjust = 0, vjust=-1)))
