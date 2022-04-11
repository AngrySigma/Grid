clear
clc
cd 'D:\GREAT_VAULT\Study\Cathedral\Grid\Grid_map'
ex = Grid;
ex.add_node('1');
ex.add_node('2');
ex.add_line('1');
a = ex.find_node('2')
disp (ex)