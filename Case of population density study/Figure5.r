#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~                  Figure 5                ~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

source('./Utils/plot_cs_matrix.r')

#------------------------------------------------------------------------------#
#---------------------------      Figure 5a       -----------------------------#
#------------------------------------------------------------------------------#

pcc = readxl::read_xlsx("./Case of population density study/Case of population density study.xlsx",
                        sheet = "pcc")
fig5a = plot_cs_matrix(pcc)
fig5a
ggplot2::ggsave('./Case of population density study/fig5a.png',
                fig5a, width = 3.65, height = 4.05, dpi = 300)

#------------------------------------------------------------------------------#
#---------------------------      Figure 5b       -----------------------------#
#------------------------------------------------------------------------------#

gd = readxl::read_xlsx("./Case of population density study/Case of population density study.xlsx",
                       sheet = "gd")
fig5b = plot_cs_matrix(gd)
fig5b
ggplot2::ggsave('./Case of population density study/fig5b.png',
                fig5b, width = 3.65, height = 4.05, dpi = 300)

#------------------------------------------------------------------------------#
#---------------------------      Figure 5c       -----------------------------#
#------------------------------------------------------------------------------#

directlingam = readxl::read_xlsx("./Case of population density study/Case of population density study.xlsx",
                                 sheet = "directlingam")
fig5c = plot_cs_matrix(directlingam)
fig5c
ggplot2::ggsave('./Case of population density study/fig5c.png',
                fig5c, width = 3.65, height = 4.05, dpi = 300)

#------------------------------------------------------------------------------#
#---------------------------      Figure 5d       -----------------------------#
#------------------------------------------------------------------------------#

gccm = readxl::read_xlsx("./Case of population density study/Case of population density study.xlsx",
                         sheet = "gccm")
fig5d = plot_cs_matrix(gccm)
fig5d
ggplot2::ggsave('./Case of population density study/fig5d.png',
                fig5d, width = 3.65, height = 4.05, dpi = 300)

#------------------------------------------------------------------------------#
#---------------------------      Figure 5e       -----------------------------#
#------------------------------------------------------------------------------#

gcmc = readxl::read_xlsx("./Case of population density study/Case of population density study.xlsx",
                         sheet = "gcmc")
fig5e = plot_cs_matrix(gcmc)
fig5e
ggplot2::ggsave('./Case of population density study/fig5e.png',
                fig5e, width = 3.65, height = 4.05, dpi = 300)
