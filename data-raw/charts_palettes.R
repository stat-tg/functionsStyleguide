library(palettes)

# Fill: Discrete palettes with main colors -----------------------------------------------------------
maincolors_discrete <- pal_palette(
  fillColor = c("#1D6AA2", "#ADD9A1", "#F5A951", "#A73559","#96C2E8","#5399A0","#727272"),
  fillHighlight = c("#0355ac", "#87bf77", "#f28f1c", "#c4003d", "#50b5e0","#3fc6cd","#5399A0","#e7e7e7","#979797","#727272"),
  fillBlueGreys = c("#1D6AA2", "#e7e7e7","#bebebe","#979797","#727272","#4f4f4f")
)

plot(maincolors_discrete)

usethis::use_data(maincolors_discrete, overwrite = TRUE)

# Borders: Discrete palettes for highlight colors -----------------------------------------------------------
border_discrete <- pal_palette(
  borderColor = c("#175582", "#8aae81","#c48741", "#862a47","#789bba","#427a80","#5b5b5b"),
  borderHighligt = c("#02448a", "#6c995f", "#c27216", "#9d0031", "#4091b3","#329ea4","#427a80","#b9b9b9"),
  borderBlueGreys = c("#175582", "#b9b9b9","#989898","#797979","#5b5b5b","#3f3f3f")
)

plot(border_discrete)

usethis::use_data(border_discrete, overwrite = TRUE)

# Fill: Sequential palettes ---------------------------------------------------------
colors_sequential <- pal_palette(
  fillSeq2 = (c("#1d6aa2", "#cee8c7")),
  fillSeq3 = (c("#1d6aa2", "#52afb3", "#cee8c7")),
  fillSeq4 = (c("#1d6aa2", "#2899b1", "#7cc3b5", "#cee8c7")),
  fillSeq5 = (c("#1d6aa2", "#118eaf", "#52afb3", "#91ccb8", "#cee8c7")),
  fillSeq6 = (c("#1d6aa2", "#0587ae", "#39a2b2", "#6bbbb4", "#9dd2ba", "#cee8c7")),
  fillSeqHighlight2 = (c("#1d6aa2", "#12a8ae")),
  fillSeqHighlight3 = (c("#1d6aa2", "#51baa8", "#87bf77")),
  fillSeqHighlight4 = (c("#1d6aa2", "#008baf", "#69c3a5", "#87bf77")),
  fillSeqHighlight5 = (c("#1d6aa2", "#0084ae", "#009db0", "#3cb3ab", "#87bf77")),

)

plot(colors_sequential)

usethis::use_data(colors_sequential, overwrite = TRUE)

# Border: Sequential palettes ---------------------------------------------------------
border_sequential <- pal_palette(
  borderSeq2 = (c("#175582", "#a5ba9f")),
  borderSeq3 = (c("#175582", "#428c8f", "#a5ba9f")),
  borderSeq4 = (c("#175582", "#207a8e", "#639c91", "#a5ba9f")),
  borderSeq5 = (c("#175582", "#0e728c", "#428c8f", "#74a393", "#a5ba9f")),
  borderSeq6 = (c("#175582", "#046c8b", "#2e828e", "#569690", "#7ea895", "#a5ba9f")),
  borderSeqHighlight2 = (c("#175582", "#0e868b")),
  borderSeqHighlight3 = (c("#175582", "#419586", "#6c995f")),
  borderSeqHighlight4 = (c("#175582", "#006f8c", "#549c84", "#6c995f")),
  borderSeqHighlight5 = (c("#175582", "#006a8b", "#007e8d", "#308f89", "#6c995f")),

)

plot(border_sequential)

usethis::use_data(border_sequential, overwrite = TRUE)


# Fill: Divergent palettes ---------------------------------------------------------
colors_divergent <- pal_palette(
  fillDiv2 = (c("#1d6aa2", "#f5a951")),
  fillDiv3 = (c("#1d6aa2", "#e7e7e7", "#f5a951")),
  fillDiv4 = (c("#1d6aa2", "#93abc9", "#f9cca1", "#f5a951")),
  fillDiv5 = (c("#1d6aa2", "#93abc9", "#e7e7e7", "#f9cca1", "#f5a951")),
  fillDiv6 = (c("#1d6aa2", "#7294bc", "#b2c1d6", "#f8d8bb", "#f9c087", "#f5a951")),
  fillDiv7 = (c("#1d6aa2", "#7294bc", "#b2c1d6", "#e7e7e7", "#f8d8bb", "#f9c087", "#f5a951")),
  fillDiv8 = (c("#1d6aa2", "#6189b6", "#93abc9", "#c2cddd", "#f7dec8", "#f9cca1", "#f8bb79", "#f5a951")),
  fillDiv9 = (c("#1d6aa2", "#6189b6", "#93abc9", "#c2cddd", "#e7e7e7", "#f7dec8", "#f9cca1", "#f8bb79", "#f5a951"))
)

plot(colors_divergent)

usethis::use_data(colors_divergent, overwrite = TRUE)

# Border: Divergent palettes ---------------------------------------------------------
border_divergent <- pal_palette(
  borderDiv3 = (c("#175582", "#b9b9b9", "#c48741")),
  borderDiv4 = (c("#175582", "#7689a1", "#c7a381", "#c48741")),
  borderDiv5 = (c("#175582", "#7689a1", "#b9b9b9", "#c7a381", "#c48741")),
  borderDiv6 = (c("#175582", "#5b7696", "#8e9aab", "#f8d8bb", "#c79a6c", "#c48741")),
  borderDiv7 = (c("#175582", "#5b7696", "#8e9aab", "#b9b9b9", "#f8d8bb", "#c79a6c", "#c48741")),
  borderDiv8 = (c("#175582", "#4e6e92", "#7689a1", "#9ba4b1", "#f7dec8", "#c7a381", "#c69661", "#c48741")),
  borderDiv9 = (c("#175582", "#4e6e92", "#7689a1", "#9ba4b1", "#b9b9b9", "#f7dec8", "#c7a381", "#c69661", "#c48741"))

)

plot(border_divergent)

usethis::use_data(border_divergent, overwrite = TRUE)


# Fill: Discrete palettes for political parties -----------------------------------------------------------
party_colors <- pal_palette(
  fillColor = c("#4B8A3E", "#D6862B", "#3872B5", "#F0554D","#84B547","#C4C43D","#DEAA28", "#A65E42", "#B32E32"),
  # fillHighlight = c("#0355ac", "#87bf77", "#f28f1c", "#c4003d", "#50b5e0","#3fc6cd","#5399A0","#e7e7e7"),
  # fillLines = c("#0355ac", "#87bf77", "#f28f1c", "#c4003d", "#50b5e0","#3fc6cd","#5399A0","#e7e7e7","#979797","#727272"),
)

plot(party_colors)

usethis::use_data(party_colors, overwrite = TRUE)

# Fill: Discrete palettes for men and women -----------------------------------------------------------
colors_gender <- pal_palette(
  fillColor = c("#77cd8b", "#a46da2"),
  fillHighlight = c("#2CA02C", "#91308e"),
  fillLineCombi = c("#55c16e", "#863d83"),
  fillBars = c("#99daa8", "#c39ec1")
)

plot(colors_gender)

usethis::use_data(colors_gender, overwrite = TRUE)

# Border: Discrete palettes for men and women -----------------------------------------------------------
border_gender <- pal_palette(
  borderColor = c("#5fa46f", "#835782"),
  # borderHighlight = c("#2CA02C", "#91308e"),
  borderLineCombi = c("#449a58", "#6b3169"),
  borderBars = c("#7aae86", "#9c7e9a")
)

plot(border_gender)

usethis::use_data(border_gender, overwrite = TRUE)


# Fill: Discrete palettes for regions -----------------------------------------------------------
colors_regions <- pal_palette(
  fillAusland = "#96C2E8",
  fillAuslandLine = "#50b5e0",
  fillSchweiz = "#1D6AA2",
  fillSchweizLine = "#0355ac",
  fillKantone = "#bebebe",
  fillKantoneLine = "#979797",
  fillOstschweiz ="#f5a951",
  fillOstschweizLine ="#f28f1c",
  fillTG = "#87bf77",
  fillTGLine = "#1E8501"
)

plot(colors_regions)

usethis::use_data(colors_regions, overwrite = TRUE)

# Border: Discrete palettes for regions -----------------------------------------------------------
border_regions <- pal_palette(
  borderAusland = "#789bba",
  borderSchweiz = "#175582",
  borderKantone = "#989898",
  borderOstschweiz ="#c48741",
  borderTG = "#6c995f")

plot(border_regions)

usethis::use_data(border_regions, overwrite = TRUE)


# All palettes ----------------------------------------------------------------
styleguide_palettes <- c(
  maincolors_discrete,
  border_discrete,
  colors_divergent,
  colors_sequential,
  colors_gender,
  colors_regions,
  party_colors,
  border_divergent,
  border_sequential,
  border_gender,
  border_regions
)

plot(styleguide_palettes)


usethis::use_data(styleguide_palettes, overwrite = TRUE)
