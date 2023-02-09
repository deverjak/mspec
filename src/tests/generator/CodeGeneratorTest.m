classdef CodeGeneratorTest < matlab.unittest.TestCase & mspec.generator.CodeGenerator

 

    methods(TestClassSetup)
        % Shared setup for the entire test class
    end

    methods(TestMethodSetup)
        function loadDocument(testCase)
            load('DummyDocument.mat', 'DummyDocument');
            testCase.Document = DummyDocument;
        end
    end

    methods(Test)
        % Test methods

        function testClassdefSettingsOnFirstLine(testCase)
            testCase.createMSpecFile();
            testCase.verifyEqual(testCase.Code(1,1), "classdef NewFeatureMSpecTest < mspec.TestCase");
            testCase.verifyEqual(testCase.Code(3,1), "properties");
            testCase.Code
        end
    end

    methods (Access = protected)
%         function saveToFile(testCase, filename)
% 
%         end

    end

end