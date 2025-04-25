plot_ca_matrix = \(.tbf,legend_title = "Association"){
  .tbf = .tbf |> 
    dplyr::mutate(sig_marker = dplyr::case_when(
      sig < 0.001 ~ "***",
      sig < 0.01  ~ "**",
      sig < 0.05  ~ "*",
      .default =  ""
    )) |> 
    dplyr::mutate(sig_marker = paste0(round(ca,3),sig_marker))
  
  fig = ggplot2::ggplot(data = .tbf,
                        ggplot2::aes(x = effect, y = cause)) +
    ggplot2::geom_tile(color = "black", ggplot2::aes(fill = ca)) +
    ggplot2::geom_abline(slope = 1, intercept = 0, color = "black", linewidth = 0.25) +
    ggplot2::geom_text(ggplot2::aes(label = sig_marker), color = "black", 
                       family = "serif", size = 15, size.unit = "pt") +
    ggplot2::labs(x = "Effect", y = "Cause", fill = legend_title) +
    ggplot2::scale_x_discrete(expand = c(0, 0)) +
    ggplot2::scale_y_discrete(expand = c(0, 0)) +
    ggplot2::scale_fill_gradient(low = "#9bbbb8", high = "#256c68") +
    ggplot2::coord_equal() +
    ggplot2::theme_void() +
    ggplot2::theme(
      axis.text.x = ggplot2::element_text(angle = 0, family = "serif", size = 18),
      axis.text.y = ggplot2::element_text(color = "black", family = "serif", size = 18),
      axis.title.y = ggplot2::element_text(angle = 90, family = "serif", size = 20),
      axis.title.x = ggplot2::element_text(color = "black", family = "serif", size = 20,
                                           margin = ggplot2::margin(t = 5.5, unit = "pt")),
      legend.text = ggplot2::element_text(family = "serif", size = 10.5),
      legend.title = ggplot2::element_text(family = "serif", size = 15),
      legend.background = ggplot2::element_rect(fill = NA, color = NA),
      legend.direction = "horizontal",
      legend.position = "bottom",
      legend.key.width = ggplot2::unit(25, "pt"),
      legend.margin = ggplot2::margin(t = 1, r = 0, b = 0, l = -25, unit = "pt"),
      panel.grid = ggplot2::element_blank(),
      panel.border = ggplot2::element_rect(color = "black", fill = NA)
    )
  return(fig)
}