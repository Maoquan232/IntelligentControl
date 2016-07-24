% 粒子群 求解函数最值  画出个体适配值平均值 和 最大值的变化
% f(x1,x2)=x1^2 + x2^2 - 0.3cos(3*pi*x1)-0.4cos(4*pi*x2)+0.7
% x1[-1 1]  x2[-1 1]
clear all
clc
%% 参数设置
PSO_size=30;%粒子数
x_min=-1;
x_max=1;  
a_indivi=0.4; %个体认知分量控制参数
a_global=0.6; %群体社会分量控制参数
w=0.95;       %惯性权重
%% 变量初始化
PSO_x=x_min+(x_max-x_min)*rand(PSO_size,2); %各个粒子初始位置  
PSO_v=rand(PSO_size,2);%各粒子初始速度向量
PSO_x_fitness=zeros(PSO_size,1);    % 个体最佳适配值
PSO_best_fitness=zeros(1,1); % 全局最佳适配值
PSO_x_position=zeros(PSO_size,2);   % 个体最佳适配值的位置
PSO_best_position=zeros(1,2);% 全局最佳适配值位置
%% 迭代开始
for step=1:100
%% 计算适配值 fitness
x1=PSO_x(:,1);
x2=PSO_x(:,2);
% 函数值
Fx=x1.^2 + x2.^2 - 0.3*cos(3*pi.*x1)-0.4*cos(4*pi.*x2)+0.7; 
% 各粒子最佳适配值
 temp_fitness=1./Fx;  %适配值计算公式
 Min_Fx(step)=min(Fx);%函数最小值
 % 更新个体最佳适配值
%  PSO_x_fitness=max(temp_fitness,PSO_x_fitness);
 for i=1:1:PSO_size
     if temp_fitness(i)>PSO_x_fitness(i)
         PSO_x_fitness(i)=temp_fitness(i);
         PSO_x_position(i,:)=PSO_x(i,:);
     end
 end
% 全局最佳适配值及位置
[PSO_best_fitness(step),best_index]=max(PSO_x_fitness);
PSO_best_position(step,:)=PSO_x_position(best_index,:);
PSO_Best_P=repmat(PSO_best_position(step,:),PSO_size,1);
% 平均适配值
PSO_ave_fitness(step)=sum(PSO_x_fitness)/PSO_size;

%% 速度更新
PSO_v=w*PSO_v+a_indivi*rand(1)*(PSO_x_position-PSO_x)+a_global*rand(1)*(PSO_Best_P-PSO_x);
% 惯性权重修改方法
 w=1-step/300;
%   PSO_v(best_index,:)=0;
%% 位置更新
PSO_x=PSO_x+PSO_v;
%% 粒子群搜索绘图
    figure(1)
    plot(x1,x2,'o','LineWidth',2)
    xlim([-1,1]);ylim([-1,1]);
    text(0.55,0.85,['迭代次数' num2str(step)],'Margin',10,'BackgroundColor','yellow');
    grid on;
    drawnow; 
    pause(0.1)
end
%% 绘图
figure(2)
plot([1:step],Min_Fx,'LineWidth',2);grid on
title('函数最小值Min f(x)');xlabel('迭代次数');ylabel('f(x)'); 
figure(3)
plot([1:step],PSO_best_fitness,'b','LineWidth',2);grid on
title('最大适配值变化曲线');xlabel('迭代次数');ylabel('Best-fitness');
figure(4)
plot([1:step],PSO_ave_fitness,'r','LineWidth',2);grid on
title('平均适配值变化曲线');xlabel('迭代次数');ylabel('Average-fitness');
 
