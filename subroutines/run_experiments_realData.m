function C_cell_power_mean = run_experiments_realData(p, diagShiftValue, data, labels, W_given, knnVector, method_str)

    numClusters = length(unique(labels));
    view_num    = length(data);
    
    % transpose data so that rows correspond to observations and columns to features
    data = cellfun(@(x) x', data, 'UniformOutput', false);
            
    W_knn_cell = cell(view_num,1);
    for j = 1:view_num
        knnPos        = knnVector(j);
        M             = corr(data{j}');

        W_knn_cell{j} = BuildWeightsFromDistance(M,knnPos,'kfn');
        W_knn_cell{j} = M.*W_knn_cell{j};
        W_knn_cell{j} = 0.5*(W_knn_cell{j}+W_knn_cell{j}');
    end
    
    if isempty(W_given)
        W_cell = [W_knn_cell];
    else
        W_cell = [{W_given}; W_knn_cell];
    end

    s                 = RandStream('mcg16807','Seed',0); RandStream.setGlobalStream(s);
    C_cell_power_mean = clustering_multilayer_graphs_with_power_mean_laplacian(W_cell, p, numClusters, diagShiftValue, method_str);