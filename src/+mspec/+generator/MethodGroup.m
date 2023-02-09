classdef MethodGroup

    properties
        ParentScenario
        Descriptor table = table([], [], 'VariableNames', {'Field', 'Value'})
        Methods table = table([], [], 'VariableNames', {'MethodName', 'Arguments'})
    end

end