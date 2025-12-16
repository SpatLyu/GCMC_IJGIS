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
lorenz = simulate_attractor(fLorenz, 0, 0.1, 0, steps = 12000)

# --- Plot M view ---

png("./Schematic diagram/M.png", width = 1600, height = 1600, res = 300, bg = "white")
plot3D::lines3D(lorenz[,1], lorenz[,2], lorenz[,3], colvar = NULL, col = "#e6a922",
                theta = 10, phi = 0, pch = 19, lwd = 1.25, bty = "n", axes = FALSE)
dev.off()

# --- Plot MX view ---

Mx = tEDM::embedded(as.data.frame(lorenz),"x",E = 20,tau = 3)

png("./schematic/Mx.png", width = 1600, height = 1600, res = 300, bg = "transparent")
plot3D::lines3D(Mx[,3], Mx[,6], Mx[,9], colvar = NULL, col = "#6faecb",
                theta = 30, phi = 90, pch = 19, lwd = 1.25, bty = "n", axes = FALSE)
dev.off()

# png("./schematic/Mx.png", width = 1600, height = 1600, res = 300, bg = "transparent")
# plot3D::lines3D(lorenz[,1], lorenz[,2], lorenz[,3], colvar = NULL, col = "#6faecb",
#                 theta = 15, phi = 75, pch = 19, lwd = 1.25, bty = "n", axes = FALSE)
# dev.off()

# --- Plot MY view ---

My = tEDM::embedded(as.data.frame(lorenz),"y",E = 20,tau = 3)

png("./schematic/My.png", width = 1600, height = 1600, res = 300, bg = "transparent")
plot3D::lines3D(My[,3], My[,6], My[,9], colvar = NULL, col = "#fb9f4b",
                theta = 30, phi = 90, pch = 19, lwd = 1.25, bty = "n", axes = FALSE)
dev.off()

# png("./schematic/My.png", width = 1600, height = 1600, res = 300, bg = "transparent")
# plot3D::lines3D(lorenz[,1], lorenz[,2], lorenz[,3], colvar = NULL, col = "#fb9f4b",
#                 theta = 35, phi = -95, pch = 19, lwd = 1.25, bty = "n", axes = FALSE)
# dev.off()