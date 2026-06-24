#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~                  Figure 5                ~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

library(tmap)
source("./Utils/plot_cs_matrix.r")

columbus = sf::read_sf("./Case of residential crime study/columbus.gpkg") |> 
  dplyr::select(hoval, inc, crime)
columbus

#------------------------------------------------------------------------------#
#---------------------------      Figure 5a       -----------------------------#
#------------------------------------------------------------------------------#

fig5a = tm_shape(columbus) + 
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
              col = "grey", lwd = 1.25) +
  tm_compass(position = tm_pos_in(pos.h = 0.15,
                                  pos.v = 0.95)) +
  tm_layout(frame = FALSE,
            legend.width = 25,
            legend.height = 5,
            legend.title.size = 2.5,
            legend.title.fontfamily = "serif",
            legend.text.size = 1.25,
            legend.text.fontfamily = "serif")
fig5a
tmap_save(fig5a, "./Case of residential crime study/fig5a.png", dpi = 300)

#------------------------------------------------------------------------------#
#---------------------------      Figure 5b       -----------------------------#
#------------------------------------------------------------------------------#

fig5b = tm_shape(columbus) + 
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
              col = "grey", lwd = 1.25) +
  tm_compass(position = tm_pos_in(pos.h = 0.15,
                                  pos.v = 0.95)) +
  tm_layout(frame = FALSE,
            legend.width = 25,
            legend.height = 5,
            legend.title.size = 2.5,
            legend.title.fontfamily = "serif",
            legend.text.size = 1.25,
            legend.text.fontfamily = "serif")
fig5b
tmap_save(fig5b, "./Case of residential crime study/fig5b.png", dpi = 300)

#------------------------------------------------------------------------------#
#---------------------------      Figure 5c       -----------------------------#
#------------------------------------------------------------------------------#

fig5c = tm_shape(columbus) + 
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
              col = "grey", lwd = 1.25) +
  tm_compass(position = tm_pos_in(pos.h = 0.15,
                                  pos.v = 0.95)) +
  tm_layout(frame = FALSE,
            legend.width = 25,
            legend.height = 5,
            legend.title.size = 2.5,
            legend.title.fontfamily = "serif",
            legend.text.size = 1.25,
            legend.text.fontfamily = "serif")
fig5c
tmap_save(fig5c, "./Case of residential crime study/fig5c.png", dpi = 300)

#------------------------------------------------------------------------------#
#---------------------------      Figure 5d       -----------------------------#
#------------------------------------------------------------------------------#

pcc = readxl::read_xlsx(
  "./Case of residential crime study/Case of residential crime study.xlsx",
  sheet = "pcc"
)
fig5d = plot_cs_matrix(pcc)
fig5d
ggplot2::ggsave("./Case of residential crime study/fig5d.png",
                fig5d, width = 3.65, height = 4.05, dpi = 300)

#------------------------------------------------------------------------------#
#---------------------------      Figure 5e       -----------------------------#
#------------------------------------------------------------------------------#

gd = readxl::read_xlsx(
  "./Case of residential crime study/Case of residential crime study.xlsx",
  sheet = "gd"
)
fig5e = plot_cs_matrix(gd)
fig5e
ggplot2::ggsave("./Case of residential crime study/fig5e.png",
                fig5e, width = 3.65, height = 4.05, dpi = 300)

#------------------------------------------------------------------------------#
#---------------------------      Figure 5f       -----------------------------#
#------------------------------------------------------------------------------#

directlingam = readxl::read_xlsx(
  "./Case of residential crime study/Case of residential crime study.xlsx",
  sheet = "directlingam"
)
fig5f = plot_cs_matrix(directlingam)
fig5f
ggplot2::ggsave("./Case of residential crime study/fig5f.png",
                fig5f, width = 3.65, height = 4.05, dpi = 300)

#------------------------------------------------------------------------------#
#---------------------------      Figure 5g       -----------------------------#
#------------------------------------------------------------------------------#

gccm = readxl::read_xlsx(
  "./Case of residential crime study/Case of residential crime study.xlsx",
  sheet = "gccm"
)
fig5g = plot_cs_matrix(gccm)
fig5g
ggplot2::ggsave("./Case of residential crime study/fig5g.png",
                fig5g, width = 3.65, height = 4.05, dpi = 300)

#------------------------------------------------------------------------------#
#---------------------------      Figure 5h       -----------------------------#
#------------------------------------------------------------------------------#

gcmc = readxl::read_xlsx(
  "./Case of residential crime study/Case of residential crime study.xlsx",
  sheet = "gcmc"
)
fig5h = plot_cs_matrix(gcmc)
fig5h
ggplot2::ggsave("./Case of residential crime study/fig5h.png",
                fig5h, width = 3.65, height = 4.05, dpi = 300)
