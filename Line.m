classdef Line < handle
    properties (Access = public)
        id;
        p_node;
        c_node;
        len = [];
        w =[];
        I0;
        U0;
        sigma0;
    end
    methods (Access = public)
        
         function this = Line(line_id, p_node, c_node, varargin)
            this.id = line_id;
            this.p_node = p_node;
            this.c_node = c_node;
            varargin = cell2mat(varargin);
            if ~isempty(varargin)
                if numel(varargin) > 2
                    error('Too much arguments.');
                end
                if numel(varargin) >= 1
                    if isnumeric(varargin(1))
                        this.len = varargin(1);
                    else
                        error('Line parameters must be numeric')
                    end
                end
                if numel(varargin) == 2
                    if isnumeric(varargin(2))
                        this.w = varargin(2);
                    else
                        error('Line parameters must be numeric')
                    end 
                end
            end
         end
         %check for too much parameters is needed (i guess)
         
         function calculate_sigma_line(this)
             this.c_node.calculate_sigma_node
             AB = [this.c_node.sigma, -eye(3, 3)] * ...
                 expm(-this.w * this.len);
             this.sigma0 = -AB(:, 4:6) \ AB(:, 1:3);
         end
         
         function spread_phasors_line(this)
             this.U0 = this.p_node.U;
             this.I0 = this.sigma0 * this.p_node.U;
             this.c_node.spread_phasors_node()
         end
    end
end