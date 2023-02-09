classdef CodeGenerator < handle
    %CODEGENERATOR Summary of this class goes here
    %   Detailed explanation goes here

    properties (Access = protected)
        Code string = ""
    end

    properties (Access = public)
        Document mspec.generator.Document
        OutputFolder = pwd;
    end

    methods
        function createMSpecFile(obj)
            obj.addProperties();
            for i=1:length(obj.Document.MethodGroups)
                obj.addMethodGroup(i);
            end
            obj.generateClassdef(length(obj.Code)+1);
            obj.saveToFile(strcat(obj.Document.Name, 'MSpecTest','.m'));
        end
    end

    methods (Access = protected)
        function generateClassdef(obj, lastLine)
            obj.Code(1, 1) = strcat("classdef ", string(obj.Document.Name),"MSpecTest < mspec.TestCase");
            obj.Code(lastLine, 1) = "end";
        end

        function addProperties(obj)
            tempCode(1, 1) = "";
            tempCode(2, 1) = "properties";
            tempCode(3, 1) = "FixtureData = struct()";
            tempCode(4, 1) = "end";

            obj.Code = [obj.Code; tempCode];
        end

        function addMethodGroup(obj, i)
            tempCode(1, 1) = "";
            if obj.Document.MethodGroups(i).IsTest
                tempCode(2, 1) = strcat("methods (Test, Description = '", obj.Document.MethodGroups(i).Description ,"')");
            else
                tempCode(2, 1) = strcat("methods (Description = '", obj.Document.MethodGroups(i).Description ,"')");
            end
            tempCode = [tempCode; ...
                obj.addMethod(obj.Document.MethodGroups(i).Methods.MethodName(1), ...
                obj.Document.MethodGroups(i).IsTest)];
            tempCode(length(tempCode)+1, 1) = "end";

            obj.Code = [obj.Code; tempCode];
        end

        function tempCode = addMethod(~, name, isTest)
            tempCode(1, 1) = strcat("function ", name,"(testCase)");
            line = 2;
            if isTest
                tempCode(line, 1) = "testCase.setupTestCase(); % BDD Setup, do NOT delete";
                line = 3;
            end
            tempCode(line, 1) = "%not implemented";
            tempCode(line+1, 1) = "end";
        end

        function saveToFile(obj, filename)
            writematrix( obj.Code , fullfile(obj.OutputFolder, filename) , "FileType", "text", "Delimiter", "bar");
        end
    end
end
