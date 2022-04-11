classdef Grid < handle
    
    
    properties
        source_id = 'source'
        lines = []
        nodes = []
    end
    
    
    methods
        function this = Grid()
            this.add_node(this.source_id);
        end
        function this = add_node(this, node_id)
            this.check_node_id(node_id)
            this.nodes{end + 1} = Node(node_id);
        end
        
        
        function this = add_line(this, line_id, p_node_id, c_node_id)
            this.check_line_id(line_id)
            this.lines{end + 1} = Line(line_id, this.find_node(p_node_id), this.find_node(c_node_id));
            if ~isempty(this.find_node(c_node_id).p_line)
                %error(['A parent l!ne has been already assigned to the node,', 'Node ID: ', c_node_id, 'Line ID: ', line_id])
                error(sprintf('A parent line has been already assigned to the node \n Node ID: %s, Line ID: %s', c_node_id, line_id))
            end
            if strcmp(c_node_id, this.source_id)
                error(sprintf('Source can not be chosen as a child'))
            end
            this.find_node(c_node_id).p_line = this.find_line(line_id);
            this.find_node(p_node_id).c_line{end + 1} = this.find_line(line_id);
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
        
        function plot_grid(this)
            figure
            hold on
            for i = 1:length(this.nodes)
                this.nodes{i}.coord = [rand rand];
            end
            plot (this.nodes{1}.coord(1),this.nodes{1}.coord(2),'pk','MarkerSize',10)
            for i = 1: length(this.lines)
                plot ([this.lines{i}.p_node.coord(1) ...
                    this.lines{i}.c_node.coord(1)], ...
                    [this.lines{i}.p_node.coord(2), ...
                    this.lines{i}.c_node.coord(2)],'-ok','MarkerSize',10)
            end
        end
        
        %{
        function plot_children(this, node_id, varargin)
            if ~isempty(varargin)
                angle = varargin(1);
                x = varargin(2);
                y = varargin(3);
                edge = varargin(4);
            else
                angle = 0;
                x = 0;
                y = 0;
                edge = 1;
            end
            for i = 1:length(this.find_node(node_id).c_line)
                plot ([y y + edge * real(exp(2i * pi * angle / 360))],...
                [y y + imag(exp(2i * pi * angle / 360))],'-ko')
                plot_children()
            end
        end
        %}
    end
end