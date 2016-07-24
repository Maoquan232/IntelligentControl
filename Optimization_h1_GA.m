% �Ŵ��㷨 ��⺯����ֵ  ������������ֵƽ��ֵ �� ���ֵ�ı仯
% f(x1,x2)=x1^2 + x2^2 - 0.3cos(3*pi*x1)-0.4cos(4*pi*x2)+0.7
% x1[-1 1]  x2[-1 1]
% 
clear all
clc
x_min=-1;
x_max=1;
Pop_size=30; % ��Ⱥ��
Word_length=11; %�ֳ�
Variation_rate=0.001; %������ 
Cross_rate=0.8; %������

Pop=round(rand(Pop_size,2*Word_length));  %��ʼ����Ⱥ

for step=1:100
% % �ɶ����Ʊ����Ӧ��xֵ ���㺯��ֵ
    x1_Bin=Pop(:,[1:Word_length]);
    x2_Bin=Pop(:,[Word_length+1:2*Word_length]);
 %�����Ʊ��뻯Ϊʮ����---x1 ��Ӧ�����
    x1_Num=bin2dec(num2str(x1_Bin(:,:))); 
    x2_Num=bin2dec(num2str(x2_Bin(:,:)));
 %����x1 x2 ������ֵ   
    x1=x_min + x1_Num/(2^Word_length-1)*(x_max-x_min);
    x2=x_min + x2_Num/(2^Word_length-1)*(x_max-x_min);
    Fx=x1.^2 + x2.^2 - 0.3*cos(3*pi.*x1)-0.4*cos(4*pi.*x2)+0.7; 
 % ������Сֵ�����Ӧ�ĸ���
%     [Fx_ranked,Fx_index]=sort(Fx);%����
%     Min_Fx(step)=Fx_ranked(1);  % ������Сֵ
%     Pop_best=Pop(Fx_index(1),:);% ��Ѹ���
%     Best_x1=x1(Fx_index(1));
%     Best_x2=x2(Fx_index(1));
    [Min_Fx(step),Min_index]=min(Fx);% ������Сֵ ���� ��Ӧ�ĸ������
    Pop_best=Pop(Min_index,:);% ��Ѹ���
    Best_x1=x1(Min_index);
    Best_x2=x2(Min_index);

%% ��������ֵ
fitness=1./Fx; %�ú���ֵ�ĵ�����Ϊ����ֵ
fitness_max(step)=max(fitness);
%% ѡ�񷽷�������ֵԽ��,��һ��Խ��(����ѡ��)
fitness_ave(step)=sum(fitness)/Pop_size; %ƽ������ֵ
Sec_pro= floor(fitness./fitness_ave(step)); %�����Ŵ�����������ƽ������ֵ���Ŵ�
 n=1;
for i=1:1:Pop_size
    for j=1:1:Sec_pro(i)
        Pop_next(n,:)=Pop(i,:);
        n=n+1;
    end
end
% ʣ�� Pop_size-sum(Sec_pro)�� �������ѡ��
Sec_size=sum(Sec_pro);
Rest_size=Pop_size-Sec_size;
Sec_row=ceil(Pop_size*rand(Rest_size,1)) ;
Pop_next([Sec_size+1:Pop_size],:)=Pop(Sec_row,:);

%% ����  
for i=1:2:(Pop_size-1)
    m=ceil(2*Word_length*rand);%���ѡ����н���
    if  rand(1)<Cross_rate                  
        temp= Pop_next(i,[m:2*Word_length]);
        Pop_next(i,[m:2*Word_length])=Pop_next(i+1,[m:2*Word_length]);
        Pop_next(i+1,[m:2*Word_length])=temp;
    end
end

%% ���� 
for i=1:Pop_size
    for j=1:2*Word_length
        if  rand(1)<Variation_rate
            Pop_next(i,j)=~Pop_next(i,j);
        end
    end
end

%% ������Ѹ���
% Pop_next(Pop_size-1,:)=Pop_best;
% Pop_next(Pop_size,:)=Pop_best;

Pop=Pop_next;
%% ��ͼ
    figure(1)
    plot(x1,x2,'o','LineWidth',2)
    xlim([-1,1]);ylim([-1,1]);
    text(0.55,0.85,['��������' num2str(step)],'Margin',10,'BackgroundColor','yellow');
    grid on;
    drawnow; 
    pause(0.1)
    if step==10
    end
end
figure(2)
plot([1:step],Min_Fx,'LineWidth',2);grid on
title('������СֵMin f(x)');xlabel('��������');ylabel('f(x)'); 
figure(3)
plot([1:step],fitness_max,'b',[1:step],fitness_ave,'r','LineWidth',2);grid on
title('����ֵ�仯����');xlabel('��������');ylabel('fitness');
legend('fitness���ֵ','fitnessƽ��ֵ');

% figure(4)
% [x_1,x_2]=meshgrid(-1:0.01:1);
% y=x_1.^2 + x_2.^2 - 0.3*cos(3*pi.*x_1)-0.4*cos(4*pi.*x_2)+0.7;
% mesh(x_1,x_2,y)
% title('ԭ����')
