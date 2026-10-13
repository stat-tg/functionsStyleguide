#' Styleguide palettes
#'
#' Palettes with the colors according to the Styleguide of the Amt für Daten und Statistik Thurgau (see also file://svmktgaccp01.tg.ch/data$/SK-Daten-und-Prozesse/stat/allgemein/styleguide_qmd/index.html) as well as functions for simple ggplot plots.
#'
#' @format ## `styleguide_palettes`
#' An object of class `palettes_palette` with `r length(styleguide_palettes)`
#' colour palettes. Use `names(styleguide_palettes)` to return all palette names.
#' @source <file://svmktgaccp01.tg.ch/data$/SK-Daten-und-Prozesse/stat/allgemein/styleguide_qmd/index.html>
#' @author [Daniela Koller](https://github.com/ogdtg)
#' @seealso [pal_palette()], [pal_colour()]
#' @examples
#' # Get all palettes by name.
#' names(styleguide_palettes)
#'
#' # Plot all palettes.
#' plot(styleguide_palettes)
"styleguide_palettes"

#' @rdname styleguide_palettes
#' @format ## `maincolors_discrete`
#' An object of class `palettes_palette` with
#' `r length(maincolors_discrete)` discrete colour palettes for the main 7 colors including colors for segmental charts and highlight colors especially for line charts.
#'  Use `names(maincolors_discrete)` to return all palette names.
"maincolors_discrete"

#' @rdname styleguide_palettes
#' @format ## `border_discrete`
#' An object of class `palettes_palette` with
#' `r length(border_discrete)` border colors for the 7 main colors used for bar charts etc.
#'  Use `names(border_discrete)` to return all palette names.
"border_discrete"

#' @rdname styleguide_palettes
#' @format ## `colors_divergent`
#' An object of class `palettes_palette` with
#' `r length(colors_divergent)` color palettes for divergent categories i.e. categorical data with negative and positive values.
#'  Use `names(colors_divergent)` to return all palette names.
"colors_divergent"

#' @rdname styleguide_palettes
#' @format ## `border_divergent`
#' An object of class `palettes_palette` with
#' `r length(border_divergent)`border color palettes for divergent categories i.e. categorical data with negative and positive values.
#'  Use `names(border_divergent)` to return all palette names.
"border_divergent"


#' @rdname styleguide_palettes
#' @format ## `colors_sequential`
#' An object of class `palettes_palette` with
#' `r length(colors_sequential)` color palettes for sequential categories i.e. categorical data with ordinal data categories.
#'  Use `names(colors_sequential)` to return all palette names.
"colors_sequential"

#' @rdname styleguide_palettes
#' @format ## `border_sequential`
#' An object of class `palettes_palette` with
#' `r length(border_sequential)` border color palettes for sequential categories i.e. categorical data with ordinal data categories.
#'  Use `names(border_sequential)` to return all palette names.
"border_sequential"

#' @rdname styleguide_palettes
#' @format ## `colors_gender`
#' An object of class `palettes_palette` with
#' `r length(colors_gender)` color palettes for gender categories (men = green color shapes, women = violet color shapes).
#'  Use `names(colors_gender)` to return all palette names.
"colors_gender"



#' @rdname styleguide_palettes
#' @format ## `border_gender`
#' An object of class `palettes_palette` with
#' `r length(border_gender)` border color palettes for gender categories (men = green color shapes, women = violet color shapes).
#'  Use `names(border_gender)` to return all palette names.
"border_gender"

#' @rdname styleguide_palettes
#' @format ## `colors_regions`
#' An object of class `palettes_palette` with
#' `r length(colors_regions)` color palettes for different regional data i.e. Switzerland, Eastern Switzerland, other cantons etc.
#'  Use `names(colors_regions)` to return all palette names.
"colors_regions"

#' @rdname styleguide_palettes
#' @format ## `border_regions`
#' An object of class `palettes_palette` with
#' `r length(border_regions)` border color palettes for different regional data i.e. Switzerland, Eastern Switzerland, other cantons etc.
#'  Use `names(border_regions)` to return all palette names.
"border_regions"

#' @rdname styleguide_palettes
#' @format ## `party_colors`
#' An object of class `palettes_palette` with
#' `r length(party_colors)` party colors for the main political parties.
#'  Use `names(party_colors)` to return all palette names.
"party_colors"

