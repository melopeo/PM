function C = clustering_multilayer_graphs_with_power_mean_laplacian(W_cell, p, numClusters, diagShift, method_str, krylovOpts)
% C = clustering_multilayer_graphs_with_power_mean_laplacian(W_cell, p, diagShift, method_str)
% INPUT: W_cell (cell)              : cell containing adjacency matrices
%        p (scalar)                 : p-th power of generalized matrix mean
%        diagShift (scalar)         : diagonal shift of Laplacians for the case where p<0
%                                     deafult:
%                                     - for p <= 0 : log(1+abs(p))+1
%                                     - for p > 0  : zero
%        numClusters (scalar)       : number of clusters to compute
%        method_str (string)        : string defining computation method of
%                                     eigenvectors
%                                    options:
%                                    - 'direct' : first computes the power mean
%                                       Laplacian Lp and then the corresponding eigenvectors
%                                    - 'eigs' : first computes the power mean
%                                       Laplacian (Lp)^p (avoids the outer power '1/p' 
%                                       and then the corresponding
%                                       eigenvectors) and then the corresponding eigenvectors
%                                    - 'polynomial_krylov': matrix-free
%                                       polynomial krylov computation of
%                                       eigenvectors of power mean Laplacian Lp
% OUTPUT: C (array)                 : array with clustering assignments                                   

% Reference:
% @InProceedings{pmlr-v84-mercado18a,
%   title = 	 {The Power Mean Laplacian for Multilayer Graph Clustering},
%   author = 	 {Pedro Mercado and Antoine Gautier and Francesco Tudisco and Matthias Hein},
%   booktitle =  {Proceedings of the Twenty-First International Conference on Artificial Intelligence and Statistics},
%   pages = 	 {1828--1838},
%   year = 	     {2018},
%   editor = 	 {Amos Storkey and Fernando Perez-Cruz},
%   volume = 	 {84},
%   series = 	 {Proceedings of Machine Learning Research},
%   address = 	 {Playa Blanca, Lanzarote, Canary Islands},
%   month = 	 {09--11 Apr},
%   publisher =  {PMLR},
%   pdf = 	     {http://proceedings.mlr.press/v84/mercado18a/mercado18a.pdf},
%   url = 	     {http://proceedings.mlr.press/v84/mercado18a.html},
%   abstract = 	 {Multilayer graphs encode different kind of interactions between the same set of entities. When one wants to cluster such a multilayer graph, the natural question arises how one should merge the information from different layers. We introduce in this paper a one-parameter family of matrix power means for merging the Laplacians from different layers and analyze it in expectation in the stochastic block model. We show that this family allows to recover ground truth clusters under different settings and verify this in real world data. While the matrix power mean is computationally expensive to compute we introduce a scalable numerical scheme that allows to efficiently compute the eigenvectors of the matrix power mean of large sparse graphs.}
% }

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % Process input parameters % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

% if diagonal shift is not given, set it depending on value of p
if nargin < 4 
    if p > 0
        diagShift = 0;
    else
        diagShift = log(1+abs(p))+1;
    end
end

if nargin < 5
    method_str = 'polynomial_krylov';
end

if nargin < 6
    krylovOpts.tol   = 1.e-10;
    krylovOpts.maxIt = size(W_cell{1},1);
end

if isempty(diagShift)
    if p > 0
        diagShift = 0;
    else
        diagShift = log(1+abs(p))+1;
    end
end

% polynomial krylov method is designed only for negative powers
if (p>=0 && (strcmp(method_str, 'polynomial_krylov')==1))
    warning(['Polynomial Krylov method is developed only for negative powers (i.e. p<0). Computation will proceed with method_str = ''eigs'' '])
    method_str = 'eigs';
end

assert( numClusters >=2, 'Number of clusters (numClusters) has to be larger than one')

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % Clustering % % % % %  % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
matrix_cell                 = get_Laplacians(W_cell, diagShift);
[eigenvectors, eigenvalues] = get_eigenvectors_of_power_mean_laplacian(matrix_cell, p, numClusters, method_str, krylovOpts);
C                           = kmeans(eigenvectors, numClusters, 'Replicates', 10, 'emptyaction', 'singleton');
