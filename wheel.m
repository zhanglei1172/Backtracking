%%
clc,clear
a = [57, 71, 87, 97, 99, 101, 103, 113, 114, 115, 128, 129, 131, 137, 147, 156, 163, 186];
%% 有剪枝（每当解中多一个值确定下来之后都判断，可以加速）k为指针
n = 18;%A中一共有多少索引（A为一个特解）
shunXu = 0;%是否从左到右尝试%候选值多的放在越后面遍历越好（以候选值少的先遍历原则为方向就可以加速）
% houXuanChi={};%初始化候选池空间
houXuanChi = cell(1,n);%初始化候选池空间
for i = 1:n
    houXuanChi{i} = [0:floor(1000/a(i))];
end
%%
tic
global con %该全局变量为算法遍历到的最后一个索引
% A = zeros(1,n);%初始化解空间
% index = zeros(1,n);%作为候选池的索引(初始化)
[A,index,chiChang] = deal(zeros(1,n));
if shunXu
    con = n;%顺序的话，就让k从1开始遍历到n
    k = 1;
else
    con = 1;%反序的话，就让k从n开始遍历到1
    k = n;
end
k_dir = shunXu*2-1;
% chiChang = zeros(1,n);
for i = 1:n
    chiChang(i) = length(houXuanChi{i});%候选池的长度（主要用来约束索引不能超过池长）
end
count = 0;%用来记录结果数
while(k>0 && k<=n)
    index(k) = index(k) + 1;%该点索引值需要自增1
    if index(k) > chiChang(k)%判断：如果候选池的索引（k下）比候选池（k下）的长度还大
        index(k) = 0;%重置k下的索引值
        A(k) = 0;%对尝试的小解 复原
        k = k-k_dir;%多步回溯
        continue
    end  
    A(k) = houXuanChi{k}(index(k));%继续选择下一个候选数   
    while  isValidA(A,k) == 0 && index(k) <= chiChang(k)%当k下的小解不正确 但 还可以选择的情况下
        index(k) = index(k) + 1;%候选池索引自增1
        if index(k) <= chiChang(k)%若未超过候选范围
            A(k) = houXuanChi{k}(index(k));%让A在k下取下一个候选值
        end
    end
    if index(k) <= chiChang(k)%若跳出循环但候选还没超过范围，说明小解合法【判断是否是小解】
        if k == con%遍历完了所有的索引%%【判断是否是大解】
            count = count+1;
%             result(count,:) = A;%记录结果
            %             break;若果只需要找一个结果就行
        else%只说明当下小解ok，需要尝试下一层的小解
            k = k+k_dir;
        end
    else%超过了范围都没找到k下的小解
        index(k) = 0;%重置k下的索引值
        A(k) = 0;%对尝试的小解 复原
        k = k-k_dir;%单步回溯
    end
end
count
toc