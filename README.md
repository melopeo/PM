# PM
## The Power Mean Laplacian for Multilayer Graph Clustering

MATLAB implementation of the paper:

[P. Mercado, A. Gautier, F. Tudisco, and M. Hein, The Power Mean Laplacian for Multilayer Graph Clustering. In AISTATS 2018.](http://proceedings.mlr.press/v84/mercado18a/mercado18a.pdf)

## Content:
- `example.m` : contains three easy examples showing how to use the code

- `SBM_execute.m` : runs spectral clustering on signed networks under the stochastic block model (Fig.2 of our [paper](http://papers.nips.cc/paper/6164-clustering-signed-networks-with-the-geometric-mean-of-laplacians.pdf))

- `wikipedia_example_analysis.m` : generates plots from Wikipedia experiment (Fig.4 of our [paper](http://papers.nips.cc/paper/6164-clustering-signed-networks-with-the-geometric-mean-of-laplacians.pdf)). 
   - The corresponding eigenvectors are precomputed with `wikipedia_example.m` and are located in the folder `Wikipedia/wikipedia_example`
   
## Usage:
Let `Wpos` and `Wneg` be the positive and negative adjacency matrices, respectively, and `numClusters` the desired number of clusters. Clusters through the geometric mean Laplacian are computed via

```
C = clustering_signed_networks_with_geometric_mean_of_Laplacians(Wpos,Wneg,numClusters);
```
## Quick Overview:
![](https://github.com/melopeo/GM/blob/master/PaperAndPoster/ThePowerMeanLaplacianforMultilayerGraphClustering.jpg)

## Citation:
```


@InProceedings{pmlr-v84-mercado18a,
  title = 	 {The Power Mean Laplacian for Multilayer Graph Clustering},
  author = 	 {Pedro Mercado and Antoine Gautier and Francesco Tudisco and Matthias Hein},
  booktitle = 	 {Proceedings of the Twenty-First International Conference on Artificial Intelligence and Statistics},
  pages = 	 {1828--1838},
  year = 	 {2018},
  editor = 	 {Amos Storkey and Fernando Perez-Cruz},
  volume = 	 {84},
  series = 	 {Proceedings of Machine Learning Research},
  address = 	 {Playa Blanca, Lanzarote, Canary Islands},
  month = 	 {09--11 Apr},
  publisher = 	 {PMLR},
  pdf = 	 {http://proceedings.mlr.press/v84/mercado18a/mercado18a.pdf},
  url = 	 {http://proceedings.mlr.press/v84/mercado18a.html},
  abstract = 	 {Multilayer graphs encode different kind of interactions between the same set of entities. When one wants to cluster such a multilayer graph, the natural question arises how one should merge the information from different layers. We introduce in this paper a one-parameter family of matrix power means for merging the Laplacians from different layers and analyze it in expectation in the stochastic block model. We show that this family allows to recover ground truth clusters under different settings and verify this in real world data. While the matrix power mean is computationally expensive to compute we introduce a scalable numerical scheme that allows to efficiently compute the eigenvectors of the matrix power mean of large sparse graphs.}
}

```
