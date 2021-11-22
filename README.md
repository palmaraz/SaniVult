<div id="top"></div>

<br />

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://github.com/palmaraz/SaniVult/blob/master/LICENSE) [![DOI](https://zenodo.org/badge/429053003.svg)](https://zenodo.org/badge/latestdoi/429053003)

<br />

# The SaniVult project

<br />

<!-- TABLE OF CONTENTS -->

<summary>Table of Contents</summary>

<ol> <li> <a href="#about">About</a> <ul> <li><a href="#credit-authorship">CRediT authorship</a></li> </ul> <ul> <li><a href="#abstract">Abstract</a></li> </ul> <ul> <li><a href="#built-with">Built With</a></li> </ul> </li> <li> <a href="#reproducible-workflow">Reproducible workflow</a> <ul> <li><a href="#prerequisites">Prerequisites</a></li> <li><a href="#workflow">Workflow</a></li> </ul> </li> <li><a href="#roadmap">Roadmap</a></li> <li><a href="#license">License</a></li> <li><a href="#contact">Contact</a></li> <li><a href="#r-packages-used-in-this-project">R packages used in this project</a></li> </ol>

<br />

<!-- ABOUT THE PROJECT -->

## About

This is the GitHub hosting of the project [SaniVult](https://github.com/palmaraz/SaniVult). The paper associated to the project is published in the journal [Ecological Applications](https://esajournals.onlinelibrary.wiley.com/journal/19395582). See the `CITATION` file for a BibTex entry to the article. This folder contains the files needed to reproduce all the results of the project, and compile the manuscript of the associated paper.

### CRediT authorship

This project was conducted by:

· [Pablo Almaraz](https://scholar.google.es/citations?user=GDFS1v0AAAAJ&hl) (see [contact](#contact) below), which participated in study conception, designed and conducted the analyses, and led manuscript writing.

· [Guillermo Blanco](https://www.mncn.csic.es/es/quienes_somos/blanco-hervas-guillermo), which led and conceived the study, conducted the field surveys and participated in manuscript writing.

· [Félix Martínez](mailto:femolivas@gmail.com), which conducted the field surveys.

· [Zebensui Morales-Reyes](https://scholar.google.es/citations?user=44Sx6JsAAAAJ&hl=es), which contributed ideas and participated in manuscript writing.

· [José A. Sánchez Zapata](https://scholar.google.es/citations?user=GqacT-wAAAAJ&hl=es&oi=ao), which contributed ideas and participated in manuscript writing.

The major goal of the project is to evaluate the impacts of the outbreak of a [Bovine Spongiform Encephalopathy](https://www.efsa.europa.eu/en/topics/topic/bovine-spongiform-encephalopathy-bse) epidemic in Europe on the demographic and population dynamics of one of the world's largest colonies of the [Eurasian Griffon vulture](http://datazone.birdlife.org/species/factsheet/griffon-vulture-gyps-fulvus) (*Gyps fulvus*). The Eurasian Griffon vulture is a keystone scavenger providing fundamental ecosystem services worldwide. For further details, see the [abstract](#abstract) below and the file `ms/main_text.pdf`. Read the [published version of the paper](https://esajournals.onlinelibrary.wiley.com/journal/19395582).

<p align="right">(<a href="#top">back to top</a>)</p>

<br />

<!-- PROJECT LOGO -->

<p align="center">
  <a href="https://github.com/palmaraz/SaniVult">
    <img src="docs/imgs/Mario_Modesto_Mata_CC_BY-SA_(Gyps_fulvus).jpg" width="450" title="Attribution: Mario Modesto Mata / CC BY-SA (https://creativecommons.org/licenses/by-sa/3.0) Source: https://commons.wikimedia.org/wiki/File:Buitres_leonados_(Gyps_fulvus)_0.jpg">
  </a>
</p>

### Abstract

Scavenging is a key ecological process controlling energy flow in ecosystems and providing valuable ecosystem services worldwide. As long-lived species, the demographic dynamics of vultures can be disrupted by spatio-temporal fluctuations in food availability, with dramatic impacts on their population viability and the ecosystem services provided. In Europe, the outbreak of Bovine Spongiform Encephalopathy (BSE) in 2001 prompted a restrictive sanitary legislation banning the presence of livestock carcasses in the wild at a continental scale. In long-lived vertebrate species the buffering hypothesis predicts that the demographic traits with the largest contribution to population growth rate should be less temporally variable. The BSE outbreak provides a unique opportunity to test for the impact of demographic buffering in a keystone scavenger suffering abrupt but transient food shortages. We study the 42-year dynamics (1978-2020) of one of the world's largest breeding colonies of Eurasian griffon vultures (*Gyps fulvus*). We fitted an inverse Bayesian state-space model with density-dependent demographic rates to the time-series of stage-structured abundances to investigate shifts in vital rates and population dynamics before, during and after the implementation of a restrictive sanitary regulation. Prior to the BSE outbreak the dynamics was mainly driven by adult survival: 83% of temporal variance in abundance was explained by variability in this rate. Moreover, during this period the regulation of population size operated through density-dependent fecundity and sub-adult survival. However, after the onset of the European ban, a one-month delay in average laying date, a drop in fecundity and a reduction in the number of fledglings induced a transient increase in the impact of fledgling and sub-adult recruitment on dynamics. Although adult survival rate remained constantly high, as predicted by the buffering hypothesis, its relative impact on the temporal variance in abundance dropped to 71% during the sanitary legislation and to 54% after the ban was lifted. A significant increase in the relative impact of environmental stochasticity on dynamics was modeled after the BSE outbreak. These results provide empirical evidence on how abrupt environmental deterioration may induce dramatic demographic and dynamic changes in the populations of keystone scavengers, with far-reaching impacts on ecosystem functioning worldwide.

<p align="right">(<a href="#top">back to top</a>)</p>

### Built With

This is a [workflowr](https://jdblischak.github.io/workflowr/) project bootstraped by a suite of open-source tools.

-   [GNU/Linux](https://www.gnu.org/)
-   [ubuntu Budgie](https://ubuntubudgie.org/)
-   [GNU Make](https://www.gnu.org/software/make/)
-   [C++](https://isocpp.org/)
-   [gpp](https://logological.org/gpp)
-   [TexStudio](https://www.texstudio.org/)
-   [JAGS](https://sourceforge.net/projects/mcmc-jags/)
-   [R](https://cran.r-project.org/)
-   [RStudio](https://www.rstudio.com/)

A suite of [R](https://cran.r-project.org/) packages were used in this project. I am [grateful](https://github.com/Pakillo/grateful) to all the people involved in the development of these open-source packages. Run the following [R](https://cran.r-project.org/) command from within the project for producing a reference list of the packages used:

``` r
grateful::cite_packages(out.format = "rmd", out.dir = file.path(getwd(), "analysis"))
```

A list of these packages is placed at the [end](#r-packages-used-in-this-project) of this document.

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- GETTING STARTED -->

## Reproducible workflow

This section shows how to reproduce the results of the accompanying paper. The folder `./code` has the following structure:

``` bash
.
├── ./code
│   ├── ./code/S4D3M_JAGS_Fitting.R
│   ├── ./code/S4D3M_JAGS_model.jags
│   └── ./code/utilities.R
```

In this folder, the file `./code/utilities.R` contains all the functions and utilities necessary to conduct the analyses. The file `./code/S4D3M_JAGS_model.jags` contains the state-space stage-structured demographic density-dependent model ([S4D3M](https://github.com/palmaraz/SaniVult/blob/master/code/S4D3M_JAGS_model.jags)) developed in the [accompanying paper](https://esajournals.onlinelibrary.wiley.com/journal/19395582) written in the [JAGS](https://sourceforge.net/projects/mcmc-jags/) language.

The [data](https://github.com/palmaraz/SaniVult/tree/master/data) folder has the following structure:

``` bash
├── ./data
│   ├── ./data/Breeding_output.csv
│   ├── ./data/BSE_cases.csv
│   └── ./data/data.csv
```

The [manuscript](https://github.com/palmaraz/SaniVult/tree/master/ms) folder has the following structure:

``` bash
├── ms
│   ├── appendix.pdf
│   ├── appendix.tex
│   ├── arxiv.sty
│   ├── biblio.bib
│   ├── DataS1.zip
│   ├── figs
│   │   ├── Fig1.pdf
│   │   ├── Fig2.pdf
│   │   ├── Fig3.pdf
│   │   ├── Fig4.pdf
│   │   ├── FigS1.pdf
│   │   ├── FigS3.pdf
│   │   └── FigS4.pdf
│   ├── main_text.pdf
│   ├── main_text.tex
│   ├── MetadataS1.docx
│   └── MetadataS1.pdf
```

<p align="right">(<a href="#top">back to top</a>)</p>

#### Prerequisites

Prior to reproducing the results, make sure to have installed all the necessary software. In particular, you need [JAGS](https://sourceforge.net/projects/mcmc-jags/) and [R](https://cran.r-project.org/). The [R](https://cran.r-project.org/) libraries needed to reproduce the results (see [below](#r-packages-used-in-this-project)) will be automatically installed by the package [pacman](https://github.com/trinker/pacman).

### Workflow

Note that the [S4D3M](https://github.com/palmaraz/SaniVult/blob/master/code/S4D3M_JAGS_model.jags) is fitted through Bayesian MCMC methods using Gibbs sampling, and runs in [JAGS](https://sourceforge.net/projects/mcmc-jags/): even though [JAGS](https://sourceforge.net/projects/mcmc-jags/) is written in the [C++](https://isocpp.org/) language, the code can take several hours to run depending on the architecture used. Note that there are relatively easy ways of parallelizing this code.

You can reproduce the results of the accompanying paper with three methods:

1.  The first, easiest way to reproduce all the analyses in the project is to use the `Makefile`. With simple [GNU Make](https://www.gnu.org/software/make/) syntax, you can reproduce all the project, from statistical analyses to manuscript production. For example, in [GNU/Linux](https://www.gnu.org/) based systems, you can point with the command shell to the project folder and run the following command:

    ``` sh
    make all
    ```

    This command will first conduct all the statistical analyses in the project, and produce all the figures. It then will assemble and compile the manuscript and associated supplementary materials with the necessary figures. Finally, it will open the files. Alternatively, note that you can run this command within [RStudio](https://www.rstudio.com/) from the Terminal tab. 

2.  From within `R`, simply `source` the file `./code/S4D3M_JAGS_Fitting.R`. This will perform all the analyses of the paper in the required order.

3.  The final method is to open the R Markdown file `./analysis/index.Rmd` to interactively execute the workflow.

    <p align="right">(<a href="#top">back to top</a>)</p>

    <!-- ROADMAP -->

## Roadmap

-   [ ] Add links to the final files and web addresses.

-   [ ] Obtain the DOIs.

-   [x] Add back to top links

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- LICENSE -->

## License

Distributed under the MIT License. See `LICENSE` for more information.

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- CONTACT -->

## Contact

Pablo Almaraz - [\@palmaraz_Eco](https://twitter.com/palmaraz_Eco) - [palmaraz\@gmail.com](mailto:palmaraz@gmail.com)

Personal webpage: <https://palmaraz.github.io/>

Project Link: <https://github.com/palmaraz/SaniVult>

<p align="right">(<a href="#top">back to top</a>)</p>

# R packages used in this project

-   base (R Core Team 2021)
-   workflowr (Blischak, Carbonetto, and Stephens 2019)
-   rmarkdown (Xie, Dervieux, and Riederer 2020)
-   checkpoint (Ooi, de Vries, and Microsoft 2021)
-   coda (Plummer et al. 2006)
-   data.table (Dowle and Srinivasan 2021)
-   ggmcmc (Fernández-i-Marín 2016)
-   ggsci (Xiao 2018)
-   grateful (Rodríguez-Sánchez and Hutchins 2020)
-   mvtnorm (Genz and Bretz 2009)
-   pacman (Rinker and Kurkiewicz 2018)
-   patchwork (Pedersen 2020)
-   runjags (Denwood 2016)
-   tidyverse (Wickham et al. 2019)
-   truncnorm (Mersmann et al. 2018)
-   viridis (Garnier et al. 2021)
-   xtable (Dahl et al. 2019)
-   dplyr (Wickham et al. 2021)
-   ggpubr (Kassambara 2020)
-   plyr (Wickham 2011)
-   readr (Wickham and Hester 2021)
-   reshape2 (Wickham 2007)
-   tibble (Müller and Wickham 2021)

## References

Blischak, John D, Peter Carbonetto, and Matthew Stephens. 2019. Creating and Sharing Reproducible Research Code the Workflowr Way *F1000Research* 8 (1749). <https://doi.org/10.12688/f1000research.20843.1>.

Dahl, David B., David Scott, Charles Roosen, Arni Magnusson, and Jonathan Swinton. 2019. *Xtable: Export Tables to LaTeX or HTML*. <https://CRAN.R-project.org/package=xtable>.

Denwood, Matthew J. 2016. "<span class="nocase">runjags</span>: An R Package Providing Interface Utilities, Model Templates, Parallel Computing Methods and Additional Distributions for MCMC Models in JAGS." *Journal of Statistical Software* 71 (9): 1–25. <https://doi.org/10.18637/jss.v071.i09>.

Dowle, Matt, and Arun Srinivasan. 2021. *Data.table: Extension of 'Data.frame'*. <https://CRAN.R-project.org/package=data.table>.

Fernández-i-Marín, Xavier. 2016. "<span class="nocase">ggmcmc</span>: Analysis of MCMC Samples and Bayesian Inference." *Journal of Statistical Software* 70 (9): 1–20. <https://doi.org/10.18637/jss.v070.i09>.

Garnier, Simon, Ross, Noam, Rudis, Robert, Camargo, et al. 2021. <span
class="nocase">viridis</span> - Colorblind-Friendly Color Maps for r. <https://doi.org/10.5281/zenodo.4679424>.

Genz, Alan, and Frank Bretz. 2009. *Computation of Multivariate Normal and t Probabilities*. Lecture Notes in Statistics. Heidelberg: Springer-Verlag.

Kassambara, Alboukadel. 2020. *Ggpubr: 'Ggplot2' Based Publication Ready Plots*. <https://CRAN.R-project.org/package=ggpubr>.

Mersmann, Olaf, Heike Trautmann, Detlef Steuer, and Björn Bornkamp. *Truncnorm: Truncated Normal Distribution*. <https://CRAN.R-project.org/package=truncnorm>.

Müller, Kirill, and Hadley Wickham. 2021. *Tibble: Simple Data Frames*. <https://CRAN.R-project.org/package=tibble>.

Ooi, Hong, Andrie de Vries, and Microsoft. 2021. *Checkpoint: Install Packages from Snapshots on the Checkpoint Server for Reproducibility*. <https://CRAN.R-project.org/package=checkpoint>.

Pedersen, Thomas Lin. 2020. *Patchwork: The Composer of Plots*. <https://CRAN.R-project.org/package=patchwork>.

Plummer, Martyn, Nicky Best, Kate Cowles, and Karen Vines. 2006. "CODA: Convergence Diagnosis and Output Analysis for MCMC." *R News* 6 (1): 7–11. <https://journal.r-project.org/archive/>.

R Core Team. 2021. *R: A Language and Environment for Statistical Computing*. Vienna, Austria: R Foundation for Statistical Computing. <https://www.R-project.org/>.

Rinker, Tyler W., and Dason Kurkiewicz. 2018. <span
class="nocase">pacman</span>: Package Management for R. Buffalo, New York. <http://github.com/trinker/pacman>.

Rodríguez-Sánchez, Francisco, and Shaurita D. Hutchins. 2020. *Grateful: Facilitate Citation of r Packages*. <https://github.com/Pakillo/grateful>.

Wickham, Hadley. 2007. "Reshaping Data with the <span
class="nocase">reshape</span> Package." *Journal of Statistical Software* 21 (12): 1–20. <http://www.jstatsoft.org/v21/i12/>.

———. 2011. "The Split-Apply-Combine Strategy for Data Analysis." *Journal of Statistical Software* 40 (1): 1–29. <http://www.jstatsoft.org/v40/i01/>.

Wickham, Hadley, Mara Averick, Jennifer Bryan, Winston Chang, Lucy D'Agostino McGowan, Romain François, Garrett Grolemund, et al. 2019. "Welcome to the <span class="nocase">tidyverse</span>." *Journal of Open Source Software* 4 (43): 1686. <https://doi.org/10.21105/joss.01686>.

Wickham, Hadley, Romain François, Lionel Henry, and Kirill Müller. 2021. *Dplyr: A Grammar of Data Manipulation*. <https://CRAN.R-project.org/package=dplyr>.

Wickham, Hadley, and Jim Hester. 2021. *Readr: Read Rectangular Text Data*. <https://CRAN.R-project.org/package=readr>.

Xiao, Nan. 2018. *Ggsci: Scientific Journal and Sci-Fi Themed Color Palettes for 'Ggplot2'*. <https://CRAN.R-project.org/package=ggsci>.

Xie, Yihui, Christophe Dervieux, and Emily Riederer. 2020. *R Markdown Cookbook*. Boca Raton, Florida: Chapman; Hall/CRC. <https://bookdown.org/yihui/rmarkdown-cookbook>.

<p align="right">(<a href="#top">back to top</a>)</p>
