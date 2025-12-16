# --- Intersectional Cardinality curve for H0 and H1 hypothesis ---

Mx = readr::read_csv('./Schematic diagram/Mx.csv')
My = readr::read_csv('./Schematic diagram/My.csv')

H1 = spEDM:::RcppIntersectionCardinality(as.matrix(Mx), as.matrix(My),
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
