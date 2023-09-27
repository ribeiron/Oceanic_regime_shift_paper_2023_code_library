%%complete map
%we want to get it all the way to dalton polynya

%%mapping the data... 

%%selecting Vincennes Bay data
% East Antarctica 30E-170E
% Casey Station 90-130E / 63-67S
% Vincennes Bay 104-112E 64S

load ANT_MONTHLY_SIP_08_17.mat


 n_mask=nan(721,721);
 lat_ip=nan(721,721);
 lon_ip=nan(721,721);
 for i=1:length(n_mask);
     c=find(MEAN_ANT_SIP_2008_2016(:,i)<=-500 ...
         & AllLat(:,i)<=-63.5 ...
         & AllLon(:,i)>=83 & AllLon(:,i)<=105);
     n_mask(c,i)=MEAN_ANT_SIP_2008_2016(c,i);
     lon_ip(c,i)=AllLon(c,i);
     lat_ip(c,i)=AllLat(c,i);
 end
 

addpath 'C:\Users\nribeiro\Desktop\Seal Data\matlab_tools\TOOLBOX\m_map1.4\m_map'

%cd 'E:\Chapter 2'
load West_Shack_VB_Totten_complete.mat

%determina um meshgrid de lat/lon para o bedmap fornecer os dados depois
lat_gps = linspace(-71,55,400);
lon_gps = linspace(40,160,400);

%pega os dados de matimetria do bedmap para um determiando range de lat/lon
[lat,lon,bed] = bedmap2_data('bed',lat_gps,lon_gps); 

%|Z = bedmap2_data(var)| returns Bedmap2 data of type |var| at full 1 km resolution. |var| options are: 
% * |'icemask'|         0 = grounded, 1 = ice shelf, 127 = ocean

figure('position',[100 100 900 400])
bedmap2 ('bed',caxis,[-3500 0])
bedmap2 'patchshelves'
bedmap2 'patchgl'
bedmap2 'patchshelves'
outlineashelf('shackleton','linewidth',3) 
outlineashelf('vincennes','linewidth',3) 
outlineashelf('west','linewidth',3) 


scarlabel('Shackleton Ice Shelf','fontangle','italic',...
    'color','b','fontweight','bold')

saveas(gcf,'ShackletonIceShelf_inset_map.tiff');
saveas(gcf,'ShackletonIceShelf_inset_map.png');
print -depsc2 ShackletonIceShelf_inset_map.eps


%determina um meshgrid de lat/lon para o bedmap fornecer os dados depois
lat_gps = linspace(-71,55,400);
lon_gps = linspace(40,160,400);


%pega os dados de matimetria do bedmap para um determiando range de lat/lon
[lat,lon,bed] = bedmap2_data('bed',lat_gps,lon_gps); 


%getting colormap winter
%run the figure with winter and then when happy use cmap and save the map
cmap=colormap

%modificando o colormap pra ficar numa cor aceitavel nas ice shelves,
%adicionar cinza claro no fim do mapa
mymap = [0         0    1.0000
         0    0.0159    0.9921
         0    0.0317    0.9841
         0    0.0476    0.9762
         0    0.0635    0.9683
         0    0.0794    0.9603
         0    0.0952    0.9524
         0    0.1111    0.9444
         0    0.1270    0.9365
         0    0.1429    0.9286
         0    0.1587    0.9206
         0    0.1746    0.9127
         0    0.1905    0.9048
         0    0.2063    0.8968
         0    0.2222    0.8889
         0    0.2381    0.8810
         0    0.2540    0.8730
         0    0.2698    0.8651
         0    0.2857    0.8571
         0    0.3016    0.8492
         0    0.3175    0.8413
         0    0.3333    0.8333
         0    0.3492    0.8254
         0    0.3651    0.8175
         0    0.3810    0.8095
         0    0.3968    0.8016
         0    0.4127    0.7937
         0    0.4286    0.7857
         0    0.4444    0.7778
         0    0.4603    0.7698
         0    0.4762    0.7619
         0    0.4921    0.7540
         0    0.5079    0.7460
         0    0.5238    0.7381
         0    0.5397    0.7302
         0    0.5556    0.7222
         0    0.5714    0.7143
         0    0.5873    0.7063
         0    0.6032    0.6984
         0    0.6190    0.6905
         0    0.6349    0.6825
         0    0.6508    0.6746
         0    0.6667    0.6667
         0    0.6825    0.6587
         0    0.6984    0.6508
         0    0.7143    0.6429
         0    0.7302    0.6349
         0    0.7460    0.6270
         0    0.7619    0.6190
         0    0.7778    0.6111
         0    0.7937    0.6032
         0    0.8095    0.5952
         0    0.8254    0.5873
         0    0.8413    0.5794
         0    0.8571    0.5714
         0    0.8730    0.5635
         0    0.8889    0.5556
         0    0.9048    0.5476
         0    0.9206    0.5397
         0    0.9365    0.5317
         0    0.9524    0.5238
         0    0.9683    0.5159
         0    0.9841    0.5079
         0    1.0000    0.5000
       .85       .85       .85];

%ice mask
[lat,lon,icemask] = bedmap2_data('icemask',lat_gps,lon_gps); 
[i,j]=find(icemask==1);
id_sh=find(icemask==1);

%creating the ice mask a partir do bedmap data para usar com contourf.
a=size(icemask);
n=nan(a(1),a(2));
n(id_sh)=1000;

lat_sh=lat(id_sh);
lon_sh=lon(id_sh);
   

fig=figure;
fig.Position = [5 5 1000 700]; 
m_proj('mercator','lon',[90 102],'lat',[-67 -63.5]);
h = m_pcolor(lon, lat, bed); 
    set(h, 'EdgeColor', 'none'); hold on;
    colormap('gray')
    caxis([-3000 0]);
ax = gca;
ax.FontSize = 16; 


%[c,hContour]=m_contourf(lon,lat,bed);
[M, c] = m_contour(lon, lat, bed,[-400,-500,-600,-700,-800,-1000,-1500, -2000, -2500, -3000]);
hold on;
%c.LineColor = [1, 1, 1];
c.LineColor = [0, 0, 0];

clabel(M,c,[-500, -700, -1000],'FontSize',11,'LabelSpacing',5000);
cl=colorbar
ylabel(cl, 'Depth (m)')
ax = gca;
ax.FontSize = 22; 
hold on;
m_gshhs_h('patch',[.5 .5 .5]); %usando o pacote de alta resolucao
hold on;
[c,hContour]=m_contourf(lon,lat,n,[1,1]) 
[c,hContour]=m_contour(lon,lat,icemask,[1,1],'LineColor'...
    ,'k','LineWidth',1)
hold on;
caxis([-3000 0])
m_grid('linewi',2,'tickdir','out','linestyle','none' );

saveas(gcf,'Shack_final_map_a.tiff');
saveas(gcf,'Shack_final_map1_a.png');
print -depsc2 Shack_final_map_a.eps


addpath 'C:\Users\nribeiro\Desktop\Seal Data\matlab_tools'
addpath 'C:\Users\nribeiro\Desktop\Seal Data\matlab_tools\TOOLBOX\cmocean'   
fig=figure;
fig.Position = [5 5 1000 700]; 
m_proj('mercator','lon',[90 102],'lat',[-67 -63.5]);
[c,hContour]=m_contourf(lon_ip,lat_ip,n_mask/(-100),'LineStyle','none');
%%transparency of the contours
% This is the secret that 'keeps' the transparency.
%eventFcn = @(srcObj, e) updateTransparency(srcObj);
%addlistener(hContour, 'MarkedClean', eventFcn);

cl=colorbar
ylabel(cl, 'Sea-ice Production (m)')
cmap=cmocean('ice',7)%cmap=cmocean('thermal')
cmap=cmap
colormap(cmap(2:7,:));
ax = gca;
ax.FontSize = 29; 
hold on;
m_gshhs_h('patch',[.5 .5 .5]); %usando o pacote de alta resolucao
hold on;
%[c,hContour]=m_contourf(lon,lat,n,[1,1]) 
[c,hContour]=m_contour(lon,lat,icemask,[1,1],'LineColor'...
    ,'k','LineWidth',1)
hold on;
caxis([5 20])
m_grid('linewi',2,'tickdir','out');


saveas(gcf,'Sea-Ice_Prod_Shack_final_map1.tiff');
saveas(gcf,'Sea-Ice_Prod_Shack_final_map1.png');
print -depsc2 Sea-Ice_Prod_Shack_final_map1.eps

figure;
m_proj('mercator','lon',[83 105],'lat',[-67 -63.5]);
[c,hContour]=m_contour(lon_ip,lat_ip,n_mask/(-100),'LineStyle','none');
cl=colorbar
ylabel(cl, 'Sea-ice Production (m)')
colormap(flipud(jet))
ax = gca;
ax.FontSize = 29; 
hold on;
m_gshhs_h('patch',[.5 .5 .5]); %usando o pacote de alta resolucao
hold on;
[c,hContour]=m_contourf(lon,lat,n,[1,1]) 
[c,hContour]=m_contour(lon,lat,icemask,[1,1],'LineColor'...
    ,'k','LineWidth',1)
hold on;
caxis([5 20])
m_grid('linewi',2,'tickdir','out');

saveas(gcf,'Sea-Ice_Prod_Shack_final_map1.tiff');
saveas(gcf,'Sea-Ice_Prod_Shack_final_map1.png');
print -depsc2 Sea-Ice_Prod_Shack_final_map1.eps

  figure(2)
   clf
   h2 = subplot(1,1,1)
   hold on
   axis([83 105 -67 -63.5])
   contour(lon_ip,lat_ip,n_mask)
   colorbar

saveas(gcf,'Sea-Ice_Prod_map_contouropen.tiff');
saveas(gcf,'Sea-Ice_Prod_map_contouropen.png');
print -depsc2 Sea-Ice_Prod_map_contouropen.eps
   
   
 figure(2)
   clf
   h2 = subplot(1,1,1)
   hold on
   axis([83 105 -67 -63.5])
   [h,hCountour]=contour(xx,yy,zz2,[-500 -500])
   contour(xx,yy,zz2,[-1000 -1000])
   colorbar   
saveas(gcf,'Sea-Ice_Prod_map_contourclose.tiff');
saveas(gcf,'Sea-Ice_Prod_map_contourclose.png');
print -depsc2 Sea-Ice_Prod_map_contourclose.eps

cmap=[.8 .8 .8]
figure;
m_proj('mercator','lon',[83 105],'lat',[-67 -63.5]);
hold on;
[c,hContour]=m_contour(lon,lat,bed,'-k');
clabel(c,hContour,'FontSize',16,'LabelSpacing',5000);
m_grid('linewi',2,'tickdir','out');
colormap(cmap)
ax = gca;
ax.FontSize = 27; 
hold on;
m_gshhs_h('patch',[.5 .5 .5]); %usando o pacote de alta resolucao
hold on;
[c,hContour]=m_contourf(lon,lat,n,[1,1]) 
[c,hContour]=m_contour(lon,lat,icemask,[1,1],'LineColor'...
    ,'k','LineWidth',1)
hold on;
m_plot(lon_vcb,lat_vcb,'.r','MarkerSize',6)
m_scatter(lon_vcb(1,:),lat_vcb(1,:),8,diff_depth(1,:),'filled','markeredgecolor','k');


hold on;
caxis([-3000 0])

saveas(gcf,'Shack_final_map.tiff');
saveas(gcf,'Shack_final_map.png');
print -depsc2 Shack_final_map.eps



figure;
m_proj('mercator','lon',[104 114.5],'lat',[-67 -65]);
ax = gca;
ax.FontSize = 29; 
hold on;
m_contour(lon_ip,lat_ip,n_mask,[-500,-500],'LineColor'...
    ,'cyan','LineStyle','--','LineWidth',2)


figure;
m_proj('mercator','lon',[83 105],'lat',[-67 -63.5]);
[h,hCountour]=m_contourf(lon_ip,lat_ip,n_mask,'LineStyle','none');
hold on;
colorbar
colormap parula
ax = gca;
ax.FontSize = 27; 
hold on;
m_gshhs_h('patch',[.5 .5 .5]); %usando o pacote de alta resolucao
hold on;
[c,hContour]=m_contourf(lon,lat,n,[1,1]) 
[c,hContour]=m_contour(lon,lat,icemask,[1,1],'LineColor'...
    ,'k','LineWidth',1)
axis([-0.2 0.2 -1.6 -1.5])
hold on;
% caxis([-3000 0])
colorbar 
m_grid('linewi',2,'tickdir','out');

saveas(gcf,'Totten_final_map1.tiff');
saveas(gcf,'Totten_final_map1.png');
print -depsc2 Totten_final_map1.eps


figure;
m_proj('mercator','lon',[104 123],'lat',[-67.5 -65]);
[c,hContour]=m_contourf(lon,lat,bed);
hold on;
clabel(c,hContour,'FontSize',16,'LabelSpacing',5000);
colorbar
colormap(mymap)
ax = gca;
ax.FontSize = 28; 
hold on;
m_gshhs_h('patch',[.5 .5 .5]); %usando o pacote de alta resolucao
hold on;
[c,hContour]=m_contourf(lon,lat,n,[1,1]) 
[c,hContour]=m_contour(lon,lat,icemask,[1,1],'LineColor'...
    ,'k','LineWidth',1)
hold on;
caxis([-3000 0])
colorbar 
m_grid('linewi',2,'tickdir','out');

saveas(gcf,'INTRO_map.tiff');
saveas(gcf,'INTRO_map..png');
print -depsc2 INTRO_map..eps