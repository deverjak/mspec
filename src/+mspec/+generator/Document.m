classdef Document < handle


    properties
        Name
        Properties = ["FixtureData", "struct()"]
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
                    mgIndex = obj.getMethodGroupIndex();
                    obj.MethodGroups(mgIndex).ParentScenario = obj.getScenarioTag(i);
                    obj.setTestProperty(keyword, mgIndex);
                    obj.MethodGroups(mgIndex).Description = obj.getMethodGroupDescription(keyword, i);
                    temp = table(obj.generateValidMethodNameFromDescription(keyword, i), "", 'VariableNames', {'MethodName', 'Arguments'});
                    obj.MethodGroups(mgIndex).Methods = [obj.MethodGroups(mgIndex).Methods; temp];
                end
            end
        end

        function index = getMethodGroupIndex(obj)
            index = length(obj.MethodGroups)+1;
        end
        function tag = getScenarioTag(~, iScenario)
            tag = ['[S', num2str(iScenario), ']'];
        end
        function setTestProperty(obj, keyword, methoudGroupIndex)
            obj.MethodGroups(methoudGroupIndex).IsTest = isequal(keyword, "Then");
        end
        function description = getMethodGroupDescription(obj, keyword, index)
            description = strcat(obj.getScenarioTag(index), obj.Feature.Scenario(index).(keyword));
        end
        function name = generateValidMethodNameFromDescription(obj, keyword, index)
            name = char(genvarname(obj.Feature.Scenario(index).(keyword)));
            name(1) = lower(name(1));
            name = string(name);
        end
    end
end

