function SBM_case_2

% Fixing structure of graph:
% - 3 clusters
% - Each layer is only bringing information about one cluster. In particular
% - - Layer one brings info about cluster 1
% - - Layer two brings info about cluster 2
% - - Layer two brings info about cluster 3

restoredefaultpath
addpath(genpath('utils'))
addpath(genpath('ThePowerMeanLaplacianForMultilayerGraphClustering'))

dirName_Output_Data = 'SBM_case_2';
if ~exist(dirName_Output_Data,'dir')
    mkdir(dirName_Output_Data)
end

method_str = 'eigs';
% method_str = 'polynomial_krylov';

% Graph data
sizeOfEachCluster   = 100;
numClusters         = 3;
numLayers           = 3;
sizeOfGraph         = numClusters*sizeOfEachCluster;

GroundTruth         = [];
for i = 1:numClusters
    GroundTruth = [GroundTruth; i*ones(sizeOfEachCluster,1)];
end

GroundTruthPerLayerCell     = cell(numLayers,1);
for i = 1:numLayers
    GroundTruthPerLayerCell{i} = GroundTruth == i;
end

% Data for power means
pArray                 = [10,5,2,1,0,-1,-2,-5,-10];
idxNeg                 = find(pArray<=0);
diagShiftArray         = ones(size(pArray));
diagShiftArray(idxNeg) = log(1+abs(pArray(idxNeg)))+1;

% Mixing parameter
diffArray              = 0.0:0.005:0.1;
pinArray               = (0.1+diffArray)/2;
poutArray              = (0.1-diffArray)/2;
% number of runs
numRuns = 10;

% Run experiment
subdir = strcat(dirName_Output_Data, filesep, 'method_str_', method_str);
if ~exist(subdir,'dir')
    mkdir(subdir)
end

power_mean_error_mean_cell = cell(length(diffArray),1);

for i = 1:length(diffArray)

        p = pinArray(i);
        q = poutArray(i);

        C_cell_power_mean = run_experiment_SBM(...
            p, q, numRuns, numClusters, GroundTruthPerLayerCell, numLayers, pArray, diagShiftArray, method_str);

        power_mean_error_mean_cell{i} = get_means(C_cell_power_mean, GroundTruth);

end

filename = strcat(subdir, filesep, 'output.mat');
save(filename, 'power_mean_error_mean_cell', '-v7.3')
% load(filename)

% Plot
fig_handle      = get_plot_SBM_2(power_mean_error_mean_cell, diffArray);
filename_prefix = strcat(subdir, filesep, 'plot');
save_plots(fig_handle, filename_prefix)

function fig_handle = get_plot_SBM_2(power_mean_error_mean_cell, diffArray)

    dataMatrix = cell2mat(power_mean_error_mean_cell)';
    dataMatrix = dataMatrix(:, diffArray>=0.03);

    % plot Parameters
    [legendCell, colorCell, markerCell, LineStyleCell, LineWidthCell] = get_plot_parameters;
    MarkerSize      = [];
    fontSize        = 20;
    fontSize_legend = 14;

    xArray          = diffArray;
    xArray          = xArray(diffArray>=0.03);
    legendLocation  = 'northeast';
    xAxisTitle_str  = '\fontsize{15}{0} $\mathbf{p_{\mathrm{in}} - p_{\mathrm{out}}}$';
    yAxisTitle_str  = 'Mean Clustering Error';
    title_str       = '';
    legendBoolean   = true;
    xTickArray      = 1:4:length(xArray);
    yTickArray      = 0:0.1:0.5;
    1;

    % plot!
    fig_handle = plot_performance(dataMatrix, xArray, legendCell, colorCell, LineStyleCell, markerCell, MarkerSize, LineWidthCell,legendLocation,xAxisTitle_str,yAxisTitle_str, title_str, fontSize,fontSize_legend,legendBoolean,xTickArray,yTickArray);

