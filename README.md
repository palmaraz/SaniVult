<div id="top"></div>

<br />

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://github.com/palmaraz/SaniVult/blob/master/LICENSE)

<br />

# The SaniVult project

<br />

<!-- TABLE OF CONTENTS -->

<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about">About</a>
      <ul>
        <li><a href="#abstract">Abstract</a></li>
      </ul>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#reproducible-workflow">Reproducible workflow</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#workflow">Workflow</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#folder-structure">Folder structure</a></li>
  </ol>
</details>

<br />

<!-- ABOUT THE PROJECT -->

## About

This is the GitHub hosting of the project [SaniVult](https://github.com/palmaraz/SaniVult). The paper associated to the project is published in the journal [Ecological Applications](https://esajournals.onlinelibrary.wiley.com/journal/19395582). See the `CITATION`for a BibTex entry to the article. This folder contains the files needed to reproduce all the results of the project, and compile the manuscript of the associated paper.

The major goal of the project is to evaluate the impacts of the outbreak of a Bovine Spongiform Encephalopathy epidemic on the demographic and population dynamics of one of the world's largest colony of the Eurasian Griffon vulture (*Gyps fulvus*). The Eurasian Griffon vulture is a keystone scavenger providing fundamental ecosystem services. For further details, see the **abstract** below and the file `ms/main_text.pdf`. Read the published version of the paper.

<p align="right">(<a href="#top">back to top</a>)</p>

<br />

<!-- PROJECT LOGO -->
<p align="center">
  <a href="https://github.com/palmaraz/SaniVult">
    <img src="docs/imgs/Mario_Modesto_Mata_CC_BY-SA_(Gyps_fulvus).jpg" width="450" title="Attribution: Mario Modesto Mata / CC BY-SA (https://creativecommons.org/licenses/by-sa/3.0) Source: https://commons.wikimedia.org/wiki/File:Buitres_leonados_(Gyps_fulvus)_0.jpg">
  </a>
</p>


### Abstract

Scavenging is a key ecological process controlling energy flow in ecosystems and providing valuable ecosystem services worldwide. As long-lived species, the demographic dynamics of vultures can be disrupted by spatio-temporal fluctuations in food availability, with dramatic impacts on their population viability and the ecosystem services provided. In Europe, the outbreak of Bovine Spongiform Encephalopathy (BSE) in 2001 prompted a restrictive sanitary legislation banning the presence of livestock carcasses in the wild at a continental scale. In long-lived vertebrate species the buffering hypothesis predicts that the demographic traits with the largest contribution to population growth rate should be less temporally variable. The BSE outbreak provides a unique opportunity to test for the impact of demographic buffering in a keystone scavenger suffering abrupt but transient food shortages. We study the 42-year dynamics (1978-2020) of one of the world’s largest breeding colonies of Eurasian griffon vultures (*Gyps fulvus*). We fitted an inverse Bayesian state-space model with density-dependent demographic rates to the time-series of stage-structured abundances to investigate shifts in vital rates and population dynamics before, during and after the implementation of a restrictive sanitary regulation. Prior to the BSE outbreak the dynamics was mainly driven by adult survival: 83% of temporal variance in abundance was explained by variability in this rate. Moreover, during this period the regulation of population size operated through density-dependent fecundity and sub-adult survival. However, after the onset of the European ban, a one-month delay in average laying date, a drop in fecundity and a reduction in the number of fledglings induced a transient increase in the impact of fledgling and sub-adult recruitment on dynamics. Although adult survival rate remained constantly high, as predicted by the buffering hypothesis, its relative impact on the temporal variance in abundance dropped to 71% during the sanitary legislation and to 54% after the ban was lifted. A significant increase in the relative impact of environmental stochasticity on dynamics was modeled after the BSE outbreak. These results provide empirical evidence on how abrupt environmental deterioration may induce dramatic demographic and dynamic changes in the populations of keystone scavengers, with far-reaching impacts on ecosystem functioning worldwide.

<p align="right">(<a href="#top">back to top</a>)</p>

### Built With

This is a [workflowr](https://github.com/jdblischak/workflowr) project bootstraped by a suite of open-source tools.

-   [GNU/Linux](https://www.gnu.org/)
-   [Ubuntu Budgie](https://ubuntubudgie.org/)
-   [GNU Make](https://www.gnu.org/software/make/)
-   [TexStudio](https://www.texstudio.org/)
-   [JAGS](https://sourceforge.net/projects/mcmc-jags/)
-   [R](https://cran.r-project.org/)
-   [RStudio](https://www.rstudio.com/)

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- GETTING STARTED -->

## Reproducible workflow

This section shows how to reproduce the results of the accompanying paper. The folder `./code` has the following structure:

```bash
.
├── ./code
│   ├── ./code/S4D3M_JAGS_Fitting.R
│   ├── ./code/S4D3M_JAGS_model.R
│   └── ./code/utilities.r

```

In this folder, the file `./code/utilities.r` contains all the functions and utilities necessary to conduct the analyses. The file `./code/S4D3M_JAGS_model.R` contains the state-space stage-structured demographic density-dependent model (S4D3M) developed in the accompanying paper written in the [JAGS](https://sourceforge.net/projects/mcmc-jags/) language.

<p align="center">
  <a href="https://github.com/palmaraz/SaniVult">
    <img src="docs/image/S4D3M.svg" title="State-space stage-structured demographic density-dependent model (S4D3M)">
  </a>
</p>


The simplified folder structure (see [below](#full-folder-structure) for a full structure) is the following:

```bash
.
├── ./code
│   ├── ./code/S4D3M_JAGS_Fitting.R
│   ├── ./code/S4D3M_JAGS_model.R
│   └── ./code/utilities.r
├── ./data
│   ├── ./data/Breeding_output.csv
│   ├── ./data/BSE_cases.csv
│   └── ./data/data.csv
├── ./Makefile

```

Here I only

### Prerequisites

This is an example of how to list things you need to use the software and how to install them.

-   npm

    ``` sh
    npm install npm@latest -g
    ```

### Workflow

*Below is an example of how you can instruct your audience on installing and setting up your app. This template doesn't rely on any external dependencies or services.*

1.  Get a free API Key at <https://example.com>

2.  Clone the repo

    ``` sh
    git clone https://github.com/your_username_/Project-Name.git
    ```

3.  Install NPM packages

    ``` sh
    npm install
    ```

4.  Enter your API in `config.js`

    ``` js
    const API_KEY = 'ENTER YOUR API';
    ```

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- USAGE EXAMPLES -->

## Usage

Use this space to show useful examples of how a project can be used. Additional screenshots, code examples and demos work well in this space. You may also link to more resources.

*For more examples, please refer to the [Documentation](https://example.com)*

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- ROADMAP -->

## Roadmap

-   [ ] Add links to the final files and web addresses

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


### Folder structure

This is the folder structure of the [SaniVult](https://github.com/palmaraz/SaniVult) project




#### Full folder structure: 

<p align="right">(<a href="#top">back to top</a>)</p>

```bash
.
├── ./analysis
│   ├── ./analysis/index.Rmd
│   ├── ./analysis/license.Rmd
│   └── ./analysis/_site.yml
├── ./CITATION
├── ./code
│   ├── ./code/S4D3M_JAGS_Fitting.R
│   ├── ./code/S4D3M_JAGS_model.R
│   └── ./code/utilities.r
├── ./data
│   ├── ./data/Breeding_output.csv
│   ├── ./data/BSE_cases.csv
│   └── ./data/data.csv
├── ./docs
│   ├── ./docs/imgs
│   │   └── ./docs/imgs/Mario_Modesto_Mata_CC_BY-SA_(Gyps_fulvus).jpg
│   ├── ./docs/index.html
│   ├── ./docs/license.html
│   └── ./docs/site_libs
│       ├── ./docs/site_libs/bootstrap-3.3.5
│       │   ├── ./docs/site_libs/bootstrap-3.3.5/css
│       │   │   ├── ./docs/site_libs/bootstrap-3.3.5/css/bootstrap.css
│       │   │   ├── ./docs/site_libs/bootstrap-3.3.5/css/bootstrap.css.map
│       │   │   ├── ./docs/site_libs/bootstrap-3.3.5/css/bootstrap.min.css
│       │   │   ├── ./docs/site_libs/bootstrap-3.3.5/css/bootstrap-theme.css
│       │   │   ├── ./docs/site_libs/bootstrap-3.3.5/css/bootstrap-theme.css.map
│       │   │   ├── ./docs/site_libs/bootstrap-3.3.5/css/bootstrap-theme.min.css
│       │   │   ├── ./docs/site_libs/bootstrap-3.3.5/css/cerulean.min.css
│       │   │   ├── ./docs/site_libs/bootstrap-3.3.5/css/cosmo.min.css
│       │   │   ├── ./docs/site_libs/bootstrap-3.3.5/css/darkly.min.css
│       │   │   ├── ./docs/site_libs/bootstrap-3.3.5/css/flatly.min.css
│       │   │   ├── ./docs/site_libs/bootstrap-3.3.5/css/fonts
│       │   │   │   ├── ./docs/site_libs/bootstrap-3.3.5/css/fonts/LatoBold.ttf
│       │   │   │   ├── ./docs/site_libs/bootstrap-3.3.5/css/fonts/LatoItalic.ttf
│       │   │   │   ├── ./docs/site_libs/bootstrap-3.3.5/css/fonts/Lato.ttf
│       │   │   │   ├── ./docs/site_libs/bootstrap-3.3.5/css/fonts/NewsCycleBold.ttf
│       │   │   │   ├── ./docs/site_libs/bootstrap-3.3.5/css/fonts/NewsCycle.ttf
│       │   │   │   ├── ./docs/site_libs/bootstrap-3.3.5/css/fonts/OpenSansBoldItalic.ttf
│       │   │   │   ├── ./docs/site_libs/bootstrap-3.3.5/css/fonts/OpenSansBold.ttf
│       │   │   │   ├── ./docs/site_libs/bootstrap-3.3.5/css/fonts/OpenSansItalic.ttf
│       │   │   │   ├── ./docs/site_libs/bootstrap-3.3.5/css/fonts/OpenSansLightItalic.ttf
│       │   │   │   ├── ./docs/site_libs/bootstrap-3.3.5/css/fonts/OpenSansLight.ttf
│       │   │   │   ├── ./docs/site_libs/bootstrap-3.3.5/css/fonts/OpenSans.ttf
│       │   │   │   ├── ./docs/site_libs/bootstrap-3.3.5/css/fonts/RalewayBold.ttf
│       │   │   │   ├── ./docs/site_libs/bootstrap-3.3.5/css/fonts/Raleway.ttf
│       │   │   │   ├── ./docs/site_libs/bootstrap-3.3.5/css/fonts/RobotoBold.ttf
│       │   │   │   ├── ./docs/site_libs/bootstrap-3.3.5/css/fonts/RobotoLight.ttf
│       │   │   │   ├── ./docs/site_libs/bootstrap-3.3.5/css/fonts/RobotoMedium.ttf
│       │   │   │   ├── ./docs/site_libs/bootstrap-3.3.5/css/fonts/Roboto.ttf
│       │   │   │   ├── ./docs/site_libs/bootstrap-3.3.5/css/fonts/SourceSansProBold.ttf
│       │   │   │   ├── ./docs/site_libs/bootstrap-3.3.5/css/fonts/SourceSansProItalic.ttf
│       │   │   │   ├── ./docs/site_libs/bootstrap-3.3.5/css/fonts/SourceSansProLight.ttf
│       │   │   │   ├── ./docs/site_libs/bootstrap-3.3.5/css/fonts/SourceSansPro.ttf
│       │   │   │   └── ./docs/site_libs/bootstrap-3.3.5/css/fonts/Ubuntu.ttf
│       │   │   ├── ./docs/site_libs/bootstrap-3.3.5/css/journal.min.css
│       │   │   ├── ./docs/site_libs/bootstrap-3.3.5/css/lumen.min.css
│       │   │   ├── ./docs/site_libs/bootstrap-3.3.5/css/paper.min.css
│       │   │   ├── ./docs/site_libs/bootstrap-3.3.5/css/readable.min.css
│       │   │   ├── ./docs/site_libs/bootstrap-3.3.5/css/sandstone.min.css
│       │   │   ├── ./docs/site_libs/bootstrap-3.3.5/css/simplex.min.css
│       │   │   ├── ./docs/site_libs/bootstrap-3.3.5/css/spacelab.min.css
│       │   │   ├── ./docs/site_libs/bootstrap-3.3.5/css/united.min.css
│       │   │   └── ./docs/site_libs/bootstrap-3.3.5/css/yeti.min.css
│       │   ├── ./docs/site_libs/bootstrap-3.3.5/fonts
│       │   │   ├── ./docs/site_libs/bootstrap-3.3.5/fonts/glyphicons-halflings-regular.eot
│       │   │   ├── ./docs/site_libs/bootstrap-3.3.5/fonts/glyphicons-halflings-regular.svg
│       │   │   ├── ./docs/site_libs/bootstrap-3.3.5/fonts/glyphicons-halflings-regular.ttf
│       │   │   ├── ./docs/site_libs/bootstrap-3.3.5/fonts/glyphicons-halflings-regular.woff
│       │   │   └── ./docs/site_libs/bootstrap-3.3.5/fonts/glyphicons-halflings-regular.woff2
│       │   ├── ./docs/site_libs/bootstrap-3.3.5/js
│       │   │   ├── ./docs/site_libs/bootstrap-3.3.5/js/bootstrap.js
│       │   │   ├── ./docs/site_libs/bootstrap-3.3.5/js/bootstrap.min.js
│       │   │   └── ./docs/site_libs/bootstrap-3.3.5/js/npm.js
│       │   └── ./docs/site_libs/bootstrap-3.3.5/shim
│       │       ├── ./docs/site_libs/bootstrap-3.3.5/shim/html5shiv.min.js
│       │       └── ./docs/site_libs/bootstrap-3.3.5/shim/respond.min.js
│       ├── ./docs/site_libs/font-awesome-5.1.0
│       │   ├── ./docs/site_libs/font-awesome-5.1.0/css
│       │   │   ├── ./docs/site_libs/font-awesome-5.1.0/css/all.css
│       │   │   └── ./docs/site_libs/font-awesome-5.1.0/css/v4-shims.css
│       │   └── ./docs/site_libs/font-awesome-5.1.0/webfonts
│       │       ├── ./docs/site_libs/font-awesome-5.1.0/webfonts/fa-brands-400.eot
│       │       ├── ./docs/site_libs/font-awesome-5.1.0/webfonts/fa-brands-400.svg
│       │       ├── ./docs/site_libs/font-awesome-5.1.0/webfonts/fa-brands-400.ttf
│       │       ├── ./docs/site_libs/font-awesome-5.1.0/webfonts/fa-brands-400.woff
│       │       ├── ./docs/site_libs/font-awesome-5.1.0/webfonts/fa-brands-400.woff2
│       │       ├── ./docs/site_libs/font-awesome-5.1.0/webfonts/fa-regular-400.eot
│       │       ├── ./docs/site_libs/font-awesome-5.1.0/webfonts/fa-regular-400.svg
│       │       ├── ./docs/site_libs/font-awesome-5.1.0/webfonts/fa-regular-400.ttf
│       │       ├── ./docs/site_libs/font-awesome-5.1.0/webfonts/fa-regular-400.woff
│       │       ├── ./docs/site_libs/font-awesome-5.1.0/webfonts/fa-regular-400.woff2
│       │       ├── ./docs/site_libs/font-awesome-5.1.0/webfonts/fa-solid-900.eot
│       │       ├── ./docs/site_libs/font-awesome-5.1.0/webfonts/fa-solid-900.svg
│       │       ├── ./docs/site_libs/font-awesome-5.1.0/webfonts/fa-solid-900.ttf
│       │       ├── ./docs/site_libs/font-awesome-5.1.0/webfonts/fa-solid-900.woff
│       │       └── ./docs/site_libs/font-awesome-5.1.0/webfonts/fa-solid-900.woff2
│       ├── ./docs/site_libs/header-attrs-2.11
│       │   └── ./docs/site_libs/header-attrs-2.11/header-attrs.js
│       ├── ./docs/site_libs/highlightjs-9.12.0
│       │   ├── ./docs/site_libs/highlightjs-9.12.0/default.css
│       │   ├── ./docs/site_libs/highlightjs-9.12.0/highlight.js
│       │   └── ./docs/site_libs/highlightjs-9.12.0/textmate.css
│       ├── ./docs/site_libs/jquery-3.6.0
│       │   ├── ./docs/site_libs/jquery-3.6.0/jquery-3.6.0.js
│       │   ├── ./docs/site_libs/jquery-3.6.0/jquery-3.6.0.min.js
│       │   └── ./docs/site_libs/jquery-3.6.0/jquery-3.6.0.min.map
│       ├── ./docs/site_libs/jqueryui-1.11.4
│       │   ├── ./docs/site_libs/jqueryui-1.11.4/images
│       │   │   ├── ./docs/site_libs/jqueryui-1.11.4/images/ui-icons_444444_256x240.png
│       │   │   ├── ./docs/site_libs/jqueryui-1.11.4/images/ui-icons_555555_256x240.png
│       │   │   ├── ./docs/site_libs/jqueryui-1.11.4/images/ui-icons_777620_256x240.png
│       │   │   ├── ./docs/site_libs/jqueryui-1.11.4/images/ui-icons_777777_256x240.png
│       │   │   ├── ./docs/site_libs/jqueryui-1.11.4/images/ui-icons_cc0000_256x240.png
│       │   │   └── ./docs/site_libs/jqueryui-1.11.4/images/ui-icons_ffffff_256x240.png
│       │   ├── ./docs/site_libs/jqueryui-1.11.4/index.html
│       │   ├── ./docs/site_libs/jqueryui-1.11.4/jquery-ui.css
│       │   ├── ./docs/site_libs/jqueryui-1.11.4/jquery-ui.js
│       │   ├── ./docs/site_libs/jqueryui-1.11.4/jquery-ui.min.css
│       │   ├── ./docs/site_libs/jqueryui-1.11.4/jquery-ui.min.js
│       │   ├── ./docs/site_libs/jqueryui-1.11.4/jquery-ui.structure.css
│       │   ├── ./docs/site_libs/jqueryui-1.11.4/jquery-ui.structure.min.css
│       │   ├── ./docs/site_libs/jqueryui-1.11.4/jquery-ui.theme.css
│       │   ├── ./docs/site_libs/jqueryui-1.11.4/jquery-ui.theme.min.css
│       │   └── ./docs/site_libs/jqueryui-1.11.4/README
│       ├── ./docs/site_libs/navigation-1.1
│       │   ├── ./docs/site_libs/navigation-1.1/codefolding.js
│       │   ├── ./docs/site_libs/navigation-1.1/sourceembed.js
│       │   └── ./docs/site_libs/navigation-1.1/tabsets.js
│       └── ./docs/site_libs/tocify-1.9.1
│           ├── ./docs/site_libs/tocify-1.9.1/jquery.tocify.css
│           └── ./docs/site_libs/tocify-1.9.1/jquery.tocify.js
├── ./EcolApp.odt
├── ./EcolApp.pdf
├── ./LICENSE
├── ./Makefile
├── ./ms
│   ├── ./ms/appendix.pdf
│   ├── ./ms/appendix.tex
│   ├── ./ms/arxiv.sty
│   ├── ./ms/biblio.bib
│   ├── ./ms/DataS1.zip
│   ├── ./ms/figs
│   │   ├── ./ms/figs/Fig1.pdf
│   │   ├── ./ms/figs/Fig2.pdf
│   │   ├── ./ms/figs/Fig3.pdf
│   │   ├── ./ms/figs/Fig4.pdf
│   │   ├── ./ms/figs/FigS1.pdf
│   │   ├── ./ms/figs/FigS3.pdf
│   │   └── ./ms/figs/FigS4.pdf
│   ├── ./ms/main_text.pdf
│   ├── ./ms/main_text.tex
│   ├── ./ms/MetadataS1.docx
│   └── ./ms/MetadataS1.pdf
├── ./MS_2020_BiolCons_Graphical_Abstract.pdf
├── ./output
│   ├── ./output/BSE
│   │   ├── ./output/BSE/MCMC_diagnostics
│   │   │   ├── ./output/BSE/MCMC_diagnostics/MCMC_diagnostics_beta.pdf
│   │   │   ├── ./output/BSE/MCMC_diagnostics/MCMC_diagnostics_DemPar.pdf
│   │   │   ├── ./output/BSE/MCMC_diagnostics/MCMC_diagnostics_Prior_Prob_DensDep.pdf
│   │   │   ├── ./output/BSE/MCMC_diagnostics/MCMC_diagnostics_ProbDD.pdf
│   │   │   └── ./output/BSE/MCMC_diagnostics/MCMC_diagnostics_Sigma.pdf
│   │   ├── ./output/BSE/N_equil
│   │   │   ├── ./output/BSE/N_equil/Empirical_Dist_Neq.pdf
│   │   │   ├── ./output/BSE/N_equil/Empirical_Neq_data.csv
│   │   │   ├── ./output/BSE/N_equil/Empirical_Neq.pdf
│   │   │   └── ./output/BSE/N_equil/Equil_Size_results.RData
│   │   ├── ./output/BSE/PPC_Simulation
│   │   │   ├── ./output/BSE/PPC_Simulation/PPC_PreBSE_count_i.csv
│   │   │   ├── ./output/BSE/PPC_Simulation/PPC_PreBSE.pdf
│   │   │   ├── ./output/BSE/PPC_Simulation/SimTS_PreBSE.csv
│   │   │   ├── ./output/BSE/PPC_Simulation/SimTS_PreBSE.pdf
│   │   │   ├── ./output/BSE/PPC_Simulation/y_ppc_summary.csv
│   │   │   ├── ./output/BSE/PPC_Simulation/y_ppc_summary.html
│   │   │   └── ./output/BSE/PPC_Simulation/y_ppc_summary.tex
│   │   ├── ./output/BSE/Rdata_Bayesian.RData
│   │   ├── ./output/BSE/runjagsfiles
│   │   │   ├── ./output/BSE/runjagsfiles/CODAchain1.txt
│   │   │   ├── ./output/BSE/runjagsfiles/CODAchain2.txt
│   │   │   ├── ./output/BSE/runjagsfiles/CODAchain3.txt
│   │   │   ├── ./output/BSE/runjagsfiles/CODAindex.txt
│   │   │   ├── ./output/BSE/runjagsfiles/data.txt
│   │   │   ├── ./output/BSE/runjagsfiles/inits1.txt
│   │   │   ├── ./output/BSE/runjagsfiles/inits2.txt
│   │   │   ├── ./output/BSE/runjagsfiles/inits3.txt
│   │   │   ├── ./output/BSE/runjagsfiles/jagsinfo.Rsave
│   │   │   ├── ./output/BSE/runjagsfiles/model.txt
│   │   │   ├── ./output/BSE/runjagsfiles/out1.Rdump
│   │   │   ├── ./output/BSE/runjagsfiles/out2.Rdump
│   │   │   ├── ./output/BSE/runjagsfiles/out3.Rdump
│   │   │   ├── ./output/BSE/runjagsfiles/samplers.csv
│   │   │   ├── ./output/BSE/runjagsfiles/scriptlauncher.sh
│   │   │   ├── ./output/BSE/runjagsfiles/sim.1
│   │   │   │   ├── ./output/BSE/runjagsfiles/sim.1/jagsoutput.txt
│   │   │   │   ├── ./output/BSE/runjagsfiles/sim.1/jagspid.txt
│   │   │   │   └── ./output/BSE/runjagsfiles/sim.1/script.cmd
│   │   │   ├── ./output/BSE/runjagsfiles/sim.2
│   │   │   │   ├── ./output/BSE/runjagsfiles/sim.2/CODAindex.txt
│   │   │   │   ├── ./output/BSE/runjagsfiles/sim.2/jagsoutput.txt
│   │   │   │   ├── ./output/BSE/runjagsfiles/sim.2/jagspid.txt
│   │   │   │   ├── ./output/BSE/runjagsfiles/sim.2/samplers.csv
│   │   │   │   └── ./output/BSE/runjagsfiles/sim.2/script.cmd
│   │   │   ├── ./output/BSE/runjagsfiles/sim.3
│   │   │   │   ├── ./output/BSE/runjagsfiles/sim.3/CODAindex.txt
│   │   │   │   ├── ./output/BSE/runjagsfiles/sim.3/jagsoutput.txt
│   │   │   │   ├── ./output/BSE/runjagsfiles/sim.3/jagspid.txt
│   │   │   │   ├── ./output/BSE/runjagsfiles/sim.3/samplers.csv
│   │   │   │   └── ./output/BSE/runjagsfiles/sim.3/script.cmd
│   │   │   └── ./output/BSE/runjagsfiles/simchainsinfo.Rsave
│   │   ├── ./output/BSE/Run_time.txt
│   │   ├── ./output/BSE/Summary_Statistics.csv
│   │   ├── ./output/BSE/Summary_table.html
│   │   └── ./output/BSE/Summary_table.tex
│   ├── ./output/Fig1.pdf
│   ├── ./output/Fig2.pdf
│   ├── ./output/Fig3.pdf
│   ├── ./output/Fig4.pdf
│   ├── ./output/FigS3.pdf
│   ├── ./output/PostBSE
│   │   ├── ./output/PostBSE/MCMC_diagnostics
│   │   │   ├── ./output/PostBSE/MCMC_diagnostics/MCMC_diagnostics_beta.pdf
│   │   │   ├── ./output/PostBSE/MCMC_diagnostics/MCMC_diagnostics_DemPar.pdf
│   │   │   ├── ./output/PostBSE/MCMC_diagnostics/MCMC_diagnostics_Prior_Prob_DensDep.pdf
│   │   │   ├── ./output/PostBSE/MCMC_diagnostics/MCMC_diagnostics_ProbDD.pdf
│   │   │   └── ./output/PostBSE/MCMC_diagnostics/MCMC_diagnostics_Sigma.pdf
│   │   ├── ./output/PostBSE/N_equil
│   │   │   ├── ./output/PostBSE/N_equil/Empirical_Dist_Neq.pdf
│   │   │   ├── ./output/PostBSE/N_equil/Empirical_Neq_data.csv
│   │   │   ├── ./output/PostBSE/N_equil/Empirical_Neq.pdf
│   │   │   └── ./output/PostBSE/N_equil/Equil_Size_results.RData
│   │   ├── ./output/PostBSE/PPC_Simulation
│   │   │   ├── ./output/PostBSE/PPC_Simulation/PPC_PreBSE_count_i.csv
│   │   │   ├── ./output/PostBSE/PPC_Simulation/PPC_PreBSE.pdf
│   │   │   ├── ./output/PostBSE/PPC_Simulation/SimTS_PreBSE.csv
│   │   │   ├── ./output/PostBSE/PPC_Simulation/SimTS_PreBSE.pdf
│   │   │   ├── ./output/PostBSE/PPC_Simulation/y_ppc_summary.csv
│   │   │   ├── ./output/PostBSE/PPC_Simulation/y_ppc_summary.html
│   │   │   └── ./output/PostBSE/PPC_Simulation/y_ppc_summary.tex
│   │   ├── ./output/PostBSE/Rdata_Bayesian.RData
│   │   ├── ./output/PostBSE/runjagsfiles
│   │   │   ├── ./output/PostBSE/runjagsfiles/CODAchain1 (2).txt
│   │   │   ├── ./output/PostBSE/runjagsfiles/CODAchain1.txt
│   │   │   ├── ./output/PostBSE/runjagsfiles/CODAchain3.txt
│   │   │   ├── ./output/PostBSE/runjagsfiles/CODAindex.txt
│   │   │   ├── ./output/PostBSE/runjagsfiles/data.txt
│   │   │   ├── ./output/PostBSE/runjagsfiles/inits1.txt
│   │   │   ├── ./output/PostBSE/runjagsfiles/inits2.txt
│   │   │   ├── ./output/PostBSE/runjagsfiles/inits3.txt
│   │   │   ├── ./output/PostBSE/runjagsfiles/jagsinfo.Rsave
│   │   │   ├── ./output/PostBSE/runjagsfiles/model.txt
│   │   │   ├── ./output/PostBSE/runjagsfiles/out1.Rdump
│   │   │   ├── ./output/PostBSE/runjagsfiles/out2.Rdump
│   │   │   ├── ./output/PostBSE/runjagsfiles/out3.Rdump
│   │   │   ├── ./output/PostBSE/runjagsfiles/samplers.csv
│   │   │   ├── ./output/PostBSE/runjagsfiles/scriptlauncher.sh
│   │   │   ├── ./output/PostBSE/runjagsfiles/sim.1
│   │   │   │   ├── ./output/PostBSE/runjagsfiles/sim.1/jagsoutput.txt
│   │   │   │   ├── ./output/PostBSE/runjagsfiles/sim.1/jagspid.txt
│   │   │   │   └── ./output/PostBSE/runjagsfiles/sim.1/script.cmd
│   │   │   ├── ./output/PostBSE/runjagsfiles/sim.2
│   │   │   │   ├── ./output/PostBSE/runjagsfiles/sim.2/CODAindex.txt
│   │   │   │   ├── ./output/PostBSE/runjagsfiles/sim.2/jagsoutput.txt
│   │   │   │   ├── ./output/PostBSE/runjagsfiles/sim.2/jagspid.txt
│   │   │   │   ├── ./output/PostBSE/runjagsfiles/sim.2/samplers.csv
│   │   │   │   └── ./output/PostBSE/runjagsfiles/sim.2/script.cmd
│   │   │   ├── ./output/PostBSE/runjagsfiles/sim.3
│   │   │   │   ├── ./output/PostBSE/runjagsfiles/sim.3/CODAindex.txt
│   │   │   │   ├── ./output/PostBSE/runjagsfiles/sim.3/jagsoutput.txt
│   │   │   │   ├── ./output/PostBSE/runjagsfiles/sim.3/jagspid.txt
│   │   │   │   ├── ./output/PostBSE/runjagsfiles/sim.3/samplers.csv
│   │   │   │   └── ./output/PostBSE/runjagsfiles/sim.3/script.cmd
│   │   │   └── ./output/PostBSE/runjagsfiles/simchainsinfo.Rsave
│   │   ├── ./output/PostBSE/Run_time.txt
│   │   ├── ./output/PostBSE/Summary_Statistics.csv
│   │   ├── ./output/PostBSE/Summary_table.html
│   │   └── ./output/PostBSE/Summary_table.tex
│   ├── ./output/ppc_results.csv
│   └── ./output/PreBSE
│       ├── ./output/PreBSE/MCMC_diagnostics
│       │   ├── ./output/PreBSE/MCMC_diagnostics/MCMC_diagnostics_beta.pdf
│       │   ├── ./output/PreBSE/MCMC_diagnostics/MCMC_diagnostics_DemPar.pdf
│       │   ├── ./output/PreBSE/MCMC_diagnostics/MCMC_diagnostics_Prior_Prob_DensDep.pdf
│       │   ├── ./output/PreBSE/MCMC_diagnostics/MCMC_diagnostics_ProbDD.pdf
│       │   └── ./output/PreBSE/MCMC_diagnostics/MCMC_diagnostics_Sigma.pdf
│       ├── ./output/PreBSE/N_equil
│       │   ├── ./output/PreBSE/N_equil/Empirical_Dist_Neq.pdf
│       │   ├── ./output/PreBSE/N_equil/Empirical_Neq_data.csv
│       │   ├── ./output/PreBSE/N_equil/Empirical_Neq.pdf
│       │   └── ./output/PreBSE/N_equil/Equil_Size_results.RData
│       ├── ./output/PreBSE/PPC_Simulation
│       │   ├── ./output/PreBSE/PPC_Simulation/PPC_PreBSE_count_i.csv
│       │   ├── ./output/PreBSE/PPC_Simulation/PPC_PreBSE.pdf
│       │   ├── ./output/PreBSE/PPC_Simulation/SimTS_PreBSE.csv
│       │   ├── ./output/PreBSE/PPC_Simulation/SimTS_PreBSE.pdf
│       │   ├── ./output/PreBSE/PPC_Simulation/y_ppc_summary.csv
│       │   ├── ./output/PreBSE/PPC_Simulation/y_ppc_summary.html
│       │   └── ./output/PreBSE/PPC_Simulation/y_ppc_summary.tex
│       ├── ./output/PreBSE/Rdata_Bayesian.RData
│       ├── ./output/PreBSE/runjagsfiles
│       │   ├── ./output/PreBSE/runjagsfiles/CODAchain1 (2).txt
│       │   ├── ./output/PreBSE/runjagsfiles/CODAchain2.txt
│       │   ├── ./output/PreBSE/runjagsfiles/CODAchain3.txt
│       │   ├── ./output/PreBSE/runjagsfiles/CODAindex.txt
│       │   ├── ./output/PreBSE/runjagsfiles/data.txt
│       │   ├── ./output/PreBSE/runjagsfiles/inits1.txt
│       │   ├── ./output/PreBSE/runjagsfiles/inits2.txt
│       │   ├── ./output/PreBSE/runjagsfiles/inits3.txt
│       │   ├── ./output/PreBSE/runjagsfiles/jagsinfo.Rsave
│       │   ├── ./output/PreBSE/runjagsfiles/model.txt
│       │   ├── ./output/PreBSE/runjagsfiles/out1.Rdump
│       │   ├── ./output/PreBSE/runjagsfiles/out2.Rdump
│       │   ├── ./output/PreBSE/runjagsfiles/out3.Rdump
│       │   ├── ./output/PreBSE/runjagsfiles/samplers.csv
│       │   ├── ./output/PreBSE/runjagsfiles/scriptlauncher.sh
│       │   ├── ./output/PreBSE/runjagsfiles/sim.1
│       │   │   ├── ./output/PreBSE/runjagsfiles/sim.1/jagsoutput.txt
│       │   │   ├── ./output/PreBSE/runjagsfiles/sim.1/jagspid.txt
│       │   │   └── ./output/PreBSE/runjagsfiles/sim.1/script.cmd
│       │   ├── ./output/PreBSE/runjagsfiles/sim.2
│       │   │   ├── ./output/PreBSE/runjagsfiles/sim.2/CODAindex.txt
│       │   │   ├── ./output/PreBSE/runjagsfiles/sim.2/jagsoutput.txt
│       │   │   ├── ./output/PreBSE/runjagsfiles/sim.2/jagspid.txt
│       │   │   ├── ./output/PreBSE/runjagsfiles/sim.2/samplers.csv
│       │   │   └── ./output/PreBSE/runjagsfiles/sim.2/script.cmd
│       │   ├── ./output/PreBSE/runjagsfiles/sim.3
│       │   │   ├── ./output/PreBSE/runjagsfiles/sim.3/CODAindex.txt
│       │   │   ├── ./output/PreBSE/runjagsfiles/sim.3/jagsoutput.txt
│       │   │   ├── ./output/PreBSE/runjagsfiles/sim.3/jagspid.txt
│       │   │   ├── ./output/PreBSE/runjagsfiles/sim.3/samplers.csv
│       │   │   └── ./output/PreBSE/runjagsfiles/sim.3/script.cmd
│       │   └── ./output/PreBSE/runjagsfiles/simchainsinfo.Rsave
│       ├── ./output/PreBSE/Run_time.txt
│       ├── ./output/PreBSE/Summary_Statistics.csv
│       ├── ./output/PreBSE/Summary_table.html
│       └── ./output/PreBSE/Summary_table.tex
├── ./README.html
├── ./README.log
├── ./README.md
├── ./README.tex
├── ./SaniVult.Rproj
└── ./_workflowr.yml

49 directories, 292 files

```
<p align="right">(<a href="#top">back to top</a>)</p>
