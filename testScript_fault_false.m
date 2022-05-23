clear nGrid
% Load paramters '*.mat' file
load('testing_parameters.mat');
% Assign input properties
% loads' props
load_1 = param.sigma1;
load_2 = param.sigma2;
length_1 = 2;
length_2 = 1;
length_3 = 4;
length_4 = 1;
% lines' props
line_Z = param.Z;
line_Y = param.Y;
line_W = [ zeros(3), line_Z; line_Y, zeros(3) ];
%
% source props
src_ID = 'srcNode';
src_EMF = 1e4;
src_Z0 = 1+0.14i;
src_Zn = 1e6;
% Describe net structure and element props
nGrid = Grid();
% nGrid.add_node('srcNode'); % source node
nGrid.find_node('source').load = zeros(3,3);
nGrid.add_node('intN_1'); % internal node
nGrid.find_node('intN_1').load = zeros(3,3);
nGrid.add_node('Load_1'); % load node
nGrid.find_node('Load_1').load = load_1;
nGrid.add_node('intN_2'); % internal node
nGrid.find_node('intN_2').load = zeros(3,3);
nGrid.add_node('Load_2'); % load node
nGrid.find_node('Load_2').load = load_2;

nGrid.add_line('Line_1', 'source', 'intN_1');
nGrid.find_line('Line_1').len = length_1;
nGrid.find_line('Line_1').w = line_W;
nGrid.add_line('Line_2',  'intN_1', 'Load_1');
nGrid.find_line('Line_2').len = length_2;
nGrid.find_line('Line_2').w = line_W;
nGrid.add_line('Line_3',  'intN_1', 'intN_2');
nGrid.find_line('Line_3').len = length_3;
nGrid.find_line('Line_3').w = line_W;
nGrid.add_line('Line_4',  'intN_2', 'Load_2');
nGrid.find_line('Line_4').len = length_4;
nGrid.find_line('Line_4').w = line_W;
nGrid.insert_fault('Line_1', 1, ones(1,6))
% Set source parameters
% nGrid.setSource( src_ID, src_EMF, src_Z0, src_Zn );
nGrid.emf = src_EMF;
nGrid.z0= src_Z0;
nGrid.zn = src_Zn;
% Call phasors calculations
nGrid.calculate_phasors;
% Collect nodes phasors
resPhasors = [];
for k = 1:numel(nGrid.nodes)
    resPhasors(k).nodeID = nGrid.nodes{k}.id;
    resPhasors(k).U = nGrid.nodes{k}.U;
    resPhasors(k).I = nGrid.nodes{k}.I;
end
% % Save coolected phasors
% save('testResults.mat', 'resPhasors', '-v7');
% display I phasors
for k = [1, 2, 3, 4, 5]
    disp(['I of node ' nGrid.nodes{k}.id])
    disp(num2str(abs(nGrid.nodes{k}.I)))
end
nGrid.plot_grid()