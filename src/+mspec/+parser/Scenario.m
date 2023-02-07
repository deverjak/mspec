classdef Scenario < handle

    properties
        Name
        Given
        When
        Then
        
    end

    properties (Access = private)
        RawDefinition = string.empty
        Keywords = ["Given", "When", "Then"];
    end

    methods 
        function parseSteps(obj)
            for keyword = obj.Keywords
                for i=1:length(obj.RawDefinition)
                    line = obj.RawDefinition(i);
                    if contains(line, keyword)
                        obj.(keyword) = strtrim(line);
                    end
                end
            end
        end        
        function pushLineForStepParsing(obj, line)
            obj.RawDefinition(length(obj.RawDefinition) + 1, 1) = line;
        end
    end

end

