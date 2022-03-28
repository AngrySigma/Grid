classdef Grid < handle
    properties
        lines
        nodes = [Node(0)]
        nodes_id = [0]
    end
    methods
        function obj = add_node(obj, node_id)
            obj.nodes(length(obj.nodes) + 1) = Node(node_id);
            for i = 1:length(obj.nodes)
            disp(obj.nodes(i).id)
            end
        end
    end
end