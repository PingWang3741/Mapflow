function [e,f]=DCinit(b,n,p,v)
Z = b; 
angle=inv(Z(1:(n-1),1:(n-1)))*p(1:(n-1))'; %One minor mistake
angle=-[angle; 0];
e=v.*cos(angle');
f=v.*sin(angle');