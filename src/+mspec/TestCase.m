classdef TestCase < matlab.unittest.TestCase
    properties (Access = private)
        MethodName
        MetaMethodList
        GroupTag
    end

    methods (Access = protected)
        function setupTestCase(testCase)
            testCase.setMetaDataMethodList();
            testCase.setMethodName();
            testCase.setGroupTag();
            
            methods = testCase.findMethodsToInvoke();
            testCase.invokeTestCaseSetupMethods(methods);
        end
    end

    methods (Access = private)
        function setMethodName(testCase)
            stack = dbstack;
            completeMethodName = split(stack(3).name, '.');
            testCase.MethodName = completeMethodName{2};
        end
        function setMetaDataMethodList(testCase)
            metaData = metaclass(testCase);
            testCase.MetaMethodList = table(string({metaData.MethodList.Name})', ...
                string({metaData.MethodList.Description})', 'VariableNames', ...
                {'Method', 'Description'});
        end
        function setGroupTag(testCase)
            idx = find(contains(testCase.MetaMethodList(:,1).Variables, ...
                testCase.MethodName)==true);
             groupDescription = extractBetween(testCase.MetaMethodList.Description(idx), ...
                 "[", "]", "Boundaries","inclusive");
             testCase.GroupTag = groupDescription(1);
        end
    
        function methods = findMethodsToInvoke(testCase)
            methods = string.empty;
            for keyword = ["Given", "When"]
                invokable = contains(testCase.MetaMethodList.Description, testCase.GroupTag) & ...
                    contains(testCase.MetaMethodList.Description, keyword);
                methods(length(methods)+1) = testCase.MetaMethodList.Method(invokable);
            end
        end
        function invokeTestCaseSetupMethods(testCase, methods)
            for method = methods
                fh = str2func(method);
                fh(testCase);
            end
        end
    end
end

