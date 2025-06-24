#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~                  Figure 6                ~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

if (!requireNamespace("ggradar")) {
  devtools::install_github("ricardo-bion/ggradar", 
                           dependencies = TRUE)
}

#------------------------------------------------------------------------------#
#---------------------------      Figure 6a       -----------------------------#
#------------------------------------------------------------------------------#

df1 = readxl::read_xlsx("./Sensitivity analysis/figure6.xlsx",
                        sheet = "elev_noise")
fig6a = ggradar::ggradar(df1,
                         label.gridline.min = F,
                         label.gridline.mid = F,
                         label.gridline.max = F,
                         values.radar = c("0", "0.1", "0.3"),
                         gridline.mid.colour = "#e7aa21",
                         grid.min = 0,
                         grid.mid = 0.1,
                         grid.max = 0.3,
                         group.line.width = 0.75,
                         group.point.size = 2.05,
                         legend.position = "bottom")
fig6a

#------------------------------------------------------------------------------#
#---------------------------      Figure 6b       -----------------------------#
#------------------------------------------------------------------------------#

df2 = readxl::read_xlsx("./Sensitivity analysis/figure6.xlsx",
                        sheet = "popd_noise")
fig6b = ggradar::ggradar(df2,
                         label.gridline.min = F,
                         label.gridline.mid = F,
                         label.gridline.max = F,
                         values.radar = c("0", "0.1", "0.3"),
                         gridline.mid.colour = "#e7aa21",
                         grid.min = 0,
                         grid.mid = 0.1,
                         grid.max = 0.3,
                         group.line.width = 0.75,
                         group.point.size = 2.05,
                         legend.position = "bottom")
fig6b

#------------------------------------------------------------------------------#
#---------------------------      Figure 6c       -----------------------------#
#------------------------------------------------------------------------------#

df3 = readxl::read_xlsx("./Sensitivity analysis/figure6.xlsx",
                        sheet = "all_noise")
fig6c = ggradar::ggradar(df3,
                         label.gridline.min = F,
                         label.gridline.mid = F,
                         label.gridline.max = F,
                         values.radar = c("0", "0.1", "0.3"),
                         gridline.mid.colour = "#e7aa21",
                         grid.min = 0,
                         grid.mid = 0.1,
                         grid.max = 0.3,
                         group.line.width = 0.75,
                         group.point.size = 2.05,
                         legend.position = "bottom")
fig6c