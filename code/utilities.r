# Function and utilities ####

# A wrapper to export objects derived within a function to the global environment ####
# https://stackoverflow.com/questions/17484771/convenience-function-for-exporting-objects-to-the-global-environment
export_to_globenv <- function(...) {
  arg.list <- list(...)
  names <- all.names(match.call())[-1]
  for (i in seq_along(names)) assign(names[i],arg.list[[i]],.GlobalEnv)
}

# JAGS specifications ####
runjags.options(summary.warning=F,
                nodata.warning=F,
                inits.warning=F,
                rng.warning=F,
                blockignore.warning=F,
                blockcombine.warning=F,
                silent.jags=F,
                silent.runjags=F)

# Function for formatting summary results from a JAGS object ####
Statistics_Bayes = function(mod,ndigits=4) {
  format(round(as.data.frame(cbind(Mean = (mod$summary$statistics[,1]),
                                   "Lower 95 HPD" = (mod$HPD[,1]),
                                   "Upper 95 HPD" = (mod$HPD[,3]),
                                   SD = (mod$summary$statistics[,2]),
                                   Var = ((mod$summary$statistics[,2]^2)),
                                   SSeff = (mod$mcse$sseff),
                                   SSD = (mod$mcse$ssd),
                                   MCSE = (mod$mcse$mcse),
                                   "MC err %" = (100*(mod$mcse$mcse/mod$mcse$ssd)),
                                   "PSRF point" = (mod$psrf$psrf[,1]),
                                   "PSRF Upper CI" = (mod$psrf$psrf[,2]))), ndigits), nsmall = ndigits)}

# Load inits ####
inits = function(){
  list(
    F=max(min(rnorm(1,vital_rates[1],sqrt(vital_rates[2])),1),0),
    Gf=max(min(rnorm(1,vital_rates[3],sqrt(vital_rates[4])),1),0),
    Ss=max(min(rnorm(1,vital_rates[5],sqrt(vital_rates[6])),1),0),
    Sa=max(min(rnorm(1,vital_rates[7],sqrt(vital_rates[8])),1),0),
    beta=runif(5,0,0.01),
    sd.delta=runif(3,5,8),
    Tau=diag(0.1,3))
}


# Data and hyperpriors for the demographic parameters ####

load_data = function(TimePeriod){

  NStages=3

  # Fecundity
  F_mean = mean(c(0.818,0.785,0.740,0.698,0.770,0.670,0.710))
  F_var = var(c(0.818,0.785,0.740,0.698,0.770,0.670,0.710))

  # Fledgling recruitment
  Gf_mean =  mean(c(0.6462,0.871,0.710,0.560,0.60,0.688))
  Gf_var = var(c(0.6462,0.871,0.710,0.560,0.60,0.688))

  # Sub-adult survival
  Ss_mean = mean(c(0.9485,0.858,0.955,0.970,0.946,0.964))
  Ss_var = var(c(0.9485,0.858,0.955,0.970,0.946,0.964))

  # Adult survival
  Sa_mean = mean(c(0.9463,0.9485,0.8240,0.987,0.955,0.970,0.952,0.969))
  Sa_var = var(c(0.9463,0.9485,0.8240,0.987,0.955,0.970,0.952,0.969))

  data = readr::read_delim("data/data.csv", ";", escape_double = FALSE, trim_ws = TRUE, show_col_types = FALSE)

  if(TimePeriod == "PreBSE"){

    data_PreBSE = as.matrix(data[1:23,c("Year","Fledglings","Nonbreeding","Breeding")])
    data_PreBSE[1,4]=sample(100:176,1,TRUE)
    data_PreBSE[1,3]=176 - data_PreBSE[1,4]
    F_mean_PreBSE = mean(as.matrix(data[1:23,"Fledglings"])/as.matrix(data[1:23,"Breeding"]),na.rm =T)
    F_var_PreBSE = (sd(as.matrix(data[1:23,"Fledglings"])/as.matrix(data[1:23,"Breeding"]),na.rm =T))^2

    data = data_PreBSE
    vital_rates = c(F_mean_PreBSE,F_var_PreBSE,Gf_mean,Gf_var,Ss_mean,Ss_var,Sa_mean,Sa_var)
    NYears = nrow(data)

  }

  if(TimePeriod == "BSE"){

    data_BSE = as.matrix(data[24:33,c("Year","Fledglings","Nonbreeding","Breeding")])
    F_mean_BSE = mean(as.matrix(data[24:33,"Fledglings"])/as.matrix(data[24:33,"Breeding"]),na.rm =T)
    F_var_BSE = (sd(as.matrix(data[24:33,"Fledglings"])/as.matrix(data[24:33,"Breeding"]),na.rm =T))^2

    data = data_BSE
    vital_rates = c(F_mean_BSE,F_var_BSE,Gf_mean,Gf_var,Ss_mean,Ss_var,Sa_mean,Sa_var)
    NYears = nrow(data)

  }

  if(TimePeriod == "PostBSE"){

    data_PostBSE = as.matrix(data[34:42,c("Year","Fledglings","Nonbreeding","Breeding")])
    F_mean_PostBSE = mean(as.matrix(data[34:42,"Fledglings"])/as.matrix(data[34:42,"Breeding"]),na.rm =T)
    F_var_PostBSE = (sd(as.matrix(data[34:42,"Fledglings"])/as.matrix(data[34:42,"Breeding"]),na.rm =T))^2

    data = data_PostBSE
    vital_rates = c(F_mean_PostBSE,F_var_PostBSE,Gf_mean,Gf_var,Ss_mean,Ss_var,Sa_mean,Sa_var)
    NYears = nrow(data)

  }

  export_to_globenv(data,vital_rates,NYears,NStages)

}

# Function for a preliminary fit of the S4D3M ####
# This function will find the equilibrium population size during each period
find_equilibrium_population = function(TimePeriod,
                                       NStages = 3,
                                       n.chains = 3,
                                       adapt = 10000,
                                       burnin = 300000,
                                       sample = 1000,
                                       thin = 200,
                                       NSimulYears=201,
                                       NSimulations=100){

  if (!dir.exists(file.path("output",TimePeriod,"N_equil"))) {
    dir.create(file.path("output",TimePeriod,"N_equil"), showWarnings = TRUE, recursive = TRUE) }

  runjags.options(silent.jags=F,silent.runjags=F)

  # Model
  Model_init_run = "model {

  # State equation of the S4D3M: ####

    for(t in 2:NYears){

      w[t,1:NStages] ~ dmnorm(mu[t,1:NStages], Tau[,])

        mu[t,1] <- F*n[t-1,3]/(1 + beta[1]*N[t-1])

        mu[t,2] <- Gf*n[t-1,1]/(1 + beta[2]*N[t-1]) + Ss*n[t-1,2]/(1 + beta[3]*N[t-1])

        mu[t,3] <- Gs*n[t-1,2]/(1 + beta[4]*N[t-1]) + Sa*n[t-1,3]/(1 + beta[5]*N[t-1])

        # Total population size
        N[t-1] <- n[t-1,1] + n[t-1,2] + n[t-1,3]

      # Demographic stochasticity: ####
      for(i in 1:NStages){

        n[t,i] ~ dnorm(w[t,i], Dem.prec[t,i])

        Dem.var[t,i] <- delta[i]/n[t-1,i]
        Dem.prec[t,i] <- 1/Dem.var[t,i]

        }

    }

    # Initial states: ####
    for(i in 1:NStages){

      n[1,i] ~ dpois(y[1,i])

    }

    # Observation model: ####

    for(t in 2:NYears){

      for(i in 1:NStages){

        y[t,i] ~ dpois(n[t,i])

      }

    }

    # Total population size the last year of the series
    N[NYears] <- n[NYears,1] + n[NYears,2] + n[NYears,3]

  # Variances of latent states:

  for(i in 1:NStages){

    varn[i] <- pow(sd(n[,i]), 2)

  }

  varN <- pow(sd(N), 2)

  # Informative priors, including natural history data (See Table S1): ####

  F ~ dnorm(F_mean, 1/F_var)T(0,1)
  Gf ~ dnorm(Gf_mean, 1/(10*Gf_var))T(0,1)
  Ss ~ dnorm(Ss_mean, 1/(10*Ss_var))T(0,1)
  Gs <- 1 - Ss
  Sa ~ dnorm(Sa_mean, 1/(10*Sa_var))T(0,1)

  # SSVS, spike-and-slab prior ####

    for(j in 1:DDParam){

      beta[j] ~ dnorm(0, 1/tau.var[j])T(0,)

      tau.var[j] <- (1 - Prob_DensDep[j])*Var_when_inactive + Prob_DensDep[j]*Var_when_active
      Prob_DensDep[j] ~ dbern(Prior_Prob_DensDep)

    }

    Prior_Prob_DensDep ~ dbeta(2,2)

  # Environmental correlations among stages ####

    for(i in 1: NStages){

      n.sigma[i] <- sqrt(Sigma[i,i])
      n.sigma2[i] <- Sigma[i,i]

      delta[i] <- pow(sd.delta[i], 2)
      sd.delta[i] ~ dunif(0, 10)

    }

    # Residual environmental covariance matrix (Sigma): ####
    Sigma[1:NStages,1:NStages] <- inverse(Tau[,])
    Tau[1:NStages,1:NStages] ~ dscaled.wishart(rep(1,NStages), NStages)

}"

  data_list = list(
    NStages = 3,
    NYears = nrow(data),
    DDParam = 5,
    Var_when_inactive = 10^-4,
    Var_when_active = 0.1,
    F_mean = vital_rates[1],
    F_var = vital_rates[2],
    Gf_mean = vital_rates[3],
    Gf_var = vital_rates[4],
    Ss_mean = vital_rates[5],
    Ss_var = vital_rates[6],
    Sa_mean = vital_rates[7],
    Sa_var = vital_rates[8],
    y = data[,-1])

  parameters = c("F","Ss","Gs","Gf","Sa","beta","Prob_DensDep","delta","Sigma","varn","varN")

  message("Run a preliminary fitting of the SSSSDM to obtain posterior parameter values:")

  mod = run.jags(
    data=data_list,
    inits=inits,
    monitor=parameters,
    model=Model_init_run,
    n.chains = n.chains,
    adapt = adapt,
    burnin = burnin,
    sample = sample,
    thin = thin,
    method='parallel',
    modules = 'glm')

  summ_jags = mod$summaries

  varn = summ_jags[c("varn[1]","varn[2]","varn[3]"),"Mean"]
  varN = summ_jags["varN","Mean"]

  NStages = 3
  F = summ_jags["F","Mean"]
  Ss = summ_jags["Ss","Mean"]
  Gs = summ_jags["Gs","Mean"]
  Gf = summ_jags["Gf","Mean"]
  Sa = summ_jags["Sa","Mean"]
  beta = summ_jags[grep("beta", rownames(summ_jags)), "Mean"]
  delta = summ_jags[grep("delta", rownames(summ_jags)), "Mean"]
  y_true = matrix(c(data[1,"Fledglings"],data[1,"Nonbreeding"],data[1,"Breeding"]),1,NStages)
  Sigma = matrix(summ_jags[grep("Sigma", rownames(summ_jags)), "Mean"], NStages)

  n = array(NA, c(NSimulYears, NStages, NSimulations))
  w = array(NA, c(NSimulYears, NStages, NSimulations))
  mu = array(NA, c(NSimulYears, NStages, NSimulations))
  y = array(NA, c(NSimulYears, NStages, NSimulations))
  N = array(NA, c(NSimulYears, 1, NSimulations))

  for(s in 1:NSimulations){

    # Initial states:

    for(i in 1:NStages){

      n[1,i,s] = rpois(1, y_true[1,i])

    }

    for(t in 2:NSimulYears){

      # Total population size
      N[t-1,,s] <- n[t-1,1,s] + n[t-1,2,s] + n[t-1,3,s]

      mu[t,1,s] <- F*n[t-1,3,s]/(1 + beta[1]*N[t-1,,s])
      mu[t,2,s] <- Gf*n[t-1,1,s]/(1 + beta[2]*N[t-1,,s]) + Ss*n[t-1,2,s]/(1 + beta[3]*N[t-1,,s])
      mu[t,3,s] <- Gs*n[t-1,2,s]/(1 + beta[4]*N[t-1,,s]) + Sa*n[t-1,3,s]/(1 + beta[5]*N[t-1,,s])

      w[t,,s] = rmvnorm(1, mu[t,,s], Sigma)

      # Demographic stochasticity

      for(i in 1:NStages){

        n[t,i,s] = rnorm(1, w[t,i,s], delta[i]/n[t-1,i,s])

      }

    }

    for(i in 1:NStages){

      y[1,i,s] = y_true[1,i]

    }


    # Observation models:

    for(t in 2:NSimulYears){
      for(i in 1:NStages){

        y[t,i,s] = rpois(1, n[t,i,s])

      }
    }

    N[NSimulYears,,s] <- n[NSimulYears,1,s] + n[NSimulYears,2,s] + n[NSimulYears,3,s]

    if(s == 1){
      pdf(paste("output/",TimePeriod,"/N_equil","/Empirical_Neq.pdf",sep = ""))
      plot(N[,,s],col="red",t="l",xlab="Time",ylab="N",ylim=c(0,1200))}
    else{lines(N[,,s],col="red",t="l")}
    if(s == NSimulations){
      dev.off()}

    if(s == 1){
      SimTS = as.data.frame(cbind("Iteration"=rep(s,NSimulYears),
                                  "Year"=seq(1,NSimulYears,1),
                                  "Type"=rep("Simulation",NSimulYears),
                                  "N"=N[,,s]))
    }

    else {SimTS = rbind(SimTS,
                        as.data.frame(cbind("Iteration"=rep(s,NSimulYears),
                                            "Year"=seq(1,NSimulYears,1),
                                            "Type"=rep("Simulation",NSimulYears),
                                            "N"=N[,,s])))}

  }

  N_equil = as.numeric(unlist(SimTS[SimTS[,"Year"] %in% round(NSimulYears/2):NSimulYears,]["N"])) %>% subset(., . > 0)
  meanN_equil = mean(N_equil,na.rm = T)
  varN_equil = var(N_equil,na.rm = T)
  pdf(paste("output/",TimePeriod,"/N_equil","/Empirical_Dist_Neq.pdf",sep = ""))
  hist(N_equil,col="blue",xlab="N",main = "Density at equilibrium")
  dev.off()


  # Write results to a file
  suppressWarnings(write.table(file=paste("output/",TimePeriod,"/N_equil","/Empirical_Neq_data.csv",sep = ""),
                               SimTS,sep=";",
                               row.names = FALSE, col.names = TRUE, append = TRUE))

  assign(paste("varn_",TimePeriod,sep=""), varn, envir = .GlobalEnv)
  assign(paste("varN_",TimePeriod,sep=""), varN, envir = .GlobalEnv)
  assign(paste("meanN_equil_",TimePeriod,sep=""), meanN_equil, envir = .GlobalEnv)
  assign(paste("varN_equil_",TimePeriod,sep=""), varN_equil, envir = .GlobalEnv)

  save.image(paste("output/",TimePeriod,"/N_equil","/Equil_Size_results",".RData",sep = ""))

}

# Function for fitting the S4D3M to each time period ####
# This function

fit_S4D3M = function(TimePeriod,
                        n.chains = 3,
                        adapt = 10000,
                        burnin = 300000,
                        sample = 1000,
                        thin = 200,
                        mcmc_diagnostics_plots = TRUE,
                        PPC_simulations = TRUE,
                        N_PPC_Fits = 50,
                        burnin_ppc = 50000,
                        sample_ppc = 1000,
                        thin_ppc = 50) {

  # Model

  SSSSDM_model = read.jagsfile("code/S4D3M_JAGS_model.jags")

  if (!dir.exists(file.path("output",TimePeriod))) {
    dir.create(file.path("output",TimePeriod), showWarnings = TRUE, recursive = TRUE) }

  if(TimePeriod == "PreBSE"){
    varn = varn_PreBSE
    varN = varN_PreBSE
    meanN_equil = meanN_equil_PreBSE
    sdN_equil = sqrt(varN_equil_PreBSE)
  }

  if(TimePeriod == "BSE"){
    varn = varn_BSE
    varN = varN_BSE
    meanN_equil = meanN_equil_BSE
    sdN_equil = sqrt(varN_equil_BSE)
  }

  if(TimePeriod == "PostBSE"){
    varn = varn_PostBSE
    varN = varN_PostBSE
    meanN_equil = meanN_equil_PostBSE
    sdN_equil = sqrt(varN_equil_PostBSE)
  }

  data_list = list(
    NStages = NStages,
    NYears = NYears,
    DDParam = 5,
    Var_when_inactive = 10^-4,
    Var_when_active = 0.1,
    F_mean = vital_rates[1],
    F_var = vital_rates[2],
    Gf_mean = vital_rates[3],
    Gf_var = vital_rates[4],
    Ss_mean = vital_rates[5],
    Ss_var = vital_rates[6],
    Sa_mean = vital_rates[7],
    Sa_var = vital_rates[8],
    y = data[,-1],
    varn = varn,
    varN = varN,
    meanN_equil = meanN_equil)

  parameters = c("Prior_Prob_DensDep",
                 "Lef_F_DI","Lef_F_DD",
                 "Lef_Gf_DI","Lef_Gf_DD",
                 "Lef_Ss_DI","Lef_Ss_DD",
                 "Lef_Gs_DI","Lef_Gs_DD",
                 "Lef_Sa_DI","Lef_Sa_DD",
                 "var.fec","var.fledrec","var.subrec","var.subsurv","var.adsurv","var.envstoc","var.demstoc",
                 "beta","Prob_DensDep","TransR","PredR","delta","Sigma","Corr","n","y_ppc")

  mod = run.jags(
    data=data_list,
    inits=inits,
    monitor=parameters,
    model=SSSSDM_model,
    n.chains = n.chains,
    adapt = adapt,
    burnin = burnin,
    sample = sample,
    thin = thin,
    method='parallel',
    modules = 'glm',
    keep.jags.files=file.path(paste("output/",TimePeriod,"/runjagsfiles",sep = "")))

  sink(file= paste("output/",TimePeriod,"/Run_time",".txt",sep = ""))
  cat("Fitting of the bayesian model took", mod[["timetaken"]][[1]]/60, "minutes, or", mod[["timetaken"]][[1]]/3600, "hours.")
  sink()

  param_to_sum = add.summary(mod,vars = c("Prior_Prob_DensDep",
                                          "Lef_F_DI","Lef_F_DD",
                                          "Lef_Gf_DI","Lef_Gf_DD",
                                          "Lef_Ss_DI","Lef_Ss_DD",
                                          "Lef_Gs_DI","Lef_Gs_DD",
                                          "Lef_Sa_DI","Lef_Sa_DD",
                                          "var.fec","var.fledrec","var.subrec","var.subsurv","var.adsurv","var.envstoc","var.demstoc",
                                          "beta","Prob_DensDep","TransR","PredR","Sigma","delta","y_ppc","n"))

  Summary = tibble::rownames_to_column(Statistics_Bayes(param_to_sum, ndigits=4),"Parameter")

  summ_jags = summary(mod)
  assign(paste("runjagsobj_",TimePeriod,sep=""), mod, envir = .GlobalEnv)

  write.table(summ_jags, file = paste("output/",TimePeriod,"/Summary_Statistics",".csv",sep = ""), sep =";",
              row.names=TRUE, quote=FALSE)

  print.xtable(xtable(Summary), type= "html", file = paste("output/",TimePeriod,"/Summary_table",".html",sep = ""))
  print.xtable(xtable(Summary), type= "latex", file = paste("output/",TimePeriod,"/Summary_table",".tex",sep = ""))

  # Population growth rate from the Jacobian and the Lefkovitch matrix:
  post_vars=as.data.frame(combine.mcmc(as.mcmc.list(mod)))
  nloops = nrow(post_vars)

  Eigenvals = matrix(rep(NA,NStages*nloops),ncol=NStages,nrow=nloops)
  Lambda_A=NULL
  Lambda_J=NULL
  Lambda_asymptotic=NULL
  A = array(NA, c(NStages, NStages, nloops))
  J = array(NA, c(NStages, NStages, nloops))

  F = dplyr::select(post_vars, starts_with("Lef_F_DI"))
  Ss = dplyr::select(post_vars, starts_with("Lef_Ss_DI"))
  Gs = dplyr::select(post_vars, starts_with("Lef_Gs_DI"))
  Gf = dplyr::select(post_vars, starts_with("Lef_Gf_DI"))
  Sa = dplyr::select(post_vars, starts_with("Lef_Sa_DI"))
  beta = dplyr::select(post_vars, starts_with("beta"))

  for(i in 1:nloops){

    A[,,i] = matrix(c(0, 0,  F[i,]/(beta[1][i,]*rtruncnorm(1, a=0, b=Inf, meanN_equil,sdN_equil)+1),
                      Gf[i,]/(beta[2][i,]*rtruncnorm(1, a=0, b=Inf, meanN_equil,sdN_equil)+1),  Ss[i,]/(beta[3][i,]*rtruncnorm(1, a=0, b=Inf, meanN_equil,sdN_equil)+1),  0,
                      0,  Gs[i,]/(beta[4][i,]*rtruncnorm(1, a=0, b=Inf, meanN_equil,sdN_equil)+1),  Sa[i,]/(beta[5][i,]*rtruncnorm(1, a=0, b=Inf, meanN_equil,sdN_equil)+1)), 3, 3,
                    byrow = T)

    J[,,i] = matrix(c(0, 0,  (-F[i,]*beta[1][i,])/(beta[1][i,]*rtruncnorm(1, a=0, b=Inf, meanN_equil,sdN_equil)+1)^2,
                      (-Gf[i,]*beta[2][i,])/(beta[2][i,]*rtruncnorm(1, a=0, b=Inf, meanN_equil,sdN_equil)+1)^2,  (-Ss[i,]*beta[3][i,])/(beta[3][i,]*rtruncnorm(1, a=0, b=Inf, meanN_equil,sdN_equil)+1)^2,  0,
                      0,  (-Gs[i,]*beta[4][i,])/(beta[4][i,]*rtruncnorm(1, a=0, b=Inf, meanN_equil,sdN_equil)+1)^2,  (-Sa[i,]*beta[5][i,])/(beta[5][i,]*rtruncnorm(1, a=0, b=Inf, meanN_equil,sdN_equil)+1)^2), 3, 3,
                    byrow = T)

    Eigenvals[i,] = matrix(eigen(J[,,i])$values, nrow=1)
    Lambda_asymptotic[i] = max(Mod(eigen(J[,,i])$values))

    Lambda_A[i] = max(Re(eigen(A[,,i])$values))
    Lambda_J[i] = max(Re(eigen(J[,,i])$values))

  }

  mean_Jacobian = matrix(c(0,0,mean(J[1,3,]),
                           mean(J[2,1,]), mean(J[2,2,]), 0,
                           0, mean(J[3,2,]), mean(J[3,3,])), 3, 3, byrow = T)

  sd_Jacobian = matrix(c(0,0,sd(J[1,3,]),
                         sd(J[2,1,]), sd(J[2,2,]), 0,
                         0, sd(J[3,2,]), sd(J[3,3,])), 3, 3, byrow = T)


  assign(paste("Eigenvals_",TimePeriod,sep=""), Eigenvals, envir = .GlobalEnv)
  assign(paste("Lambda_asymptotic_",TimePeriod,sep=""), Lambda_asymptotic, envir = .GlobalEnv)
  assign(paste("Lambda_A_",TimePeriod,sep=""), Lambda_A, envir = .GlobalEnv)
  assign(paste("Lambda_J_",TimePeriod,sep=""), Lambda_J, envir = .GlobalEnv)
  assign(paste("mean_Jacobian_",TimePeriod,sep=""), mean_Jacobian, envir = .GlobalEnv)
  assign(paste("sd_Jacobian_",TimePeriod,sep=""), sd_Jacobian, envir = .GlobalEnv)

  # MCMC diagnostic tests

  if(mcmc_diagnostics_plots){

    if (!dir.exists(file.path("output",TimePeriod,"MCMC_diagnostics"))) {
      dir.create(file.path("output",TimePeriod,"MCMC_diagnostics"), showWarnings = TRUE, recursive = TRUE)}

    ggmcmc(ggs(as.mcmc.list(mod)),
           family = c("Prior_Prob_DensDep"),
           file = paste("output/",TimePeriod,"/MCMC_diagnostics/","MCMC_diagnostics_Prior_Prob_DensDep",".pdf",sep = ""),
           param_page = 5, width=8, height=11)

    ggmcmc(ggs(as.mcmc.list(mod)),
           family = c("beta"),
           file = paste("output/",TimePeriod,"/MCMC_diagnostics/","MCMC_diagnostics_beta",".pdf",sep = ""),
           param_page = 5, width=8, height=11)

    ggmcmc(ggs(as.mcmc.list(mod)),
           family = c("Prob_DensDep"),
           file = paste("output/",TimePeriod,"/MCMC_diagnostics/","MCMC_diagnostics_ProbDD",".pdf",sep = ""),
           param_page = 5, width=8, height=11)

    ggmcmc(ggs(as.mcmc.list(mod)),
           family = c("Lef_"),
           file = paste("output/",TimePeriod,"/MCMC_diagnostics/","MCMC_diagnostics_DemPar",".pdf",sep = ""),
           param_page = 10, width=8, height=13)

    ggmcmc(ggs(as.mcmc.list(mod)),
           family = c("Sigma"),
           file = paste("output/",TimePeriod,"/MCMC_diagnostics/","MCMC_diagnostics_Sigma",".pdf",sep = ""),
           param_page = 3, width=8, height=8)

  }

  # Posterior predicted simulations

  if(PPC_simulations){

    if (!dir.exists(file.path("output",TimePeriod,"PPC_Simulation"))) {
      dir.create(file.path("output",TimePeriod,"PPC_Simulation"), showWarnings = TRUE, recursive = TRUE)}

    # Assemble posterior predicted datasets
    param_to_sum = add.summary(mod, vars = c("y_ppc"))
    y_ppc_summary = tibble::rownames_to_column(Statistics_Bayes(param_to_sum, ndigits=4),"Parameter")

    write.table(y_ppc_summary, file = paste("output/",TimePeriod,"/PPC_Simulation","/y_ppc_summary",".csv",sep = ""), sep =";",
                row.names=FALSE, quote=FALSE)
    print.xtable(xtable(y_ppc_summary), type= "html",
                 file = paste("output/",TimePeriod,"/PPC_Simulation","/y_ppc_summary",".html",sep = ""))
    print.xtable(xtable(y_ppc_summary), type= "latex",
                 file = paste("output/",TimePeriod,"/PPC_Simulation","/y_ppc_summary",".tex",sep = ""))

    # Fitting of the SSSSD model to the posterior predicted data sets

    True_Value_DemPar = as_tibble(cbind("Rate"=c("Fecundity",
                                           "Sub-adult survival",
                                           "Sub-adult recruitment",
                                           "Fledgling recruitment",
                                           "Adult survival"),
                                         "True_Value"=(summ_jags[c("Lef_F_DI","Lef_Ss_DI","Lef_Gs_DI","Lef_Gf_DI","Lef_Sa_DI"),"Mean"])))

    colnames(data) = c("Year","Fledglings","Sub-adults","Adults")
    Observed = reshape2::melt(as.data.frame(data[,c("Year","Fledglings","Sub-adults","Adults")]),
                              id=c("Year"),
                              variable.name = "Stage",
                              value.name = "Observed")

    y_ppc_mcmc = dplyr::select(as.data.frame(combine.mcmc(as.mcmc.list(mod))), starts_with("y_ppc"))

    # Randomly select N_PPC_Fits rows from the posterior samples of y_ppc
    y_ppc_mcmc_fitting = dplyr::sample_n(y_ppc_mcmc, N_PPC_Fits)

    initial_time_global = proc.time()

    for(i in 1:N_PPC_Fits){

      counter = i

      initial_time_sim = proc.time()

      SSSSDM_model = read.jagsfile("code/S4D3M_JAGS_model.jags")

      # Save simulated time series:
      dat = matrix(y_ppc_mcmc_fitting[i,], nrow(data), NStages)
      colnames(dat) = c("Fledglings","Sub-adults","Adults")
      SimTS = as.data.frame(cbind("Iteration"=rep(i,NYears),
                                  "Year"=seq(data[1],data[dim(data)[1]],1),
                                  "Type"=rep("Simulation",NYears),dat))

      # Write results to a file
      if(i == 1){data.table::fwrite(SimTS, file = paste("output/",TimePeriod,"/PPC_Simulation/","SimTS_PreBSE",".csv",sep = ""),sep=";",
                                    row.names = FALSE, col.names = TRUE, append = TRUE)}

      else{data.table::fwrite(SimTS, file = paste("output/",TimePeriod,"/PPC_Simulation/","SimTS_PreBSE",".csv",sep = ""),sep=";",
                              row.names = FALSE, col.names = FALSE, append = TRUE)}


      # Perform posterior predictive checking:

      data_list = list(
        NStages = NStages,
        NYears = NYears,
        DDParam = 5,
        Var_when_inactive = 10^-4,
        Var_when_active = 0.1,
        F_mean = vital_rates[1],
        F_var = vital_rates[2],
        Gf_mean = vital_rates[3],
        Gf_var = vital_rates[4],
        Ss_mean = vital_rates[5],
        Ss_var = vital_rates[6],
        Sa_mean = vital_rates[7],
        Sa_var = vital_rates[8],
        y = dat,
        varn = varn,
        varN = varN,
        meanN_equil = meanN_equil)

      parameters = c("Lef_F_DI","Lef_Ss_DI","Lef_Gs_DI","Lef_Gf_DI","Lef_Sa_DI")

      mod_ppc = run.jags(
        data=data_list,
        inits=inits,
        monitor=parameters,
        model=SSSSDM_model,
        n.chains = 3,
        adapt = adapt,
        burnin = burnin_ppc,
        sample = sample_ppc,
        thin = thin_ppc,
        method='parallel',
        modules = 'glm')

      Posterior_fitted_Value = as.data.frame(tibble::rownames_to_column(Statistics_Bayes(mod_ppc, ndigits=4),"Parameter")[1:5,2])
      colnames(Posterior_fitted_Value) = "Posterior_fitted_Value"

      # Write results to a file
      if(counter == 1){write.table(file=paste("output/",TimePeriod,"/PPC_Simulation","/PPC_PreBSE_count_i",".csv",sep = ""),
                                   cbind(True_Value_DemPar, Posterior_fitted_Value),sep=";",
                                   row.names = FALSE, col.names = TRUE, append = TRUE)}

      else{write.table(file=paste("output/",TimePeriod,"/PPC_Simulation","/PPC_PreBSE_count_i",".csv",sep = ""),
                       cbind(True_Value_DemPar, Posterior_fitted_Value),sep=";",
                       row.names = FALSE, col.names = FALSE, append = TRUE)}

      final_time_sim = proc.time() - initial_time_sim
      final_time_global = proc.time() - initial_time_global
      message("Simulation number ", counter, " took ", round(final_time_sim[3],2), " sec., ", "total PPC is taking ", round(final_time_global[3]/60,2), " min...\n")

    }
  }

  # Plots:

  SimTS_full = reshape2::melt(as.data.frame(readr::read_delim(paste("output/",TimePeriod,"/PPC_Simulation/","SimTS_PreBSE",".csv",sep = ""),";",
                                                              escape_double = FALSE, trim_ws = TRUE, show_col_types = FALSE)),
                              id=c("Iteration","Year","Type"),
                              variable.name = "Stage",
                              value.name="Mean")

  plotTS = SimTS_full  %>%
    group_by(Stage,Year) %>%
    summarise(LCI_90 = quantile(Mean,  probs = 0.025),
              HCI_90 = quantile(Mean,  probs = 0.975),
              Mean = mean(Mean)) %>%
    bind_cols(.,as_tibble(Observed[,c("Observed")])) %>%
    ggplot(., aes(x=Year,y=Mean, colour=Stage)) +
    geom_line(aes(x=Year, y = Mean, group = Stage), size=0.4) +
    geom_ribbon(aes(ymin = LCI_90, ymax = HCI_90, fill=Stage), alpha = 0.2, linetype=0) +
    geom_point(aes(x=Year, y=value, col = Stage), size=2) +
    scale_y_continuous(limits = c(0,750)) +
    scale_color_startrek() +
    scale_fill_startrek() +
    theme_classic() +
    theme(axis.text=element_text(size=15),
          axis.title=element_text(size=15),
          plot.title = element_text(size=17)) +
    theme(legend.position = "none")

    if(TimePeriod == "PreBSE"){
      plotTS = plotTS  +
        theme(legend.position = c(0.2, 0.8)) +
        labs(title="D) Before BSE outbreak",
             x="Year",
             y="Predicted and observed Abundance")
    }

    if(TimePeriod == "BSE"){
      plotTS = plotTS  +
        labs(title="E) During BSE outbreak",
             x="Year",
             y="Predicted and observed Abundance")
    }

    if(TimePeriod == "PostBSE"){
      plotTS = plotTS  +
        labs(title="F) After BSE outbreak",
             x="Year",
             y="Predicted and observed Abundance")
    }

  ggsave(paste("output/",TimePeriod,"/PPC_Simulation/","SimTS_PreBSE",".pdf",sep = ""),plotTS,
         width=5, height=5, paper='special')

  assign(paste("plot_",TimePeriod,"_SimTS",sep=""), plotTS, envir = .GlobalEnv)

  PPC_to_plot_data = readr::read_delim(paste("output/",TimePeriod,"/PPC_Simulation","/PPC_PreBSE_count_i",".csv",sep = ""),";", escape_double = FALSE, trim_ws = TRUE, show_col_types = FALSE)
  PPC_to_plot_data$Rate = factor(PPC_to_plot_data$Rate, levels = c("Fecundity", "Fledgling recruitment", "Sub-adult recruitment", "Sub-adult survival", "Adult survival"))

  PPC_plot = PPC_to_plot_data %>%
    ggplot(., aes(x=True_Value, y=Posterior_fitted_Value, col=Rate)) +
    geom_abline(intercept = 0, slope = 1, colour="black", lwd=0.7) +
    geom_boxplot() +
    geom_point(size=0.7) +
    scale_x_continuous(limits = c(0,1.05)) +
    scale_y_continuous(limits = c(0,1.05)) +
    scale_color_viridis(discrete = TRUE, option = "D") +
    scale_fill_viridis(discrete = TRUE) +
    theme_bw() +
    theme(panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          axis.text=element_text(size=15),
          axis.title=element_text(size=15),
          plot.title = element_text(size=17)) +
    theme(legend.position="none")

  if(TimePeriod == "PreBSE"){
    PPC_plot = PPC_plot  +
      theme(legend.background = element_blank(),
            legend.box.background = element_blank(),
            legend.key = element_blank(),
            legend.position=c(0.2,0.75),
            legend.title = element_text(size = 12),
            legend.text = element_text(size = 8)) +
      labs(title="A) Before BSE outbreak",
           x = "Sampling posterior estimate",
           y = "Posterior estimates from simulated data")
  }

  if(TimePeriod == "BSE"){
    PPC_plot = PPC_plot  +
      labs(title="B) During BSE outbreak",
           x = "Sampling posterior estimate",
           y = "Posterior estimates from simulated data")
  }

  if(TimePeriod == "PostBSE"){
    PPC_plot = PPC_plot  +
      labs(title="C) After BSE outbreak",
           x = "Sampling posterior estimate",
           y = "Posterior estimates from simulated data")
  }

  ggsave(paste("output/",TimePeriod,"/PPC_Simulation","/PPC_PreBSE",".pdf",sep = ""),PPC_plot,
         width=5, height=5, paper='special')

  assign(paste("PPC_",TimePeriod,"_plot",sep=""), PPC_plot, envir = .GlobalEnv)

  save.image(paste("output/",TimePeriod,"/Rdata_Bayesian",".RData",sep = ""))

}

# Plot figures ####

Figures = function(){


  # Plot Fig. 1 ####

  data_ts_raw = read_delim("output/ppc_results.csv", ";", escape_double = FALSE, trim_ws = TRUE, show_col_types = FALSE )
  BSE_cases = read_delim("data/BSE_cases.csv", ";", escape_double = FALSE, trim_ws = TRUE, show_col_types = FALSE)
  Breeding_output = read_delim("data/Breeding_output.csv", ";", escape_double = FALSE, trim_ws = TRUE, show_col_types = FALSE)

  data_ts_raw$Stage = factor(data_ts_raw$Stage, levels=c("Fledglings", "Sub-adults", "Adults"))

  scaleFactor = 3

  plot_ts1a = ggplot(data_ts_raw,aes(x=Year, y=Estimated, colour=Stage)) +
    annotate("rect", xmin = 2002, xmax = 2011, ymin = 0, ymax = 700,
             alpha = .15) +
    geom_ribbon(aes(ymax = Upper95, ymin = Lower95, fill = Stage), alpha = 0.5, linetype=0) +
    geom_line(aes(x=Year, y = data_ts_raw$Estimated, group = Stage), size=0.6) +
    geom_point(aes(x=Year, y=Observed, col = Stage), size=1.5) +
    geom_line(aes(x=Year, y = data_ts_raw$`BSE cases`*scaleFactor), size=1, colour="orange") +
    scale_x_continuous(limits = c(1980,2020)) +
    scale_y_continuous(sec.axis = sec_axis(~./scaleFactor, name = "BSE cases")) +
    scale_color_startrek() +
    scale_fill_startrek() +
    theme_classic() +
    theme(axis.line.y.right = element_line(color = "orange"),
          axis.ticks.y.right = element_line(color = "orange"),
          axis.text=element_text(size=15),
          axis.title=element_text(size=17),
          plot.title = element_text(size=17),
          legend.position = c(0.2, 0.8)) +
    labs(title="A)", x="Year", y="Abundance")

  plot_ts1b = ggplot(Breeding_output,aes(x=Year, y=Breeding_output$`Breeding pairs (%)`, colour=Stage)) +
    annotate("rect", xmin = 2002, xmax = 2011, ymin = 0, ymax = 100,
             alpha = .15) +
    geom_line(aes(x=Year, y = Breeding_output$`Breeding pairs (%)`, group = Stage), size=1) +
    geom_point(aes(x=Year, y=Breeding_output$`Breeding pairs (%)`, col = Stage), size=2) +
    scale_x_continuous(limits=c(1980,2020)) +
    scale_y_continuous(limits=c(0,100)) +
    scale_color_uchicago() +
    scale_fill_uchicago() +
    theme_classic() +
    labs(title="B)", x="Year", y="Breeding pairs (%)") +
    theme(axis.text=element_text(size=15),
          axis.title=element_text(size=17),
          plot.title = element_text(size=17)) +
    theme(legend.background = element_blank(),
          legend.box.background = element_blank(),
          legend.key = element_blank(),
          legend.position = c(0.32, 0.9)) +
    theme(legend.key.size = unit(1, 'cm'), #change legend key size
          legend.key.height = unit(0.4, 'cm'), #change legend key height
          legend.key.width = unit(0.4, 'cm'), #change legend key width
          legend.title = element_text(size=11), #change legend title font size
          legend.text = element_text(size=9)) #change legend text font size

  plot_ts1c = ggplot(Breeding_output,aes(x=Year, y=Breeding_output$`Mean laying date`, colour=Stage)) +
    annotate("rect", xmin = 2002, xmax = 2011, ymin = 45, ymax = 120,
             alpha = .15) +
    geom_line(aes(x=Year, y = Breeding_output$`Mean laying date`, group = Stage), size=1) +
    geom_point(aes(x=Year, y=Breeding_output$`Mean laying date`, col = Stage), size=2) +
    scale_x_continuous(limits=c(1980,2020)) +
    scale_color_uchicago() +
    scale_fill_uchicago() +
    theme_classic() +
    theme(axis.text=element_text(size=15),
          axis.title=element_text(size=17),
          plot.title = element_text(size=17)) +
    labs(title="C)", x="Year", y="Mean laying date") +
    theme(legend.position = "none")

  plot_ts1d = ggplot(Breeding_output,aes(x=Year, y=Breeding_output$`Breeding success`, colour=Stage)) +
    annotate("rect", xmin = 2002, xmax = 2011, ymin = 0, ymax = 1,
             alpha = .15) +
    geom_line(aes(x=Year, y = Breeding_output$`Breeding success`, group = Stage), size=1) +
    geom_point(aes(x=Year, y=Breeding_output$`Breeding success`, col = Stage), size=2) +
    scale_x_continuous(limits=c(1980,2020)) +
    scale_y_continuous(limits=c(0,1)) +
    scale_color_uchicago() +
    scale_fill_uchicago() +
    theme_classic() +
    theme(axis.text=element_text(size=15),
          axis.title=element_text(size=17),
          plot.title = element_text(size=17)) +
    labs(title="D)", x="Year", y="Breeding success") +
    theme(legend.position = "none")

  Fig1 = plot_ts1a / plot_ts1b / plot_ts1c / plot_ts1d
  ggsave("output/Fig1.pdf",plot=Fig1, width=5, height=12, paper='special')
  ggsave("ms/figs/Fig1.pdf",plot=Fig1, width=5, height=12, paper='special')

  # Plot Fig. 2 ####

  # Demographic rates

  Lef_DI_PreBSE = reshape2::melt(
    as.data.frame(dplyr::select(as.data.frame(combine.mcmc(as.mcmc.list(runjagsobj_PreBSE))),ends_with("_DI"))),
    variable.name="DemRate",value.name="Value")
  Lef_DI_PreBSE = Lef_DI_PreBSE %>% mutate(Period = rep("PreBSE",nrow(Lef_DI_PreBSE)),
                                           Type = rep("Density-independent",nrow(Lef_DI_PreBSE)))

  Lef_DI_BSE = reshape2::melt(
    as.data.frame(dplyr::select(as.data.frame(combine.mcmc(as.mcmc.list(runjagsobj_BSE))),ends_with("_DI"))),
    variable.name="DemRate",value.name="Value")
  Lef_DI_BSE = Lef_DI_BSE %>% mutate(Period = rep("BSE",nrow(Lef_DI_BSE)),
                                     Type = rep("Density-independent",nrow(Lef_DI_BSE)))

  Lef_DI_PostBSE = reshape2::melt(
    as.data.frame(dplyr::select(as.data.frame(combine.mcmc(as.mcmc.list(runjagsobj_PostBSE))),ends_with("_DI"))),
    variable.name="DemRate",value.name="Value")
  Lef_DI_PostBSE = Lef_DI_PostBSE %>% mutate(Period = rep("PostBSE",nrow(Lef_DI_PostBSE)),
                                             Type = rep("Density-independent",nrow(Lef_DI_PostBSE)))

  Lef_DD_PreBSE = reshape2::melt(
    as.data.frame(dplyr::select(as.data.frame(combine.mcmc(as.mcmc.list(runjagsobj_PreBSE))),ends_with("_DD"))),
    variable.name="DemRate",value.name="Value")
  Lef_DD_PreBSE = Lef_DD_PreBSE %>% mutate(Period = rep("PreBSE",nrow(Lef_DD_PreBSE)),
                                           Type = rep("Density-dependent",nrow(Lef_DD_PreBSE)))

  Lef_DD_BSE = reshape2::melt(
    as.data.frame(dplyr::select(as.data.frame(combine.mcmc(as.mcmc.list(runjagsobj_BSE))),ends_with("_DD"))),
    variable.name="DemRate",value.name="Value")
  Lef_DD_BSE = Lef_DD_BSE %>% mutate(Period = rep("BSE",nrow(Lef_DD_BSE)),
                                     Type = rep("Density-dependent",nrow(Lef_DD_BSE)))

  Lef_DD_PostBSE = reshape2::melt(
    as.data.frame(dplyr::select(as.data.frame(combine.mcmc(as.mcmc.list(runjagsobj_PostBSE))),ends_with("_DD"))),
    variable.name="DemRate",value.name="Value")
  Lef_DD_PostBSE = Lef_DD_PostBSE %>% mutate(Period = rep("PostBSE",nrow(Lef_DD_PostBSE)),
                                             Type = rep("Density-dependent",nrow(Lef_DD_PostBSE)))


  Demographic_rates = rbind(Lef_DI_PreBSE, Lef_DI_BSE, Lef_DI_PostBSE,
                            Lef_DD_PreBSE, Lef_DD_BSE, Lef_DD_PostBSE)
  Demographic_rates$DemRate = gsub("_DI|_DD|Lef_", "", Demographic_rates$DemRate)
  Demographic_rates$DemRate = factor(Demographic_rates$DemRate, levels=c("F", "Gf", "Gs", "Ss", "Sa"))

  Demographic_rates_plot = ggplot(Demographic_rates, aes(x=DemRate, y=Value, fill=Type)) +
    geom_boxplot(width = 0.5, outlier.alpha = 0.05, outlier.shape = NA, notch = F) +
    facet_wrap(~factor(Period, levels=c('PreBSE','BSE','PostBSE'))) +
    theme_bw() +
    scale_fill_viridis(discrete = TRUE, option = "C") +
    theme(legend.position="top") +
    labs(title = "A", x = "Demographic rate", y = "Value") +
    theme(strip.text = element_text(size=16),
          plot.title = element_text(size=20),
          legend.text = element_text(size=16),
          axis.title = element_text(size=16),
          axis.text=element_text(size=15),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank())


  # Variance components
  VarComp_PreBSE = reshape2::melt(
    as.data.frame(dplyr::select(as.data.frame(combine.mcmc(as.mcmc.list(runjagsobj_PreBSE))),starts_with("var."))),
    variable.name="VarComp",value.name="Value")
  VarComp_PreBSE = VarComp_PreBSE %>% mutate(Period = rep("PreBSE",nrow(VarComp_PreBSE)))

  VarComp_BSE = reshape2::melt(
    as.data.frame(dplyr::select(as.data.frame(combine.mcmc(as.mcmc.list(runjagsobj_BSE))),starts_with("var."))),
    variable.name="VarComp",value.name="Value")
  VarComp_BSE = VarComp_BSE %>% mutate(Period = rep("BSE",nrow(VarComp_BSE)))

  VarComp_PostBSE = reshape2::melt(
    as.data.frame(dplyr::select(as.data.frame(combine.mcmc(as.mcmc.list(runjagsobj_PostBSE))),starts_with("var."))),
    variable.name="VarComp",value.name="Value")
  VarComp_PostBSE = VarComp_PostBSE %>% mutate(Period = rep("PostBSE",nrow(VarComp_PostBSE)))

  Variance_components = rbind(VarComp_PreBSE, VarComp_BSE, VarComp_PostBSE)
  Variance_components$VarComp = plyr::revalue(Variance_components$VarComp, c("var.fec"="Fecundity",
                                                                             "var.fledrec"="Fledgling recruitment",
                                                                             "var.subrec"="Sub-adult recruitment",
                                                                             "var.subsurv"="Sub-adult survival",
                                                                             "var.adsurv"="Adult survival",
                                                                             "var.envstoc"="Environmental stochasticity",
                                                                             "var.demstoc"="Demographic stochasticity"))
  Variance_components$Period = factor(Variance_components$Period, levels=c("PreBSE", "BSE", "PostBSE"))

  Variance_components_plot = ggplot(Variance_components, aes(x=VarComp, y=100*Value, fill=Period)) +
    geom_boxplot(width = 0.5, outlier.alpha = 0.05, outlier.shape = NA, notch = F) +
    scale_x_discrete(guide = guide_axis(n.dodge = 2)) +
    scale_fill_tron() +
    theme_bw() +
    theme(legend.position="top") +
    labs(title = "B", x="Variance component", y = "% of explained variance") +
    theme(plot.title = element_text(size=20),
          legend.text = element_text(size=15),
          axis.title = element_text(size=15),
          axis.text=element_text(size=12),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank())

  Fig2 = Demographic_rates_plot / Variance_components_plot
  ggsave("output/Fig2.pdf", plot = Fig2, width = 11, height = 10)
  ggsave("ms/figs/Fig2.pdf", plot = Fig2, width = 11, height = 10)

  # Plot Fig. 3 ####

  Lambda_A=reshape2::melt(as.data.frame(cbind(
    PreBSE = Lambda_A_PreBSE,
    BSE = Lambda_A_BSE,
    PostBSE = Lambda_A_PostBSE)),
    variable.name="Period",value.name="Lambda")

  Asymptotic_rate_of_increase_plot = ggpubr::ggdensity(Lambda_A, x = "Lambda",
                                                       add = "median",
                                                       rug = T,
                                                       xlim = c(0.85, 1.15),
                                                       color = "Period", fill = "Period",
                                                       palette = c("#FF3300", "#00CCFF", "#FFCC33"),
                                                       xlab = "Asymptotic rate of increase",
                                                       ylab = "Probability density") + geom_vline(xintercept = 1,
                                                                                                  color = "black")

  PredR_PreBSE = dplyr::select(as.data.frame(combine.mcmc(as.mcmc.list(runjagsobj_PreBSE))), starts_with("PredR"))
  PredR_BSE = dplyr::select(as.data.frame(combine.mcmc(as.mcmc.list(runjagsobj_BSE))), starts_with("PredR"))
  PredR_PostBSE = dplyr::select(as.data.frame(combine.mcmc(as.mcmc.list(runjagsobj_PostBSE))), starts_with("PredR"))

  colnames(PredR_PreBSE) = "PreBSE"
  colnames(PredR_BSE) = "BSE"
  colnames(PredR_PostBSE) = "PostBSE"

  Transient_Growth_Rate = reshape2::melt(as.data.frame(cbind(
    PredR_PreBSE,
    PredR_BSE,
    PredR_PostBSE)), variable.name="Period",value.name="Lambda")

  Transient_Growth_Rate_plot = ggpubr::ggdensity(Transient_Growth_Rate, x = "Lambda",
                                             add = "median",
                                             rug = T,
                                             xlim = c(0.85, 1.15),
                                             color = "Period", fill = "Period",
                                             palette = c("#FF3300", "#00CCFF", "#FFCC33"),
                                             xlab = "Transient rate of increase",
                                             ylab = "Probability density") + geom_vline(xintercept = 1,
                                                                                        color = "black")

  rate_of_increase_plots = Transient_Growth_Rate_plot / Asymptotic_rate_of_increase_plot
  rate_of_increase_plots = rate_of_increase_plots +  plot_annotation(tag_levels = 'A')

  pdf("output/Fig3.pdf",width=4, height=6, paper='special')
  print(rate_of_increase_plots)
  dev.off()
  pdf("ms/figs/Fig3.pdf",width=4, height=6, paper='special')
  print(rate_of_increase_plots)
  dev.off()

  # Plot Fig. 4 ####

  Fig_PPC = (PPC_PreBSE_plot + PPC_BSE_plot + PPC_PostBSE_plot)/(plot_PreBSE_SimTS + plot_BSE_SimTS + plot_PostBSE_SimTS)

  ggsave(file=paste("output/","Fig4",".pdf",sep = ""),plot=Fig_PPC,width=14.5, height=9, paper='special')
  ggsave(file=paste("ms/figs/","Fig4",".pdf",sep = ""),plot=Fig_PPC,width=14.5, height=9, paper='special')

  # Plot Fig. S3 ####

  Spectral_radius=reshape2::melt(as.data.frame(cbind(
    PreBSE = Lambda_asymptotic_PreBSE,
    BSE = Lambda_asymptotic_BSE,
    PostBSE = Lambda_asymptotic_PostBSE)),
    variable.name="Period",value.name="Lambda")

  Spectral_radius_plot = ggpubr::ggdensity(Spectral_radius, x = "Lambda",
                                           add = "median",
                                           rug = T,
                                           color = "Period", fill = "Period",
                                           palette = c("#FF3300", "#00CCFF", "#FFCC33"),
                                           xlab = "Spectral radius",
                                           ylab = "Probability density")

  pdf("output/FigS3.pdf", width=7, height=4, paper='special')
  print(Spectral_radius_plot)
  dev.off()
  pdf("ms/figs/FigS3.pdf", width=7, height=4, paper='special')
  print(Spectral_radius_plot)
  dev.off()

}

# END ####


