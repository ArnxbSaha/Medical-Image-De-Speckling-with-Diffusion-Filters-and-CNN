 
% Implementation of SRAD Filter
% Ref :Yongjian Yu and Scott T. Acton, "Speckle Reducing Anisotropic
% Diffusion",IEEE TRANSACTIONS ON IMAGE PROCESSING, VOL. 11, NO. 11, NOVEMBER2002% Jeny Rajan, Chandrashekar P.S% usage S=srad(I,T)
% I- noisy image
% T - threshold (greater than 0).

function S=srad2(I,T)
tic
[x y]=size(I);
I=double(I);
Ic=double(I);
delta_t = 0.08;
t=1;eps=0.00000000001;
for t=1:T
    qt=exp(-t*.2);
    [Ix,Iy] = gradient(Ic);
    di=sqrt(Ix.^2+Iy.^2);di2=del2(Ic);
    T1=0.5*((di./(Ic+eps)).^2);
    T2=0.0625*((di2./(Ic+eps)).^2);
    T3=(1+(0.25*(di2./(Ic+eps)))).^2;
    T=sqrt((T1-T2)./(T3+eps));
    dd=(T.^2-qt.^2)./((qt.^2*(1+qt.^2)+eps));
    cq=1./(1+dd);[D1,D2]=gradient(cq.*Ix);
    [D3,D4]=gradient(cq.*Iy);D=D1+D4;
    Ic=real(Ic+delta_t .*D);
end
toc
S=uint8(Ic);

%Frost filter for speckle noise reduction%Author : Jeny Rajanfunction [ft]=frost(I)% I is the noisy input imagetic[x y z]=size(I);I=double(I);K=1;N=I;for i=1:xfor j=1:yif (i>1 & i<x & j>1 & j<y)mat(1)=I(i-1,j);mat(2)=I(i+1,j);mat(3)=I(i,j-1);mat(4)=I(i,j+1);d(1)=sqrt((i-(i-1))^2);d(2)=sqrt((i-(i+1))^2);d(3)=sqrt((j-(j-1))^2);d(4)=sqrt((j-(j+1))^2);mn=mean(mean(mat));