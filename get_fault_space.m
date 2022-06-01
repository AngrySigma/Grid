clc, clear all, close all

num_exp = 10;
save_file = 'fault_space_tab.mat';
resPhasors_ins = [];

for k = 1:num_exp
    
    % run main script and return nGrid
%     nGrid = FaultScript();
    run("testScript.m");
    
    % init rand line
    nline = numel(nGrid.lines);
    idx_line = randi(nline);
    need_line = nGrid.lines{idx_line};
    
    % init rel coord 
    xi = rand();
    
    % init sigma fault vec
    sf_v = zeros(1, 6);
    while sum(sf_v) == 0
        sf_v = (0.9 * rand(1, 6) + 0.1) .* round(rand(1,6));
    end
    
    % insert fault in rand place
    nGrid.insert_fault(need_line.id, xi, sf_v)
    
    % call phasors calculations
    nGrid.calculate_phasors;
    
    % collect source phasors
    resPhasors_ins(k).U = nGrid.nodes{1}.U;
    resPhasors_ins(k).I = nGrid.nodes{1}.I;
    resPhasors_ins(k).sf_v = sf_v;

end

% save coolected phasors
save(save_file, 'resPhasors_ins', '-v7');
