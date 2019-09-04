%load A_1.mat%读取数据文件（矩阵共8列，依次代表经度、纬度、年、月、日、深度、温度、盐度;共4316234个数据点）
z0=[0:5:100,125:25:500,550:50:2000];%设定WOA标准层
for z=z0%所有深度
    for k=1:12%12个月份
        %******************************************数据预处理**********************************************
        data0=zeros(401,521);%格点数据
        c=zeros(401,521);%修正值
        Lon=115:0.125:180;Lat=-10:0.125:40;[Lon,Lat]=meshgrid(Lon,Lat);%格点经纬度
        month=data(:,4);%提取月份
        %tic
        M=data(month==k,[1,2,6,7,8]);%提取第k月的数据
        loc=find(M(:,3)==z);M=M(loc,:);lon=M(:,1);lat=M(:,2);T=M(:,4);%提取当前z深度的数据
        %**************************************************************************************************
        
        %****************************************first-guess filed*****************************************
        %first-guess filed
        for i=1:401
            lat1=Lat(i,1)-0.5;lat2=Lat(i,1)+0.5;T0=T(find(lat>lat1&lat<lat2));data0(i,:)=sum(T0)/numel(T0);                                                                                                                                                                                                                                                                                                                                                                                             ;T0=T(find(lat>lat1&lat<lat2));data0(i,:)=sum(T0)/numel(T0);
        end
        %**************************************************************************************************
        
        %***********************************************correction*****************************************
        for i=1:401
            for j=1:521
                Lat1=Lat(i,j)-5;Lat2=Lat(i,j)+5;Lon1=Lon(i,j)-5;Lon2=Lon(i,j)+5;%设定搜索范围±5°
                index0=find(lat>=Lat1&lat<=Lat2&lon>=Lon1&lon<=Lon2);%提取范围内的索引
                T0=T(index0);lon0=lon(index0);lat0=lat(index0);%提取索引对应的数据
                d=(((lon0-Lon(i,j)).*cos(lon0/180*pi)).^2+(lat0-Lat(i,j)).^2)*12321;%r^2
                index1=find(d<=100000);%提取影响半径内的索引
                if ~isempty(index1)
                    T1=T0(index1);lon1=lon0(index1);lat1=lat0(index1);d1=d(index1);%提取影响半径内的数据
                    w=exp(-4*d1/100000);%权重
                    q=T1-data0(round((lat1+10)/0.125+1),1);%first-filed guess与数据之差
                    c(i,j)=w'*q/sum(w);%修正值
                end
            end
            
        end
        data0=data0+c;%对first-filed guess修正
        %**************************************************************************************************

        %save(['CTD_z_test' num2str(z) '_' num2str(k) '_T'],'data0')%存文件
    end
    toc
end