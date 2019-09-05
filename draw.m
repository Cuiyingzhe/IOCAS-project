%load data_blur
monthname={'Jan','Feb','Mar','Apr','May','June','July','Aug','Sept','Oct','Nov','Dec'};
z0=[0:5:100,125:25:500,550:50:2000];
Lon=115:0.125:180;Lat=-10:0.125:40;
[Lon,Lat]=meshgrid(Lon,Lat);
%for z=1:67
for i=7:12
%i=8;
subplot(2,3,i-6)
%name=['CTD_z' num2str(z0(z)) '_' num2str(i) '_T'];
%load(name)
%m(i)=mean(data0(:));
m_proj('Miller','longitudes',[115 180],'latitudes',[-10 40],1)
%m_coast;%画出海岸线
[cs,h]=m_contour(Lon,Lat,power(:,:,i));
clabel(cs,h,'fontsize',8,'Color','black','FontWeight','bold');%标注轮廓，字体，字体大小，颜色
%m(i)=mean(mean(data_blur(:,:,1,i,1)))
xlabel([monthname{i} ' Power'],'fontsize',30,'interpreter','latex')
colormap('jet');
shading flat
%m_coast();
m_coast('patch',[1 1 1],'edgecolor','k');
m_grid('box','fancy','YaxisLocation', 'left','linewidth',2,'fontsize',16,'fontname','TImes New Roman');
colorbar('Location','southoutside','fontsize',16,'fontname','TImes New Roman')
caxis([0 500])

pause(0.5)
end