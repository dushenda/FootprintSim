syms x
eqn = sin(0.445*x)*cos(x/2)-0.16305==0;
S = vpasolve(eqn);
%%
syms x
eqn2 = (asin(0.168/(cos(x/2)))-asin(0.108/(cos(x/2))))*0.445 - asin(0.16305/cos(x/2))==0;
x = -10:0.1:10;
%%

y = (asin(0.168./(cos(x/2)))-asin(0.108./(cos(x/2))))*0.445 - asin(0.16305./cos(x/2));

S2 = solve(eqn2)

res = 0.37466231761455910321683585246198;

k = sin(0.445*res)*cos(res/2)
