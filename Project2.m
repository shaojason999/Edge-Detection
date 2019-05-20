ori_I=imread('airplane.jpg');
%ori_I=imread('spider.png');

figure(1);
% sobel mask
gx=[-1,-2,-1;0,0,0;1,2,1;];
gy=[-1,0,1;-2,0,2;-1,0,1;];

% choose the image source here
subplot(3,3,1);
imshow(ori_I);
title('origin');

S=size(ori_I);
X=S(1);
Y=S(2);

% RGB to gray image
I=rgb2gray(ori_I);
subplot(3,3,2);
imshow(I);
title('gray');

% histogram equalization
%{
% �έp����ϥ�(�ӼơB���v�B�֭p)
num=zeros(256,1);
prob=zeros(256,1);
cdf=zeros(256,1);

% �U�Ƕ��έp(�����)
for i=1:X
    for j=1:Y
        num(I(i,j)+1)=num(I(i,j)+1)+1;
    end
end
% �ন���v
for i=1:256
    prob(i)=num(i)/(X*Y);
end
% �֥[�Bnormalization to 255
cdf(1)=prob(1)*(256-1);
for i=1:255
    cdf(i+1)=cdf(i)+prob(i+1)*255;
end
% round
for i=1:255
    cdf(i)=round(cdf(i));
end
cdf=uint8(cdf);
% mapping
for i=1:X
    for j=1:Y
        I(i,j)=cdf(I(i,j)+1)-1;
    end
end
subplot(3,3,3);
imshow(I);
title('histogram equalization');
%}
   
I=double(I);    % �নdouble�A�B��~��T(���ӬOunsign int) 
% Guassian Blur
Sigma=5;
tempI=I;
Gau_blur=zeros(3,3);
% Caculate the Gau_blur matrix
for i=1:3
    for j=1:3
        Gau_blur(i,j)=exp(-((i-1)^2+(j-1)^2)/(2*Sigma^2))/(2*pi*Sigma^2);
    end
end
Gau_bur=Gau_blur./sum(sum(Gau_blur)); % normalization to 1
% bluring here
for i=2:X-1
    for j=2:Y-1
        block=[I(i-1,j-1),I(i-1,j),I(i-1,j+1);I(i,j-1),I(i,j),I(i,j+1);I(i+1,j-1),I(i+1,j),I(i+1,j+1)];
        tempI(i,j)=sum(sum(Gau_bur.*block)); % �ۭ��ۥ[(�䤤�@�Ӱ��C�ۥ[�A�@�Ӱ���ۥ[)
    end
end
I=tempI;
I=uint8(I);

subplot(3,3,4);
imshow(I);
title('Guassian Blur');

% ���M�ϧ���ܬO��uint�A���O�p����٬O�n��double�~��T�A��matlab�w�]�N�Odouble
newI=zeros(X,Y);
newIx=zeros(X,Y);    % for horizontal edge
newIy=zeros(X,Y);    % for vertical edge
newIT=zeros(X,Y);    % used threshold on newI
I=double(I);

% Sobel
for i=2:X-1
    for j=2:Y-1
        block=[I(i-1,j-1),I(i-1,j),I(i-1,j+1);I(i,j-1),I(i,j),I(i,j+1);I(i+1,j-1),I(i+1,j),I(i+1,j+1)];
        newIx(i,j)=sum(sum(gx.*block)); % �ۭ��ۥ[(�䤤�@�Ӱ��C�ۥ[�A�@�Ӱ���ۥ[)
        newIy(i,j)=sum(sum(gy.*block));
    end
end

%newI=(newIx.^2+newIy.^2).^0.5;  % ����ۥ[�}�ڸ��ĪG�񵴹�Ȭۥ[�n�A�B�����
newI=abs(newIx)+abs(newIy); % �p�G�ε���Ȭۥ[�ĪG���t

newIx=uint8(newIx); % ��^0-255���d��
newIy=uint8(newIy);
newI=uint8(newI);

subplot(3,3,5);
imshow(newIx);
title('herizontal edge');
subplot(3,3,6);
imshow(newIy);
title('vertical edge');
subplot(3,3,7);
imshow(newI);
title('gradient magnitude');

% threshold
TL=130; % threshold_low
TH=150; % threshold_high
for i=2:X-1
    for j=2:Y-1
        if(newI(i,j)<=TL)
            newIT(i,j)=0;
        elseif(newI(i,j)>=TH)
            newIT(i,j)=255;
        elseif(newI(i-1,j-1)>=TH || I(i-1,j)>=TH || I(i-1,j+1)>=TH || I(i,j-1)>=TH || I(i,j+1)>=TH || I(i+1,j-1)>=TH || I(i+1,j)>=TH || I(i+1,j+1)>=TH)
            newIT(i,j)=255;
        end
    end
end

subplot(3,3,8);
imshow(newIT);
title('gradient with thresholds');

    
    
    
            