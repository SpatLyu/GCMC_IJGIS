# --- Demonstration of Intersectional Cardinality ---

Mx = as.matrix(readr::read_csv('./Schematic diagram/Mx.csv'))
My = as.matrix(readr::read_csv('./Schematic diagram/My.csv'))

Dx = spEDM:::RcppMatDistance(Mx,L1norm = FALSE,NA_rm = TRUE)
Dy = spEDM:::RcppMatDistance(My,L1norm = FALSE,NA_rm = TRUE)

NNx = order(Dx[1,])[2:150]
NNy = unique(unlist(purrr::map(NNx,\(.idx) order(Dy[.idx,])[2:150])))

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
