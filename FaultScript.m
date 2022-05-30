clear
nGrid = Grid();
nGrid.emf = 1e4;
nGrid.z0= 1+0.14i;
nGrid.zn = 1e-9;
load('testing_parameters.mat');
sigma_1 = param.sigma1;
sigma_2 = param.sigma2;
loads = {0.7 * sigma_1, 0.4 * sigma_1, sigma_2, 0.3 * sigma_2, 0.4 * sigma_1, 0.8 * sigma_2, sigma_1, 2 * sigma_2, 0.25 * sigma_1};
for i = 1:7
    nGrid.add_node(['int_', num2str(i)]);
end
for i = 1:9
    nGrid.add_node(['load_', num2str(i)], loads{i});
end
nGrid.add_line('line_1', 'source', 'int_1', 1);
nGrid.add_line('line_2', 'int_1', 'load_1', 3);
nGrid.add_line('line_3', 'int_1', 'int_2', 1);
nGrid.add_line('line_4', 'int_2', 'load_2', 0.5);
nGrid.add_line('line_5', 'int_2', 'int_3', 0.5);
nGrid.add_line('line_6', 'int_3', 'int_4', 0.2);
nGrid.add_line('line_7', 'int_3', 'int_5', 1);
nGrid.add_line('line_8', 'int_3', 'load_3', 0.7);
nGrid.add_line('line_9', 'int_4', 'load_4', 1);
nGrid.add_line('line_10', 'int_4', 'int_6', 0.3);
nGrid.add_line('line_11', 'int_6', 'load_5', 0.4);
nGrid.add_line('line_12', 'int_6', 'int_7', 0.1);
nGrid.add_line('line_13', 'int_7', 'load_6', 0.3);
nGrid.add_line('line_14', 'int_7', 'load_7', 1);
nGrid.add_line('line_15', 'int_5', 'load_8', 0.4);
nGrid.add_line('line_16', 'int_5', 'load_9', 1.5);
nGrid.plot_grid();