% 遗传算法 求解函数最值  画出个体适配值平均值 和 最大值的变化
% f(x1,x2)=x1^2 + x2^2 - 0.3cos(3*pi*x1)-0.4cos(4*pi*x2)+0.7
% x1[-1 1]  x2[-1 1]
% 
clear all
clc
x_min=-1;
x_max=1;
Pop_size=30; % 种群数
Word_length=11; %字长
Variation_rate=0.001; %变异率 
Cross_rate=0.8; %交叉率

Pop=round(rand(Pop_size,2*Word_length));  %初始化种群

for step=1:100
% % 由二进制编码对应的x值 计算函数值
    x1_Bin=Pop(:,[1:Word_length]);
    x2_Bin=Pop(:,[Word_length+1:2*Word_length]);
 %二进制编码化为十进制---x1 对应的序号
    x1_Num=bin2dec(num2str(x1_Bin(:,:))); 
    x2_Num=bin2dec(num2str(x2_Bin(:,:)));
 %计算x1 x2 及函数值   
    x1=x_min + x1_Num/(2^Word_length-1)*(x_max-x_min);
    x2=x_min + x2_Num/(2^Word_length-1)*(x_max-x_min);
    Fx=x1.^2 + x2.^2 - 0.3*cos(3*pi.*x1)-0.4*cos(4*pi.*x2)+0.7; 
 % 函数最小值及其对应的个体
%     [Fx_ranked,Fx_index]=sort(Fx);%排序
%     Min_Fx(step)=Fx_ranked(1);  % 函数最小值
%     Pop_best=Pop(Fx_index(1),:);% 最佳个体
%     Best_x1=x1(Fx_index(1));
%     Best_x2=x2(Fx_index(1));
    [Min_Fx(step),Min_index]=min(Fx);% 函数最小值 及其 对应的个体序号
    Pop_best=Pop(Min_index,:);% 最佳个体
    Best_x1=x1(Min_index);
    Best_x2=x2(Min_index);

%% 计算适配值
fitness=1./Fx; %用函数值的导数作为适配值
fitness_max(step)=max(fitness);
%% 选择方法：适配值越大,下一代越多(比例选择)
fitness_ave(step)=sum(fitness)/Pop_size; %平均适配值
Sec_pro= floor(fitness./fitness_ave(step)); %个体遗传比例，大于平均适配值才遗传
 n=1;
for i=1:1:Pop_size
    for j=1:1:Sec_pro(i)
        Pop_next(n,:)=Pop(i,:);
        n=n+1;
    end
end
% 剩下 Pop_size-sum(Sec_pro)个 个体随机选择
Sec_size=sum(Sec_pro);
Rest_size=Pop_size-Sec_size;
Sec_row=ceil(Pop_size*rand(Rest_size,1)) ;
Pop_next([Sec_size+1:Pop_size],:)=Pop(Sec_row,:);

%% 交叉  
for i=1:2:(Pop_size-1)
    m=ceil(2*Word_length*rand);%随机选择进行交叉
    if  rand(1)<Cross_rate                  
        temp= Pop_next(i,[m:2*Word_length]);
        Pop_next(i,[m:2*Word_length])=Pop_next(i+1,[m:2*Word_length]);
        Pop_next(i+1,[m:2*Word_length])=temp;
    end
end

%% 变异 
for i=1:Pop_size
    for j=1:2*Word_length
        if  rand(1)<Variation_rate
            Pop_next(i,j)=~Pop_next(i,j);
        end
    end
end

%% 保留最佳个体
% Pop_next(Pop_size-1,:)=Pop_best;
% Pop_next(Pop_size,:)=Pop_best;

Pop=Pop_next;
%% 画图
    figure(1)
    plot(x1,x2,'o','LineWidth',2)
    xlim([-1,1]);ylim([-1,1]);
    text(0.55,0.85,['进化代数' num2str(step)],'Margin',10,'BackgroundColor','yellow');
    grid on;
    drawnow; 
    pause(0.1)
    if step==10
    end
end
figure(2)
plot([1:step],Min_Fx,'LineWidth',2);grid on
title('函数最小值Min f(x)');xlabel('进化代数');ylabel('f(x)'); 
figure(3)
plot([1:step],fitness_max,'b',[1:step],fitness_ave,'r','LineWidth',2);grid on
title('适配值变化曲线');xlabel('进化代数');ylabel('fitness');
legend('fitness最大值','fitness平均值');

% figure(4)
% [x_1,x_2]=meshgrid(-1:0.01:1);
% y=x_1.^2 + x_2.^2 - 0.3*cos(3*pi.*x_1)-0.4*cos(4*pi.*x_2)+0.7;
% mesh(x_1,x_2,y)
% title('原函数')
