function imout = convolvepoints(x,y,np,psf_tmp,pixelsize)
% imout = convolvepoints(x,y,np,psf_tmp,pixelsize)
% psf should be odd with the maximum in the central pixel...


minx = min(x);
maxx = max(x);
miny = min(y);
maxy = max(y);
sp = size(psf_tmp);
psf_tmp2 = double(psf_tmp/sum(psf_tmp(:))); %normalize to 1
sizeim_tmp = [ceil((maxx-minx)/pixelsize), ceil((maxy-miny)/pixelsize)];
sizeim = sizeim_tmp + ~mod(sizeim_tmp,2); %to make it odd

centerim = [maxx-minx, maxy-miny]/2;
psf_tmp3 = padimage(psf_tmp2,fliplr(sizeim)+2*sp);
xr=x-minx;
yr=y-miny;

psf = dip_image(psf_tmp3);
imout_tmp = newim(psf);
for ii=1:length(np)
    imout_tmp = imout_tmp + np(ii)*shift(psf, [xr(ii)-centerim(1), yr(ii)-centerim(2)]);
end
imout = imout_tmp(sp:end-sp,sp:end-sp);