%%
clc,clear
a = [57, 71, 87, 97, 99, 101, 103, 113, 114, 115, 128, 129, 131, 137, 147, 156, 163, 186];
%% �м�֦��ÿ�����ж�һ��ֵȷ������֮���жϣ����Լ��٣�kΪָ��
n = 18;%A��һ���ж���������AΪһ���ؽ⣩
shunXu = 0;%�Ƿ�����ҳ���%��ѡֵ��ķ���Խ�������Խ�ã��Ժ�ѡֵ�ٵ��ȱ���ԭ��Ϊ����Ϳ��Լ��٣�
% houXuanChi={};%��ʼ����ѡ�ؿռ�
houXuanChi = cell(1,n);%��ʼ����ѡ�ؿռ�
for i = 1:n
    houXuanChi{i} = [0:floor(1000/a(i))];
end
%%
tic
global con %��ȫ�ֱ���Ϊ�㷨�����������һ������
% A = zeros(1,n);%��ʼ����ռ�
% index = zeros(1,n);%��Ϊ��ѡ�ص�����(��ʼ��)
[A,index,chiChang] = deal(zeros(1,n));
if shunXu
    con = n;%˳��Ļ�������k��1��ʼ������n
    k = 1;
else
    con = 1;%����Ļ�������k��n��ʼ������1
    k = n;
end
k_dir = shunXu*2-1;
% chiChang = zeros(1,n);
for i = 1:n
    chiChang(i) = length(houXuanChi{i});%��ѡ�صĳ��ȣ���Ҫ����Լ���������ܳ����س���
end
count = 0;%������¼�����
while(k>0 && k<=n)
    index(k) = index(k) + 1;%�õ�����ֵ��Ҫ����1
    if index(k) > chiChang(k)%�жϣ������ѡ�ص�������k�£��Ⱥ�ѡ�أ�k�£��ĳ��Ȼ���
        index(k) = 0;%����k�µ�����ֵ
        A(k) = 0;%�Գ��Ե�С�� ��ԭ
        k = k-k_dir;%�ಽ����
        continue
    end  
    A(k) = houXuanChi{k}(index(k));%����ѡ����һ����ѡ��   
    while  isValidA(A,k) == 0 && index(k) <= chiChang(k)%��k�µ�С�ⲻ��ȷ �� ������ѡ��������
        index(k) = index(k) + 1;%��ѡ����������1
        if index(k) <= chiChang(k)%��δ������ѡ��Χ
            A(k) = houXuanChi{k}(index(k));%��A��k��ȡ��һ����ѡֵ
        end
    end
    if index(k) <= chiChang(k)%������ѭ������ѡ��û������Χ��˵��С��Ϸ����ж��Ƿ���С�⡿
        if k == con%�����������е�����%%���ж��Ƿ��Ǵ�⡿
            count = count+1;
%             result(count,:) = A;%��¼���
            %             break;����ֻ��Ҫ��һ���������
        else%ֻ˵������С��ok����Ҫ������һ���С��
            k = k+k_dir;
        end
    else%�����˷�Χ��û�ҵ�k�µ�С��
        index(k) = 0;%����k�µ�����ֵ
        A(k) = 0;%�Գ��Ե�С�� ��ԭ
        k = k-k_dir;%��������
    end
end
count
toc