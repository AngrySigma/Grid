classdef Node < handle
    properties (Access = public)
        id;
        p_line = [];
        c_line = [];
        load;
        I;
        U;
        sigma;
        coord;
    end
    methods (Access = public)
        
         function this = Node(node_id, varargin)
            this.id = node_id;
            varargin = cell2mat(varargin);
            if ~isempty(varargin)
                %check for numeric
%                 if ~isnumeric(varargin)
%                     error('Load should be numeric value');
%                     % validateattributes(4, {'numeric'}, {'size', 1}) -
%                     % potom mogno zdelat
%                 else
%                     this.load = varargin;
%                 end
                validateattributes(varargin, {'numeric'}, {'size', [3, 3]});
                this.load = varargin;
            end
         end
         
        function calculate_sigma_node(this)
            this.sigma = this.load;
            if ~isempty(this.c_line)
                for j = 1:length(this.c_line)
                    this.c_line{j}.calculate_sigma_line
                    this.sigma = this.sigma + this.c_line{j}.sigma0;
                end
            end
        end
        function spread_phasors_node(this)
             UI = expm(-this.p_line.len * this.p_line.w) * ...
                 [this.p_line.U0; this.p_line.I0];
             this.U = UI(1:3, 1);
             this.I = UI(4:6, 1);
             for k = 1:numel(this.c_line)
                this.c_line{k}.spread_phasors_line()
             end
         end
    end


end