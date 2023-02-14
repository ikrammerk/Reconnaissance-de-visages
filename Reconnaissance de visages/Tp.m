
clear all;
close all;
clc;

%QST 1
I= imread('Base/1-01.jpg');
Ima_gray=rgb2gray(I);
imshow(Ima_gray);


%QST 2
figure;
R=1;
N=8;
Attributs=lbp(Ima_gray,R,N,0,'h');
plot(Attributs);


%QST 3 LBP en variant le nombre des voisinages pour mode classique, u2, ri, riu2

%classique
figure;
subplot(1,3,1);
lbp_1_8_classique = lbpim(Ima_gray,1,8,0,'h');
title('fg');
subplot(1,3,2);
lbp_2_12_classique = lbpim(Ima_gray,2,12,0,'h');
title('fxg');
subplot(1,3,3);
lbp_4_16_classique = lbpim(Ima_gray,4,16,0,'h');
title('fcg');

%mapping u2
figure;
subplot(1,3,1);
lbp_1_8_u2 = lbpim(Ima_gray,1,8,'u2','h');
subplot(1,3,2);
lbp_2_12_u2 = lbpim(Ima_gray,2,12,'u2','h');
subplot(1,3,3);
lbp_4_16_u2 = lbpim(Ima_gray,4,16,'u2','h');

%mapping ri
figure;
subplot(1,3,1);
lbp_1_8_ri  = lbpim(Ima_gray,1,8,'ri','h');
subplot(1,3,2);
lbp_2_12_ri = lbpim(Ima_gray,2,12,'ri','h');
subplot(1,3,3);
lbp_4_16_ri = lbpim(Ima_gray,4,16,'ri','h');

%mapping riu2
figure;
subplot(1,3,1);
lbp_1_8_riu2 = lbpim(Ima_gray,1,8,'riu2','h');
subplot(1,3,2);
lbp_2_12_riu2 = lbpim(Ima_gray,2,12,'riu2','h');
subplot(1,3,3);
lbp_4_16_riu2  = lbpim(Ima_gray,4,16,'riu2','h');




