# --- Demonstration of Intersectional Cardinality ---

Mx = as.matrix(readr::read_csv('./Schematic diagram/Mx.csv'))
My = as.matrix(readr::read_csv('./Schematic diagram/My.csv'))

Dx = spEDM:::RcppMatDistance(Mx,L1norm = FALSE,NA_rm = TRUE)
Dy = spEDM:::RcppMatDistance(My,L1norm = FALSE,NA_rm = TRUE)

NNx = order(Dx[1,])[2:150]
NNy = unique(unlist(purrr::map(NNx,\(.idx) order(Dy[.idx,])[2:150])))

NNx_range = apply(Mx[NNx,],2,range)
NNy_range = apply(My[NNx,],2,range)
NNyp_range = apply(My[NNy,],2,range)
NN_range = rbind(NNx_range,NNy_range,NNyp_range) |> 
  apply(2,range) |> 
  range()

png("./Schematic diagram/NNx.png", width = 1600, height = 1600, res = 300, bg = "white")

plot3D::lines3D(Mx[,1], Mx[,2], Mx[,3],
                colvar = NULL, pch = 19, col = "grey70",
                theta = 10, phi = 0, lwd = 0.25, bty = "n")

plot3D::scatter3D(Mx[NNx,1], Mx[NNx,2], Mx[NNx,3],
                  colvar = NULL, pch = 19, col = "#fabcbd",
                  theta = 10, phi = 0, cex = 0.25, bty = "n", add = TRUE)

plot3D::scatter3D(Mx[1,1], Mx[1,2], Mx[1,3],
                  colvar = NULL, pch = 19, col = "#f03e41ff",
                  theta = 10, phi = 0, cex = 0.55, bty = "n", add = TRUE)

dev.off()

png("./Schematic diagram/NNx_local.png", width = 1600, height = 1600, res = 300, bg = "white")

plot3D::lines3D(Mx[,1], Mx[,2], Mx[,3],
                xlim = NN_range,
                ylim = NN_range,
                zlim = NN_range,
                colvar = NULL, pch = 19, col = "grey70",
                theta = 10, phi = 0, lwd = 0.35, bty = "n")

plot3D::scatter3D(Mx[NNx,1], Mx[NNx,2], Mx[NNx,3],
                  xlim = NN_range,
                  ylim = NN_range,
                  zlim = NN_range,
                  colvar = NULL, pch = 19, col = "#fabcbd",
                  theta = 10, phi = 0, cex = 0.35, bty = "n", add = TRUE)

plot3D::scatter3D(Mx[1,1], Mx[1,2], Mx[1,3],
                  xlim = NN_range,
                  ylim = NN_range,
                  zlim = NN_range,
                  colvar = NULL, pch = 19, col = "#f03e41ff",
                  theta = 10, phi = 0, cex = 0.75, bty = "n", add = TRUE)

dev.off()

png("./Schematic diagram/NNy.png", width = 1600, height = 1600, res = 300, bg = "white")

plot3D::lines3D(My[,1], My[,2], My[,3],
                colvar = NULL, pch = 19, col = "grey70",
                theta = 10, phi = 0, lwd = 0.15, bty = "n")

plot3D::scatter3D(Mx[NNx,1], Mx[NNx,2], Mx[NNx,3],
                colvar = NULL, pch = 19, col = "#627b9cff",
                theta = 10, phi = 0, cex = 0.15, bty = "n", add = TRUE)

plot3D::scatter3D(My[1,1], My[1,2], My[1,3],
                colvar = NULL, pch = 19, col = "#055ad0ff",
                theta = 10, phi = 0, cex = 0.55, bty = "n", add = TRUE)

dev.off()

png("./Schematic diagram/NNy_local.png", width = 1600, height = 1600, res = 300, bg = "white")

plot3D::lines3D(My[,1], My[,2], My[,3],
                xlim = NN_range,
                ylim = NN_range,
                zlim = NN_range,
                colvar = NULL, pch = 19, col = "grey70",
                theta = 10, phi = 30, lwd = 0.35, bty = "n")

plot3D::scatter3D(My[NNx,1], My[NNx,2], My[NNx,3],
                  xlim = NN_range,
                  ylim = NN_range,
                  zlim = NN_range,
                  colvar = NULL, pch = 19, col = "#627b9cff",
                  theta = 10, phi = 30, cex = 0.35, bty = "n", add = TRUE)

plot3D::scatter3D(My[1,1], My[1,2], My[1,3],
                  xlim = NN_range,
                  ylim = NN_range,
                  zlim = NN_range,
                  colvar = NULL, pch = 19, col = "#055ad0ff",
                  theta = 10, phi = 30, cex = 0.75, bty = "n", add = TRUE)

dev.off()

png("./Schematic diagram/NNy_projected.png", width = 1600, height = 1600, res = 300, bg = "white")

plot3D::lines3D(My[,1], My[,2], My[,3],
                colvar = NULL, pch = 19, col = "grey70",
                theta = 10, phi = 0, lwd = 0.15, bty = "n")

plot3D::scatter3D(Mx[NNy,1], Mx[NNy,2], Mx[NNy,3],
                  colvar = NULL, pch = 19, col = "#627b9cff",
                  theta = 10, phi = 0, cex = 0.15, bty = "n", add = TRUE)

plot3D::scatter3D(My[1,1], My[1,2], My[1,3],
                  colvar = NULL, pch = 19, col = "#055ad0ff",
                  theta = 10, phi = 0, cex = 0.55, bty = "n", add = TRUE)

dev.off()

png("./Schematic diagram/NNy_projected_local.png", width = 1600, height = 1600, res = 300, bg = "white")

plot3D::lines3D(My[,1], My[,2], My[,3],
                xlim = NN_range,
                ylim = NN_range,
                zlim = NN_range,
                colvar = NULL, pch = 19, col = "grey70",
                theta = 10, phi = 0, lwd = 0.35, bty = "n")

plot3D::scatter3D(Mx[NNy,1], Mx[NNy,2], Mx[NNy,3],
                  xlim = NN_range,
                  ylim = NN_range,
                  zlim = NN_range,
                  colvar = NULL, pch = 19, col = "#627b9cff",
                  theta = 10, phi = 0, cex = 0.35, bty = "n", add = TRUE)

plot3D::scatter3D(My[1,1], My[1,2], My[1,3],
                  xlim = NN_range,
                  ylim = NN_range,
                  zlim = NN_range,
                  colvar = NULL, pch = 19, col = "#055ad0ff",
                  theta = 10, phi = 0, cex = 0.85, bty = "n", add = TRUE)

dev.off()
