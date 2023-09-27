clear all
%TriagemVB, plot geral
addpath 'C:\Users\nribeiro\Desktop\Seal Data\matlab_tools\TOOLBOX\seawater'

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

%%getting the 
load West_Shack_VB_Totten_complete.mat

%Shack Only
ie=find(lat_vcb(1,:) < -63 & lon_vcb(1,:) < 105 & lon_vcb(1,:) > 90);


%create a different sec matrix if you still find repeated date
% B=repmat(1:59,[1 100]); 
% sec17=B(1,1:length(ie));

yr17=yr_vcb(1,ie);
mth17=mth_vcb(1,ie);
day17=day_vcb(1,ie);
hr17=hr_vcb(1,ie);
mi17=mi_vcb(1,ie);
sec17=sec_vcb(1,ie);
sn=seal_vcb(1,ie);

date17=[yr17' mth17' day17' hr17' mi17' sec17'];
date17=datenum(date17)

SA_17=sal_adj_vcb(:,ie);
ND_17=ND_vcb(:,ie);
temp_pot_vcb=temp_pot_vcb(:,ie);
temp_adj_vcb=temp_adj_vcb(:,ie);
PR_17=pres_adj_vcb(:,ie);
lat_17=lat_vcb(:,ie);
lon_17=lon_vcb(:,ie);

%tem que refazer isso
s=size(temp_pot_vcb);

max_id=[];
bt_depth=[];
bt_depth2=[];
t=temp_pot_vcb;
for i=1:s(2);
    a=isnan(t(:,i));
    ii=find(a==0); %achar o ponto maximo que seja numerico.
    if isempty(ii)==0
    MA1=nanmax(ii);
    max_id=[max_id,PR_17(MA1,i)];
    bt_depth=[bt_depth,temp_pot_vcb(MA1,i)];
    bt_depth2=[bt_depth2,temp_adj_vcb(MA1,i)];
    else
    max_id=[max_id,nan];    
    bt_depth=[bt_depth,nan];
    bt_depth2=[bt_depth2,nan];
    clear MA1 a i
    end
end

 depth_seal=sw_dpth(max_id,lat_17);  
 pressure=max_id;
 bt_pot_temp=bt_depth;
 bt_temp=bt_depth2;
 latitude=lat_17;
 longitude=lon_17;

d_bedmap=[];
for i=1:length(lat_17);
    ii=find(lon>=(lon_17(i)-0.00005) & lon<=(lon_17(i)+0.00005));
    if isempty(ii)==0;
        a=lat(ii);
        nn=lat_17(i);
        [val,idx]=min(abs(a-nn));
        minVal=a(idx);
        final_id=ii(idx);
        depth=bed(final_id);
        d_bedmap=[d_bedmap depth];
    else
        kk=find(lon>=(lon_17(i)-0.0005) & lon<=(lon_17(i)+0.0005));
        if isempty(kk)==0;
            a=lat(kk);
            nn=lat_17(i);
            [val,idx]=min(abs(a-nn));
            minVal=a(idx);
            final_id=kk(idx);
            depth=bed(final_id);
            d_bedmap=[d_bedmap depth];
        else
            kk=find(lon>=(lon_17(i)-0.005) & lon<=(lon_17(i)+0.005));
            a=lat(kk);
            nn=lat_17(i);
            [val,idx]=min(abs(a-nn));
            minVal=a(idx);
            final_id=kk(idx);
            depth=bed(final_id);
            d_bedmap=[d_bedmap depth];
        end
    end
end

d_bed=d_bedmap;

d_bed=d_bed*(-1);
ii=find(d_bed<0);
d_bed(ii)=0;
% diff_depth=d_bed-max_id;
diff_depth=d_bed-depth_seal;

 depth_bedmap=d_bed;
 depth_seal=sw_dpth(max_id,lat_17);  
 max_pres=max_id;
 bt_pot_temp=bt_depth;
 bt_temp=bt_depth2;
 latitude=lat_17;
 longitude=lon_17;
 
save seal_denman_esmee depth_bedmap depth_seal diff_depth max_pres bt_pot_temp bt_temp latitude longitude
save extra_month_year yr17 mth17

cmap=[.8 .8 .8]
figure;
%m_proj('mercator','lon',[90 105],'lat',[-67.5 -63]);
m_proj('mercator','lon',[90 97],'lat',[-67.5 -63]);
[c,hContour]=m_contour(lon,lat,bed,[-200,-500,-800,-1000,-1500,-2000,-2500,-3000],'-k');
clabel(c,hContour,[-200,-500,-800,-1000,-1500,-2000,-2500,-3000])
hold on;
ax = gca;
ax.FontSize = 22; 
%[c,hContour]=m_contour(lon,lat,bed,'-k');
m_gshhs_h('patch',[.5 .5 .5]); %usando o pacote de alta resolucao 
hold on;
%[c,hContour]=m_contourf(lon,lat,n,[1,1]); 
m_contour(lon,lat,n,[1,1]);
hold on;
m_grid('linewi',2,'tickdir','out');
hold on;

ff=find(diff_depth>-200);
ig=m_scatter(lon_17(1,ff),lat_17(1,ff),20,'filled');
set(ig,'markerfacecolor',[.75 .75 .75]);
% ie.MarkerFaceAlpha=.2;
hold on;
f=find(diff_depth<=-200);
ie=m_scatter(lon_17(1,f),lat_17(1,f),60,diff_depth(1,f),'filled');
ie.MarkerFaceAlpha=.5;
hold on;
[c,hContour]=m_contour(lon,lat,icemask,[1,1],'LineColor'...
    ,'k','LineWidth',1);
m_gshhs_h('Color','k');
%esme's float
llg=[93.932,93.789,93.983,94.419,94.549,94.25,94.273,94.157,94.09,...
    94.087,94.064,94.044,94.042,94.03];
llt=[-65.102,-65.233,-65.228,-65.276,-65.379,-65.729,-65.781,-66,...
    -66.014,-66.013,-66.013,-66.021,-66.025,-66.027];

m_plot(llg,llt,'p','color','r','markerfacecolor','r','markersize',10)

cl=colorbar;
ylabel(cl, 'Depth (m)')
caxis([-800 -200])


saveas(gcf,'Shack_complete_final_mapb.tiff');
saveas(gcf,'Shack_complete_final_mapb.png');
print -depsc2 Shack_complete_final_mapb.eps

saveas(gcf,'Shack_90-105_bathydiff.tiff');
saveas(gcf,'Shack_90-105_bathydiff.png');
print -depsc2 Shack_90-105_bathydiff.eps

saveas(gcf,'floatposition.png');
saveas(gcf,'bathymetry.png');

