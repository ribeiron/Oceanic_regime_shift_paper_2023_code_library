clear all
%%set the CTD bit

cd 'C:\Users\nribeiro\Desktop\Chapter 2'

load ShackCTD_data_coast_no_interp.mat

yaki1=[255,255,217;...
    199,233,180;...
    127,205,187;...
    65,182,196;...
    29,145,192;...
    34,94,168;...
    37,52,148;...
    8,29,88;...
    129,15,124;...
    231,41,138;...
    247,104,161]

yaki1=yaki1/256;

yaki2=[255,255,217;...
    237,248,177;...
    199,233,180;...
    127,205,187;...
    65,182,196;...
    29,145,192;...
    34,94,168;...
    37,52,148;...
    8,29,88;...
    129,15,124;...
    231,41,138;...
    247,104,161]

yaki2=yaki2/256;
%%PLOTTING FIGS
%first comes variales for the map
addpath 'C:\Users\nribeiro\Desktop\Seal Data\matlab_tools\TOOLBOX\m_map1.4\m_map'
addpath 'C:\Users\nribeiro\Desktop\Seal Data\matlab_tools\TOOLBOX\cbdate\cbdate'
addpath 'C:\Users\nribeiro\Desktop\Seal Data\matlab_tools\TOOLBOX\cmocean'                    
addpath 'C:\Users\nribeiro\Desktop\Seal Data\matlab_tools\TOOLBOX\tight_subplot'
addpath 'C:\Users\nribeiro\Desktop\Seal Data\matlab_tools\TOOLBOX\suplabel'

%determina um meshgrid de lat/lon para o bedmap fornecer os dados depois
lat_gps = linspace(-71,55,400);
lon_gps = linspace(40,160,400);

%determina um meshgrid de lat/lon para o bedmap fornecer os dados depois
% % %determina um meshgrid de lat/lon para o bedmap fornecer os dados depois
% % lat_gps = linspace(-80,0,400);
% % lon_gps = linspace(160,0,400);

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

idx=find(x>90 & x <102)

month=month(idx);
ship=ship(idx);
yr=yr(idx);
x=x(idx);
y=y(idx);

year=yr;
tic
c=[];
cdata=[];
u_yr=unique(year);
for i=1:length(u_yr);
    idx=find(year==u_yr(i));
    mth=month(idx);
    for k=1:12;
        data=find(mth==k);
        if isempty(data)==1
            c=[c,0];
        else
            c=[c,length(data)];
        end
    end
    cdata=[cdata;c];
    c=[];
end

%we have to eliminate the 2009 data by deleting the last column
yr_no_09=unique(yr);
cdata1=cdata';
cdata1(cdata1==0)=nan;
figure;
h=heatmap(yr_no_09(1:15),1:12,cdata1(:,1:15),'ColorLimits',[0 30],'MissingDataColor','1.00,1.00,1.00');
ax = gca;
ax.FontSize = 16; 
%cmap=cmocean('deep')%cmap=cmocean('thermal')
cmap=yaki1;
h.Colormap = cmap(1:10,:)
axs = struct(gca);
cb = axs.Colorbar;
title('Time Distribution for the Historical Data')
ylabel('Month')
ylabel(cb, 'Number of Profiles', 'FontSize',14)
caxis([1,30]);
t=get(cb,'Limits');   %Azzi Abdelmalek contribution. Great Matalab answers contributor
T=linspace(1,t(2),6)
set(cb,'Ticks',T)
TL=arrayfun(@(x) sprintf('%.0f',x),T,'un',0)
set(cb,'TickLabels',TL)

 saveas(gcf,'fig_3b_heatmap.png');
 print -depsc2 fig_3b_heatmap.eps
 
   day=ones(194,1);%had to invent that, size of matrix
   date=[yr' month' day];
   date=datenum(date);
   
    %fig = figure('Position', get(0, 'Screensize'))
    fig = figure('WindowState', 'maximized');
    %fig.WindowState = 'maximized';
    subplot(2,2,3);
    m_proj('mercator','lon',[90 102],'lat',[-67.5 -64]);
    [c,hContour]=m_contour(lon,lat,bed,[-400,-600,-800,-1000,-1500,-2000,-2500,-3000],'-k')
    hold on;
    [c,hContour]=m_contour(lon,lat,bed,[-1000,-1000],'-k','linewidth',2);
    %m_elev('contourf'); colormap gray;
    m_gshhs_h('patch',[.5 .5 .5]); %usando o pacote de alta resolucao
    hold on;
    ax = gca;
    ax.FontSize = 18;
    [c,h(1)]=m_contour(lon,lat,n,[1,1])
    hold on;
    m_grid('linewi',2,'tickdir','out');
    hold on;
    pointsize=35;
    hold on;
    i=find(yr>=1960 & yr<=1969 & x>90);
    h2=m_scatter(x(i),y(i),pointsize,month(i),'o','filled','markeredgecolor','k');
    i=find(yr>=1930 & yr<=1959 & x>90);
    h1=m_scatter(x(i),y(i),pointsize,month(i),'s','filled','markeredgecolor','k');
    i=find(yr>=1970 & yr<=1979 & x>90);
    h1=m_scatter(x(i),y(i),pointsize,month(i),'^','filled','markeredgecolor','k');
    i=find(yr>=1980 & yr<=1989 & x>90);
    h3=m_scatter(x(i),y(i),90,month(i),'p','filled','markeredgecolor','k');
    i=find(yr>=1990 & yr<=1999 & x>90);
    h3=m_scatter(x(i),y(i),pointsize,month(i),'v','filled','markeredgecolor','k');
    %i=find(yr>=2000 & yr<=2014 & x>90);
    %h4=m_scatter(x(i),y(i),pointsize,month(i),'d','filled','markeredgecolor','k');
    hold on
    [c,hContour]=m_contour(lon,lat,icemask,[1,1],'LineColor'...
    ,'k','LineWidth',1);
    m_gshhs_h('Color','k');
    caxis([min(month) max(month)]);
    title('');
    xlabel('Longitude')
    ylabel('Latitude')
    %colormap(flipud(parula));
    %cmap=cmocean('deep')
    cmap=yaki2;
    colormap(cmap)
    h=colorbar;
    h.Title.String='month'
    set(h, 'YDir','reverse');
    t=get(h,'Limits');   %Azzi Abdelmalek contribution. Great Matalab answers contributor
    T=linspace(t(1),t(2),7)
    set(h,'Ticks',T)
    TL=arrayfun(@(x) sprintf('%.0f',x),T,'un',0)
    set(h,'TickLabels',TL);
    %Build legend
    hold on;
    g1=m_plot(nan,nan,'linestyle','none','marker','s','markersize',7,'color','k',...
        'MarkerFaceColor','k');
    hold on;
    g2=m_plot(nan,nan,'linestyle','none','marker','o','markersize',7,'color','k',...
        'MarkerFaceColor','k');
    hold on;
    g3=m_plot(nan,nan,'linestyle','none','marker','^','markersize',7,'color','k',...
        'MarkerFaceColor','k');
    hold on;
    g4=m_plot(nan,nan,'linestyle','none','marker','p','markersize',7,'color','k',...
        'MarkerFaceColor','k');
    hold on;
    g5=m_plot(nan,nan,'linestyle','none','marker','v','markersize',7,'color','k',...
        'MarkerFaceColor','k');
    hold on;
    %g6=m_plot(nan,nan,'linestyle','none','marker','d','markersize',7,'color','k',...
    %    'MarkerFaceColor','k');
    
    legend([g1,g2,g3,g4,g5],{'1956-1957','1961-1969','1971-1978','1983-1989','1996'}, 'location','southeast','fontsize',10);

    %saveas(gcf,'fig_scatter_ctdc.png');
    %print -depsc2 fig_scatter_ctdc.eps
    
    %%%_________________________________________________________
    %clear all
    load West_Shack_VB_Totten_triado_coast.mat
    ie=find(lon_vcb(1,:) > 90 & lon_vcb(1,:) <= 102);
  
    
    lat_17=lat_vcb(1,ie);
    lon_17=lon_vcb(1,ie);
    yr_17=yr_vcb(1,ie);
    mth_17=mth_vcb(1,ie);
    day_17=day_vcb(1,ie);
    
    %number of seals
    seal_17=seal_vcb(1,ie);
    no=unique(seal_17)

%determina um meshgrid de lat/lon para o bedmap fornecer os dados depois
lat_gps = linspace(-71,55,400);
lon_gps = linspace(40,160,400);

%determina um meshgrid de lat/lon para o bedmap fornecer os dados depois
% % %determina um meshgrid de lat/lon para o bedmap fornecer os dados depois
% % lat_gps = linspace(-80,0,400);
% % lon_gps = linspace(160,0,400);

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


date=[yr_17' mth_17' day_17'];
date=datenum(date);


   yaki2=[255,255,217;...
    237,248,177;...
    199,233,180;...
    127,205,187;...
    65,182,196;...
    29,145,192;...
    34,94,168;...
    37,52,148;...
    8,29,88;...
    129,15,124;...
    231,41,138;...
    247,104,161]

yaki2=yaki2/256;


    %fig=figure;
    subplot(2,2,2);
    m_proj('mercator','lon',[90 102],'lat',[-67.5 -64]);
    [c,hContour]=m_contour(lon,lat,bed,[-400,-600,-800,-1000,-1500,-2000,-2500,-3000],'-k')
    hold on;
    [c,hContour]=m_contour(lon,lat,bed,[-1000,-1000],'-k','linewidth',2);
    %m_elev('contourf'); colormap gray;
    m_gshhs_h('patch',[.5 .5 .5]); %usando o pacote de alta resolucao
    hold on;
    ax = gca;
    ax.FontSize = 18;
    [c,h(1)]=m_contour(lon,lat,n,[1,1])
    hold on;
    m_grid('linewi',2,'tickdir','out');
    hold on;
    pointsize=130;
    h1=m_scatter(lon_17,lat_17,pointsize,mth_17,'.');
    hold on
    [c,hContour]=m_contour(lon,lat,icemask,[1,1],'LineColor'...
    ,'k','LineWidth',1);
    m_gshhs_h('Color','k');
    caxis([min(mth_17) 12]);
    title('','Fontsize',18)
    ylabel('Latitude')
    %colormap(flipud(parula));
    %cmap=cmocean('phase')
    cmap=yaki2;
    colormap(cmap)
    h=colorbar;
    h.Title.String='month'
    set(h, 'YDir','reverse');
    t=get(h,'Limits');   %Azzi Abdelmalek contribution. Great Matalab answers contributor
    T=linspace(t(1),t(2),7)
    set(h,'Ticks',T)
    TL=arrayfun(@(x) sprintf('%.0f',x),T,'un',0)
    set(h,'TickLabels',TL);
   
    %saveas(gcf,'fig3_3c_scatter_time.png');
    %print -depsc2 fig3c_scatter_time.eps
    
    %subplot(2,1,2);
    %figure;
    subplot(2,2,4)
    m_proj('mercator','lon',[90 102],'lat',[-67.5 -64]);
    [c,hContour]=m_contour(lon,lat,bed,[-400,-600,-800,-1000,-1500,-2000,-2500,-3000],'-k')
    hold on;
    [c,hContour]=m_contour(lon,lat,bed,[-1000,-1000],'-k','linewidth',2);
    %m_elev('contourf'); colormap gray;
    m_gshhs_h('patch',[.5 .5 .5]); %usando o pacote de alta resolucao
    hold on;
    ax = gca;
    ax.FontSize = 18;
    [c,h(1)]=m_contour(lon,lat,n,[1,1])
    hold on;
    m_grid('linewi',2,'tickdir','out');
    hold on;
    pointsize=130;
    h1=m_scatter(lon_17,lat_17,pointsize,yr_17,'.');
    hold on
    [c,hContour]=m_contour(lon,lat,icemask,[1,1],'LineColor'...
    ,'k','LineWidth',1);
    m_gshhs_h('Color','k');
    caxis([min(yr_17) max(yr_17)]);
    title('','Fontsize',18);
    xlabel('Longitude')
    %colormap(flipud(parula));
    %cmap=cmocean('phase')
    cmpa=yaki2;
    colormap(cmap)
    h=colorbar;
    h.Title.String='year'
    set(h, 'YDir','reverse');
    t=get(h,'Limits');   %Azzi Abdelmalek contribution. Great Matalab answers contributor
    T=linspace(t(1),t(2),7)
    set(h,'Ticks',T)
    TL=arrayfun(@(x) sprintf('%.0f',x),T,'un',0)
    set(h,'TickLabels',TL);
    
    
    fig.WindowState = 'maximized';
    set(fig,'PaperType','a4')
    set(fig,'PaperOrientation','portrait')
    set(fig,'PaperPositionMode','auto')
    %then save with print a
    %then save with print a
    print('fig3_scatter_time','-dpng','-r600')

    %%things that weren't working
    %set(gcf,'Color','w');
    %F = getframe(fig);
    %imwrite(F.cdata, 'Foos.png', 'png')
    
    %set(fig,'PaperPositionMode','auto');
    %saveas(gcf,'fig3_scatter_time.png');
    %set(gcf, 'Position', get(0, 'Screensize'));
    %print -depsc2 fig3_scatter_time.eps
    %print('fig3_scatter_time','-dpng','-r600')
   
    %FigH = figure('Position', get(0, 'Screensize'));
    %saveas(fig, 'Foos2.png','png');