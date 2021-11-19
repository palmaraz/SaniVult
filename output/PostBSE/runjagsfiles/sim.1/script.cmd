load glm
model in "model.txt"
data in "data.txt"
compile, nchains(1)
parameters in "inits1.txt", chain(1)
initialize
adapt 10000
update 500000
monitor Prior_Prob_DensDep, thin(500)
monitor Lef_F_DI, thin(500)
monitor Lef_F_DD, thin(500)
monitor Lef_Gf_DI, thin(500)
monitor Lef_Gf_DD, thin(500)
monitor Lef_Ss_DI, thin(500)
monitor Lef_Ss_DD, thin(500)
monitor Lef_Gs_DI, thin(500)
monitor Lef_Gs_DD, thin(500)
monitor Lef_Sa_DI, thin(500)
monitor Lef_Sa_DD, thin(500)
monitor var.fec, thin(500)
monitor var.fledrec, thin(500)
monitor var.subrec, thin(500)
monitor var.subsurv, thin(500)
monitor var.adsurv, thin(500)
monitor var.envstoc, thin(500)
monitor var.demstoc, thin(500)
monitor beta, thin(500)
monitor Prob_DensDep, thin(500)
monitor TransR, thin(500)
monitor PredR, thin(500)
monitor delta, thin(500)
monitor Sigma, thin(500)
monitor Corr, thin(500)
monitor n, thin(500)
monitor y_ppc, thin(500)
update 500000
parameters to "out1.Rdump", chain(1)
coda *, stem(sim.1/CODA)
samplers to sim.1/samplers.csv
update 0
model clear
exit
