classdef Document < handle


    properties
        Name
        Properties
        MethodGroups mspec.generator.MethodGroup = mspec.generator.MethodGroup.empty
    end

    properties (Access = private)
        Keywords = ["Given", "When", "Then"];
        Feature
    end

    methods
        function setFeature(obj, feature)
            obj.Feature = feature;
            obj.createDocument();
        end
    end

    methods (Access = private)
        function createDocument(obj)
            for i = 1 : length(obj.Feature.Scenario)
                for keyword = obj.Keywords
                    methoudGroupIndex = length(obj.MethodGroups)+1;
                    obj.MethodGroups(methoudGroupIndex).ParentScenario = ...
                        ['[S', num2str(i), ']'];
                    tempDescription = ["Description", "[S1] Given logged User U"];
                    tempTable = array2table(tempDescription);
                    tempTable.Properties.VariableNames = {'Field', 'Value'};
                    obj.MethodGroups(methoudGroupIndex).Descriptor = [obj.MethodGroups(methoudGroupIndex).Descriptor; ...
                        tempTable];
                end
            end
        end
    end
end

