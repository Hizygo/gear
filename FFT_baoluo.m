%%%%%%%%%%%%%%%%%数据处理%%%%%%%%%%%%%%
close all; clc; clear;


YY=load('S2_800_40_1.mat');
X=YY.n_Point1__Z.y_values.values(10240*10:10240*20);
sig=X(10240*6.2:10240*7.2);
% YY=load('H1_800_40_1.mat');
% X=YY.Data1_AI_2(10240*10:10240*20);
fs=10240;
l=length(X);
t=(0:1/fs:l/fs-1/fs);
figure(1);
plot(t,X);
% xlim([0 10])
% xlim([5.2 6.2])
% xlim([0 1])
% title('', 'FontName','Times New Roman','FontSize',14)%%%%%%%%%%%%%%%%%%%%设置图片标题上数字的字体及大小
% xlabel('时间(s)','FontName','Times New Roman','FontSize',14)%%%%%%%%%%%%%设置X坐标轴上数字的字体及大小
% ylabel('振动幅值(g)','FontName','Times New Roman','FontSize',14)%%%%%%%%设置Y坐标轴上数字的字体及大小
% set(gca,'FontName','Times New Roman','FontSize',14)%%%%%%%%%%%%%%%%%%%%%%设置坐标轴上数字的字体
% %%%%%%%%%%%%%%%%%%这个需要注意，修改Data cursor数字及其字体大小，也就是标注：：：：：使用方法：现在图片上标出，然后在command命令中输入该指令
% set(findall(gcf,'ViewStyle','datatip'),'FontName','Times New Roman','fontsize',14)

xlim([0 1])
ylim([-100 60])
% title('', 'FontName','Times New Roman','FontSize',14)%%%%%%%%%%%%%%%%%%%%设置图片标题上数字的字体及大小
xlabel('Time(s)','FontName','Times New Roman','FontSize',10)%%%%%%%%%%%%%设置X坐标轴上数字的字体及大小
ylabel('Amplitude(g)','FontName','Times New Roman','FontSize',10)%%%%%%%%设置Y坐标轴上数字的字体及大小
% set(gca,'FontName','Times New Roman','FontSize',14)%%%%%%%%%%%%%%%%%%%%%%设置坐标轴上数字的字体
set(gca,'FontWeight','bold'); %字符粗细，normal为不加粗，bold加粗
set(gcf, 'unit', 'centimeters', 'position', [10 5 7 6]);

%%%%fft%%%
nfft=2^nextpow2(l);
Y=fft(X,nfft);
Y_fft=abs(Y)*2/nfft;
f_input=fs*(0:nfft/2)/nfft;
% figure(2);
% plot(f_input,Y_fft(1:nfft/2+1));
% xlim([0 5000])
% title('', 'FontName','Times New Roman','FontSize',14)%%%%%%%%%%%%%%%%%%%%设置图片标题上数字的字体及大小
% xlabel('频率(Hz)','FontName','Times New Roman','FontSize',14)%%%%%%%%%%%%%设置X坐标轴上数字的字体及大小
% ylabel('振动幅值(g)','FontName','Times New Roman','FontSize',14)%%%%%%%%设置Y坐标轴上数字的字体及大小
% set(gca,'FontName','Times New Roman','FontSize',14)%%%%%%%%%%%%%%%%%%%%%%设置坐标轴上数字的字体


Rp = 0.2;                                                                
Rs = 20; 
wz=1874;wc1=30;wc2=100;
wp_low=[wz-wc1,wz+wc1];
ws_low=[wz-wc2,wz+wc2];
[n_low wn_low] = buttord(wp_low/(fs/2),ws_low/(fs/2),Rp,Rs);
[b_low a_low] = butter(n_low,wn_low);
yFilter = filter(b_low,a_low,X); 

nfftFilter=2^nextpow2(length(yFilter));
f_inputFilter=fs*(0:nfftFilter/2)/nfftFilter;
xFilter=fft(yFilter,nfftFilter);
xxFilter=abs(xFilter)*2/nfftFilter;
% s2=selfEntropy(xxFilter);
% figure(3)
% plot(f_inputFilter,xxFilter(1:nfftFilter/2+1))


yHilbert = hilbert(yFilter);
yHilbert = abs(yHilbert);
yHilbert=detrend(yHilbert,'constant');
nfftHilbert=2^nextpow2(length(yHilbert));
f_inputHilbert=fs*(0:nfftHilbert/2)/nfftHilbert;
xHilbert=fft(yHilbert,nfftHilbert);
yyHilbert=abs(xHilbert)*2/nfftHilbert;
yyHilbert=yyHilbert.^2;

figure(4)
plot(f_inputHilbert,yyHilbert(1:nfftHilbert/2+1)*9.8)

% xlim([0,20])
% title('', 'FontName','Times New Roman','FontSize',14)%%%%%%%%%%%%%%%%%%%%设置图片标题上数字的字体及大小
% xlabel('频率(Hz)','FontName','Times New Roman','FontSize',14)%%%%%%%%%%%%%设置X坐标轴上数字的字体及大小
% ylabel('振动幅值(g)','FontName','Times New Roman','FontSize',14)%%%%%%%%设置Y坐标轴上数字的字体及大小
% set(gca,'FontName','Times New Roman','FontSize',14)%%%%%%%%%%%%%%%%%%%%%%设置坐标轴上数字的字体及大小
% %%%%%%%%%%%%%%%%%%这个需要注意，修改Data cursor数字及其字体大小，也就是标注：：：：：使用方法：现在图片上标出，然后在command命令中输入该指令
% set(findall(gcf,'ViewStyle','datatip'),'FontName','Times New Roman','fontsize',14)

xlim([0 80])
% ylim([0 0.1])
% title('', 'FontName','Times New Roman','FontSize',14)%%%%%%%%%%%%%%%%%%%%设置图片标题上数字的字体及大小
xlabel('Frequency(Hz)','FontName','Times New Roman','FontSize',10)%%%%%%%%%%%%%设置X坐标轴上数字的字体及大小
ylabel('Amplitude(g)','FontName','Times New Roman','FontSize',10)%%%%%%%%设置Y坐标轴上数字的字体及大小
% set(gca,'FontName','Times New Roman','FontSize',14)%%%%%%%%%%%%%%%%%%%%%%设置坐标轴上数字的字体
set(gca,'FontWeight','bold'); %字符粗细，normal为不加粗，bold加粗
set(gcf, 'unit', 'centimeters', 'position', [10 5 7 6]);

