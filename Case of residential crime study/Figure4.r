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
tmap_save(fig4a,'./Case of residential crime study/fig4a.png',dpi = 300)

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
tmap_save(fig4b,'./Case of residential crime study/fig4b.png',dpi = 300)

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
tmap_save(fig4c,'./Case of residential crime study/fig4c.png',dpi = 300)

#------------------------------------------------------------------------------#
#---------------------------      Figure 4d       -----------------------------#
#------------------------------------------------------------------------------#

pcc = readxl::read_xlsx("./Case of residential crime study/Case of residential crime study.xlsx",
                        sheet = "pcc")
fig4d = plot_cs_matrix(pcc)
fig4d
ggplot2::ggsave('./Case of residential crime study/fig4d.png',
                fig4d, width = 3.65, height = 4.05, dpi = 300)

#------------------------------------------------------------------------------#
#---------------------------      Figure 4e       -----------------------------#
#------------------------------------------------------------------------------#

gd = readxl::read_xlsx("./Case of residential crime study/Case of residential crime study.xlsx",
                        sheet = "gd")
fig4e = plot_cs_matrix(gd)
fig4e
ggplot2::ggsave('./Case of residential crime study/fig4e.png',
                fig4e, width = 3.65, height = 4.05, dpi = 300)

#------------------------------------------------------------------------------#
#---------------------------      Figure 4f       -----------------------------#
#------------------------------------------------------------------------------#

directlingam = readxl::read_xlsx("./Case of residential crime study/Case of residential crime study.xlsx",
                                 sheet = "directlingam")
fig4f = plot_cs_matrix(directlingam)
fig4f
ggplot2::ggsave('./Case of residential crime study/fig4f.png',
                fig4f, width = 3.65, height = 4.05, dpi = 300)

#------------------------------------------------------------------------------#
#---------------------------      Figure 4g       -----------------------------#
#------------------------------------------------------------------------------#

gccm = readxl::read_xlsx("./Case of residential crime study/Case of residential crime study.xlsx",
                        sheet = "gccm")
fig4g = plot_cs_matrix(gccm)
fig4g
ggplot2::ggsave('./Case of residential crime study/fig4g.png',
                fig4g, width = 3.65, height = 4.05, dpi = 300)

#------------------------------------------------------------------------------#
#---------------------------      Figure 4h       -----------------------------#
#------------------------------------------------------------------------------#

gcmc = readxl::read_xlsx("./Case of residential crime study/Case of residential crime study.xlsx",
                         sheet = "gcmc")
fig4h = plot_cs_matrix(gcmc)
fig4h
ggplot2::ggsave('./Case of residential crime study/fig4h.png',
                fig4h, width = 3.65, height = 4.05, dpi = 300)
