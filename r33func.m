function fy = r33func(x,d,vn)
%   文件名: r33func.m
%   版权: GuangXi Univ.
%   作者: Xz Tang, robo
%   日期: Oct. 12, 2015  
%   描述:   
%    
%   输入变量说明： x为变量，代表边
%                 d为最高阶数
%                 vn为顶点数



en = vn * (vn-1) /2;            %计算边数
e = sym(zeros(vn,vn))           %边集对应的二维数组，e(i,j)代表<vi, vj>的值， 初始化为0 
k = 1;                          %x变量的起始标号
for i=1:vn                      % 
    for j = i+1 : vn
        e(i,j) = x(k)           %将边集x的值赋给e
        k = k+1;
    end
end
vertex =[];                          %顶点集，初始化为空
for i = 1:vn
    vertex = [vertex,i]              %构建顶点集{1,2,3,...,vn}
end

combarr = combntns(vertex,3);        %从顶点集中任选3个顶点，求所有的取值组合
size_of_combarr = size(combarr,1);   %求所有取值组合的总数，3团的数目
for i = 1:size_of_combarr            %对每一个3团
    u = combarr(i,1);
    v = combarr(i,2);
    w = combarr(i,3);
    h = e(u,v)+e(u,w)+e(v,w)         %3条边的和
    f(i) = (h-1)*(h-2)               
end

for i = 1:en
    f(size_of_combarr+i) = x(i)*(x(i)-1)
end

cnum = (size(x,1) + 1)*(vn*(vn-1)*(vn-2)/6+en)         %计算系数的个数
c = sym('c',[1,cnum]);                                 %系数变量
syms fy                                                %多项式符号变量

fy = 0

for i = 1:35
    k = 16 * (i-1) + 1
    alpha(i) = c(k)
    for j = 1:15
        alpha(i) = alpha(i) + c(k+j) * x(j)
    end
    fy = fy + alpha(i) * f(i)
end



end

