classdef ParserTest < matlab.unittest.TestCase
    
    properties
        BasicFeature
        Parser
    end
   
    methods(TestMethodSetup)
        function setupFeatures(testCase)
            testCase.BasicFeature = ["Scenario: First feature " 
                                 "  Given I have two gherkins"
                                 "  When I eat one gherkin" 
                                 "  Then I have one gherkin"];
        end
        function setupParser(testCase)
            testCase.Parser = mspec.parser.Parser();
        end
    end
    
    methods(Test)
        % Test methods
        
        function whenFeatureContainsOneScenario_shouldGetItsName(testCase)
            testCase.Parser.Feature(1).FileContent = testCase.BasicFeature;
            testCase.Parser.parseFeatureScenarios();
            testCase.verifyEqual(testCase.Parser.Feature.Scenario(1).Name, ...
                "First feature");
        end
        

    end

    methods (Access = private)
        
    end
    
end