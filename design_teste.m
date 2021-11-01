% design_teste
clear all

Origin=pwd;
cd(Origin)

Im=imread('Rotation_masked_000250_raw.tif');
info = imfinfo('Rotation_masked_000250_raw.tif'); 
bits= info.BitsPerSample;

s=2;
sigma=1; 
nG=11;
nW=11;
p=0.5;

[Mask,M]=OGW_mask(Im,bits,s,sigma,nG,nW,p);

subplot (2,2,1)
imshow(Im, [0 250])
title('Raw')

subplot (2,2,2)
imshow(Mask, [0 1])
title('Mask - uint8')

subplot (2,2,3)
imshow(M, [0 1])
title('M - double')

subplot (2,2,4)
Im(M==0)=0;
imshow(Im, [0 250])
title('Masked Im')



