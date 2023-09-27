%%% the graphs that put seals and historical data

load West_Shack_VB_Totten_triado_coast.mat
%load ShackCTD_data_coast.mat
load ShackCTD_data_coast_no_interp.mat
 

ie=find(lon_vcb(1,:) > 90 & lon_vcb(1,:) <= 96.5);

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
PR_17=pres_adj_vcb(:,ie);
lat_17=lat_vcb(:,ie);
lon_17=lon_vcb(:,ie);

%adicionar para tirar perfis ruins.
[r_s,c_s]=find(SA_17<=33.9 & PR_17>=300);
c_s=unique(c_s);

len=length(lat_17);
PR_17=[PR_17(:,1:36),PR_17(:,38:116),PR_17(:,118:len)];
SA_17=[SA_17(:,1:36),SA_17(:,38:116),SA_17(:,118:len)];
temp_pot_vcb=[temp_pot_vcb(:,1:36),temp_pot_vcb(:,38:116),temp_pot_vcb(:,118:len)];
lat_17=[lat_17(1,1:36),lat_17(1,38:116),lat_17(1,118:len)];
lon_17=[lon_17(1,1:36),lon_17(1,38:116),lon_17(1,118:len)];


%%interpolation of data to do pressure averaged profiles. 

%// define a "uniform" grid without holes (same boundaries and sampling than original grid)
[AI,BI] = meshgrid(1,1:10:1001) ;
s=size(temp_pot_vcb);
PR_interp=repmat(BI,1,s(2))
%// re-interpolate scattered data (only valid indices) over the "uniform" grid


t_seal = [];
s_seal = [];
for i=1:s(2);
    %// identify indices valid for the 3 matrix 
    idxgood=~(isnan(temp_pot_vcb(:,i)) | isnan(PR_17(:,i))); 

    %interp s & t 
    t = interp1(PR_17(idxgood,i),temp_pot_vcb(idxgood,i),BI);
    sal = interp1(PR_17(idxgood,i),SA_17(idxgood,i),BI);
    t_seal = [t_seal t];
    s_seal = [s_seal sal];
end


%%map of ISW variables
addpath 'C:\Users\nribeiro\Desktop\Seal Data\matlab_tools\TOOLBOX\m_map1.4\m_map'
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

cmap=[.8 .8 .8]

%%figure
si=size(temp_pot_vcb);
fig=figure;
fig.Position = [5 5 800 600]; 
% [ha, pos] = tight_subplot(2, 4, [0.1 0.05],[.15 .1],[.09 .04])
% axes(ha(1));
subplot(2,2,1)
m_proj('mercator','lon',[87 97],'lat',[-67 -64]);
hold on
ax = gca;
ax.FontSize = 16; 
[c,hContour]=m_contour(lon,lat,bed,[-800,-1000,-1500,-2000,-2500,-3000],'-k');
m_gshhs_h('patch',[.5 .5 .5]); %usando o pacote de alta resolucao 
hold on;
m_contour(lon,lat,n,[1,1]);
hold on;
m_grid('linewi',2,'tickdir','out');
% m_plot(DSW_lon,DSW_lat,'.','MarkerSize',6,'Color','green');
%title({'Historical Data/ Seal Data'});
pointsize=15;
%ig=find(yr17>=2013);
% m_plot(lon_17(ig),lat_17(ig),'.','LineStyle','none',...
%                        'MarkerEdgeColor',[.75 .75 .75],...
%                        'MarkerFaceColor',[.75 .75 .75],...
%                        'MarkerSize',15)
%m_plot(lon_17,lat_17,'.','LineStyle','none','color',[253 184 99]/255,'MarkerSize',8)
m_plot(lon_17,lat_17,'.','LineStyle','none','color',[1 0.5 0],'MarkerSize',8)
%have to do this to clear bad ones
hold on;
ih=find(x > 90 & x < 96.5);
x=x(ih);
y=y(ih);
S=S(:,ih);
PT=PT(:,ih);
P=P(:,ih);
[r,c]=find(S<34.1 & P>400);
c=unique(c); %162 and 45
len=length(x);
x=[x(1,1:44),x(1,46),x(1,48:132),x(1,134:164),x(1,166:len)];
y=[y(1,1:44),y(1,46),y(1,48:132),y(1,134:164),y(1,166:len)];
S=[S(:,1:44),S(:,46),S(:,48:132),S(:,134:164),S(:,166:len)];
PT=[PT(:,1:44),PT(:,46),PT(:,48:132),PT(:,134:164),PT(:,166:len)];
P=[P(:,1:44),P(:,46),P(:,48:132),P(:,134:164),P(:,166:len)];

%// define a "uniform" grid without holes (same boundaries and sampling than original grid)
[AI,BI] = meshgrid(1,1:10:1001) ;
%have to do this because some values on P are the same. 
tt=linspace(0.0005,0.0007,185)'
s=size(PT);
tt=repmat(tt,1,s(2))
P_tt=P+tt;
%// re-interpolate scattered data (only valid indices) over the "uniform" grid


t_ctd = [];
s_ctd = [];
for i=1:s(2);
    %// identify indices valid for the 3 matrix 
    idxgood=~(isnan(PT(:,i)) | isnan(P_tt(:,i))); 

    %interp s & t 
    t = interp1(P_tt(idxgood,i),PT(idxgood,i),BI);
    sal = interp1(P_tt(idxgood,i),S(idxgood,i),BI);
    t_ctd = [t_ctd t];
    s_ctd = [s_ctd sal];
end


m_scatter(x,y,8,[84 39 136]/255,'filled','markeredgecolor',[84 39 136]/255);
hold on;
[c,hContour]=m_contour(lon,lat,icemask,[1,1],'LineColor'...
    ,'k','LineWidth',1);
m_gshhs_h('Color','k');
xlabel('Longitude')
ylabel('Latitude')

subplot(2,2,4);
%2013
for k=1:si(1);
    fit2=scatter(temp_pot_vcb(k,:),PR_17(k,:),15,[1 0.5 0],'filled');%[253 184 99]/255
    %fit2.MarkerFaceAlpha = .2;
    hold on;
end
plot(nanmean(temp_pot_vcb,2),nanmean(PR_17,2))
si2=size(PT);
%PP=repmat(P,[1,si2(2)]);
%CTD
for k=1:si2(1);
    fit2=scatter(PT(k,:),P(k,:),15,[84 39 136]/255,'filled');
    %fit2.MarkerFaceAlpha = .2;
    hold on;
end
hold on;
ax = gca;
ax.FontSize = 16; 
set(gca,'Ydir','reverse')
xlim([-2,1]);
xlabel('\theta (\circC)')
ylabel('dbar')
% hold on;
plot([-1.92 -1.92],[0 1200],'LineStyle','--','Color','g',...
    'LineWidth',2);
plot([-1.8 -1.8],[0 1200],'LineStyle','--','Color','g',...
    'LineWidth',2);
ylim([0,1200]);
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
g_x=[-2:1:0.3];% user defined grid X [start:spaces:end]
s=xlim;
% for i=1:length(g_x)
%    plot([g_x(i) g_x(i)],[g_y(1) g_y(end)],'k:') %y grid lines
%    hold on    
% end
for i=1:length(g_y)
   plot([g_x(1) s(2)],[g_y(i) g_y(i)],'LineStyle','-','Color',[.8 .8 .8]) %x grid lines
   hold on    
end
hold on;
% %custom legend because the dots are coming out transparent
% h = zeros(2, 1);
% h(1) = scatter(NaN,NaN,15,'k','filled');
% h(2) = scatter(NaN,NaN,15,'r','filled');
% hh=legend(h, 'CTD','seals', ...
%   'location', 'SouthEast');


subplot(2,2,3);
%2013
for k=1:si(1);
    fit2=scatter(SA_17(k,:),PR_17(k,:),15,[1 0.5 0],'filled');%[253 184 99]/255
    %fit2.MarkerFaceAlpha = .2;
    hold on;
end

%CTD
for k=1:si2(1);
    fit2=scatter(S(k,:),P(k,:),15,[84 39 136]/255,'filled');
    %fit2.MarkerFaceAlpha = .2;
    hold on;
end
hold on;
ax = gca;
ax.FontSize = 16; 
set(gca,'Ydir','reverse')
xlim([33,34.8]);
xlabel('Salinity');
ylabel('dbar')
% hold on;
plot([34.4 34.4],[0 1200],'LineStyle','--','Color','g',...
    'LineWidth',2);
ylim([0,1200]);
set(gca, ...
  'Box'         , 'off'     , ...
  'TickDir'     , 'out'     , ...
  'TickLength'  , [.02 .02] , ...
  'XMinorTick'  , 'on'      , ...
  'YMinorTick'  , 'on'      , ...
  'XGrid'       , 'on'      , ...
  'LineWidth'   , 1         );
% gridlines ---------------------------
g_y=[0:100:1200]; % user defined grid Y [start:spaces:end]
g_x=[33.5:0.5:34.5]; % user defined grid X [start:spaces:end]
s=xlim;
% for i=1:length(g_x)
%    plot([g_x(i) g_x(i)],[g_y(1) g_y(end)],'k:') %y grid lines
%    hold on    
% end
for i=1:length(g_y)
   plot([s(1) s(2)],[g_y(i) g_y(i)],'LineStyle','-','Color',[.8 .8 .8]) %x grid lines
   hold on    
end
hold on;
%custom legend because the dots are coming out transparent
%h = zeros(2, 1);
%h(1) = scatter(NaN,NaN,15,'k','filled');
%h(2) = scatter(NaN,NaN,15,'r','filled');
%hh=legend(h, 'CTD','seals', ...
%  'location', 'SouthWest');

saveas(gcf,'fig_fulldatacomparison.png');
print -depsc2 fig_fulldatacomparison.eps

saveas(gcf,'fig_fulldatacomparison_solid.png');
print -depsc2 fig_fulldatacomparison_solid.eps

saveas(gcf,'fig_fulldatacomparison_solid_newcolor.png');
print -depsc2 fig_fulldatacomparison_solid_newcolor.eps

% %%%%%%%%%%%%%%%%%%%%%%%%%%
% teste for the mean profiles
% 
% 
% fig=figure;
% fig.Position = [5 5 1000 500]; 
% hAx=axes;
% pos=get(hAx(1),'position');
% posLeft=pos(1);
% pos(1)=pos(1)*2; pos(3)=pos(3)-pos(1);
% set(hAx(1),'position',pos)
% pos(1)=posLeft; pos(3)=0.01;
% %fixing the graph box
% set(gca, ...
%   'Box'         , 'off'     , ...
%   'TickDir'     , 'out'     , ...
%   'TickLength'  , [.02 .02] , ...
%   'XMinorTick'  , 'on'      , ...
%   'YMinorTick'  , 'on'      , ...
%   'YGrid'       , 'on'      , ...
%   'XGrid'       , 'on'      , ...
%   'LineWidth'   , 1         );
% hold on;
% plot(nanmean(t_seal,2),PR_interp,'blue')
% hold on;
% plot(nanmean(t_seal,2)+nanstd(t_seal,0,2),PR_interp,'b--')
% hold on;
% plot(nanmean(t_seal,2)-nanstd(t_seal,0,2),PR_interp,'b--')
% 
% hold on
% plot(nanmean(t_ctd,2),PR_interp,'red')
% hold on;
% plot(nanmean(t_ctd,2)+nanstd(t_ctd,1,2),PR_interp,'r--')
% hold on;
% plot(nanmean(t_ctd,2)-nanstd(t_ctd,0,2),PR_interp,'r--')
% hold on;
% ax = gca;
% ax.FontSize = 12; 
% set(gca,'Ydir','reverse')
% xlim([-2,1]);
% xlabel('\theta (\circC)')
% ylabel('dbar')
% %ax1.XColor = 'r';
% %ax1.YColor = 'r';
% 
% h_ax = gca;
% h_ax_line = axes('position', get(h_ax, 'position')); 
% hold on;
% plot(nanmean(s_seal,2),PR_interp,'red')
% hold on;
% plot(nanmean(s_seal,2)+nanstd(s_seal,0,2),PR_interp,'r--')
% hold on;
% plot(nanmean(s_seal,2)-nanstd(s_seal,0,2),PR_interp,'r--')
% hold on;
% plot(nanmean(s_ctd,2),PR_interp,'b')
% hold on;
% plot(nanmean(s_ctd,2)+nanstd(s_ctd,0,2),PR_interp,'b--')
% hold on;
% plot(nanmean(s_ctd,2)-nanstd(s_ctd,0,2),PR_interp,'b--')
% %fixing the graph box
% set(gca, ...
%   'Box'         , 'off'     , ...
%   'TickDir'     , 'out'     , ...
%   'TickLength'  , [.02 .02] , ...
%   'XMinorTick'  , 'on'      , ...
%   'YMinorTick'  , 'on'      , ...
%   'YGrid'       , 'on'      , ...
%   'XGrid'       , 'on'      , ...
%   'LineWidth'   , 1         );
% % Put the new axes' y labels on the right, set the x limits the same as the original axes', and make the background transparent
% set(h_ax_line, 'XAxisLocation', 'top', 'YAxisLocation', 'right', 'color', 'none'); 
% ax = gca;
% ax.FontSize = 12; 
% xlim([33,34.8]);
% xlabel('Salinity');
% ylabel('dbar')
% set(gca,'Ydir','reverse')

%%%%%%%%%%%%%%%%%%%%%%%%%
%ISW inset

figure;
for k=1:si(1);
    fit2=scatter(temp_pot_vcb(k,:),PR_17(k,:),15,[1 0.5 0],'filled');%[253 184 99]/255
    %fit2.MarkerFaceAlpha = .5;
    hold on;
end
for k=1:si2(1);
    fit2=scatter(PT(k,:),P(k,:),15,[84 39 136]/255,'filled');
    %fit2.MarkerFaceAlpha = .5;
    hold on;
end
hold on;
ax = gca;
ax.FontSize = 21; 
set(gca,'Ydir','reverse')
xlim([-2,1]);
xlabel('\theta (\circC)')
ylabel('dbar')
% hold on;
plot([-1.92 -1.92],[0 1200],'LineStyle','--','Color','g',...
    'LineWidth',3);
plot([-1.8 -1.8],[0 1200],'LineStyle','--','Color','g',...
    'LineWidth',3);
% set(gca,'color',[0 0 0])
ylim([0,1000]);
xlim([-2,-1.915])
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
g_x=[-2:1:0.3];% user defined grid X [start:spaces:end]
s=xlim;
% for i=1:length(g_x)
%    plot([g_x(i) g_x(i)],[g_y(1) g_y(end)],'k:') %y grid lines
%    hold on    
% end
for i=1:length(g_y)
   plot([g_x(1) s(2)],[g_y(i) g_y(i)],'LineStyle','-','Color',[.8 .8 .8]) %x grid lines
   hold on    
end
hold on;

saveas(gcf,'fig_fulldatacomparison_ISWinset.png');
print -depsc2 fig_fulldatacomparison_ISWinset.eps

saveas(gcf,'fig_fulldatacomparison_ISWinset_solid.png');
print -depsc2 fig_fulldatacomparison_ISWinset_solid.eps

saveas(gcf,'fig_fulldatacomparison_ISWinset_solid_newcolor.png');
print -depsc2 fig_fulldatacomparison_ISWinset_solid_newcolor.eps


%%%%%do the pressured profiles
fig=figure;
fig.Position = [5 5 1000 660]; 

hAx=axes;
pos=get(hAx(1),'position');
posLeft=pos(1);
pos(1)=pos(1)*2; pos(3)=pos(3)-pos(1);
set(hAx(1),'position',pos)
pos(1)=posLeft; pos(3)=0.01;
%fixing the graph box
set(gca, ...
  'Box'         , 'off'     , ...
  'TickDir'     , 'out'     , ...
  'TickLength'  , [.02 .02] , ...
  'XMinorTick'  , 'on'      , ...
  'YMinorTick'  , 'on'      , ...
  'YGrid'       , 'on'      , ...
  'XGrid'       , 'on'      , ...
  'LineWidth'   , 1         );
hold on;
plot(nanmean(t_seal,2),PR_interp,'Color',[1 0.5 0],...
    'linewidth',2)
hold on;
plot(nanmean(t_seal,2)+nanstd(t_seal,0,2),PR_interp,'linestyle','--','Color',[1 0.5 0],...
    'linewidth',2)
hold on;
plot(nanmean(t_seal,2)-nanstd(t_seal,0,2),PR_interp,'linestyle','--','Color',[1 0.5 0],...
    'linewidth',2)
hold on;
plot(nanmean(t_ctd,2),PR_interp,'Color',[84 39 136]/255,...
    'linewidth',2)
hold on;
plot(nanmean(t_ctd,2)+nanstd(t_ctd,0,2),PR_interp,'linestyle','--','Color',[84 39 136]/255,...
    'linewidth',2)
hold on;
plot(nanmean(t_ctd,2)-nanstd(t_ctd,0,2),PR_interp,'linestyle','--','Color',[84 39 136]/255,...
    'linewidth',2)

hold on;
ax = gca;
ax.FontSize = 36; 
set(gca,'Ydir','reverse')
xlim([-2.2,-1]);
ylim([0,1000]);
xlabel('\theta (\circC)')
ylabel('dbar')

saveas(gcf,'pres_prof_seal_mCDWarea_full_comparison.png');
saveas(gcf, 'pres_prof_seal_mCDWarea_full_comparison.eps');
%%ctd


%%%%%do the pressured profiles
fig=figure;
fig.Position = [5 5 1000 660]; 
hAx=axes;
pos=get(hAx(1),'position');
posLeft=pos(1);
pos(1)=pos(1)*2; pos(3)=pos(3)-pos(1);
set(hAx(1),'position',pos)
pos(1)=posLeft; pos(3)=0.01;
%fixing the graph box
set(gca, ...
  'Box'         , 'off'     , ...
  'TickDir'     , 'out'     , ...
  'TickLength'  , [.02 .02] , ...
  'XMinorTick'  , 'on'      , ...
  'YMinorTick'  , 'on'      , ...
  'YGrid'       , 'on'      , ...
  'XGrid'       , 'on'      , ...
  'LineWidth'   , 1         );
hold on;
plot(nanmean(s_seal,2),PR_interp,'Color',[1 0.5 0],...
    'linewidth',2)
hold on;
plot(nanmean(s_seal,2)+nanstd(s_seal,0,2),PR_interp,'linestyle','--','Color',[1 0.5 0],...
    'linewidth',2)
hold on;
plot(nanmean(s_seal,2)-nanstd(s_seal,0,2),PR_interp,'linestyle','--','Color',[1 0.5 0],...
    'linewidth',2)
hold on;
plot(nanmean(s_ctd,2),PR_interp,'Color',[84 39 136]/255,...
    'linewidth',2)
hold on;
plot(nanmean(s_ctd,2)+nanstd(s_ctd,0,2),PR_interp,'linestyle','--','Color',[84 39 136]/255,...
    'linewidth',2)
hold on;
plot(nanmean(s_ctd,2)-nanstd(s_ctd,0,2),PR_interp,'linestyle','--','Color',[84 39 136]/255,...
    'linewidth',2)

hold on;
ax = gca;
ax.FontSize = 36; 
set(gca,'Ydir','reverse')
xlim([33.4,34.6]);
ylim([0,1000]);
xlabel('\theta (\circC)')
ylabel('dbar')

saveas(gcf,'pres_prof_ctd_mCDWarea_full_comparison.png');
saveas(gcf, 'pres_prof_ctd_mCDWarea_full_comparison.eps');




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%------------------------
%all the specific graphs

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%have to do a bit of data comparison because steve requested it

ih=find(x>90 & x<96.5 & yr>=1950 & yr<=1979);
S1=S(:,ih)
P1=P(:,ih)
PT1=PT(:,ih)

x1=x(ih)
y1=y(ih)

s=size(S1);
%tem que refazer isso
max_idb=[];
bt_depth=[];
S_depth=[];
t=S1;
for i=1:s(2);
    a=isnan(t(:,i));
    ii=find(a==0); %achar o ponto maximo que seja numerico.
    if isempty(ii)==0
    MA1=nanmax(ii);
    max_idb=[max_idb,P1(MA1,i)];
    S_depth=[S_depth,S1(MA1,i)];
    else
    max_id=[max_id,nan];    
    S_depth=[S_depth,nan];
    clear MA1 a i
    end
end

[i,j]=find(S_depth<34.5);
idx2=unique(j);
x2=x1(idx2);
y2=y1(idx2); 

[i,j]=find(S_depth>34.5);
idx=unique(j);
x1=x1(idx);
y1=y1(idx);


%%figure
si=size(temp_pot_vcb);
si2=size(PT);
fig=figure;
fig.Position = [5 5 800 600]; 
% [ha, pos] = tight_subplot(2, 4, [0.1 0.05],[.15 .1],[.09 .04])
% axes(ha(1));
subplot(2,2,[1 2])
m_proj('mercator','lon',[87 97],'lat',[-67 -64]);
hold on
ax = gca;
ax.FontSize = 16; 
[c,hContour]=m_contour(lon,lat,bed,[-800,-1000,-1500,-2000,-2500,-3000],'-k');
m_gshhs_h('patch',[.5 .5 .5]); %usando o pacote de alta resolucao 
hold on;
m_contour(lon,lat,n,[1,1]);
hold on;
m_grid('linewi',2,'tickdir','out');
% m_plot(DSW_lon,DSW_lat,'.','MarkerSize',6,'Color','green');
title({'Comparing the "two branches of salty water" on the CTD data'});
pointsize=15;
hold on;
m_scatter(x2,y2,15,'filled','m','markeredgecolor','k');
m_scatter(x1,y1,10,'filled','k','markeredgecolor','k');

%CTD
subplot(2,2,3)
for k=1:si2(1);
    fit2=scatter(PT1(k,idx2),PP1(k,idx2),15,'filled','m');
    fit2.MarkerFaceAlpha = .2;
    hold on;
end
hold on;
for k=1:si2(1);
    fit2=scatter(PT1(k,idx),PP1(k,idx),15,'filled','k');
    fit2.MarkerFaceAlpha = .2;
    hold on;
end
hold on;
set(gca,'Ydir','reverse')
xlim([-2,1]);
xlabel('\theta (\circ)')
ylabel('dbar')
% hold on;
plot([-1.92 -1.92],[0 1200],'LineStyle','--','Color','k',...
    'LineWidth',2);
plot([-1.8 -1.8],[0 1200],'LineStyle','--','Color','k',...
    'LineWidth',2);

subplot(2,2,4)
for k=1:si2(1);
    fit2=scatter(S1(k,idx2),PP1(k,idx2),15,'filled','m');
    fit2.MarkerFaceAlpha = .2;
    hold on;
end
hold on; 
for k=1:si2(1);
    fit2=scatter(S1(k,idx),PP1(k,idx),15,'filled','k');
    fit2.MarkerFaceAlpha = .2;
    hold on;
end
set(gca,'Ydir','reverse')
xlim([33,34.8]);
xlabel('Salinity');
% hold on;
plot([34.5 34.5],[0 1200],'LineStyle','--','Color','k',...
    'LineWidth',2);
plot([34.4 34.4],[0 1200],'LineStyle','--','Color','k',...
    'LineWidth',2);

saveas(gcf,'fig_comparison2branchesS.png');
print -depsc2 fig_comparison2branchesS.eps

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%have to find the very fresh profile to show steve
        ih=find(x>90 & x<96.5 & yr>=1950 & yr<=1979);
        S1=S(:,ih)
        P1=P(:,ih)
        PT1=PT(:,ih)
        x1=x(ih);
        y1=y(ih);
        yr1=yr(ih);
        %make the warm profile of CTD
        [r,c]=find(S1>34 & S1<34.1 & P1>=400 & P1<=420);
        figure
        hold on;
        %plot(S1(:,43),P1(:,43),'or','Linewidth',1.5)
        plot(S1(:,45),P1(:,45),'ok','Linewidth',1.5)
        plot(S1(:,162),P1(:,162),'ob','Linewidth',1.5)
        yr1(c)
        x1(c)
        y1(c)   
        
        figure;
        ax1=subplot(1,2,1)
        plot(S1(:,162),P1(:,162),'r','Linewidth',1.5)
        hold on;
        plot(S1(:,162),P1(:,162),'r.','MarkerSize',20)
        hold on;
        plot(S1(:,45),P1(:,45),'k','Linewidth',1)
        hold on;
        plot(S1(:,45),P1(:,45),'k.','MarkerSize',15)
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
        g_x=[33.4:1:35.4];% user defined grid X [start:spaces:end]
        s=xlim;
        % for i=1:length(g_x)
        %    plot([g_x(i) g_x(i)],[g_y(1) g_y(end)],'k:') %y grid lines
        %    hold on
        % end
        for i=1:length(g_y)
            plot([g_x(1) g_x(3)],[g_y(i) g_y(i)],'LineStyle','-','Color',[.8 .8 .8]) %x grid lines
            hold on
        end
       ylim([0 600])
       xlim([33.4 34.6])
       text(33.6,520,'65.85\circS/93.00\circE','Color','r')
       text(33.6,550,'65.87\circS/94.23\circE','Color','k')
       sgtitle('year: 1966');
       
        ax2=subplot(1,2,2)
        plot(PT1(:,162),P1(:,162),'r','Linewidth',1.5)
        hold on;
        plot(PT1(:,162),P1(:,162),'r.','MarkerSize',20)
        hold on;
        plot(PT1(:,45),P1(:,45),'k','Linewidth',1)
        hold on;
        plot(PT1(:,45),P1(:,45),'k.','MarkerSize',15)
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
       ylim([0 600])
       
       
       saveas(gcf,'fig_freshCTDprof.png');
       saveas(gcf, 'fig_freshCTDprof.eps');