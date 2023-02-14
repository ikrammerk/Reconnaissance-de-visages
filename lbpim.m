function lb= lbpim(img, R,N,mapping, mode)
if(mapping == 0)
    map=0;
else
    map =getmapping(N,mapping);
end
lb =lbp(img,R,N,map,mode);
plot(lb);
end