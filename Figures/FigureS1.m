%%%% doing a depth calculation test:

clear all 
cd 'C:\Users\nribeiro\Desktop\Chapter 2'
load West_Shack_VB_Totten_triado_coast.mat
%load ShackCTD_data_coast.mat
load ShackCTD_data_coast_no_interp.mat
hold on;

ie=find(lon_vcb(1,:) > 90 & lon_vcb(1,:) <= 96.5);
ie=find(lat_vcb>=-66 & lat_vcb<=-65 & lon_vcb>=94 & lon_vcb<=96);

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

%%ctd
%have to use only waterdepth ones because the other extra ones were
%interpolated
x2=x(1,1:171);
y2=y(1,1:171);
PT2=PT(:,1:171)

ie=find(x2(1,:) > 90 & x2(1,:) <= 96.5);
ie=find(y2>=-66 & y2<=-65 & x2>=94 & x2<=96);

PT2=PT2(:,ie)
waterdepth2=waterdepth(:,ie)


s=size(PT2);

bt_depthc=[];
t=PT2;
for i=1:s(2);
    a=isnan(t(:,i));
    ii=find(a==0); %achar o ponto maximo que seja numerico.
    if isempty(ii)==0
    MA1=nanmax(ii);
    bt_depthc=[bt_depthc,PT2(MA1,i)];
    else
    bt_depthc=[bt_depthc,nan];
    clear MA1 a i
    end
end

%%seals
%1026 on the west of the Shackleton Ice Shelf
bt_temp_seal_avg=nanmean(bt_depth)
bt_temp_seal_std=nanstd(bt_depth)
bt_temp_seal_max=nanmax(bt_depth)

bt_depth_seal_avg=nanmean(max_id)
bt_depth_seal_std=nanstd(max_id)


%%ctd
bt_temp_ctd_avg=nanmean(bt_depthc)
bt_temp_ctd_std=nanstd(bt_depthc)
bt_temp_ctd_max=nanmax(bt_depthc)

bt_depth_ctd_avg=nanmean(waterdepth2)
bt_depth_ctd_std=nanstd(waterdepth2)

%%%%%%%%%%%%%%%%%%%%
%scatter plots de cada mes mostrando maximum T&S e minimum T&S
% for both CTD and seal data
clear all
addpath 'C:\Users\nribeiro\Desktop\Seal Data\matlab_tools\TOOLBOX\cmocean'                    
addpath 'C:\Users\nribeiro\Desktop\Seal Data\matlab_tools\TOOLBOX\tight_subplot'
addpath 'C:\Users\nribeiro\Desktop\Seal Data\matlab_tools\TOOLBOX\suplabel'

%first comes variales for the map
addpath 'C:\Users\nribeiro\Desktop\Seal Data\matlab_tools\TOOLBOX\m_map1.4\m_map'
addpath 'C:\Users\nribeiro\Desktop\Seal Data\matlab_tools\TOOLBOX\cbdate\cbdate'

cd 'C:\Users\nribeiro\Desktop\Chapter 2'

%load massa_dagua_index_shack+west index
load West_Shack_VB_Totten_triado_coast.mat
load  massa_dagua_index_coast_d
%%% plot water mass CDW scatter
%1 dsw
%2 isw
%3 mcdw
%4 cdw
%5 ww
%6 not classified
    
%Vincennes Bay only
ie=find(lat_vcb(1,:) < -63.5 & lon_vcb(1,:) > 90 & lon_vcb(1,:) < 102);

sal_adj_vcb=sal_adj_vcb(:,ie);
ND_vcb=ND_vcb(:,ie);
temp_pot_vcb=temp_pot_vcb(:,ie);
pres_adj_vcb=pres_adj_vcb(:,ie);
lat_vcb=lat_vcb(:,ie);
lon_vcb=lon_vcb(:,ie);
yr_vcb=yr_vcb(:,ie);
index=index(:,ie);

s=size(index);
ID500=nan(s(1),s(2));
T500=nan(s(1),s(2));
for i=1:s(2);
    idx=find(pres_adj_vcb(:,i) > 500);
    ID500(idx,i)=pres_adj_vcb(idx,i);
    T500(idx,i)=temp_pot_vcb(idx,i);
end

%calculating mCDW for max T
MA_mcdw=[];
for i=1:s(2);
    [a,b]=find(index(:,i)==3);
    if isempty(a)==0
       MA_mcdw=[MA_mcdw,max(T500(a,i))]; 
    else
       MA_mcdw=[MA_mcdw,nan];
    end
end

a=isnan(MA_mcdw);
b=find(a==0);MA_mcdw_t=MA_mcdw(b);
lat_CDW=lat_vcb(1,b);
lon_CDW=lon_vcb(1,b);
yr_CDW=yr_vcb(1,b);

c=find(a==1);mcdw_nan=MA_mcdw(c);

%sort data for plot from cold to warm
[MA_mcdw_t,id]=sort(MA_mcdw_t);
lat_CDW=lat_CDW(id);
lon_CDW=lon_CDW(id);


%%map of ISW distribution
addpath 'C:\Users\nribeiro\Desktop\Seal Data\matlab_tools\TOOLBOX\m_map1.4\m_map'

%determina um meshgrid de lat/lon para o bedmap fornecer os dados depois
lat_gps = linspace(-71,55,400);
lon_gps = linspace(40,160,400);

%pega os dados de matimetria do bedmap para um determiando range de lat/lon
[lat,lon,bed] = bedmap2_data('bed',lat_gps,lon_gps); 

%ice mask
[lat,lon,icemask] = bedmap2_data('icemask',lat_gps,lon_gps); 
[i,j]=find(icemask==1);
id_sh=find(icemask==1);

lat_sh=lat(id_sh);
lon_sh=lon(id_sh);

%creating the ice mask a partir do bedmap data para usar com contourf.
a=size(icemask);
n=nan(a(1),a(2));
n(id_sh)=1000;

%% Vincennes Bay only

%mCDW
%fig=figure('Position', get(0, 'Screensize'));
figure;
%[ha, pos] = tight_subplot(3, 2, [.1 .1],[.15 .05],[.06 .04])
%axes(ha(1));
ax1=subplot(1,2,1);
m_proj('mercator','lon',[90 102],'lat',[-67 -63.5]);
[c,hContour]=m_contour(lon,lat,bed,[-400,-500,-600,-700,-800,-1000,-1500, -2000, -2500, -3000],'-k');
m_gshhs_h('patch',[.5 .5 .5]); %usando o pacote de alta resolucao 
hold on;
ax = gca;
ax.FontSize = 14
m_contour(lon,lat,n,[1,1]);
hold on;
m_grid('linewi',2,'tickdir','out');
hold on;
% m_plot(DSW_lon,DSW_lat,'.','MarkerSize',6,'Color','green');
title({'Seal Data'},'FontSize',18);
ylabel({'mCDW';'Latitude'})
xlabel('Longitude')
%set(gca,'xtick',[])
xticks([-5 -2.5 -1 0 1 2.5 5])
pointsize=30;
%ie=m_scatter(lon_vcb(1,:),lat_vcb(1,:),15,'filled');
%set(ie,'markerfacecolor',[.75 .75 .75]);
ie=m_scatter(lon_vcb(1,:),lat_vcb(1,:),3,'filled');
set(ie,'markerfacecolor','r');
%ie.MarkerFaceAlpha=.3;
hold on;
m_scatter(lon_CDW,lat_CDW,pointsize,MA_mcdw_t,'filled','markeredgecolor','k');
hold on;
[c,hContour]=m_contour(lon,lat,icemask,[1,1],'LineColor'...
    ,'k','LineWidth',1);
m_gshhs_h('Color','k');
%caxis([min(MA_mcdw_t) max(MA_mcdw_t)]) %-1.5/1.5
caxis([-1.8, 0]) %-1.5/1.5
cmap=cmocean('thermal',4)%cmap=cmocean('thermal')
colormap(ax1,cmap);
h=colorbar
ylabel(h, '\theta_{max} (\circC)')
t=get(h,'Limits');   %Azzi Abdelmalek contribution. Great Matalab answers contributor
T=linspace(t(1),t(2),5)
set(h,'Ticks',T)
TL=arrayfun(@(x) sprintf('%.2f',x),T,'un',0)
set(h,'TickLabels',TL)


%%___________________________________________________________________
%%set the CTD bit
clear all 
load ShackCTD_data_coast_no_interp.mat
load massa_dagua_index_ShackCTD_data_coast_no_interp

%Vincennes Bay only
ie=find(y(1,:) < -63.5 & x(1,:) > 90 & x(1,:) < 102);

S=S(:,ie);
GA=GA(:,ie);
PT=PT(:,ie);
P=P(:,ie);
y=y(ie);
x=x(ie);
index=index(:,ie);
       
s=size(index);
ID500=nan(s(1),s(2));
T500=nan(s(1),s(2));
for i=1:s(2);
    idx=find(P(:,i) > 500);
    ID500(idx,i)=P(idx,i);
    T500(idx,i)=PT(idx,i);
end

%calculating mCDW for max T
MA_mcdw=[];
for i=1:s(2);
    [a,b]=find(index(:,i)==3);
    if isempty(a)==0
       MA_mcdw=[MA_mcdw,max(T500(a,i))]; 
    else
       MA_mcdw=[MA_mcdw,nan];
    end
end
     
    a=isnan(MA_mcdw);
    b=find(a==0);MA_mcdw_t=MA_mcdw(b);
    lat_CDW=y(1,b);
    lon_CDW=x(1,b);
    
    c=find(a==1);mcdw_nan=MA_mcdw(c);
    
    %%map of ISW distribution
addpath 'C:\Users\nribeiro\Desktop\Seal Data\matlab_tools\TOOLBOX\m_map1.4\m_map'

%determina um meshgrid de lat/lon para o bedmap fornecer os dados depois
lat_gps = linspace(-71,55,400);
lon_gps = linspace(40,160,400);

%pega os dados de matimetria do bedmap para um determiando range de lat/lon
[lat,lon,bed] = bedmap2_data('bed',lat_gps,lon_gps); 

%ice mask
[lat,lon,icemask] = bedmap2_data('icemask',lat_gps,lon_gps); 
[i,j]=find(icemask==1);
id_sh=find(icemask==1);

lat_sh=lat(id_sh);
lon_sh=lon(id_sh);

%creating the ice mask a partir do bedmap data para usar com contourf.
a=size(icemask);
n=nan(a(1),a(2));
n(id_sh)=1000;

  
    hold on;
    %mCDW
    %fig=figure;
    %fig.Position = [5 5 800 600]; 

        ax1=subplot(1,2,2);
        m_proj('mercator','lon',[90 102],'lat',[-67 -63.5]);
        [c,hContour]=m_contour(lon,lat,bed,[-400,-500,-600,-700,-800,-1000,-1500, -2000, -2500, -3000],'-k');
        m_gshhs_h('patch',[.5 .5 .5]); %usando o pacote de alta resolucao 
        hold on;
        ax = gca;
        ax.FontSize = 14
        m_contour(lon,lat,n,[1,1]);
        hold on;
        m_grid('linewi',2,'tickdir','out');
        %m_grid('linewi',2,'tickdir','out','xticklabels',[]);
        hold on;
        %ylabel('mCDW')
        xlabel('Longitude')
        pointsize=30;
        %ie=m_scatter(x(1,:),y(1,:),15,'filled');
        %set(ie,'markerfacecolor',[.75 .75 .75]);
        ie=m_scatter(x(1,:),y(1,:),2,'filled');
        set(ie,'markerfacecolor','r');
        %ie.MarkerFaceAlpha=.3;
        hold on;
        m_scatter(lon_CDW,lat_CDW,pointsize,MA_mcdw_t,'filled','markeredgecolor','k');
        hold on;
        [c,hContour]=m_contour(lon,lat,icemask,[1,1],'LineColor'...
        ,'k','LineWidth',1);
        m_gshhs_h('Color','k');
        %caxis([min(MA_mcdw_t) max(MA_mcdw_t)])%-1.5/1.5
        caxis([-1.8 0])
        title({'Historical Data'},'FontSize',18);
        cmap=cmocean('thermal',4)
        colormap(ax1,cmap)
        h=colorbar
        ylabel(h, '\theta_{max} (\circC)')
        t=get(h,'Limits');   %Azzi Abdelmalek contribution. Great Matalab answers contributor
        T=linspace(t(1),t(2),5)
        set(h,'Ticks',T)
        TL=arrayfun(@(x) sprintf('%.2f',x),T,'un',0)
        set(h,'TickLabels',TL)
        hold on;
                       
        saveas(gcf,'fig_500_comparison.png');
        print(gcf, 'fig_500_comparison','-depsc2');
        
       