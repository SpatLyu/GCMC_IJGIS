#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~            Validation of GCMC in benchmark systems            ~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

# Remove all R objects
rm(list = ls())

# install required packages
if (!requireNamespace("fields")) install.packages("fields")
if (!requireNamespace("MASS")) install.packages("MASS")
if (!requireNamespace("spEDM")) install.packages("spEDM")

#-----------------------------------------------------------------------------#
#------           Simulate spatial distribution of three species        ------#
#-----------------------------------------------------------------------------#

sim_trispecies = \(nx, ny, seed = 123){
  grid = expand.grid(seq(0, 10, length.out = nx), 
                     seq(0, 10, length.out = ny))
  cov.fun = \(d, range = 1.5, sill = 1) sill * exp(-d/range)
  dist.mat = fields::rdist(grid)
  cov.mat = cov.fun(dist.mat, range = 1.5, sill = 1)
  set.seed(seed)
  res = replicate(3, {
    MASS::mvrnorm(1, rep(0, nrow(grid)), cov.mat) |>
      pmax(0) |>
      sdsfun::normalize_vector(0,1) |>
      matrix(nrow = nx, ncol = ny) |> 
      terra::rast()
  }, simplify = FALSE)
  terra::rast(res)
}

species = sim_trispecies(20, 20, seed = 42) 
names(species) = letters[1:3]
terra::plot(species, nc = 3)

s_val = terra::values(species)
stats::cor.test(s_val[,"a"], s_val[,"b"])
stats::cor.test(s_val[,"a"], s_val[,"c"])
stats::cor.test(s_val[,"b"], s_val[,"c"])

#-----------------------------------------------------------------------------#
#------                        Scenario 1: a→b→c                        ------#
#-----------------------------------------------------------------------------#

sim1 = spEDM::slm(species, x = "a", y = "b", z = "c", k = 4, step = 15, transient = 1, threshold = Inf,
                  alpha_x = 0.2, alpha_y = 0.2, alpha_z = 0.2, 
                  beta_xy = 1, beta_xz = 0, beta_yx = 0, beta_yz = 1, beta_zx = 0, beta_zy = 0)

species_scenario1 = species
terra::values(species_scenario1[["a"]]) = sim1$x
terra::values(species_scenario1[["b"]]) = sim1$y
terra::values(species_scenario1[["c"]]) = sim1$z
species_scenario1
terra::plot(species_scenario1)

spEDM::fnn(species_scenario1, "a", E = 1:25, 
           eps = stats::sd(terra::values(species_scenario1[["a"]]), na.rm = TRUE))
spEDM::fnn(species_scenario1, "b", E = 1:25, 
           eps = stats::sd(terra::values(species_scenario1[["b"]]), na.rm = TRUE))
spEDM::fnn(species_scenario1, "c", E = 1:25, 
           eps = stats::sd(terra::values(species_scenario1[["c"]]), na.rm = TRUE))

g1 = spEDM::gcmc(species_scenario1, "a", "b", E = 6, k = 120)
g1
g1$xmap

g2 = spEDM::gcmc(species_scenario1, "b", "c", E = 6, k = 120)
g2
g2$xmap

g3 = spEDM::gcmc(species_scenario1, "a", "c", E = 6, k = 120)
g3
g3$xmap

gcmc_s1 = list(g1, g2, g3)
readr::write_rds(gcmc_s1, "./Synthetic benchmark/gcmc_s1.rds")

g1 = spEDM::gccm(species_scenario1, "a", "b", E = 6, k = 8)
g2 = spEDM::gccm(species_scenario1, "b", "c", E = 6, k = 8)
g3 = spEDM::gccm(species_scenario1, "a", "c", E = 6, k = 8)

gccm_s1 = list(g1, g2, g3)
readr::write_rds(gccm_s1, "./Synthetic benchmark/gccm_s1.rds")

#-----------------------------------------------------------------------------#
#------                        Scenario 2: a→b←c                        ------#
#-----------------------------------------------------------------------------#

sim2 = spEDM::slm(species, x = "a", y = "b", z = "c", k = 4, step = 15, transient = 1, threshold = Inf,
                  alpha_x = 0.2, alpha_y = 0.2, alpha_z = 0.2, 
                  beta_xy = 1, beta_xz = 0, beta_yx = 0, beta_yz = 0, beta_zx = 0, beta_zy = 1)

species_scenario2 = species
terra::values(species_scenario2[["a"]]) = sim2$x
terra::values(species_scenario2[["b"]]) = sim2$y
terra::values(species_scenario2[["c"]]) = sim2$z
species_scenario2
terra::plot(species_scenario2)

spEDM::fnn(species_scenario2, "a", E = 1:25, 
           eps = stats::sd(terra::values(species_scenario2[["a"]]), na.rm = TRUE))
spEDM::fnn(species_scenario2, "b", E = 1:25, 
           eps = stats::sd(terra::values(species_scenario2[["b"]]), na.rm = TRUE))
spEDM::fnn(species_scenario2, "c", E = 1:25, 
           eps = stats::sd(terra::values(species_scenario2[["c"]]), na.rm = TRUE))

g1 = spEDM::gcmc(species_scenario2, "a", "b", E = 6, k = 72)
g1
g1$xmap

g2 = spEDM::gcmc(species_scenario2, "b", "c", E = 6, k = 72)
g2
g2$xmap

g3 = spEDM::gcmc(species_scenario2, "a", "c", E = 6, k = 72)
g3
g3$xmap

gcmc_s2 = list(g1, g2, g3)
readr::write_rds(gcmc_s2, "./Synthetic benchmark/gcmc_s2.rds")

g1 = spEDM::gccm(species_scenario2, "a", "b", E = 6, k = 8)
g2 = spEDM::gccm(species_scenario2, "b", "c", E = 6, k = 8)
g3 = spEDM::gccm(species_scenario2, "a", "c", E = 6, k = 8)

gccm_s2 = list(g1, g2, g3)
readr::write_rds(gccm_s2, "./Synthetic benchmark/gccm_s2.rds")

#-----------------------------------------------------------------------------#
#------                      Scenario 3: a←b→c                          ------#
#-----------------------------------------------------------------------------#

sim3 = spEDM::slm(species, x = "a", y = "b", z = "c", k = 4, step = 15, transient = 1, threshold = Inf,
                  alpha_x = 0.2, alpha_y = 0.2, alpha_z = 0.2, 
                  beta_xy = 0, beta_xz = 0, beta_yx = 1, beta_yz = 1, beta_zx = 0, beta_zy = 0)

species_scenario3 = species
terra::values(species_scenario3[["a"]]) = sim3$x
terra::values(species_scenario3[["b"]]) = sim3$y
terra::values(species_scenario3[["c"]]) = sim3$z
species_scenario3
terra::plot(species_scenario3)

spEDM::fnn(species_scenario3, "a", E = 1:25, 
           eps = stats::sd(terra::values(species_scenario3[["a"]]), na.rm = TRUE))
spEDM::fnn(species_scenario3, "b", E = 1:25, 
           eps = stats::sd(terra::values(species_scenario3[["b"]]), na.rm = TRUE))
spEDM::fnn(species_scenario3, "c", E = 1:25, 
           eps = stats::sd(terra::values(species_scenario3[["c"]]), na.rm = TRUE))

g1 = spEDM::gcmc(species_scenario3, "a", "b", E = 8, k = 160)
g1
g1$xmap

g2 = spEDM::gcmc(species_scenario3, "b", "c", E = 8, k = 160)
g2
g2$xmap

g3 = spEDM::gcmc(species_scenario3, "a", "c", E = 8, k = 160)
g3
g3$xmap

gcmc_s3 = list(g1, g2, g3)
readr::write_rds(gcmc_s3, "./Synthetic benchmark/gcmc_s3.rds")

g1 = spEDM::gccm(species_scenario3, "a", "b", E = 8, k = 10)
g2 = spEDM::gccm(species_scenario3, "b", "c", E = 8, k = 10)
g3 = spEDM::gccm(species_scenario3, "a", "c", E = 8, k = 10)

gccm_s3 = list(g1, g2, g3)
readr::write_rds(gccm_s3, "./Synthetic benchmark/gccm_s3.rds")
