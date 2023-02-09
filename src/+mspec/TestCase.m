classdef TestCase < matlab.unittest.TestCase
   

    methods (Access = private)
        function setupTestCase(testCase)
            keyword = 'Given'
            metaData = metaclass(testCase);
            t = table(string({metaData.MethodList.Name})', ...
                string({metaData.MethodList.Description})');
            idx = find(contains(t(:,2).Variables, keyword, "IgnoreCase", true)==true);
            fh = str2func(t(idx,1).Variables);
            fh(testCase);
        end
    end
end

