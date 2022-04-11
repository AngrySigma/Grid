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
         
         % constructor
         function this = Node(node_id, varargin)
            
            % input arguments:
            %   varargin{1} - id;
            %   varargin{2} - load;
            % output arguments:
            %   this - new object reference;
            
            % handle optional input arguments
            nvarargin = numel(varargin);
            this.id = node_id;
            if nvarargin >= 1 && ~isempty(varargin{2})
                this.load = varargin{2};
            end
         end
         % END OF constructor
        
        % vozmogno potom dobavit setter
        
    end


end