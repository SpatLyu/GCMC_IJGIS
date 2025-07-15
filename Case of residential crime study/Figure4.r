#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~                  Figure 4                ~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

library(tmap)
source('./Utils/plot_cs_matrix.r')

columbus = sf::read_sf("./Case of residential crime study/columbus.gpkg") |> 
  dplyr::select(hoval,inc,crime)
columbus

#------------------------------------------------------------------------------#
#---------------------------      Figure 4a       -----------------------------#
#------------------------------------------------------------------------------#

fig4a = tm_shape(columbus) + 
  tm_polygons(fill = "crime",
              fill.scale = tm_scale_continuous(n = 5),
              fill.legend = tm_legend(
                title = "residential burglaries & vehicle thefts",
                # title = "residential burglaries & vehicle thefts (per 1000 households)",
                orientation = "landscape",
                frame = FALSE,
                title.color = "black",
                bg.color = "white",
                position = tm_pos_out(cell.h = "center",
                                      cell.v = "bottom",
                                      pos.h = "center",
                                      pos.v = "center"),
                show = TRUE
              ),
              col = 'grey', lwd = 1.25) +
  tm_compass(position = tm_pos_in(pos.h = 0.15,
                                  pos.v = 0.95)) +
  tm_layout(frame = FALSE,
            legend.width = 25,
            legend.height = 5,
            legend.title.size = 2.5,
            legend.title.fontfamily = "serif",
            legend.text.size = 1.25,
            legend.text.fontfamily = "serif")
fig4a

#------------------------------------------------------------------------------#
#---------------------------      Figure 4b       -----------------------------#
#------------------------------------------------------------------------------#

fig4b = tm_shape(columbus) + 
  tm_polygons(fill = "hoval",
              fill.scale = tm_scale_continuous(n = 5),
              fill.legend = tm_legend(
                title = "housing value (unit: $1000)",
                orientation = "landscape",
                frame = FALSE,
                title.color = "black",
                bg.color = "white",
                position = tm_pos_out(cell.h = "center",
                                      cell.v = "bottom",
                                      pos.h = "center",
                                      pos.v = "center"),
                show = TRUE
              ),
              col = 'grey', lwd = 1.25) +
  tm_compass(position = tm_pos_in(pos.h = 0.15,
                                  pos.v = 0.95)) +
  tm_layout(frame = FALSE,
            legend.width = 25,
            legend.height = 5,
            legend.title.size = 2.5,
            legend.title.fontfamily = "serif",
            legend.text.size = 1.25,
            legend.text.fontfamily = "serif")
fig4b

#------------------------------------------------------------------------------#
#---------------------------      Figure 4c       -----------------------------#
#------------------------------------------------------------------------------#

fig4c = tm_shape(columbus) + 
  tm_polygons(fill = "inc",
              fill.scale = tm_scale_continuous(n = 5),
              fill.legend = tm_legend(
                title = "household income (unit: $1000)",
                orientation = "landscape",
                frame = FALSE,
                title.color = "black",
                bg.color = "white",
                position = tm_pos_out(cell.h = "center",
                                      cell.v = "bottom",
                                      pos.h = "center",
                                      pos.v = "center"),
                show = TRUE
              ),
              col = 'grey', lwd = 1.25) +
  tm_compass(position = tm_pos_in(pos.h = 0.15,
                                  pos.v = 0.95)) +
  tm_layout(frame = FALSE,
            legend.width = 25,
            legend.height = 5,
            legend.title.size = 2.5,
            legend.title.fontfamily = "serif",
            legend.text.size = 1.25,
            legend.text.fontfamily = "serif")
fig4c

#------------------------------------------------------------------------------#
#---------------------------      Figure 4d       -----------------------------#
#------------------------------------------------------------------------------#

pcc = readxl::read_xlsx("./Case of residential crime study/Case of residential crime study.xlsx",
                        sheet = "pcc")
fig4d = plot_cs_matrix(pcc)
fig4d

#------------------------------------------------------------------------------#
#---------------------------      Figure 4e       -----------------------------#
#------------------------------------------------------------------------------#

gd = readxl::read_xlsx("./Case of residential crime study/Case of residential crime study.xlsx",
                        sheet = "gd")
fig4e = plot_cs_matrix(gd)
fig4e

#------------------------------------------------------------------------------#
#---------------------------      Figure 4f       -----------------------------#
#------------------------------------------------------------------------------#

gccm = readxl::read_xlsx("./Case of residential crime study/Case of residential crime study.xlsx",
                        sheet = "gccm")
fig4f = plot_cs_matrix(gccm)
fig4f

#------------------------------------------------------------------------------#
#---------------------------      Figure 4g       -----------------------------#
#------------------------------------------------------------------------------#

gcmc = readxl::read_xlsx("./Case of residential crime study/Case of residential crime study.xlsx",
                         sheet = "gcmc")
fig4g = plot_cs_matrix(gcmc)
fig4g