classdef Grid < handle
    
    
    properties
        lines = []
        nodes = []
    end
    
    
    methods
        function this = add_node(this, node_id)
            this.check_node_id(node_id)
            this.nodes{end + 1} = Node(node_id);
        end
        
        
        function this = add_line(this, line_id)
            this.check_line_id(line_id)
            this.lines{end + 1} = Line(line_id);
        end
        
        
        function check_node_id(this, node_id)
            if ~ischar(node_id)
                error('Node ID is not of "char" class')
            end
            for i = 1:length(this.nodes)
                if this.nodes{i}.id == node_id
                error('Node ID has a duplicate')
                end
            end
        end
        
        
        function check_line_id(this, line_id)
            if ~ischar(line_id)
                error('Line ID is not of "char" class')
            end
            for i = 1:length(this.lines)
                if this.lines{i}.id == line_id
                    error('Line ID has a duplicate')
                end
            end
        end
        
        function line_ = find_line(this, line_id)
            for num_l = 1:numel(this.lines)
               if strcmp(this.lines{num_l}.id, line_id)
                   line_ = this.lines{num_l};
                   return
               end
            end
            line_ = 0;
        end
        
        
        function node_ = find_node(this, node_id)
            for num_n = 1:numel(this.nodes)
               if strcmp(this.nodes{num_n}.id, node_id)
                   node_ = this.nodes{num_n};
                   return
               end
            end
            node_ = 0;
        end
    end
end