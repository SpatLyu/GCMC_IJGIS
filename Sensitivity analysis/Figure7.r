#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~                  Figure 7                ~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

if (!requireNamespace("ggradar")) {
  devtools::install_github("ricardo-bion/ggradar", 
                           dependencies = TRUE)
}

#------------------------------------------------------------------------------#
#---------------------------      Figure 7a       -----------------------------#
#------------------------------------------------------------------------------#

df1 = readxl::read_xlsx("./Sensitivity analysis/figure7.xlsx",
                        sheet = "elev_noise")
fig7a = ggradar::ggradar(df1,
                         label.gridline.min = F,
                         label.gridline.mid = F,
                         label.gridline.max = F,
                         values.radar = c("0", "0.115", "0.3"),
                         gridline.mid.colour = "#e7aa21",
                         grid.min = 0,
                         grid.mid = 0.115,
                         grid.max = 0.3,
                         group.line.width = 0.75,
                         group.point.size = 2.05,
                         legend.position = "bottom")
fig7a

#------------------------------------------------------------------------------#
#---------------------------      Figure 7b       -----------------------------#
#------------------------------------------------------------------------------#

df2 = readxl::read_xlsx("./Sensitivity analysis/figure7.xlsx",
                        sheet = "popd_noise")
fig7b = ggradar::ggradar(df2,
                         label.gridline.min = F,
                         label.gridline.mid = F,
                         label.gridline.max = F,
                         values.radar = c("0", "0.115", "0.3"),
                         gridline.mid.colour = "#e7aa21",
                         grid.min = 0,
                         grid.mid = 0.115,
                         grid.max = 0.3,
                         group.line.width = 0.75,
                         group.point.size = 2.05,
                         legend.position = "bottom")
fig7b

#------------------------------------------------------------------------------#
#---------------------------      Figure 7c       -----------------------------#
#------------------------------------------------------------------------------#

df3 = readxl::read_xlsx("./Sensitivity analysis/figure7.xlsx",
                        sheet = "all_noise")
fig7c = ggradar::ggradar(df3,
                         label.gridline.min = F,
                         label.gridline.mid = F,
                         label.gridline.max = F,
                         values.radar = c("0", "0.115", "0.3"),
                         gridline.mid.colour = "#e7aa21",
                         grid.min = 0,
                         grid.mid = 0.115,
                         grid.max = 0.3,
                         group.line.width = 0.75,
                         group.point.size = 2.05,
                         legend.position = "bottom")
fig7c
