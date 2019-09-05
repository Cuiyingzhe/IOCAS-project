error=zeros(1,12);
for k=1:12
    A=importdata(['woa_' num2str(k) '.csv']);
    data0=data_blur(:,:,1,k,1);
    %load(['CTD_Z0_' num2str(k) '_T.mat'])
    [a,b]=size(A.textdata(3:end,:));
    data1=reshape(str2num(char(A.textdata(3:end,:))),[a,b]);
    data1(data1(:,1)<-10|data1(:,1)>40|data1(:,2)<115|data1(:,2)>180,:)=[];
    lat=data1(:,1);lon=data1(:,2);
    delta=zeros(401,521);
    [a,b]=size(data1);
    for i=1:a
        x=(lon(i)-115)/0.125+1;y=((lat(i))+10)/0.125+1;
        
        delta(y,x)=data1(i,3)-data0(y,x);
    end
    error(k)=sum(abs(delta(:)))/a;
end