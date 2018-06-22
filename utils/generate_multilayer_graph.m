function W_cell = generate_multilayer_graph(numLayers, GroundTruthPerLayerCell, pinVec, poutVec)

    if isscalar(pinVec) 
        pinVec = pinVec*ones(numLayers,1);
    end
 
    if isscalar(poutVec) 
        poutVec = poutVec*ones(numLayers,1);
    end
    

    W_cell = cell(numLayers,1);
    for i = 1:numLayers
        flag = false;
        while ~flag
            [W,flag] = generate_sbm_graph(GroundTruthPerLayerCell{i}, pinVec(i), poutVec(i));
        end
        W_cell{i} = W;
    end