function [ res ] = PS06impulseResponseManuel(Sigma,A,C,dimension,periods)
%UNTITLED Summary of this function goes here
% Compute forecast error response functions
Phi=zeros(dimension,dimension,periods);
Phi(:,:,1)=eye(dimension);
for ii=1:periods-1
    for jj=1:ii
        if jj<=dimension
            Phi(:,:,ii+1)=Phi(:,:,ii+1)+Phi(:,:,ii-jj+1)*A(:,(jj-1)*dimension+1:jj*dimension);
        end        
    end
end
% Compute structural impulse response functions
for ii=1:periods
    Phi(:,:,ii)=Phi(:,:,ii)*C;
end
fac=Phi(1,1,1);
Phi=Phi./(-1*fac);
res.Phi = Phi;

end

