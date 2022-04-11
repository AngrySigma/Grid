classdef Line < handle
    properties (Access = public)
        id;
        p_node;
        c_node;
        len;
        w;
        I0;
        U0;
        sigma0;
    end
    methods (Access = public)
         
         % constructor
         function this = Line(line_id, p_node, c_node, varargin)
            
            % input arguments:
            %   varargin{1} - id;
            %   varargin{2} - p_node;
            %   varargin{3} - c_node;
            %   varargin{4} - len;
            %   varargin{5} - w;
            % output arguments:
            %   this - new object reference;
            
            % handle optional input arguments
            nvarargin = numel(varargin);
            this.id = line_id;
            this.p_node = p_node;
            this.c_node = c_node;

            if nvarargin >= 1 && ~isempty(varargin{1})
                this.len = varargin{1};
            end
            if nvarargin >= 2 && ~isempty(varargin{2})
                this.w = varargin{2};
            end
         end
         % END OF constructor
        
        % vozmogno potom dobavit setter
        
    end


end