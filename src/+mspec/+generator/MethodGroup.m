classdef MethodGroup

    properties
        ParentScenario
        IsTest logical = false
        Description string = ""
        Methods table = table([], [], 'VariableNames', {'MethodName', 'Arguments'})
    end

end