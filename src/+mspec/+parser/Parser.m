classdef Parser
    %PARSER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        FeatureDefinition string = ""
    end
    
    methods
        function obj = Parser()
            
        end
        
        function given = parseGiven(obj)
            if ~contains(obj.FeatureDefinition, 'given', 'IgnoreCase',true)
                given = string.empty;
                return
            end
            given = obj.FeatureDefinition;
        end

    end
end

