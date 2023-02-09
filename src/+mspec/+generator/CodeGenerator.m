classdef CodeGenerator < handle
    %CODEGENERATOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Access = protected)
        Document mspec.generator.Document
        Code string 
    end
    
    methods
        function createMSpecFile(obj)
            obj.Code(1, 1) = strcat("classdef ", string(obj.Document.Name),"MSpecTest < mspec.TestCase");
            obj.Code(2, 1) = "end";

            obj.saveToFile("NewFeatureMSpecTest.m");
        end
    end

    methods (Access = protected)
        function saveToFile(obj, filename)
            writematrix( obj.Code , filename , "FileType", "text" );
        end
    end
end

