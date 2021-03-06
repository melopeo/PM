function [legendCell, colorCell, markerCell, LineStyleCell, LineWidthCell] =get_plot_parameters

%% plotting parameters
% legendCell_state_of_art = {...
%     '$L_{\textrm{agg}}$', ...
%     '$Q_{\textrm{agg}}$', ...
%     '$\textrm{SC-ML}$', ...
%     '$\textrm{Coreg}$', ...
%     '$\textrm{BestView}$', ...
%     '$\textrm{Heuristic}$', ...
%     '$\textrm{TLMV}$', ...
%     '$\textrm{RMSC}$'};

legendCell_power_mean = {...
    '$L_{\textrm{10}}$', ...
    '$L_{\textrm{5}}$', ...
    '$L_{\textrm{2}}$', ...
    '$L_{\textrm{1}}$', ...
    '$L_{\textrm{0}}$', ...
    '$L_{\textrm{-1}}$', ...
    '$L_{\textrm{-2}}$', ...
    '$L_{\textrm{-5}}$', ...
    '$L_{\textrm{-10}}$'};

colorMatrix        = distinguishable_colors(length(legendCell_power_mean));
colorMatrix        = flipud(colorMatrix);
for i = 1:size(colorMatrix,1)
    colorCell{i} = colorMatrix(i,:);
end
aux              = colorCell{end};
colorCell{end}   = colorCell{end-1};
colorCell{end-1} = aux;

legendCell       = legendCell_power_mean;
% colorCell        = colorCell;
markerCell       = {'p', 'o', 's', '*', '+', 'p', 'o', 's', '*' };
LineStyleCell    = repmat({'-'},1,length(legendCell_power_mean));
LineWidthCell    = repmat({4.5},1,length(legendCell_power_mean));