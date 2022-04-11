classdef Node < handle
    properties
        id
        
    end
    methods
        function this = Node(id)
            this.id = id;
        end
        function check_id(this)
            disp(this.id)
        end
        function set.id(this, user_id)
            this.id = user_id;
        end
    end


end
