classdef Line
    properties
        id
    end
    methods
        function obj = Line(id)
            obj.id = id;
        end
        function check_id(obj)
            disp(obj.id)
        end
        function obj = set.id(obj, user_id)
            obj.id = user_id;
        end
    end
    
end