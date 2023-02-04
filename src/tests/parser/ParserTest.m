classdef ParserTest < matlab.unittest.TestCase
    
    properties
        Feature
        Parser
    end
   
    methods(TestMethodSetup)
        function setupFeature(testCase)
            testCase.Feature = ["Scenario: First feature " 
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
        
        function whenFeatureDefinitionIsEmpty_shouldReturnEmptyString(testCase)
            testCase.verifyParsedGiven("", string.empty);
        end

        function whenGivenIsMissing_shouldReturnEmptyString(testCase)
            testCase.verifyParsedGiven("When I eat one gherkin", string.empty);
        end

        function whenOnlyGivenIsGiven_shouldReturnGiven(testCase)
            testCase.verifyParsedGiven("Given I have two gherkins", "Given I have two gherkins");
        end
    end

    methods (Access = private)
        function verifyParsedGiven(testCase, featureText, parsedGiven)
            testCase.Parser.FeatureDefinition = featureText;
            testCase.verifyEqual(testCase.Parser.parseGiven(), parsedGiven);
        end
    end
    
end