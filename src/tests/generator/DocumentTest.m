classdef DocumentTest < matlab.unittest.TestCase
    
    properties
        Document mspec.generator.Document
        Feature
    end

    methods(TestClassSetup)
        % Shared setup for the entire test class
    end
    
    methods(TestMethodSetup)
        function setupDocument(testCase)
            testCase.Document = mspec.generator.Document();
        end
        function setupDummyFeature(testCase)
            testCase.Feature = mspec.parser.Feature();
            testCase.Feature.FileName = 'NewFeature.feature';
            testCase.Feature.Scenario = mspec.parser.Scenario;
            testCase.Feature.Scenario.Name = 'NewFeature Scenario';
            testCase.Feature.Scenario.Given = 'Given logged User U';
            testCase.Feature.Scenario.When = 'When User U disconnects';
            testCase.Feature.Scenario.Then = 'Then session is closed';

            scenario2 = mspec.parser.Scenario;
            scenario2.Name = 'User logging';
            scenario2.Given = 'Given logged User G';
            scenario2.When = 'When User U connects';
            scenario2.Then = 'Then session is opened';

            testCase.Feature.Scenario(2) = scenario2;
        end
        function setFeature(testCase)
            testCase.Document.setFeature(testCase.Feature);
        end
    end
    
    methods(Test)
        % Test methods
        
        function testParentScenario(testCase)
            testCase.verifyEqual(testCase.Document.MethodGroups(1).ParentScenario, ...
                '[S1]');
            testCase.verifyEqual(testCase.Document.MethodGroups(2).ParentScenario, ...
                '[S1]');
            testCase.verifyEqual(testCase.Document.MethodGroups(3).ParentScenario, ...
                '[S1]');
        end
        function testParentScenario2(testCase)
            testCase.verifyEqual(testCase.Document.MethodGroups(4).ParentScenario, ...
                '[S2]');
            testCase.verifyEqual(testCase.Document.MethodGroups(5).ParentScenario, ...
                '[S2]');
            testCase.verifyEqual(testCase.Document.MethodGroups(6).ParentScenario, ...
                '[S2]');
        end
        function testDescriptorInFirstGroup(testCase)
            testCase.verifyEqual(testCase.Document.MethodGroups(1).Descriptor(1, :).Variables, ...
                ["Description", "[S1]Given logged User U"]);
        end
        function testDescriptorInWhenGroupOfSecondScenario(testCase)
            testCase.verifyEqual(testCase.Document.MethodGroups(5).Descriptor(1, :).Variables, ...
                ["Description", "[S2]When User U connects"]);
        end
        function testDescriptorInTestGroup(testCase)
            testCase.verifyEqual(testCase.Document.MethodGroups(3).Descriptor.Variables, ...
                ["Test", ""; "Description", "[S1]Then session is closed"]);
        end
    end
    
end