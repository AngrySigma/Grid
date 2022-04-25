clear all;clc;
load('testing_parameters.mat');
load_1 = param.sigma1;
src_EMF = 1e4;
src_Z0 = 1+0.14i;
src_Zn = 1e6;
length_1 = 2;
line_Z = param.Z;
line_Y = param.Y;
line_W = [ zeros(3), line_Z; line_Y, zeros(3) ];
nGrid = Grid();
nGrid.find_node('source').load = zeros(3,3);
nGrid.add_node('intN_1');
nGrid.find_node('intN_1').load = load_1;
nGrid.add_line('Line_1', 'source', 'intN_1');
nGrid.find_line('Line_1').len = length_1;
nGrid.find_line('Line_1').w = line_W;
nGrid.emf = src_EMF;
nGrid.z0= src_Z0;
nGrid.zn = src_Zn;
nGrid.calculate_phasors
for k = 1:2
   disp("I of "+num2str(k)+" node ")
   disp(num2str(abs(nGrid.nodes{k}.I))) 
end