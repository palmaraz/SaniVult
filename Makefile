.PHONY: analyze compile all

.DEFAULT_GOAL := help

analyze: ## 1) Analyze all data
	@echo 'This code reproduces the manuscript, including'
	@echo 'all the analyses and figures'
	@echo 'Begin S4D3M fitting...'
	@Rscript code/S4D3M_JAGS_Fitting.R
	@echo '... end S4D3M'

compile: ## 2) Compile manuscript
	@echo 'Compile manuscript...'
	@cd ms/; find . -maxdepth 1 -name '*.tex' -exec pdflatex --interaction=batchmode {} \;
	@cd ms/; find . -maxdepth 1 -name '*.bcf' -exec biber {} \;
	@cd ms/; find . -maxdepth 1 -name '*.tex' -exec pdflatex --interaction=batchmode {} \;
	@cd ms/; rm *.log *.aux *.out *.bcf *.toc *.run.xml *.bbl *.blg
	@echo 'Open manuscript...'
	@cd ms/; find . -maxdepth 1 -name '*.pdf' -exec xdg-open {} \;
	@echo '...finished!'

all: ## Reproduce the whole project
	@echo 'This code reproduces the manuscript, including'
	@echo 'all the analyses and figures'
	@echo 'Begin S4D3M fitting...'
	@Rscript code/S4D3M_JAGS_Fitting.R
	@echo '... end S4D3M'
	@echo 'Compile manuscript...'
	@cd ms/; find . -maxdepth 1 -name '*.tex' -exec pdflatex --interaction=batchmode {} \;
	@cd ms/; find . -maxdepth 1 -name '*.bcf' -exec biber {} \;
	@cd ms/; find . -maxdepth 1 -name '*.tex' -exec pdflatex --interaction=batchmode {} \;
	@cd ms/; rm *.log *.aux *.out *.bcf *.toc *.run.xml *.bbl *.blg
	@echo 'Open manuscript...'
	@cd ms/; find . -maxdepth 1 -name '*.pdf' -exec xdg-open {} \;
	@echo '...finished!'

.PHONY: help

# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
