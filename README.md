## The Power Mean Laplacian for Multilayer Graph Clustering

MATLAB implementation of the paper:

[P. Mercado, A. Gautier, F. Tudisco, and M. Hein, The Power Mean Laplacian for Multilayer Graph Clustering. In AISTATS 2018.](http://proceedings.mlr.press/v84/mercado18a/mercado18a.pdf)

## Content:
- `example.m` : contains an easy example showing how to use the code

- `experiments_main.m` : runs experiments contained in our [paper](http://proceedings.mlr.press/v84/mercado18a/mercado18a.pdf)
 
## Usage:
Let `Wcell` be a cell with the adjacency matrices of each layer , `p` the power of the power mean Laplacian, `numClusters` the desired number of clusters. Clusters through the power mean Laplacian `L_p` are computed via
```
C = clustering_multilayer_graphs_with_power_mean_laplacian(Wcell, p, numClusters);
```
## Quick Overview:
![](https://github.com/melopeo/PM/blob/master/PaperAndPoster/ThePowerMeanLaplacianForMultilayerGraphClusteringPoster.jpg)

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
