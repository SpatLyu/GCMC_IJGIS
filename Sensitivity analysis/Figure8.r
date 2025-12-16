#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~                  Figure 8                ~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

if (!requireNamespace("ggradar")) {
  devtools::install_github("ricardo-bion/ggradar", 
                           dependencies = TRUE)
}

#------------------------------------------------------------------------------#
#---------------------------      Figure 8a       -----------------------------#
#------------------------------------------------------------------------------#

df1 = readxl::read_xlsx("./Sensitivity analysis/figure8.xlsx",
                        sheet = "elev_noise")
fig8a = ggradar::ggradar(df1,
                         label.gridline.min = F,
                         label.gridline.mid = F,
                         label.gridline.max = F,
                         values.radar = c("0", "0.11", "0.3"),
                         gridline.mid.colour = "#e7aa21",
                         grid.min = 0,
                         grid.mid = 0.115,
                         grid.max = 0.3,
                         group.line.width = 0.75,
                         group.point.size = 2.05,
                         legend.position = "bottom")
fig8a
ggplot2::ggsave('./Sensitivity analysis/fig8a.png',
                fig8a, width = 6.55, height = 5.85, dpi = 300)

#------------------------------------------------------------------------------#
#---------------------------      Figure 8b       -----------------------------#
#------------------------------------------------------------------------------#

df2 = readxl::read_xlsx("./Sensitivity analysis/figure8.xlsx",
                        sheet = "popd_noise")
fig8b = ggradar::ggradar(df2,
                         label.gridline.min = F,
                         label.gridline.mid = F,
                         label.gridline.max = F,
                         values.radar = c("0", "0.11", "0.3"),
                         gridline.mid.colour = "#e7aa21",
                         grid.min = 0,
                         grid.mid = 0.115,
                         grid.max = 0.3,
                         group.line.width = 0.75,
                         group.point.size = 2.05,
                         legend.position = "bottom")
fig8b
ggplot2::ggsave('./Sensitivity analysis/fig8b.png',
                fig8b, width = 6.55, height = 5.85, dpi = 300)

#------------------------------------------------------------------------------#
#---------------------------      Figure 8c       -----------------------------#
#------------------------------------------------------------------------------#

df3 = readxl::read_xlsx("./Sensitivity analysis/figure8.xlsx",
                        sheet = "all_noise")
fig8c = ggradar::ggradar(df3,
                         label.gridline.min = F,
                         label.gridline.mid = F,
                         label.gridline.max = F,
                         values.radar = c("0", "0.11", "0.3"),
                         gridline.mid.colour = "#e7aa21",
                         grid.min = 0,
                         grid.mid = 0.115,
                         grid.max = 0.3,
                         group.line.width = 0.75,
                         group.point.size = 2.05,
                         legend.position = "bottom")
fig8c
ggplot2::ggsave('./Sensitivity analysis/fig8c.png',
                fig8c, width = 6.55, height = 5.85, dpi = 300)
