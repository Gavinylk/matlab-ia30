%% ��׼�Ŵ��㷨SGA
clear;
%clc
pc=0.7;     % �������
pm=0.05; % �������
%�����Ŵ��㷨����
NIND=40;        %������Ŀ
MAXGEN=500;     %����Ŵ�����
NVAR=2;               %������ά��
PRECI=20;             %�����Ķ�����λ��
GGAP=0.9;             %����
trace=zeros(MAXGEN,1); %��¼�Ż��켣
FieldD=[rep(PRECI,[1,NVAR]);[-3,4.1;12.1,5.8];rep([1;0;1;1],[1,NVAR])]; %��������������
Chrom=crtbp(NIND, NVAR*PRECI);                       %������ʼ��Ⱥ
gen=0;                                               %��������   
ObjV=ObjectFunction(bs2rv(Chrom, FieldD));%�����ʼ��Ⱥ�����Ŀ�꺯��ֵ
[maxY,I]=max(ObjV); %����ֵ
X=bs2rv(Chrom, FieldD);
maxX=X(I,:);
while gen<MAXGEN                                     %����
    FitnV=ranking(-ObjV);                            %������Ӧ��ֵ(Assign fitness values)
    SelCh=select('sus', Chrom, FitnV, GGAP);         %ѡ��
    SelCh=recombin('xovsp', SelCh, pc);              %����
    SelCh=mut(SelCh,pm);                             %����
    ObjVSel=ObjectFunction(bs2rv(SelCh, FieldD));           %�����Ӵ�Ŀ�꺯��ֵ
    [Chrom ObjV]=reins(Chrom, SelCh, 1, 1, ObjV, ObjVSel);  %�ز���
    gen=gen+1;           %������������
    if maxY<max(ObjV)
        [maxY,I]=max(ObjV);
        X=bs2rv(Chrom, FieldD);
        maxX=X(I,:);
    end
    trace(gen,1)=maxY;
end

%% ��������ͼ
plot(1:gen,trace(:,1));
hold on
xlabel('��������');
ylabel('���Ž�仯');
title('SGA��������');


%% ������Ž�
disp(['����ֵΪ��',num2str(maxY)]);
disp(['��Ӧ���Ա���ȡֵ��',num2str(maxX)]);
