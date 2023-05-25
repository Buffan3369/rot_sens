# Mind the uncertainty: Global Plate Model choice impacts deep-time palaeobiological studies

Author(s): [Lucas Buffan](lucas.buffan@ens-lyon.fr), [Lewis A. Jones](mailto:LewisA.Jones@outlook.com), Mathew Domeier, Christopher R. Scotese, Sabin Zahirovic, and [Sara Varela](sara.varela@uvigo.es).

This repository contains the data and code required to run the analyses of the article, "Mind the uncertainty: Global Plate Model choice impacts deep-time palaeobiological studies" (Buffan et al. 2023). 

To cite the paper: 
> Lucas Buffan, Lewis A. Jones, Mathew Domeier, Christopher R. Scotese, Sabin Zahirovic, and Sara Varela. 2023. Mind the uncertainty: Global Plate Model choice impacts past biogeographic reconstructions.

![](figures/standard_deviation/time_series.gif)

![](figures/GDD/time_series.gif)

-------

## Study details

In this study, we evaluate the influence of Global Plate Model choice on reconstructions of the Earth's continental surface over geological timescales. Understanding this uncertainty is key to constraining the distribution of organisms in the past. This has implications for our understanding of deep time macroevolutionary and macroecolgical patterns, as well as palaeoclimatic reconstructions. Our study focused on five widely used open-source models, which are available via the [GPlates Web Service](https://gwsdoc.gplates.org/reconstruction-models):

* ME21: MERDITH model (Merdith et al., 2021) - GPlates ID = MERDITH2021
* TC17: TORSVIK & COCKS model (Torsvik and Cocks, 2017) - GPlates ID = TorsvikCocks2017
* SC16: PALEOMAP model (Scotese, 2016 & Scotese & Wright, 2018) - GPlates ID = PALEOMAP
* MA16: MATTHEWS model (Matthews et al., 2016) - GPlates ID = MATTHEWS2016_pmag_ref
* WR13: GOLONKA model (Wright et al., 2013) - GPlates ID = GOLONKA

In this work, we first adopt a simulation approach to evaluate spatiotemporal discrepancies in palaeogeographic reconstructions between the five Global Plate Models. Subsequently, using empirical data, we reconstruct the palaeodistribution of two entities which serve as proxies of past tropical/subtropical conditions: terrestrial crocodylomorphs and coral reefs. The latter approach (with empirical data) covers the last ~250 Myr, and aims to illustrate the impact of model choice within a palaeobiological framework.

-------
## Repository structure

In this repository, files and code are organised as:

* **Data** files are stored in the `/data/` folder
* **Analysis** code in the `/R/` folder
* **Results** in the `/results/` folder
* **Figures** in the `/figures/` folder

-------

## Workflow

All reconstructions were generated using the GPlates software called via pygplates, see: `/python/`.

The workflow and documentation for data analysis can be found in: `/R/data_analysis.R`.

The workflow for data visualisation can be found in: `/R/visualiation.R`.

Documentation and comments relating to the workflow can be found within the aforementioned scripts, as well as the relevant subscripts.
