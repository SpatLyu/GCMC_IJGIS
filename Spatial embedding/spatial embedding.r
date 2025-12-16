henan = sf::read_sf('./Spatial embedding/henan.geojson')

# bb = henan |> 
#   st_bbox() |>
#   st_as_sfc() |>
#   st_as_sf() |>
#   st_buffer(dist = units::set_units(0.35,"degree")) |> 
#   st_bbox() |> 
#   as.numeric()

nb = sdsfun::spdep_nb(henan)

# Selected spatial unit for illustrative calculation 
plot(henan[,"Code"])
henan[henan$Code == "4110",]

spunit = list()
spunit[[1]] = nb[[10]]
spunit[[2]] = setdiff(spEDM:::RcppLaggedNeighbor4Lattice(nb,2)[[10]],c(nb[[10]],10))
spunit[[3]] = setdiff(spEDM:::RcppLaggedNeighbor4Lattice(nb,3)[[10]],
                      spEDM:::RcppLaggedNeighbor4Lattice(nb,2)[[10]])

henan = henan |> 
  dplyr::mutate(
    lagnum = dplyr::case_when(rid == 10 ~ "0",
                              rid %in% spunit[[1]] ~ "1",
                              rid %in% spunit[[2]] ~ "2",
                              rid %in% spunit[[3]] ~ "3")
  ) |> 
  dplyr::mutate(lagnum = factor(lagnum,levels = as.character(0:3),
                                labels = c("Focal Unit",
                                           paste0(c("First","Second","Third"),
                                                  "-order Lags"))))

library(tmap)

fig11 = tm_shape(henan) + 
  tm_polygons(fill = "lagnum",
              fill.scale = tm_scale_categorical(n.max = 4,
                                                values = rev(
                                                  c("#fee5d9",
                                                    "#fcbba1",
                                                    "#fb6a4a",
                                                    "#de2d26"))),
              fill.legend = tm_legend(
                title = "Spatial Lags",
                design = "standard",
                title.color = "black",
                bg.color = "white",
                position = tm_pos_in(pos.h = "left",
                                     pos.v = "bottom"),
                show = TRUE
              ),
              col = 'grey', lwd = 1.25) +
  tm_text("popdensity",size = 1.05, # angle = 5,
          options = opt_tm_text(just = "top",on_surface = TRUE)) +
  tm_layout(frame = FALSE)
fig11
tmap_save(fig11,"./Spatial embedding/figure1_1.png",dpi = 300)

# png('./Spatial embedding/figure1_1.png', width = 1500, height = 1500, res = 300)  
# par(mar = rep(0,4))
# plot(sf::st_geometry(henan), col = 'white', lwd = 1.25, border = "grey40")
# plot(nb,coords = sdsfun::sf_coordinates(henan), lwd=1.05, col="blue", cex = 1.25, add = TRUE)
# dev.off()

embeddings = spEDM::embedded(henan, target = "popdensity", E = 3, tau = 1)
colnames(embeddings) = c("hs1","hs2","hs3")
embeddings[10,1:3]

henan$popdensity[spunit[[1]]] / 5
henan$popdensity[spunit[[2]]] / 6
henan$popdensity[spunit[[3]]] / 6

png("./Spatial embedding/figure1_2.png", width = 1800, height = 1500, res = 300)
par(mar = rep(0,4))
scatterplot3d::scatterplot3d(x = embeddings[,1], y = embeddings[,2], z = embeddings[,3],
                             xlab = latex2exp::TeX("$h_{s(1)}(x)$"),
                             ylab = latex2exp::TeX("$h_{s(2)}(x)$"),
                             zlab = latex2exp::TeX("$h_{s(3)}(x)$"),
                             pch = 16, color="red", angle = 45)
dev.off()
