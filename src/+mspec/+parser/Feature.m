classdef Feature < handle
   
    properties
        FileName
        FileContent string
        Scenario mspec.parser.Scenario
    end
    
    methods
        function parseScenarios(obj)
            for i=1:length(obj.FileContent)
                line = obj.FileContent(i);
                if obj.isStartOfScenarioDefinition(line)
                    obj.Scenario(obj.getScenarioCount+1).Name = strtrim(erase(line, 'Scenario:'));
                elseif obj.belongsToScenarioDefinition()
                    obj.Scenario(obj.getScenarioCount).pushLineForStepParsing(line);
                end
            end
            for i=1:obj.getScenarioCount
                obj.Scenario(i).parseSteps();
            end
        end
    end

    methods (Access = private)
        function count = getScenarioCount(obj)
            count = length(obj.Scenario);
        end

        function bool = isStartOfScenarioDefinition(~, line)
            bool = contains(lower(line), 'scenario');
        end
        function bool = belongsToScenarioDefinition(obj)
            bool = obj.getScenarioCount > 0;
        end
    end
end

