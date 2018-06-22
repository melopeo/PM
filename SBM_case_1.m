function SBM_case_1

restoredefaultpath
addpath(genpath('utils'))
addpath(genpath('ThePowerMeanLaplacianForMultilayerGraphClustering'))

dirName_Output_Data = 'SBM_case_1';
if ~exist(dirName_Output_Data,'dir')
    mkdir(dirName_Output_Data)
end

% Graph data
sizeOfEachCluster   = 100;
numClusters         = 2;
numLayers           = 2;

GroundTruth         = [];
for i = 1:numClusters
    GroundTruth = [GroundTruth; i*ones(sizeOfEachCluster,1)];
end

GroundTruthPerLayerCell     = cell(numLayers,1);
for i = 1:numLayers
    GroundTruthPerLayerCell{i} = GroundTruth;
end

% Data for power means
pArray                 = [10,5,2,1,0,-1,-2,-5,-10];
idxNeg                 = find(pArray<=0);
diagShiftArray         = ones(size(pArray));
diagShiftArray(idxNeg) = log(1+abs(pArray(idxNeg)))+1;

method_str = 'eigs';
% method_str = 'polynomial_krylov';

% Mixing parameter
diffArray         = -0.05:0.005:0.05;
pin_Layer1_Array  = (0.1+diffArray)/2;
pout_Layer1_Array = (0.1-diffArray)/2;

pin_Layer2_Array  = 0.09*ones(size(diffArray));
pout_Layer2_Array = 0.01*ones(size(diffArray));

pin_input         = [pin_Layer1_Array(:)  pin_Layer2_Array(:) ];
pout_input        = [pout_Layer1_Array(:) pout_Layer2_Array(:)];
1;

% number of runs
numRuns = 50;

% Run experiment  
subdir = strcat(dirName_Output_Data, filesep, 'method_str_', method_str);%, '_diagShift_', num2str(diagShiftValue));
if ~exist(subdir,'dir')
    mkdir(subdir)
end

power_mean_error_mean_cell = cell(length(diffArray),1);

for i = 1:length(diffArray)

    pinVec                        = pin_input(i,:);
    poutVec                       = pout_input(i,:);

    C_cell_power_mean             = run_experiment_SBM(...
                                    pinVec, poutVec, numRuns, numClusters, GroundTruthPerLayerCell, numLayers, pArray, diagShiftArray, method_str);
    power_mean_error_mean_cell{i} = get_means(C_cell_power_mean, GroundTruth);

end

filename = strcat(subdir, filesep, 'output.mat');
save(filename, 'power_mean_error_mean_cell', '-v7.3')
% load(filename)
1;

% Plot
fig_handle = get_plot_SBM_1(power_mean_error_mean_cell, diffArray);
filename_prefix = strcat(subdir, filesep, 'plot');
save_plots(fig_handle, filename_prefix)
1;

function fig_handle = get_plot_SBM_1(power_mean_error_mean_cell, diffArray)

    dataMatrix = cell2mat(power_mean_error_mean_cell)';

    % plot Parameters
    [legendCell, colorCell, markerCell, LineStyleCell, LineWidthCell] = get_plot_parameters;
    MarkerSize      = [];
    fontSize        = 20;
    fontSize_legend = 14;

    xArray          = diffArray;
    legendLocation  = 'northeast';
    xAxisTitle_str  = '\fontsize{15}{0} $G^{(2)}: \mathbf{p_{\mathrm{in}} - p_{\mathrm{out}}}$';%'$\mathbf{p_{\mathrm{in}}}$';%'mix parameter';
    yAxisTitle_str  = 'Mean Clustering Error';
    title_str       = '\fontsize{15}{0} $ G^{(1)}: \mathbf{ p_{\mathrm{in}}=0.9,\,\,  p_{\mathrm{out}}=0.1}$';
    legendBoolean   = true;
    xTickArray      = [1,6,11,16,21];
    yTickArray      = 0:0.1:0.5;
    1;

    % plot!
    fig_handle = plot_performance(dataMatrix, xArray, legendCell, colorCell, LineStyleCell, markerCell, MarkerSize, LineWidthCell,legendLocation,xAxisTitle_str,yAxisTitle_str, title_str, fontSize,fontSize_legend,legendBoolean,xTickArray,yTickArray);

