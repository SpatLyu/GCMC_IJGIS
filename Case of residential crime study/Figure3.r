#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~                  Figure 3                ~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

library(tmap)
source('./Utils/plot_ca_matrix.r')

columbus = sf::read_sf("./Case of residential crime study/columbus.gpkg") |> 
  dplyr::select(hoval,inc,crime)
columbus

#------------------------------------------------------------------------------#
#---------------------------      Figure 3a       -----------------------------#
#------------------------------------------------------------------------------#

fig3a = tm_shape(columbus) + 
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
fig3a

#------------------------------------------------------------------------------#
#---------------------------      Figure 3b       -----------------------------#
#------------------------------------------------------------------------------#

fig3b = tm_shape(columbus) + 
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
fig3b

#------------------------------------------------------------------------------#
#---------------------------      Figure 3c       -----------------------------#
#------------------------------------------------------------------------------#

fig3c = tm_shape(columbus) + 
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
fig3c

#------------------------------------------------------------------------------#
#---------------------------      Figure 3d       -----------------------------#
#------------------------------------------------------------------------------#

pcc = readxl::read_xlsx("./Case of residential crime study/Case of residential crime study.xlsx",
                        sheet = "pcc")
fig3d = plot_ca_matrix(pcc)
fig3d

#------------------------------------------------------------------------------#
#---------------------------      Figure 3e       -----------------------------#
#------------------------------------------------------------------------------#

gd = readxl::read_xlsx("./Case of residential crime study/Case of residential crime study.xlsx",
                        sheet = "gd")
fig3e = plot_ca_matrix(gd)
fig3e

#------------------------------------------------------------------------------#
#---------------------------      Figure 3f       -----------------------------#
#------------------------------------------------------------------------------#

gccm = readxl::read_xlsx("./Case of residential crime study/Case of residential crime study.xlsx",
                        sheet = "gccm")
fig3f = plot_ca_matrix(gccm)
fig3f

#------------------------------------------------------------------------------#
#---------------------------      Figure 3g       -----------------------------#
#------------------------------------------------------------------------------#

gcmc = readxl::read_xlsx("./Case of residential crime study/Case of residential crime study.xlsx",
                         sheet = "gcmc")
fig3g = plot_ca_matrix(gcmc)
fig3g