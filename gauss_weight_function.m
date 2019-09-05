function [data0] = gauss_weight_function(z)
%输出为各月z深度下插值后的温盐数据
%第三维为1-12月，第四维为温度、深度
load data_hzw.mat;
%months={'Jan','Feb','Mar','Apr','May','June','July','Aug','Sept','Oct','Nov','Dec'};
data0=zeros(401,481,12,2);
%for k=1:12
    k=1;
    tic
    %name=['gauss_hzw_',months{k}];
    %year=data(:,3);day=data(:,5);z=data(:,6);
    month=data(:,4);
    Jan=data(month==k,[1,2,6,7,8]);
    loc=find(Jan(:,3)==z);
    lon=Jan(loc,1);lat=Jan(loc,2);T=Jan(loc,4);S=Jan(loc,5);
    Lon=120:0.125:180;Lat=-10:0.125:40;
    [Lon,Lat]=meshgrid(Lon,Lat);
    n=numel(Lon);
    tic
    for i=1:n
        weight=zeros(numel(T),1);
        for j=1:numel(T)
            if ~(Lon(i)==lon(j)&&Lat(i)==lat(j))
                weight(j)=exp(-(Lon(i)-lon(j)).^2/(2*0.25)-(Lat(i)-lat(j)).^2/(2*0.25));
            end
        end
        weight=weight/sum(weight);
        data0(i-(ceil(i/401)-1)*401,ceil(i/401),k,1)=sum(T.*weight);
        weight=zeros(numel(S),1);
        for j=1:numel(S)
            if ~(Lon(i)==lon(j)&&Lat(i)==lat(j))
                weight(j)=exp(-(Lon(i)-lon(j)).^2/(2*0.25)-(Lat(i)-lat(j)).^2/(2*0.25));
            end
        end
        weight=weight/sum(weight);
        data0(i-(ceil(i/401)-1)*401,ceil(i/401),k,2)=sum(S.*weight);
        if mod(i,1000)==0
            toc
        end
    end
    %save('gauss_hzw_Jan','data0')
end