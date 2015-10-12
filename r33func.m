function fy = r33func(x,d,vn)
%   �ļ���: r33func.m
%   ��Ȩ: GuangXi Univ.
%   ����: Xz Tang, robo
%   ����: Oct. 12, 2015  
%   ����:   
%    
%   �������˵���� xΪ�����������
%                 dΪ��߽���
%                 vnΪ������



en = vn * (vn-1) /2;            %�������
e = sym(zeros(vn,vn))           %�߼���Ӧ�Ķ�ά���飬e(i,j)����<vi, vj>��ֵ�� ��ʼ��Ϊ0 
k = 1;                          %x��������ʼ���
for i=1:vn                      % 
    for j = i+1 : vn
        e(i,j) = x(k)           %���߼�x��ֵ����e
        k = k+1;
    end
end
vertex =[];                          %���㼯����ʼ��Ϊ��
for i = 1:vn
    vertex = [vertex,i]              %�������㼯{1,2,3,...,vn}
end

combarr = combntns(vertex,3);        %�Ӷ��㼯����ѡ3�����㣬�����е�ȡֵ���
size_of_combarr = size(combarr,1);   %������ȡֵ��ϵ�������3�ŵ���Ŀ
for i = 1:size_of_combarr            %��ÿһ��3��
    u = combarr(i,1);
    v = combarr(i,2);
    w = combarr(i,3);
    h = e(u,v)+e(u,w)+e(v,w)         %3���ߵĺ�
    f(i) = (h-1)*(h-2)               
end

for i = 1:en
    f(size_of_combarr+i) = x(i)*(x(i)-1)
end

cnum = (size(x,1) + 1)*(vn*(vn-1)*(vn-2)/6+en)         %����ϵ���ĸ���
c = sym('c',[1,cnum]);                                 %ϵ������
syms fy                                                %����ʽ���ű���

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

