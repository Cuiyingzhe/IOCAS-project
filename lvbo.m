z0=[0:5:100,125:25:500,550:50:2000];
[Lon,Lat]=meshgrid(115:0.125:180,-10:0.125:40);
data=zeros(401,521,67,12,2);
data_blur=zeros(401,521,67,12,2);
for k=1:12
    tic
    for i=1:67
        filename=['CTD_z' num2str(z0(i)) '_' num2str(k) '_T.mat'];
        load(filename)
        %data(:,:,i,k,1)=data0;
        %data=gpuArray(data);
        H = fspecial('motion',65.4019,485.9608);
        MotionBlur = imfilter(data0,H,'replicate');
        data_blur(:,:,i,k,1)=MotionBlur;
        filename=['CTD_z' num2str(z0(i)) '_' num2str(k) '_S.mat'];
        load(filename)
        data(:,:,i,k,2)=data0;
        H = fspecial('motion',65.4019,485.9608);
        MotionBlur = imfilter(data0,H,'replicate');
        data_blur(:,:,i,k,2)=MotionBlur;
    end
    toc
end
%plot(error)
%error=error_woa(data_blur);
