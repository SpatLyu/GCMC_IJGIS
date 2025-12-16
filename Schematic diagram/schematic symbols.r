# --- Simulation Function ---
simulate_attractor = function(f, x0, y0, z0, steps = 5000, dt = 0.01) {
  x = numeric(steps)
  y = numeric(steps)
  z = numeric(steps)
  x[1] = x0; y[1] = y0; z[1] = z0
  for (i in 1:(steps - 1)) {
    d = f(x[i], y[i], z[i])
    x[i + 1] = x[i] + dt * d$dx
    y[i + 1] = y[i] + dt * d$dy
    z[i + 1] = z[i] + dt * d$dz
  }
  cbind(x, y, z)
}

# --- Lorenz Parameters from Science paper (rho = 28) ---
fLorenz = function(x, y, z, sigma = 10, rho = 28, beta = 8 / 3) {
  dx = sigma * (y - x)
  dy = x * (rho - z) - y
  dz = x * y - beta * z
  list(dx = dx, dy = dy, dz = dz)
}

# --- Simulate Lorenz ---
lorenz = simulate_attractor(fLorenz, 0, 0.1, 0, steps = 5000)

# --- Plot M view ---

plot3D::scatter3D(lorenz[, 1], lorenz[, 2], lorenz[, 3],
                  colvar = NULL, pch = 19, col = "grey70",
                  theta = 10, phi = 0, cex = 0.105, bty = "n")

png("./Schematic diagram/M.png", width = 1600, height = 1600, res = 300, bg = "white")

plot3D::scatter3D(lorenz[, 1], lorenz[, 2], lorenz[, 3],
                  colvar = NULL, pch = 19, col = "grey70",
                  theta = 10, phi = 0, cex = 0.25, bty = "n")

# set.seed(42)
# clusters = kmeans(lorenz, centers = 2)$cluster

# plot3D::scatter3D(lorenz[which(clusters == 1), 1], 
#                   lorenz[which(clusters == 1), 2],
#                   lorenz[which(clusters == 1), 3],
#                   colvar = NULL, pch = 19, col = "#aec4ca",
#                   theta = 10, phi = 0, cex = 0.25, bty = "n", add = TRUE)

# plot3D::scatter3D(lorenz[which(clusters == 2), 1], 
#                   lorenz[which(clusters == 2), 2],
#                   lorenz[which(clusters == 2), 3],
#                   colvar = NULL, pch = 19, col = "#fabcbd",
#                   theta = 10, phi = 0, cex = 0.25, bty = "n", add = TRUE)

dev.off()

# --- Plot MX view ---

GenStateSpace = \(ts, E = 3, tau = 1) {
  # Input validation
  if (!is.numeric(ts)) {
    stop("Time series must be numeric", call. = FALSE)
  }
  if (E < 2) {
    stop("E must be an integer greater than 1", call. = FALSE)
  }
  if (tau < 1) {
    stop("Time delay must be positive", call. = FALSE)
  }

  # Create embedding matrix
  M = matrix(NA_real_, length(ts) - (E - 1) * tau , E)
  for (i in 1:nrow(M)) {
    M_vec = ts[seq(from = i, to = i + (E - 1) * tau, by = tau)]
    if (!anyNA(M_vec)) {
      M[i,] = M_vec
    }
  }
  return(M)
}

Mx = GenStateSpace(lorenz[,"x"],E = 20,tau = 3)

png("./Schematic diagram/Mx.png", width = 1600, height = 1600, res = 300, bg = "white")
plot3D::scatter3D(Mx[,3], Mx[,6], Mx[,9],
                  colvar = NULL, pch = 19, col = "#fabcbd",
                  theta = 10, phi = 0, cex = 0.25, bty = "n")
dev.off()

# --- Plot MY view ---

My = GenStateSpace(lorenz[,"y"],E = 20,tau = 3)

png("./Schematic diagram/My.png", width = 1600, height = 1600, res = 300, bg = "white")
plot3D::scatter3D(My[,3], My[,6], My[,9],
                  colvar = NULL, pch = 19, col = "#aec4ca",
                  theta = 10, phi = 0, cex = 0.25, bty = "n")
dev.off()

# --- Export Mx and My ---

Mx = as.data.frame(Mx[,c(3,6,9)])
names(Mx) = c("x","y","z")
readr::write_csv(Mx, './Schematic diagram/Mx.csv')

My = as.data.frame(My[,c(3,6,9)])
names(My) = c("x","y","z")
readr::write_csv(My, './Schematic diagram/My.csv')
