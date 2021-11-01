

 function[Mask,M]=OGW_mask(Im,bits,s,sigma,nG,nW,p)

% Methodology developed by "A NOVEL METHOD BASED ON THE OTSU THRESHOLD FOR INSTANTANEOUS ELIMINATION OF LIGHT REFLECTION IN PIV IMAGES" 
% In:
%     Im - Raw image
%     bits - Image depth (8-16 bits); 
%     sigma - Blur effect caused by Gaussian filter (1 or 2 by default);
%     nG - Gauss filter neighborhood size (11 px by default);
%     nW - Wiener filter neighborhood size (11 px by default);
%     p -  Constant used for a simple thresholding in the final step (0<p<1,
%     0.5 px by default);
%     s - Otsu's weighting parameter (1 by default);
% Out:
%     Mask - Estimated mask in image format (uint8);
%     M - Estimated matrix mask with double precision.
%  
% Otsu threshold  ---------------------------------------------------------

n=2^bits;

[counts,x] = imhist(Im,n);
stem(x,counts);
T = otsuthresh(counts);
BW = imbinarize(Im,T*s);

% Removing the mask associated with particle images  ------------------

Im=double(BW);

% Gauss
Im=imgaussfilt(Im,sigma,'FilterSize',nG,'FilterDomain','spatial');
% Wiener 
Im=wiener2(Im,[nW nW]);

% thresholding by a constant  ---------------------------------------------

M=Im;

M(Im<=p)=1; M(Im>p)=0;

% Image Format -------------------------------------------------------

Mask=uint8(M);

end

