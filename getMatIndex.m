function matIndex = getMatIndex(matName)
    % Returns the index of the materials list that matches the material
    % name, for the purpose of matching the material with the name.

    global allMaterials;
    [~, a] = size(allMaterials);

    for i = 1:a
        if allMaterials(i).name == matName;
            matIndex = i;
            break;
        end
    end
end