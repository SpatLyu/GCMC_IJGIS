library(sf)
library(tmap)

# henan = cnmap::getMap(code = "410000", subRegion = TRUE) |> 
#   dplyr::select(adcode,name)

cn = dplyr::select(sf::st_make_valid(mapchina::china),
                   Code = Code_Perfecture,
                   Pop = Pop_2010,Area) |> 
  dplyr::group_by(Code) |> 
  dplyr::summarise(geometry = sf::st_union(geometry) |> 
                     sf::st_cast("MULTIPOLYGON"),
                   Pop = sum(Pop,na.rm = TRUE),
                   Area = sum(Area,na.rm = TRUE)) |> 
  dplyr::mutate(popdensity = round(Pop / Area,0))
henan = cn |> 
  dplyr::filter(stringr::str_detect(Code, "^41.{2}$")) |> 
  dplyr::select(Code,popdensity) |> 
  tibble::rowid_to_column(var = "rid")

# bb = henan |> 
#   st_bbox() |>
#   st_as_sfc() |>
#   st_as_sf() |>
#   st_buffer(dist = units::set_units(0.35,"degree")) |> 
#   st_bbox() |> 
#   as.numeric()

nb = sdsfun::spdep_nb(henan)

# Selected spatial unit for illustrative calculation
mapview::mapview(henan,zcol = "Code")
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
tmap_save(fig11,'./figure/figure1_1.jpg',dpi = 300)

# jpeg("./figure/figure1_2.jpg", width = 1500, height = 1500, res = 300)  
# par(mar = rep(0,4))
# plot(sf::st_geometry(henan), col = 'white', lwd = 1.25, border = "grey40")
# plot(nb,coords = sdsfun::sf_coordinates(henan), lwd=1.05, col="blue", cex = 1.25, add = TRUE)
# dev.off()

embeddings = spEDM::embedded(henan, target = "popdensity", E = 3, tau = 1)
colnames(embeddings) = c("hs1","hs2","hs3")
# readr::write_csv(as.data.frame(embeddings),'./result/figure1_embeddings.csv')
embeddings[10,1:3]

henan$popdensity[spunit[[1]]] / 5
henan$popdensity[spunit[[2]]] / 6
henan$popdensity[spunit[[3]]] / 6

jpeg("./figure/figure1_2.jpg", width = 1800, height = 1500, res = 300)
par(mar = rep(0,4))
scatterplot3d::scatterplot3d(x = embeddings[,1], y = embeddings[,2], z = embeddings[,3],
                             xlab = latex2exp::TeX("$h_{s(1)}(x)$"),
                             ylab = latex2exp::TeX("$h_{s(2)}(x)$"),
                             zlab = latex2exp::TeX("$h_{s(3)}(x)$"),
                             pch = 16, color="red", angle = 45)
dev.off()

