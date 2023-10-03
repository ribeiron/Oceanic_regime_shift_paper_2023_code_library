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

%use 840 as index to find the high temp near shelf


%calculating mDSW for max S
s=size(sal_adj_vcb);

MA_dsw=[];
for i=1:s(2);
    [a,b]=find(index(:,i)==1);
    if isempty(a)==0
        MA_dsw=[MA_dsw,max(sal_adj_vcb(a,i))];
    else
        MA_dsw=[MA_dsw,nan];
    end
end

a=isnan(MA_dsw);
b=find(a==0);MA_dsw_s=MA_dsw(b);
lat_DSW=lat_vcb(1,b);
lon_DSW=lon_vcb(1,b);

c=find(a==1);dsw_nan=MA_dsw(c);
   
%sort data for plot from fresh to saline
[MA_dsw_s,id]=sort(MA_dsw_s);
lat_DSW=lat_DSW(id);
lon_DSW=lon_DSW(id);


%%calculating ISW for min T
MA_isw=[];
for i=1:s(2)
    [a,b]=find(index(:,i)==2);
    if isempty(a)==0
       MA_isw=[MA_isw,min(temp_pot_vcb(a,i))]; 
    else
       MA_isw=[MA_isw,nan];
    end
end

a=isnan(MA_isw);
b=find(a==0);MA_isw_t=MA_isw(b);
lat_ISW=lat_vcb(1,b);
lon_ISW=lon_vcb(1,b);

c=find(a==1);isw_nan=MA_isw(c);

%sort data for plot from warm to cold
[MA_isw_t,id]=sort(MA_isw_t,'descend');
lat_ISW=lat_ISW(id);
lon_ISW=lon_ISW(id);


%calculating mCDW for max T
MA_mcdw=[];
for i=1:s(2);
    [a,b]=find(index(:,i)==3);
    if isempty(a)==0
       MA_mcdw=[MA_mcdw,max(temp_pot_vcb(a,i))]; 
    else
       MA_mcdw=[MA_mcdw,nan];
    end
end
%---------------------------------------------------------------
%calculating mCDW for max T
for_rev=[];
for i=1:s(2);
    [a,b]=find(index(:,i)==3);
    if isempty(a)==0
        for_rev=[for_rev;temp_pot_vcb(a,i)];
    else
        for_rev=[for_rev;nan];
    end
end

for_rev2=isnan(for_rev);
i=find(for_rev2==0);
teste=find(for_rev(i)<=-1.6);

size(teste)

nanmean(for_rev)
nanstd(for_rev)
%size <=-1.6
%1033
%size >-1.6
%821

%--------------------------------------------------------
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
fig=figure;
%[ha, pos] = tight_subplot(3, 2, [.1 .1],[.15 .05],[.06 .04])
%axes(ha(1));
ax1=subplot(3,1,1);
m_proj('mercator','lon',[90 102],'lat',[-67 -64]);
[c,hContour]=m_contour(lon,lat,bed,[-400,-600,-800,-1000,-1500, -2000, -2500, -3000],'color',[.75 .75 .75]);
m_gshhs_h('patch',[.5 .5 .5]); %usando o pacote de alta resolucao 
hold on;
ax = gca;
ax.FontSize = 13
m_contour(lon,lat,n,[1,1]);
hold on;
m_grid('linewi',2,'tickdir','out','xticklabels',[]);
hold on;
% m_plot(DSW_lon,DSW_lat,'.','MarkerSize',6,'Color','green');
% title({'Water Mass Distribution';' '});
ylabel('mCDW')
set(gca,'xtick',[])
xticks([-5 -2.5 -1 0 1 2.5 5])
pointsize=30;
ie=m_scatter(lon_vcb(1,:),lat_vcb(1,:),5,'filled');
set(ie,'markerfacecolor','r');
%ie=m_scatter(lon_vcb(1,:),lat_vcb(1,:),15,'filled');
%set(ie,'markerfacecolor',[.75 .75 .75]);
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


%DSW
hold on
%axes(ha(3));
ax2=subplot(3,1,2);
m_proj('mercator','lon',[90 102],'lat',[-67 -64]);
[c,hContour]=m_contour(lon,lat,bed,[-400,-600,-800,-1000,-1500, -2000, -2500, -3000],'color',[.75 .75 .75]);
m_gshhs_h('patch',[.5 .5 .5]); %usando o pacote de alta resolucao 
hold on;
ax = gca;
ax.FontSize = 13
m_contour(lon,lat,n,[1,1]);
hold on;
m_grid('linewi',2,'tickdir','out','xticklabels',[]);
hold on;
set(gca,'xtick',[])
ylabel('DSW')
pointsize=30;
ie=m_scatter(lon_vcb(1,:),lat_vcb(1,:),5,'filled');
set(ie,'markerfacecolor','r');
%ie=m_scatter(lon_vcb(1,:),lat_vcb(1,:),15,'filled');
%set(ie,'markerfacecolor',[.75 .75 .75]);
%ie.MarkerFaceAlpha=.3;
hold on;
m_scatter(lon_DSW,lat_DSW,pointsize,MA_dsw_s,'filled','markeredgecolor','k');
hold on;
[c,hContour]=m_contour(lon,lat,icemask,[1,1],'LineColor'...
    ,'k','LineWidth',1);
m_gshhs_h('Color','k');
%caxis([min(MA_dsw_s) max(MA_dsw_s)]); %-34.44/34.64
caxis([34.46 34.7]); 
cmap=cmocean('haline',4);
colormap(ax2,cmap)
h=colorbar
ylabel(h, 'S_{max}')
t=get(h,'Limits');   %Azzi Abdelmalek contribution. Great Matalab answers contributor
T=linspace(t(1),t(2),5)
set(h,'Ticks',T)
TL=arrayfun(@(x) sprintf('%.2f',x),T,'un',0)
set(h,'TickLabels',TL)
%set( h, 'YDir', 'reverse' );


%ISW
hold on
%axes(ha(5));
ax3=subplot(3,1,3);
m_proj('mercator','lon',[90 102],'lat',[-67 -64]);
[c,hContour]=m_contour(lon,lat,bed,[-400,-600,-800,-1000,-1500, -2000, -2500, -3000],'color',[.75 .75 .75]);
m_gshhs_h('patch',[.5 .5 .5]); %usando o pacote de alta resolucao 
hold on;
ax = gca;
ax.FontSize = 13
m_contour(lon,lat,n,[1,1]);
hold on;
m_grid('linewi',2,'tickdir','out','xtick',[90:2:102],'xticklabel',[90:2:102]);
hold on;
ylabel('ISW')
pointsize=30;
ie=m_scatter(lon_vcb(1,:),lat_vcb(1,:),5,'filled');
set(ie,'markerfacecolor','r');
%ie=m_scatter(lon_vcb(1,:),lat_vcb(1,:),15,'filled');
%set(ie,'markerfacecolor',[.75 .75 .75]);
%ie.MarkerFaceAlpha=.3;
hold on;
m_scatter(lon_ISW,lat_ISW(1,:),pointsize,MA_isw_t,'filled','markeredgecolor','k');
hold on;
[c,hContour]=m_contour(lon,lat,icemask,[1,1],'LineColor'...
    ,'k','LineWidth',1);
m_gshhs_h('Color','k');
%caxis([min(MA_isw_t) max(MA_isw_t)])%-2/-1.95
caxis([-2.01, -1.92])
cmap=cmocean('thermal',4)
colormap(ax3,cmap)
h=colorbar
ylabel(h, '\theta_{min} (\circC)')
t=get(h,'Limits');   %Azzi Abdelmalek contribution. Great Matalab answers contributor
T=linspace(t(1),t(2),5)
set(h,'Ticks',T)
TL=arrayfun(@(x) sprintf('%.2f',x),T,'un',0)
set(h,'TickLabels',TL)

%F    = getframe(fig);
%set(fig,'color','w');
%imwrite(F.cdata, 'fig_scatter_seala.png')


%%bring down the resolution of the monitor a bit and then run the
%%below code when the figures are saved all shrinked. 
fig.WindowState = 'maximized';
set(fig,'PaperType','a4')
set(fig,'PaperOrientation','portrait')
set(fig,'PaperPositionMode','auto')
%then save with print a
%then save with print a
print('fig_scatter_seala','-dpng','-r600')
%saveas(gcf,'fig_scatter_seala.png');
%saveas(gcf, 'fig_scatter_seala.eps');
%close all 


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
y=y(ie);
x=x(ie);
index=index(:,ie);
       

    %%calculating mDSW for max S
    s=size(S);
    MA_dsw=[];
    for i=1:s(2);
        [a,b]=find(index(:,i)==1);
        if isempty(a)==0
            MA_dsw=[MA_dsw,max(S(a,i))];
        else
            MA_dsw=[MA_dsw,nan];
        end
    end
    
    a=isnan(MA_dsw);
    b=find(a==0);MA_dsw_s=MA_dsw(b);
    lat_DSW=y(1,b);
    lon_DSW=x(1,b);
    
    c=find(a==1);dsw_nan=MA_dsw(c);
    
    %sort data for plot from fresh to saline
    [MA_dsw_s,id]=sort(MA_dsw_s);
    lat_DSW=lat_DSW(id);
    lon_DSW=lon_DSW(id);
    
    %%calculating ISW for min T
    MA_isw=[];
    for i=1:s(2)
        [a,b]=find(index(:,i)==2);
        if isempty(a)==0
            MA_isw=[MA_isw,min(PT(a,i))];
        else
            MA_isw=[MA_isw,nan];
        end
    end
    
    a=isnan(MA_isw);
    b=find(a==0);MA_isw_t=MA_isw(b);
    lat_ISW=y(1,b);
    lon_ISW=x(1,b);
    
    c=find(a==1);isw_nan=MA_isw(c);
    
    %sort data for plot from warm to cold
    [MA_isw_t,id]=sort(MA_isw_t,'descend');
    lat_ISW=lat_ISW(id);
    lon_ISW=lon_ISW(id);
    
    %calculating mCDW for max T
for_rev=[];
for i=1:s(2);
    [a,b]=find(index(:,i)==3);
    if isempty(a)==0
        for_rev=[for_rev;PT(a,i)];
    else
        for_rev=[for_rev;nan]
    end
end

for_rev2=isnan(for_rev);
i=find(for_rev2==0);
teste=find(for_rev(i)<=-1.6);

size(teste)
%size <-1.6
%181
%size >-1.6
%5
    %calculating mCDW for max T
    MA_mcdw=[];
    for i=1:s(2);
        [a,b]=find(index(:,i)==3);
        if isempty(a)==0
            MA_mcdw=[MA_mcdw,max(PT(a,i))];
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
    fig=figure;
    %fig.Position = [5 5 800 600]; 

        ax1=subplot(3,1,1);
        m_proj('mercator','lon',[90 102],'lat',[-67 -64]);
        [c,hContour]=m_contour(lon,lat,bed,[-400,-600,-800,-1000,-1500, -2000, -2500, -3000],'color',[.75 .75 .75]);
        m_gshhs_h('patch',[.5 .5 .5]); %usando o pacote de alta resolucao 
        hold on;
        ax = gca;
        ax.FontSize = 13
        m_contour(lon,lat,n,[1,1]);
        hold on;
        m_grid('linewi',2,'tickdir','out','xticklabels',[]);
        hold on;
        ylabel('mCDW')
        pointsize=30;
        ie=m_scatter(x(1,:),y(1,:),5,'filled');
        set(ie,'markerfacecolor','r');
        %ie=m_scatter(lon_vcb(1,:),lat_vcb(1,:),15,'filled');
        %set(ie,'markerfacecolor',[.75 .75 .75]);
        %ie.MarkerFaceAlpha=.3;
        hold on;
        m_scatter(lon_CDW,lat_CDW,pointsize,MA_mcdw_t,'filled','markeredgecolor','k');
        hold on;
        [c,hContour]=m_contour(lon,lat,icemask,[1,1],'LineColor'...
        ,'k','LineWidth',1);
        m_gshhs_h('Color','k');
        %caxis([min(MA_mcdw_t) max(MA_mcdw_t)])%-1.5/1.5
        caxis([-1.8 0])
        %title({'mCDW: 28 < \gamma^{n} < 28.27', '-1.8 < \theta <= 0'},'FontSize',18);
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
        
        
        %DSW
        ax2=subplot(3,1,2);
        m_proj('mercator','lon',[90 102],'lat',[-67 -64]);
        [c,hContour]=m_contour(lon,lat,bed,[-400,-600,-800,-1000,-1500, -2000, -2500, -3000],'color',[.75 .75 .75]);
        m_gshhs_h('patch',[.5 .5 .5]); %usando o pacote de alta resolucao 
        hold on;
        ax = gca;
        ax.FontSize = 13
        m_contour(lon,lat,n,[1,1]);
        hold on;
        m_grid('linewi',2,'tickdir','out','xticklabels',[]);
        hold on;
        ylabel('DSW')
        %ax = gca;
        %ax.FontSize = 18
        pointsize=30;
        ie=m_scatter(x(1,:),y(1,:),5,'filled');
        set(ie,'markerfacecolor','r');
        %ie=m_scatter(lon_vcb(1,:),lat_vcb(1,:),15,'filled');
        %set(ie,'markerfacecolor',[.75 .75 .75]);
        %ie.MarkerFaceAlpha=.3;
        hold on;
        s=size(lat_DSW);
        m_scatter(lon_DSW,lat_DSW,pointsize,MA_dsw_s,'filled','markeredgecolor','k');
        hold on;
        [m,idx]=nanmax(MA_dsw_s);
        m_plot(lon_DSW(idx),lat_DSW(idx),'kp','MarkerFaceColor','r','LineStyle','none','Markersize',14)
        [c,hContour]=m_contour(lon,lat,icemask,[1,1],'LineColor'...
        ,'k','LineWidth',1);
        m_gshhs_h('Color','k');
        %fix colorbar issue
        %caxis([min(MA_dsw_s) max(MA_dsw_s)]);%34.45/34.80
        caxis([34.46 34.7]); 
        cmap=cmocean('haline',4);
        colormap(ax2,cmap)
        h=colorbar
        ylabel(h, 'S_{max}')
        t=get(h,'Limits');   %Azzi Abdelmalek contribution. Great Matalab answers contributor
        T=linspace(t(1),t(2),5)
        set(h,'Ticks',T)
        TL=arrayfun(@(x) sprintf('%.2f',x),T,'un',0)
        set(h,'TickLabels',TL)
        %set( h, 'YDir', 'reverse' );

    
    
        %ISW
        ax3=subplot(3,1,3);
         m_proj('mercator','lon',[90 102],'lat',[-67 -64]);
        [c,hContour]=m_contour(lon,lat,bed,[-400,-600,-800,-1000,-1500, -2000, -2500, -3000],'color',[.75 .75 .75]);
        m_gshhs_h('patch',[.5 .5 .5]); %usando o pacote de alta resolucao 
        hold on;
        ax = gca;
        ax.FontSize = 13
        m_contour(lon,lat,n,[1,1]);
        hold on;
        m_grid('linewi',2,'tickdir','out');
        hold on;
        ylabel('ISW')
        pointsize=30;
        ie=m_scatter(x(1,:),y(1,:),5,'filled');
        set(ie,'markerfacecolor','r');
        %ie=m_scatter(lon_vcb(1,:),lat_vcb(1,:),15,'filled');
        %set(ie,'markerfacecolor',[.75 .75 .75]);
        %ie.MarkerFaceAlpha=.3;
        %this i sto fix an issue with scatter, when c=3 it treats it as a
        %color matrix.
        s=size(lat_ISW);
        m_scatter(lon_ISW,lat_ISW,pointsize,MA_isw_t,'filled','markeredgecolor','k');
        hold on;
        [c,hContour]=m_contour(lon,lat,icemask,[1,1],'LineColor'...
        ,'k','LineWidth',1);
        m_gshhs_h('Color','k');
        caxis([min(MA_isw_t) max(MA_isw_t)]);
        %title({'ISW: \gamma^{n} < 28.27', '\theta < -1.95'},'Fontsize',18);
        cmap=cmocean('thermal',4)
        colormap(ax3,cmap)
        h=colorbar
        ylabel(h, '\theta_{min} (\circC)')
        t=get(h,'Limits');   %Azzi Abdelmalek contribution. Great Matalab answers contributor
        T=linspace(t(1),t(2),5)
        set(h,'Ticks',T)
        TL=arrayfun(@(x) sprintf('%.2f',x),T,'un',0)
        set(h,'TickLabels',TL)
        
        %%bring down the resolution of the monitor a bit and then run the
        %%below code when the figures are saved all shrinked. 
        fig.WindowState = 'maximized';
        set(fig,'PaperType','a4')
        set(fig,'PaperOrientation','portrait')
        set(fig,'PaperPositionMode','auto')
        %then save with print a
        print('fig_scatter_ctda','-dpng','-r600')
        %saveas(gcf,'fig_scatter_ctda.png');
        %print(gcf, 'fig_scatter_ctda','-depsc2');
        
        %make profile of the high salinity profile of CTD
        
        [d,j]=max(MA_dsw_s);
        l1=lat_DSW(j);
        l2=lon_DSW(j);
        d=find(y==l1 & x==l2);
        S1=fillmissing(S(1:12,d),'linear');
        PT1=fillmissing(PT(1:12,d),'linear');
        P1=P(1:12,d);
        P2=P(1:12,d);
        
 
        figure;
        ax1=subplot(1,2,1)
        plot(S1,P1,'r','Linewidth',1.5)
        hold on;
        plot(S(:,d),P(:,d),'r.','MarkerSize',20)
        set(gca,'Ydir','reverse')
        set(gca, ...
            'Box'         , 'off'     , ...
            'TickDir'     , 'out'     , ...
            'TickLength'  , [.02 .02] , ...
            'XMinorTick'  , 'on'      , ...
            'YMinorTick'  , 'on'      , ...
            'XGrid'       , 'on'      , ...
            'LineWidth'   , 1         );
        % gridlines ---------------------------
        hold on
        g_y=[0:100:1200]; % user defined grid Y [start:spaces:end]
        g_x=[33:1:35];% user defined grid X [start:spaces:end]
        s=xlim;
        % for i=1:length(g_x)
        %    plot([g_x(i) g_x(i)],[g_y(1) g_y(end)],'k:') %y grid lines
        %    hold on
        % end
        for i=1:length(g_y)
            plot([g_x(1) s(2)],[g_y(i) g_y(i)],'LineStyle','-','Color',[.8 .8 .8]) %x grid lines
            hold on
        end
       ylim([0 500])
        
        ax2=subplot(1,2,2)
        plot(PT1,P2,'r','Linewidth',1.5)
        hold on;
        plot(PT(:,d),P(:,d),'r.','MarkerSize',20)
        set(gca,'Ydir','reverse')
        set(gca, ...
            'Box'         , 'off'     , ...
            'TickDir'     , 'out'     , ...
            'TickLength'  , [.02 .02] , ...
            'XMinorTick'  , 'on'      , ...
            'YMinorTick'  , 'on'      , ...
            'XGrid'       , 'on'      , ...
            'LineWidth'   , 1         );
        % gridlines ---------------------------
        hold on
        g_y=[0:100:1200]; % user defined grid Y [start:spaces:end]
        g_x=[-2:1:-1.5];% user defined grid X [start:spaces:end]
        s=xlim;
        % for i=1:length(g_x)
        %    plot([g_x(i) g_x(i)],[g_y(1) g_y(end)],'k:') %y grid lines
        %    hold on
        % end
        for i=1:length(g_y)
            plot([g_x(1) s(2)],[g_y(i) g_y(i)],'LineStyle','-','Color',[.8 .8 .8]) %x grid lines
            hold on
        end
       ylim([0 500])
       
       
       saveas(gcf,'fig_saltyCTDprof.png');
       print(gcf, 'fig_saltyCTDprof','-depsc');
       
        %make the warm profile of CTD
        
        [d,j]=max(MA_mcdw_t);
        l1=lat_CDW(j);
        l2=lon_CDW(j);
        d=find(y==l1 & x==l2);
        S1=S(1:11,d);
        PT1=PT(1:11,d);
        P1=P(1:11,d);
                
        figure;
        ax1=subplot(1,2,1)
        plot(S1,P1,'r','Linewidth',1.5)
        hold on;
        plot(S(:,d),P(:,d),'r.','MarkerSize',20)
        set(gca,'Ydir','reverse')
        set(gca, ...
            'Box'         , 'off'     , ...
            'TickDir'     , 'out'     , ...
            'TickLength'  , [.02 .02] , ...
            'XMinorTick'  , 'on'      , ...
            'YMinorTick'  , 'on'      , ...
            'XGrid'       , 'on'      , ...
            'LineWidth'   , 1         );
        % gridlines ---------------------------
        hold on
        g_y=[0:100:1200]; % user defined grid Y [start:spaces:end]
        g_x=[33.5:1:35];% user defined grid X [start:spaces:end]
        s=xlim;
        % for i=1:length(g_x)
        %    plot([g_x(i) g_x(i)],[g_y(1) g_y(end)],'k:') %y grid lines
        %    hold on
        % end
        for i=1:length(g_y)
            plot([g_x(1) g_x(2)],[g_y(i) g_y(i)],'LineStyle','-','Color',[.8 .8 .8]) %x grid lines
            hold on
        end
       ylim([0 400])
        
        ax2=subplot(1,2,2)
        plot(PT1,P1,'r','Linewidth',1.5)
        hold on;
        plot(PT(:,d),P(:,d),'r.','MarkerSize',20)
        set(gca,'Ydir','reverse')
        set(gca, ...
            'Box'         , 'off'     , ...
            'TickDir'     , 'out'     , ...
            'TickLength'  , [.02 .02] , ...
            'XMinorTick'  , 'on'      , ...
            'YMinorTick'  , 'on'      , ...
            'XGrid'       , 'on'      , ...
            'LineWidth'   , 1         );
        % gridlines ---------------------------
        hold on
        g_y=[0:100:1200]; % user defined grid Y [start:spaces:end]
        g_x=[-2:1:-1.5];% user defined grid X [start:spaces:end]
        s=xlim;
        % for i=1:length(g_x)
        %    plot([g_x(i) g_x(i)],[g_y(1) g_y(end)],'k:') %y grid lines
        %    hold on
        % end
        for i=1:length(g_y)
            plot([g_x(1) s(2)],[g_y(i) g_y(i)],'LineStyle','-','Color',[.8 .8 .8]) %x grid lines
            hold on
        end
       ylim([0 400])
       
       
       saveas(gcf,'fig_tempCTDprof.png');
       saveas(gcf, 'fig_tempCTDprof.eps');
       
       
       
          %make the warm profile of CTD
        
        [d,j]=find(lat_CDW<=-65.5 & lon_CDW>=98);
        l1=lat_CDW(j);
        l2=lon_CDW(j);
        y1=yr_CDW(j)
        d=find(lat_vcb==l1 & lon_vcb==l2);
        S1=S(1:11,d);
        PT1=PT(1:11,d);
        P1=P(1:11,d);
                
        figure;
        ax1=subplot(1,2,1)
        plot(S1,P1,'r','Linewidth',1.5)
        hold on;
        plot(S(:,d),P(:,d),'r.','MarkerSize',20)
        set(gca,'Ydir','reverse')
        set(gca, ...
            'Box'         , 'off'     , ...
            'TickDir'     , 'out'     , ...
            'TickLength'  , [.02 .02] , ...
            'XMinorTick'  , 'on'      , ...
            'YMinorTick'  , 'on'      , ...
            'XGrid'       , 'on'      , ...
            'LineWidth'   , 1         );
        % gridlines ---------------------------
        hold on
        g_y=[0:100:1200]; % user defined grid Y [start:spaces:end]
        g_x=[33.5:1:35];% user defined grid X [start:spaces:end]
        s=xlim;
        % for i=1:length(g_x)
        %    plot([g_x(i) g_x(i)],[g_y(1) g_y(end)],'k:') %y grid lines
        %    hold on
        % end
        for i=1:length(g_y)
            plot([g_x(1) g_x(2)],[g_y(i) g_y(i)],'LineStyle','-','Color',[.8 .8 .8]) %x grid lines
            hold on
        end
       ylim([0 400])
        
        ax2=subplot(1,2,2)
        plot(PT1,P1,'r','Linewidth',1.5)
        hold on;
        plot(PT(:,d),P(:,d),'r.','MarkerSize',20)
        set(gca,'Ydir','reverse')
        set(gca, ...
            'Box'         , 'off'     , ...
            'TickDir'     , 'out'     , ...
            'TickLength'  , [.02 .02] , ...
            'XMinorTick'  , 'on'      , ...
            'YMinorTick'  , 'on'      , ...
            'XGrid'       , 'on'      , ...
            'LineWidth'   , 1         );
        % gridlines ---------------------------
        hold on
        g_y=[0:100:1200]; % user defined grid Y [start:spaces:end]
        g_x=[-2:1:-1.5];% user defined grid X [start:spaces:end]
        s=xlim;
        % for i=1:length(g_x)
        %    plot([g_x(i) g_x(i)],[g_y(1) g_y(end)],'k:') %y grid lines
        %    hold on
        % end
        for i=1:length(g_y)
            plot([g_x(1) s(2)],[g_y(i) g_y(i)],'LineStyle','-','Color',[.8 .8 .8]) %x grid lines
            hold on
        end
       ylim([0 400])
       
       
       saveas(gcf,'fig_tempsealprof.png');
       saveas(gcf, 'fig_tempsealprof.eps');
        
        
        