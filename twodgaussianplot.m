
clc; clear all;
rng('default') % For reproducibility

N = -2:1:2; P = -2:1:2;
[X,Y] = meshgrid(N,P);
Z = peaks(X,Y);
figure(1)
peaks(X,Y);

X_obs = reshape(X,[],1);
Y_obs = reshape(Y,[],1);
Xtrain = [X_obs Y_obs];

Z_obs = reshape(Z,[],1);

gprMdl1 = fitrgp(Xtrain,Z_obs,'KernelFunction','squaredexponential');

% hold on; patch([X_obs;flipud(X_obs)],[Zobs;flipud(Zobs)],'k','FaceAlpha',0.1);
NN = -2:.1:2; PN = -2:.1:2;
[XN,YN] = meshgrid(NN,PN);
XN_obs = reshape(XN,[],1);
YN_obs = reshape(YN,[],1);
XPredic = [XN_obs YN_obs];
% figure(2)
% peaks(XN,YN)
[zpred1,~,zint1] = predict(gprMdl1,XPredic);
zpred1 = reshape(zpred1,[size(NN,2),size(PN,2)]);
zint1_c1 = zint1(:,1);
zint1_c1 = reshape(zint1_c1,[size(NN,2),size(PN,2)]);
zint1_c2 = zint1(:,2);
zint1_c2 = reshape(zint1_c2,[size(NN,2),size(PN,2)]);

figure(2)
surf(XN,YN,zpred1)
title('Predicted Plot from trained data')
xlabel('XN')
ylabel('YN')
zlabel('Z predicted')

figure(3)
surf(XN,YN,zpred1)
title('Predicted Plot from trained data with uncertainity')
xlabel('XN')
ylabel('YN')
zlabel('Z predicted')
hold on
mesh(XN,YN,zint1_c1 )
mesh(XN,YN,zint1_c2 )

%Plot Sections
figure(4)
%X=2, new "y" on x-axis , pred "z" on y-axis 
plot(PN,zpred1(41,:))
hold on
plot(PN,zint1_c1(41,:))
plot(PN,zint1_c2(41,:))
title(' "YN" at XN =2  ')
legend('upperbound','predicted','lowerbound')
xlabel('YN')
ylabel('Z predicted')
grid on

figure(5)
%X=-2, new "y" on x-axis , pred "z" on y-axis 
plot(PN,zpred1(1,:))
hold on
plot(PN,zint1_c1(1,:))
plot(PN,zint1_c2(1,:))
title(' "YN" at XN =-2 ')
legend('upperbound','predicted','lowerbound')
xlabel('YN')
ylabel('Z predicted')
grid on

figure(6)
%Y=2, new "x" on x-axis , pred "z" on y-axis 
plot(NN,zpred1(:,41))
hold on
plot(NN,zint1_c1(:,41))
plot(NN,zint1_c2(:,41))
title(' "XN" At YN =2 ')
legend('upperbound','predicted','lowerbound')
xlabel(' "XN"')
ylabel('Z predicted')
grid on

figure(7)
% Y =-2, new "XN" , pred "z" on y-axis 
plot(NN,zpred1(:,1))
hold on
plot(NN,zint1_c1(:,1))
plot(NN,zint1_c2(:,1))
title(' "XN" At YN =-2 ')
legend('upperbound','predicted','lowerbound')
xlabel(' XN')
ylabel('Z predicted')
grid on









