#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~                  Figure 7                ~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

source('./Utils/plot_cs_matrix.r')

#------------------------------------------------------------------------------#
#---------------------------      Figure 7a       -----------------------------#
#------------------------------------------------------------------------------#

pcc = readxl::read_xlsx("./Case of net primary productivity study/Case of net primary productivity study.xlsx",
                        sheet = "pcc")
fig7a = plot_cs_matrix(pcc)
fig7a
ggplot2::ggsave('./Case of net primary productivity study/fig7a.png',
                fig7a, width = 3.65, height = 4.05, dpi = 300)

#------------------------------------------------------------------------------#
#---------------------------      Figure 7b       -----------------------------#
#------------------------------------------------------------------------------#

gd = readxl::read_xlsx("./Case of net primary productivity study/Case of net primary productivity study.xlsx",
                       sheet = "gd")
fig7b = plot_cs_matrix(gd)
fig7b
ggplot2::ggsave('./Case of net primary productivity study/fig7b.png',
                fig7b, width = 3.65, height = 4.05, dpi = 300)

#------------------------------------------------------------------------------#
#---------------------------      Figure 7c       -----------------------------#
#------------------------------------------------------------------------------#

directlingam = readxl::read_xlsx("./Case of net primary productivity study/Case of net primary productivity study.xlsx",
                                 sheet = "directlingam")
fig7c = plot_cs_matrix(directlingam)
fig7c
ggplot2::ggsave('./Case of net primary productivity study/fig7c.png',
                fig7c, width = 3.65, height = 4.05, dpi = 300)

#------------------------------------------------------------------------------#
#---------------------------      Figure 7d       -----------------------------#
#------------------------------------------------------------------------------#

gccm = readxl::read_xlsx("./Case of net primary productivity study/Case of net primary productivity study.xlsx",
                         sheet = "gccm")
fig7d = plot_cs_matrix(gccm)
fig7d
ggplot2::ggsave('./Case of net primary productivity study/fig7d.png',
                fig7d, width = 3.65, height = 4.05, dpi = 300)

#------------------------------------------------------------------------------#
#---------------------------      Figure 7e       -----------------------------#
#------------------------------------------------------------------------------#

gcmc = readxl::read_xlsx("./Case of net primary productivity study/Case of net primary productivity study.xlsx",
                         sheet = "gcmc")
fig7e = plot_cs_matrix(gcmc)
fig7e
ggplot2::ggsave('./Case of net primary productivity study/fig7e.png',
                fig7e, width = 3.65, height = 4.05, dpi = 300)
