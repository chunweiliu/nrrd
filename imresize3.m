function newim = imresize3(im,newsize)
[r,c,d] = size(im);

if size(newsize) == 1
    nr = ceil(r*newsize);
    nc = ceil(c*newsize);
    nd = ceil(d*newsize);
else
    nr = newsize(1);
    nc = newsize(2);
    nd = newsize(3);
end

temp = imresize(im,[nr,nc]);

newim = zeros(nr,nc,nd);
for i = 1:nr    
    newim(i,:,:) = imresize(squeeze(temp(i,:,:)),[nc,nd]);
end