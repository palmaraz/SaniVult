.PHONY: Analyze PPC simulate compile open All

.DEFAULT_GOAL := help

Analyze: ## 1) Analyze all data
	@echo 'This code reproduces the manuscript, including'
	@echo 'all the analyses and figures'
	@echo 'Begin SSSSDM fitting...'
	@Rscript R/SSSSDM_Fitting.R
	@echo '... end SSSSDM'

PPC: ## 2) Perform Posterior predicted checks
	@echo 'Begin posterior predicted checks...'
	@Rscript R/SSSSDM_PPC.R
	@echo '... end posterior predicted checks'

simulate: ## 3) Simulate decreasing vital rates
	@echo 'Begin posterior simulation...'
	@Rscript R/SSSSDM_SimulateRates.R
	@echo '... end posterior simulation'

compile: ## 4) Compile manuscript
	@echo 'Compile manuscript...'
	@cd manuscript/
	@pdflatex --interaction=batchmode JAE-2019-00846v2.tex
	@pdflatex --interaction=batchmode JAE-2019-00846v2.tex

open: ## 5) Open manuscript
	@echo 'Open manuscript...'
	@xdg-open manuscript/MS_2020_MainText.pdf
	@echo '...finished!'

All: ## Reproduce the whole project
	@echo 'This code reproduces the manuscript, including'
	@echo 'all the analyses and figures'
	@echo 'Begin SSSSDM fitting...'
	@Rscript R/SSSSDM_Fitting.R
	@echo '... end SSSSDM'
	@echo 'Begin posterior predicted checks...'
	@Rscript R/SSSSDM_PPC.R
	@echo '... end posterior predicted checks'
	@echo 'Begin posterior simulation...'
	@Rscript R/SSSSDM_SimulateRates.R
	@echo '... end posterior simulation'
	@echo 'Compile manuscript...'
	@cd manuscript/
	@pdflatex --interaction=batchmode JAE-2019-00846v2.tex
	@pdflatex --interaction=batchmode JAE-2019-00846v2.tex
	@echo 'Open manuscript...'
	@xdg-open MS_2020_MainText.pdf
	@echo '...finished!'

.PHONY: help

# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
