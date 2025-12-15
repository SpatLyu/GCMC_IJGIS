#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~                  Figure 6                ~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

source('./Utils/plot_cs_matrix.r')

#------------------------------------------------------------------------------#
#---------------------------      Figure 6a       -----------------------------#
#------------------------------------------------------------------------------#

pcc = readxl::read_xlsx("./Case of net primary productivity study/Case of net primary productivity study.xlsx",
                        sheet = "pcc")
fig6a = plot_cs_matrix(pcc)
fig6a
ggplot2::ggsave('./Case of net primary productivity study/fig6a.png',
                fig6a, width = 3.65, height = 4.05, dpi = 300)

#------------------------------------------------------------------------------#
#---------------------------      Figure 6b       -----------------------------#
#------------------------------------------------------------------------------#

gd = readxl::read_xlsx("./Case of net primary productivity study/Case of net primary productivity study.xlsx",
                       sheet = "gd")
fig6b = plot_cs_matrix(gd)
fig6b
ggplot2::ggsave('./Case of net primary productivity study/fig6b.png',
                fig6b, width = 3.65, height = 4.05, dpi = 300)

#------------------------------------------------------------------------------#
#---------------------------      Figure 6b       -----------------------------#
#------------------------------------------------------------------------------#

directlingam = readxl::read_xlsx("./Case of net primary productivity study/Case of net primary productivity study.xlsx",
                                 sheet = "directlingam")
fig6c = plot_cs_matrix(directlingam)
fig6c
ggplot2::ggsave('./Case of net primary productivity study/fig6c.png',
                fig6c, width = 3.65, height = 4.05, dpi = 300)

#------------------------------------------------------------------------------#
#---------------------------      Figure 6d       -----------------------------#
#------------------------------------------------------------------------------#

gccm = readxl::read_xlsx("./Case of net primary productivity study/Case of net primary productivity study.xlsx",
                         sheet = "gccm")
fig6d = plot_cs_matrix(gccm)
fig6d
ggplot2::ggsave('./Case of net primary productivity study/fig6d.png',
                fig6d, width = 3.65, height = 4.05, dpi = 300)

#------------------------------------------------------------------------------#
#---------------------------      Figure 6e       -----------------------------#
#------------------------------------------------------------------------------#

gcmc = readxl::read_xlsx("./Case of net primary productivity study/Case of net primary productivity study.xlsx",
                         sheet = "gcmc")
fig6e = plot_cs_matrix(gcmc)
fig6e
ggplot2::ggsave('./Case of net primary productivity study/fig6e.png',
                fig6e, width = 3.65, height = 4.05, dpi = 300)
