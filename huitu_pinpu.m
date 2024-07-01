clear
clc
clf

YY=load('S2_800_40_1.mat');
X=YY.n_Point1__Z.y_values.values(10240*10:10240*20);
x=X(10240*6.2+1:10240*7.2);
% x=dr(1:10000);
Fs = 10240;               %采样频率，即1s采多少个点
t = (0:1/Fs:1-Fs)';  %1000个采样点
L = length(x);
y = fft(x);
f = (0:L-1)*Fs/L;
y = y/L;
fshift = (-L/2:L/2-1)*Fs/L;
yshift = fftshift(y);
P2 = abs(fft(x)/L);
P1 = P2(1:L/2);
P1(2:end-1) = 2*P1(2:end-1);
fnew = (0:(L/2-1))*Fs/L;


figure(1)
plot(fnew,P1)
% xlabel('频率/s')
% ylabel('频域幅值/A')
xlim([0 5000])
% ylim([0 0.1])
% title('', 'FontName','Times New Roman','FontSize',14)%%%%%%%%%%%%%%%%%%%%设置图片标题上数字的字体及大小
xlabel('Frequency(Hz)','FontName','Times New Roman','FontSize',10)%%%%%%%%%%%%%设置X坐标轴上数字的字体及大小
ylabel('Amplitude(g)','FontName','Times New Roman','FontSize',10)%%%%%%%%设置Y坐标轴上数字的字体及大小
% set(gca,'FontName','Times New Roman','FontSize',14)%%%%%%%%%%%%%%%%%%%%%%设置坐标轴上数字的字体
set(gca,'FontWeight','bold'); %字符粗细，normal为不加粗，bold加粗
set(gcf, 'unit', 'centimeters', 'position', [10 5 7 6]);

