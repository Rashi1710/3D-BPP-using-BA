% evaluate the solution
function [anb, bins]=evaluate(beePos,bin,boxes,mindim, minvol)
n=length(beePos)/2;
persistent x;
if isempty(x)
        x = 0;
    end
% orientation sequence
vbo = zeros(1,n);
for i = 1:n
    brk(i).randomkey=beePos(i);
    brk(i).orientation=beePos(i+n);
    vbo(i)=beePos(i+n);
end
% box packing sequence
bpssort=zeros(n,2);
for i=1:n
    bpssort(i,1)=beePos(i);
    bpssort(i,2)=i;
end
bpssort=sortrows(bpssort,1);
bps=bpssort(:,2);
bps=reshape(bps,1,n);

% place the boxes into bines
bins = placement(bps,vbo,bin,boxes,mindim,minvol);

% calculate the fitness
anb=calfitness(bins);

x = x+1;
end