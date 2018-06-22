function [error_mean] = get_means(C_cell, GroundTruth)

    numRuns = length(C_cell);
    for j = 1:numRuns
        error_matrix(j,:) = cell2mat(...
            cellfun(@(x) classification_error_for_clustering(x,GroundTruth(:)), C_cell{j}, 'UniformOutput', false));
    end

    error_mean = mean(error_matrix,1);