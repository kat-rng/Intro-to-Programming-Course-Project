classdef bridgeMaterial
    properties
        % Values for material
        name;
        matID;
        density;
        maxShear;
        maxAxial;
        youngsModulus;
        shearModulus;
    end

    methods
        % Constructor
        function obj = bridgeMaterial(name, density, maxShear, maxAxial, youngsMod, shearMod, id)
            obj.name = name;
            obj.density = density;
            obj.maxShear = maxShear;
            obj.maxAxial = maxAxial;
            obj.youngsModulus = youngsMod;
            obj.shearModulus = shearMod;
            obj.matID = id;
        end

    end
end