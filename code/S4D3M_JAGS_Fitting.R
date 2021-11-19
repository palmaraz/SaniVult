if (!require(checkpoint)) install.packages('checkpoint')
# checkpoint::checkpoint("2021-11-18")

if (!require(pacman)) install.packages('pacman')
pacman::p_load(tidyverse,runjags,coda,ggmcmc,xtable,data.table,viridis,ggsci,patchwork,mvtnorm,truncnorm)

source("code/utilities.r")

# All periods ####

for(TimePeriod in c("PreBSE","BSE","PostBSE")){

  # Loada data: ####
  load_data(TimePeriod)

  # Find the equilibrium population and the variance of state variables: ####
  find_equilibrium_population(TimePeriod,
                              adapt = 10000,
                              burnin = 100000,
                              sample = 1000,
                              thin = 100)

  # Fit the SSSSDDDM: ####
  fit_S4D3M(TimePeriod,
               n.chains = 3,
               adapt = 10000,
               burnin = 500000,
               sample = 1000,
               thin = 500,
               mcmc_diagnostics_plots = TRUE,
               PPC_simulations = TRUE,
               N_PPC_Fits = 50,
               burnin_ppc = 100000,
               sample_ppc = 1000,
               thin_ppc = 100)

  }

# Plot Figures ####

Figures()
