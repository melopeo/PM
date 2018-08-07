function experiments_realData

% Experiments corresponding to section 5 of our paper

dirName_Output_Data = 'experiments_realData';
if ~exist(dirName_Output_Data,'dir')
    mkdir(dirName_Output_Data)
end

restoredefaultpath
addpath(genpath('utils'))
addpath(genpath('subroutines'))
addpath(genpath('Datasets'))
addpath(genpath('ThePowerMeanLaplacianForMultilayerGraphClustering'))

method_str = 'eigs';
% method_str = 'polynomial_krylov';

% datasets location and info
dir_data      = 'Datasets/';
dataname_cell = {'3sources','BBC4view_685','BBCSport2view_544','WikipediaArticles', 'UCI_mfeat', 'citeseer', 'cora', 'webKB_texas_2'};

knnArray       = [20,40,60,80,100];
p              = -10;%
diagShiftValue = log(1+(abs(p)))+1;

% p = 1;
% diagShiftValue = 0;

subDir = strcat(dirName_Output_Data, filesep, method_str);
if ~exist(subDir, 'dir')
    mkdir(subDir)
end
for r = 1:length(dataname_cell)

    dataname                = dataname_cell{r};
    [data, labels, W_given] = load_data(dir_data, dataname);
    view_num                = length(data);

    C_cell_power_mean_array = cell(length(knnArray),1);
    clusteringErrorVector   = nan(length(knnArray),1);
    for k = 1:length(knnArray)
        knnVector = ones(view_num,1)*knnArray(k);

        s = RandStream('mcg16807','Seed',0); RandStream.setGlobalStream(s);
        C_cell_power_mean_array{k} = run_experiments_realData(p, diagShiftValue, data, labels, W_given, knnVector, method_str);
        clusteringErrorVector(k)   = classification_error_for_clustering(C_cell_power_mean_array{k}, labels(:));
    end

    average_clustering_error = mean(clusteringErrorVector);

    formatSpec = strcat('Dataset: ', dataname, ' -- mean clustering error: %1.3f\n');
    fprintf(formatSpec,average_clustering_error);

    filename = strcat(subDir, filesep, dataname, '_output.mat');
    save(filename, 'C_cell_power_mean_array', 'clusteringErrorVector', '-v7.3')
1;
end
    
function [data, labels, W] = load_data(dir_data, dataname)

    dataStruct  = load(strcat(dir_data, dataname, '.mat'));
    data        = dataStruct.data;

    labels      = dataStruct.truelabel;
    labels      = labels{1};

    if isfield(dataStruct,'W')
        W = dataStruct.W;
    else
        W = [];
    end
