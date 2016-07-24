% ����Ⱥ ��⺯����ֵ  ������������ֵƽ��ֵ �� ���ֵ�ı仯
% f(x1,x2)=x1^2 + x2^2 - 0.3cos(3*pi*x1)-0.4cos(4*pi*x2)+0.7
% x1[-1 1]  x2[-1 1]
clear all
clc
%% ��������
PSO_size=30;%������
x_min=-1;
x_max=1;  
a_indivi=0.4; %������֪�������Ʋ���
a_global=0.6; %Ⱥ�����������Ʋ���
w=0.95;       %����Ȩ��
%% ������ʼ��
PSO_x=x_min+(x_max-x_min)*rand(PSO_size,2); %�������ӳ�ʼλ��  
PSO_v=rand(PSO_size,2);%�����ӳ�ʼ�ٶ�����
PSO_x_fitness=zeros(PSO_size,1);    % �����������ֵ
PSO_best_fitness=zeros(1,1); % ȫ���������ֵ
PSO_x_position=zeros(PSO_size,2);   % �����������ֵ��λ��
PSO_best_position=zeros(1,2);% ȫ���������ֵλ��
%% ������ʼ
for step=1:100
%% ��������ֵ fitness
x1=PSO_x(:,1);
x2=PSO_x(:,2);
% ����ֵ
Fx=x1.^2 + x2.^2 - 0.3*cos(3*pi.*x1)-0.4*cos(4*pi.*x2)+0.7; 
% �������������ֵ
 temp_fitness=1./Fx;  %����ֵ���㹫ʽ
 Min_Fx(step)=min(Fx);%������Сֵ
 % ���¸����������ֵ
%  PSO_x_fitness=max(temp_fitness,PSO_x_fitness);
 for i=1:1:PSO_size
     if temp_fitness(i)>PSO_x_fitness(i)
         PSO_x_fitness(i)=temp_fitness(i);
         PSO_x_position(i,:)=PSO_x(i,:);
     end
 end
% ȫ���������ֵ��λ��
[PSO_best_fitness(step),best_index]=max(PSO_x_fitness);
PSO_best_position(step,:)=PSO_x_position(best_index,:);
PSO_Best_P=repmat(PSO_best_position(step,:),PSO_size,1);
% ƽ������ֵ
PSO_ave_fitness(step)=sum(PSO_x_fitness)/PSO_size;

%% �ٶȸ���
PSO_v=w*PSO_v+a_indivi*rand(1)*(PSO_x_position-PSO_x)+a_global*rand(1)*(PSO_Best_P-PSO_x);
% ����Ȩ���޸ķ���
 w=1-step/300;
%   PSO_v(best_index,:)=0;
%% λ�ø���
PSO_x=PSO_x+PSO_v;
%% ����Ⱥ������ͼ
    figure(1)
    plot(x1,x2,'o','LineWidth',2)
    xlim([-1,1]);ylim([-1,1]);
    text(0.55,0.85,['��������' num2str(step)],'Margin',10,'BackgroundColor','yellow');
    grid on;
    drawnow; 
    pause(0.1)
end
%% ��ͼ
figure(2)
plot([1:step],Min_Fx,'LineWidth',2);grid on
title('������СֵMin f(x)');xlabel('��������');ylabel('f(x)'); 
figure(3)
plot([1:step],PSO_best_fitness,'b','LineWidth',2);grid on
title('�������ֵ�仯����');xlabel('��������');ylabel('Best-fitness');
figure(4)
plot([1:step],PSO_ave_fitness,'r','LineWidth',2);grid on
title('ƽ������ֵ�仯����');xlabel('��������');ylabel('Average-fitness');
 
