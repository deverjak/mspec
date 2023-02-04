classdef FeatureTest < matlab.unittest.TestCase
    
    properties
        BasicFeature
        AdvancedFeature
        Feature
    end
   
    methods(TestMethodSetup)
        function setupFeatures(testCase)
            testCase.BasicFeature = ["Scenario: First feature " 
                                 "  Given I have two gherkins"
                                 "  When I eat one gherkin" 
                                 "  Then I have one gherkin"];

            testCase.AdvancedFeature = ["Scenario: First feature " 
                                 "  Given I have two gherkins"
                                 "  When I eat one gherkin" 
                                 "  Then I have one gherkin"
                                 " "
                                 "Scenario: Second feature " 
                                 "  Given I have three gherkins"
                                 "  When I eat three gherkin" 
                                 "  Then I have zero gherkin"];
        end
        function setupParser(testCase)
            testCase.Feature = mspec.parser.Feature();
        end
    end
    
    methods(Test)
        % Test methods
        
        function whenFeatureContainsOneScenario_shouldGetItsName(testCase)
            testCase.Feature.FileContent = testCase.BasicFeature;
            testCase.Feature.parseScenarios();
            testCase.verifyEqual(testCase.Feature.Scenario(1).Name, ...
                "First feature");
            testCase.verifyEqual(testCase.Feature.Scenario(1).Given, ...
                "Given I have two gherkins");
            testCase.verifyEqual(testCase.Feature.Scenario(1).When, ...
                "When I eat one gherkin");
            testCase.verifyEqual(testCase.Feature.Scenario(1).Then, ...
                "Then I have one gherkin");
        end

        function whenFeatureContainsTwoScenario_shouldGetBothName(testCase)
            testCase.Feature.FileContent = testCase.AdvancedFeature;
            testCase.Feature.parseScenarios();
            testCase.verifyEqual(testCase.Feature.Scenario(2).Name, ...
                "Second feature");
            testCase.verifyEqual(testCase.Feature.Scenario(2).Given, ...
                "Given I have three gherkins");
            testCase.verifyEqual(testCase.Feature.Scenario(2).When, ...
                "When I eat three gherkin");
            testCase.verifyEqual(testCase.Feature.Scenario(2).Then, ...
                "Then I have zero gherkin");
        end
        

    end

    methods (Access = private)
        
    end
    
end