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

# intersectional cardinality curve for H0 and H1 hypothesis

H1 = spEDM:::RcppIntersectionCardinality(Mx[,c(3,6,9)], My[,c(3,6,9)],
                                         1:nrow(Mx), 1:nrow(Mx),
                                         ceiling(sqrt(3*nrow(Mx))))
H0 = seq_along(H1) / nrow(Mx)
aucH1 = sdsfun::normalize_vector(H1)
aucH0 = sdsfun::normalize_vector(H0)
cmcH = data.frame(H1 = aucH1, H0 = aucH0)

figH1 = ggplot2::ggplot(data = cmcH,ggplot2::aes(x = H0, y = H1)) +
  ggplot2::geom_ribbon(ggplot2::aes(ymin = 0, ymax = H1), fill = "#FFC799", alpha = 0.8) +
  ggplot2::geom_abline(slope = 1, intercept = 0, linetype = "dashed", color = "grey50") +
  ggplot2::geom_line(color = "#D95F5F", linetype = "dashed", linewidth = 1) +
  ggplot2::scale_x_continuous(expand = c(0, 0)) +
  ggplot2::scale_y_continuous(expand = c(0, 0)) +
  ggplot2::annotate("text", x = 0.7, y = 0.2, 
                    label = latex2exp::TeX("$AUC(H_1)$"), 
                    color = "black", size = 7.25) +
  ggplot2::labs(x = "Normalized k", y = "Normalized IC", color = NULL) +
  ggplot2::coord_equal() +
  ggplot2::theme_bw() +
  ggplot2::theme(axis.text = ggplot2::element_text(family = "serif",size = 15),
                 axis.title = ggplot2::element_text(family = "serif",size = 16.5),
                 panel.grid = ggplot2::element_blank()) 
figH1
ggplot2::ggsave('./Schematic diagram/figH1.png',
                figH1, width = 4.95, height = 4.5, dpi = 300)

figH0 = ggplot2::ggplot(data = cmcH,ggplot2::aes(x = H0, y = H0)) +
  ggplot2::geom_ribbon(ggplot2::aes(ymin = 0, ymax = H0), fill = "#afefbd", alpha = 0.8) +
  ggplot2::geom_abline(slope = 1, intercept = 0, linetype = "dashed", color = "grey50") +
  ggplot2::geom_line(color = "#5F95D9", linetype = "dashed", linewidth = 1) +
  ggplot2::scale_x_continuous(expand = c(0, 0)) +
  ggplot2::scale_y_continuous(expand = c(0, 0)) +
  ggplot2::annotate("text", x = 0.65, y = 0.2, 
                    label = latex2exp::TeX("$AUC(H_0)$"), 
                    color = "black", size = 7.25) +
  ggplot2::labs(x = "Normalized k", y = "Normalized IC", color = NULL) +
  ggplot2::coord_equal() +
  ggplot2::theme_bw() +
  ggplot2::theme(axis.text = ggplot2::element_text(family = "serif",size = 15),
                 axis.title = ggplot2::element_text(family = "serif",size = 16.5),
                 panel.grid = ggplot2::element_blank()) 
figH0
ggplot2::ggsave('./Schematic diagram/figH0.png',
                figH0, width = 4.95, height = 4.5, dpi = 300)

# figH = ggplot2::ggplot(data = cmcH,ggplot2::aes(x = aucH0)) +
#   ggplot2::geom_ribbon(ggplot2::aes(ymin = 0, ymax = aucH1), 
#                                     fill = "#afefbd", alpha = 0.5) +
#   ggplot2::geom_ribbon(ggplot2::aes(ymin = 0, ymax = aucH0), 
#                        fill = "grey", alpha = 0.5) +
#   ggplot2::geom_line(ggplot2::aes(y = aucH0, color = "H0"),lwd = 1) +
#   ggplot2::geom_line(ggplot2::aes(y = aucH1, color = "H1"),lwd = 1) +
#   ggplot2::geom_abline(slope = 1, intercept = 0, color = "grey",
#                        lwd = 0.5, linetype = 3) +
#   ggplot2::scale_color_manual(
#     values = c("H0" = "#5F95D9","H1" = "#D95F5F"), 
#     labels = c(latex2exp::TeX("$AUC(H_0)$"),
#                latex2exp::TeX("$AUC(H_1)$"))
#   ) +
#   ggplot2::scale_x_continuous(expand = c(0, 0)) +
#   ggplot2::scale_y_continuous(expand = c(0, 0)) +
#   ggplot2::labs(x = "Normalized r", y = "Normalized IC", color = NULL) +
#   ggplot2::coord_equal() +
#   ggplot2::theme_bw() +
#   ggplot2::theme(axis.text = ggplot2::element_text(family = "TNR"),
#                  axis.title = ggplot2::element_text(family = "TNR"),
#                  panel.grid = ggplot2::element_blank(),
#                  legend.position = "inside",
#                  legend.justification = c('left','top'),
#                  legend.background = ggplot2::element_rect(fill = 'transparent'),
#                  legend.text = ggplot2::element_text(family = "TNR"))
