function W=BuildWeightsFromDistancePedro(dist2,NN,whichType)
% input: 
% dist2     - distance matrix of the data
% NN        - number of neighbors for graph construction
% whichType - string: 'knn' : for k-nearest  neighbors matrix
%                   : 'kfn' : for k-farthest neighbors matrix
% output: sparse, symmetric unweighted adjacency matrix of the same size as dist2
%

if strcmp(whichType, 'knn') % build k-nearest neighbors matrix
    [~,IX] = sort(dist2,2, 'ascend');
    KNN    = IX(:,2:NN+1);  % avoid first entry, as we dont want self-loops
elseif strcmp(whichType, 'kfn') % build k-farthest neighbors matrix
    [~,IX] = sort(dist2,2, 'descend');
    KNN    = IX(:,1:NN);
end

n=size(dist2,1);

rows=zeros(n*NN,1);
cols=zeros(n*NN,1);

counter=1;
for i=1:size(dist2,1)
 rows(counter:counter+NN-1)=i;
 cols(counter:counter+NN-1)=KNN(i,:);
 counter=counter+NN;
end
W=sparse(rows,cols,ones(NN*n,1),n,n);
W=max(W,W');