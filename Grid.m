classdef Grid < handle
    
    
    properties
        source_id = 'source'
        lines = []
        nodes = []
        emf = []
        zn = []
        z0 = []
    end
    
    
    methods
        function this = Grid()
            this.add_node(this.source_id);
        end
	    function this = add_node(this, node_id, varargin)
            this.check_node_id(node_id)
            this.nodes{end + 1} = Node(node_id, cell2mat(varargin));
        end
        
        function this = add_line(this, line_id, p_node_id,...
                c_node_id, varargin)
            this.check_line_id(line_id)
            this.check_line_place(p_node_id, c_node_id)
            this.lines{end + 1} = Line(line_id, ...
                this.find_node(p_node_id),...
                this.find_node(c_node_id), varargin{:});
            this.find_node(c_node_id).p_line = this.find_line(line_id);
            this.find_node(p_node_id).c_line{end + 1} = ...
                this.find_line(line_id);
        end
        
        function check_line_place(this, p_node_id, c_node_id)        
            if ~isempty(this.find_node(c_node_id).p_line)
                error(sprintf...
                    ('A parent line is assigned to the node \n Node ID: %s, Line ID: %s',...
                    c_node_id, this.find_node(c_node_id).p_line.id))
            end
            if strcmp(c_node_id, this.source_id)
                error(sprintf('Source can not be chosen as a child'))
            end
            if strcmp(p_node_id, c_node_id)
                error('Same source and child nodes')
            end
            this.check_loop(p_node_id, c_node_id)
        end
        
        function check_loop(this, current_node_id, checked_node_id)
            if ~isempty(this.find_node(current_node_id).p_line)
                if this.find_node(current_node_id).p_line.p_node == ...
                        this.find_node(checked_node_id)
                    error('Line creates a loop')
                end
                this.check_loop...
                    (this.find_node(current_node_id)...
                    .p_line.p_node.id, checked_node_id);
            end
        end
        
        function check_node_id(this, node_id)
            if ~ischar(node_id)
                error(sprintf('Node ID is not of "char" class'))
            end
            for i = 1:length(this.nodes)
                if strcmp(this.nodes{i}.id, node_id)
                error(sprintf('Node ID has a duplicate'))
                end
            end
        end
        
        
        function check_line_id(this, line_id)
            if ~ischar(line_id)
                error(sprintf('Line ID is not of "char" class'))
            end
            for i = 1:length(this.lines)
                if strcmp(this.lines{i}.id, line_id)
                    error(sprintf('Line ID has a duplicate'))
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
        
        function calculate_phasors(this)
            src_id = this.source_id;
            this.find_node(src_id).calculate_sigma_node();
            src_emf = this.emf * [1; exp(2i * pi / 3);  exp(-2i * pi / 3)];
            z_src = eye(3,3) * this.z0 + ones(3,3) * this.zn;
            this.find_node(src_id).U = (eye(3,3) + z_src * this.find_node(src_id).sigma)^(-1) * src_emf;
            this.find_node(src_id).I = this.find_node(src_id).sigma * this.find_node(src_id).U;
            for k = 1:numel(this.find_node(src_id).c_line)
                this.find_node(src_id).c_line{k}.spread_phasors_line();
            end
        end
        
        function plot_grid(this)
            figure
            hold on
            this.nodes{1}.coord = [0, 0];
            for i = 2:length(this.nodes)
                this.nodes{i}.coord = this.nodes{i-1}.coord + [rand - 0.5 rand - 5];
            end
            plot (this.nodes{1}.coord(1),this.nodes{1}.coord(2),'*k',...
                'MarkerSize',10)
            for i = 1: length(this.lines)
                plot ([this.lines{i}.p_node.coord(1) ...
                    this.lines{i}.c_node.coord(1)], ...
                    [this.lines{i}.p_node.coord(2), ...
                    this.lines{i}.c_node.coord(2)],'-ok','MarkerSize',10)
            end
        end
        
        function insert_node(this, line_id, xi, new_node_id, new_node_load)
            this.add_node(new_node_id, new_node_load);
            old_child_id = this.find_line(line_id).c_node.id;
            this.find_line(line_id).c_node = this.find_node(new_node_id);
            this.find_node(new_node_id).p_line = this.find_line(line_id);
            this.find_node(old_child_id).p_line = {};
            this.add_line([line_id, '_2'], new_node_id, old_child_id);
            this.find_line([line_id, '_2']).w = this.find_line(line_id).w;
            this.find_line([line_id, '_2']).len = this.find_line(line_id).len * (1 - xi);
            this.find_line(line_id).id = [line_id, '_1'];
            this.find_line([line_id, '_1']).len = this.find_line([line_id, '_1']).len * xi;
        end
        
        function insert_fault(this, line_id, xi, vec)
            this.insert_node(line_id, xi, 'fault',...
                [vec(4) + vec(1) + vec(3), -vec(1), -vec(3); ...
                -vec(1), vec(5) + vec(1) + vec(2), -vec(2); ...
                -vec(3), -vec(2), vec(6) + vec(2) + vec(3)]);
        end
    end
end