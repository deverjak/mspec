classdef Parser
    %PARSER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        FeatureDefinition string = ""
        Feature mspec.parser.Feature
    end
    
    methods
        function obj = Parser()
            
        end
        
        function parseFeatureScenarios(obj)
            obj.Feature.parseScenarios();
        end

        

    end
end

