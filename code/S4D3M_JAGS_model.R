# SSSSDDDM ####

model {

    # State equation of the SSSSDDDM: ####
    for(t in 2:NYears){

      w[t,1:NStages] ~ dmnorm(mu[t,1:NStages], Tau[,])

        mu[t,1] <- F*n[t-1,3]/(1 + beta[1]*N[t-1])

        mu[t,2] <- Gf*n[t-1,1]/(1 + beta[2]*N[t-1]) + Ss*n[t-1,2]/(1 + beta[3]*N[t-1])

        mu[t,3] <- Gs*n[t-1,2]/(1 + beta[4]*N[t-1]) + Sa*n[t-1,3]/(1 + beta[5]*N[t-1])

        # Total population size
        N[t-1] <- n[t-1,1] + n[t-1,2] + n[t-1,3]

      # Demographic stochasticity:
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

        # Posterior predicted datasets
        y_ppc[t,i] ~ dpois(n[t,i])

      }

    }

    # Total population size the last year of the series
    N[NYears] <- n[NYears,1] + n[NYears,2] + n[NYears,3]

    # Predicted population size the first year of the series: ####
    for(i in 1:NStages){

      y_ppc[1,i] ~ dpois(n[1,i])

    }

    # Total posterior predicted population size: ####
    for(t in 1:NYears){

      Y_ppc[t] <- y_ppc[t,1] + y_ppc[t,2] + y_ppc[t,3]

    }

    # Observed and predicted population growth rate: ####

    for(t in 2:NYears){

      Rreal[t] <- N[t]/N[t-1]
      Rppc[t] <- Y_ppc[t]/Y_ppc[t-1]

    }

    Rreal[1] <- Rreal[2]
    Rppc[1] <- Rppc[2]

  TransR <- mean(Rreal)
  PredR <- mean(Rppc)

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

      # Bayes factor ####
      # BF[j] <- (Prob_DensDep[j]/(1-Prob_DensDep[j]))*((1-Prior_Prob_DensDep)/Prior_Prob_DensDep)

    }

    Prior_Prob_DensDep ~ dbeta(2,2)

    # Lefkovitch matrix entries, density-independent ####
    Lef_F_DI <- F
    Lef_Gf_DI <- Gf
    Lef_Ss_DI <- Ss
    Lef_Gs_DI <- Gs
    Lef_Sa_DI <- Sa

    # Lefkovitch matrix entries, density-dependent, evaluated at the equilibrium ####
    Lef_F_DD <- F/(1 + beta[1]*meanN_equil)
    Lef_Gf_DD <- Gf/(1 + beta[2]*meanN_equil)
    Lef_Ss_DD <- Ss/(1 + beta[3]*meanN_equil)
    Lef_Gs_DD <- Gs/(1 + beta[4]*meanN_equil)
    Lef_Sa_DD <- Sa/(1 + beta[5]*meanN_equil)

  # Environmental correlations among stages ####

    for(i in 1: NStages){

      for(j in 1:NStages){

       Corr[i,j] <- Sigma[i,j]/sqrt(Sigma[i,i]*Sigma[j,j])

      }

      n.sigma[i] <- sqrt(Sigma[i,i])
      n.sigma2[i] <- Sigma[i,i]

      delta[i] <- pow(sd.delta[i], 2)
      sd.delta[i] ~ dunif(0, 10)

    }

    # Residual environmental covariance matrix (Sigma): ####
    Sigma[1:NStages,1:NStages] <- inverse(Tau[,])
    Tau[1:NStages,1:NStages] ~ dscaled.wishart(rep(1,NStages), NStages)

    # Proportions of total variance explained: ####

    var.tot.fledg <- (pow(F,2)*varn[3])/pow(1 + beta[1]*varN, 2) + n.sigma2[1] + (delta[1]/varn[1])
    var.tot.nonbr <- (pow(Gf,2)*varn[1])/pow(1 + beta[2]*varN, 2) + (pow(Ss,2)*varn[2])/pow(1 + beta[3]*varN, 2) + n.sigma2[2] + (delta[2]/varn[2])
    var.tot.breed <- (pow(Gs,2)*varn[2])/pow(1 + beta[4]*varN, 2) + (pow(Sa,2)*varn[3])/pow(1 + beta[5]*varN, 2) + n.sigma2[3] + (delta[3]/varn[3])
    var.total <- var.tot.fledg + var.tot.nonbr + var.tot.breed

    var.fec <- ((pow(F,2)*varn[3])/pow(1 + beta[1]*varN, 2))/var.total
    var.fledrec <- ((pow(Gf,2)*varn[1])/pow(1 + beta[2]*varN, 2))/var.total
    var.subrec <- ((pow(Ss,2)*varn[2])/pow(1 + beta[3]*varN, 2))/var.total
    var.subsurv <- ((pow(Gs,2)*varn[2])/pow(1 + beta[4]*varN, 2))/var.total
    var.adsurv <- ((pow(Sa,2)*varn[3])/pow(1 + beta[5]*varN, 2))/var.total
    var.envstoc <- (n.sigma2[1] + n.sigma2[2] + n.sigma2[3])/var.total
    var.demstoc <- ((delta[1]/varn[1]) + (delta[2]/varn[2]) + (delta[3]/varn[3]))/var.total

    Var.total <- var.fec + var.fledrec + var.subrec + var.subsurv + var.adsurv + var.envstoc + var.demstoc

}
