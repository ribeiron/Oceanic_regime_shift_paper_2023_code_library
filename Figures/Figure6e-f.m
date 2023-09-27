%Profiles for time series fig. 


%%new time series figure with all plots, changes etc. 
%variables first 

% cmap =
% 
%     0.1630    0.0952    0.4226
%     0.1254    0.4312    0.5438
%     0.3510    0.7266    0.4708
%     0.9941    0.9367    0.6027
% 
addpath 'C:\Users\nribeiro\Desktop\Seal Data\matlab_tools\TOOLBOX\tight_subplot'
addpath 'C:\Users\nribeiro\Desktop\Seal Data\matlab_tools\TOOLBOX\suplabel'
addpath 'C:\Users\nribeiro\Desktop\Seal Data\matlab_tools\TOOLBOX\cmocean' 

clear all
load ShackCTD_data_coast_no_interp.mat
load massa_dagua_index_ShackCTD_data_coast_no_interp

%mCDW first
%box them
ig=find(y>=-66 & y<=-65 & x>=94 & x<=96)

S=S(:,ig);
GA=GA(:,ig);
PT=PT(:,ig);
P=P(:,ig);
y=y(:,ig);
x=x(:,ig);
yr=yr(:,ig);
index=index(:,ig);
mth=month(:,ig);

%%DO interpolation for mean profiles before sorting
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


%sort scatter values so salty values come on top
n=isnan(S);
nn=find(n==0);
[S,c]=sort(S(nn))
PT=PT(nn);PT=PT(c);
P=P(nn);P=P(c);

%mcdw
%seal
%%figs with map + Vertical T + Vertical S + TS
load West_Shack_VB_Totten_triado_coast.mat
load  massa_dagua_index_coast_d

%%seal west
ig=find(lat_vcb>=-66 & lat_vcb<=-65 & lon_vcb>=94 & lon_vcb<=96)
% 
Sb=sal_adj_vcb(:,ig);
GAb=ND_vcb(:,ig);
PTb=temp_adj_vcb(:,ig);
Pb=pres_adj_vcb(:,ig);
yb=lat_vcb(:,ig);
xb=lon_vcb(:,ig);
yrb=yr_vcb(:,ig);
indexb=index(:,ig);
mthb=mth_vcb(:,ig);

%% mean profiles do before sorting
%// define a "uniform" grid without holes (same boundaries and sampling than original grid)
[AI,BI] = meshgrid(1,1:10:1001) ;
s=size(PTb);
PR_interp=repmat(BI,1,s(2))
%// re-interpolate scattered data (only valid indices) over the "uniform" grid


t_seal = [];
s_seal = [];
for i=1:s(2);
    %// identify indices valid for the 3 matrix 
    idxgood=~(isnan(PTb(:,i)) | isnan(Pb(:,i))); 

    %interp s & t 
    t = interp1(Pb(idxgood,i),PTb(idxgood,i),BI);
    sal = interp1(Pb(idxgood,i),Sb(idxgood,i),BI);
    t_seal = [t_seal t];
    s_seal = [s_seal sal];
end

%sort so salty values come on top
n=isnan(Sb);
nn=find(n==0);
[Sb,c]=sort(Sb(nn));
PTb=PTb(nn);PTb=PTb(c);
Pb=Pb(nn);Pb=Pb(c);

%crate new map for laura
cmap1=[[179 88 6]/255;...
    [224 130 20]/255;...
    [253 184 99]/255;...
    [254 224 182]/255;...
    [216 218 235]/255;...
    [153 142 195]/255;...
    [84 39 136]/255]

cmap2=cmocean('haline',7);

yaki1=[255,255,217;...
    127,205,187;...
    29,145,192;...
    34,94,168;...
    37,52,148;...
    8,29,88;...
    129,15,124]

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

cmap=yaki1

si=size(PT);
figure;
[ha, pos] = tight_subplot(1, 2, [0.1 0.01],[.15 .1],[.09 .06])
axes(ha(1));
fit2=scatter(PT,P,15,S,'filled');
%cmap=cmocean('haline',7)
colormap(flipud(cmap))
h=colorbar
caxis([34 34.7]);
t=get(h,'Limits');   %Azzi Abdelmalek contribution. Great Matalab answers contributor
T=linspace(t(1),t(2),8)
set(h,'Ticks',T)
TL=arrayfun(@(x) sprintf('%.2f',x),T,'un',0)
set(h,'TickLabels',TL)
ylabel(h, 'S', 'FontSize',14)

hold on;
ax = gca;
ax.FontSize = 18; 
set(gca,'Ydir','reverse')
xlim([-2,0.3]);
hold on;
plot([-1.92 -1.92],[0 1200],'LineStyle','--','Color','k',...
    'LineWidth',2);
plot([-1.8 -1.8],[0 1200],'LineStyle','--','Color','k',...
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
text(10,-1.99,'a','Fontsize',8);
text(10,-1.79,'b','Fontsize',8);
title('Historical Data (65-66\circS; 94-96\circE)')
ylabel('(dbar)');
xlabel('\theta (\circC)')
set(colorbar,'visible','off') %to keep both plots with same size


axes(ha(2));
fit2=scatter(PTb,Pb,15,Sb,'filled');
h=colorbar
caxis([34 34.7]);
t=get(h,'Limits');   %Azzi Abdelmalek contribution. Great Matalab answers contributor
T=linspace(t(1),t(2),8)
set(h,'Ticks',T)
TL=arrayfun(@(x) sprintf('%.2f',x),T,'un',0)
set(h,'TickLabels',TL)
ylabel(h, 'S', 'FontSize',18)

hold on;
set(gca,'Ydir','reverse')
h = gca; h.YAxis.Visible = 'off'; h.FontSize = 18; 
xlim([-2,0.3]);
ylim([0,1200]);
hold on;
plot([-1.92 -1.92],[0 1200],'LineStyle','--','Color','k',...
    'LineWidth',2);
plot([-1.8 -1.8],[0 1200],'LineStyle','--','Color','k',...
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
hold on;
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
title('Seals (65-66\circS; 94-96\circE)')
ylabel('(dbar)');
xlabel('\theta (\circC)')

print('fig_timeseriesmPLOTS_a','-dpng','-r600')
saveas(gcf, 'fig_timeseriesmPLOTS_a.eps');


fig=figure;
fig.Position = [5 5 1000 500]; 
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
plot(nanmean(t_seal,2),PR_interp,'Color',[230,97,1]/256,...
    'linewidth',2)
hold on;
plot(nanmean(t_seal,2)+nanstd(t_seal,0,2),PR_interp,'linestyle','--','Color',[230,97,1]/256,...
    'linewidth',2)
hold on;
plot(nanmean(t_seal,2)-nanstd(t_seal,0,2),PR_interp,'linestyle','--','Color',[230,97,1]/256,...
    'linewidth',2)

hold on;
ax = gca;
ax.FontSize = 16; 
set(gca,'Ydir','reverse')
xlim([-2.2,-1]);
ylim([0,1000]);
xlabel('\theta (\circC)')
ylabel('Pressure (dbar)')
ax.XAxis(1).Color = [230,97,1]/256;
%ax1.XColor = 'r';
%ax1.YColor = 'r';

h_ax = gca;
h_ax_line = axes('position', get(h_ax, 'position')); 
hold on;
plot(nanmean(s_seal,2),PR_interp,'Color',[94,60,153]/256,...
    'linewidth',2)
hold on;
plot(nanmean(s_seal,2)+nanstd(s_seal,0,2),PR_interp,'linestyle','--','Color',[94,60,153]/256,...
    'linewidth',2)
hold on;
plot(nanmean(s_seal,2)-nanstd(s_seal,0,2),PR_interp,'linestyle','--','Color',[94,60,153]/256,...
    'linewidth',2)
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
% Put the new axes' y labels on the right, set the x limits the same as the original axes', and make the background transparent
set(h_ax_line, 'XAxisLocation', 'top', 'YAxisLocation', 'right', 'color', 'none'); 
ax = gca;
ax.FontSize = 16; 
xlim([33.4,34.6]);
ylim([0,1000]);
xlabel('Salinity');
ylabel('Pressure (dbar)')
set(gca,'Ydir','reverse')
ax.XAxis(1).Color = [94,60,153]/256;
ax.YAxis.Visible = 'off';

saveas(gcf,'pres_prof_seal_mCDWarea.png');
saveas(gcf, 'pres_prof_seal_mCDWarea.eps');
%%ctd

fig=figure;
fig.Position = [5 5 1000 500]; 
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
plot(nanmean(t_ctd,2),PR_interp,'Color',[230,97,1]/256,...
    'linewidth',2)
hold on;
plot(nanmean(t_ctd,2)+nanstd(t_ctd,0,2),PR_interp,'linestyle','--','Color',[230,97,1]/256,...
    'linewidth',2)
hold on;
plot(nanmean(t_ctd,2)-nanstd(t_ctd,0,2),PR_interp,'linestyle','--','Color',[230,97,1]/256,...
    'linewidth',2)

hold on;
ax = gca;
ax.FontSize = 16; 
set(gca,'Ydir','reverse')
xlim([-2.2,-1]);
ylim([0,1000]);
xlabel('\theta (\circC)')
ylabel('Pressure (dbar)')
ax.XAxis(1).Color = [230,97,1]/256;
%ax1.XColor = 'r';
%ax1.YColor = 'r';

h_ax = gca;
h_ax_line = axes('position', get(h_ax, 'position')); 
hold on;
plot(nanmean(s_ctd,2),PR_interp,'Color',[94,60,153]/256,...
    'linewidth',2)
hold on;
plot(nanmean(s_ctd,2)+nanstd(s_ctd,0,2),PR_interp,'linestyle','--',...
    'linewidth',2,'Color',[94,60,153]/256)
hold on;
plot(nanmean(s_ctd,2)-nanstd(s_ctd,0,2),PR_interp,'linestyle','--','Color',[94,60,153]/256,...
    'linewidth',2)
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
% Put the new axes' y labels on the right, set the x limits the same as the original axes', and make the background transparent
set(h_ax_line, 'XAxisLocation', 'top', 'YAxisLocation', 'right', 'color', 'none'); 
ax = gca;
ax.FontSize = 16; 
xlim([33.4,34.6]);
xlabel('Salinity');
ylabel('Pressure (dbar)')
set(gca,'Ydir','reverse')
ax.XAxis(1).Color = [94,60,153]/256;
ax.YAxis.Visible = 'off';

saveas(gcf,'pres_prof_ctd_mCDWarea.png');
saveas(gcf, 'pres_prof_ctd_mCDWarea.eps');


% %do for salt
% si=size(PTb);
% figure;
% [ha, pos] = tight_subplot(1, 2, [0.1 0.03],[.15 .1],[.09 .04])
% axes(ha(1));
% for k=1:si(1);
%     fit2=scatter(S(k,:),P(k,:),15,PT(k,:),'filled');
%     %fit2.MarkerFaceAlpha = .2;
%     hold on;
% end
% cmap=cmocean('thermal',4)
% colormap(cmap)
% h=colorbar
% t=get(h,'Limits');   %Azzi Abdelmalek contribution. Great Matalab answers contributor
% T=linspace(t(1),t(2),5)
% set(h,'Ticks',T)
% TL=arrayfun(@(x) sprintf('%.2f',x),T,'un',0)
% set(h,'TickLabels',TL)
% ylabel(h, '\theta (\circC)', 'FontSize',14)
% 
% set(gca,'Ydir','reverse')
% h = gca; h.YAxis.Visible = 'off'; h.FontSize = 18; 
% %xlim([33.3,34.8]);
% hold on;
% plot([34.4 34.4],[0 1200],'LineStyle','--','Color','k',...
%     'LineWidth',2);
% ylim([0,1200]);
% set(gca, ...
%   'Box'         , 'off'     , ...
%   'TickDir'     , 'out'     , ...
%   'TickLength'  , [.02 .02] , ...
%   'XMinorTick'  , 'on'      , ...
%   'YMinorTick'  , 'on'      , ...
%   'XGrid'       , 'on'      , ...
%   'LineWidth'   , 1         );
% hold on;
% % gridlines ---------------------------
% g_y=[0:100:1200]; % user defined grid Y [start:spaces:end]
% g_x=[33.5:0.5:34.5]; % user defined grid X [start:spaces:end]
% s=xlim;
% % for i=1:length(g_x)
% %    plot([g_x(i) g_x(i)],[g_y(1) g_y(end)],'k:') %y grid lines
% %    hold on    
% % end
% for i=1:length(g_y)
%    plot([s(1) s(2)],[g_y(i) g_y(i)],'LineStyle','-','Color',[.8 .8 .8]) %x grid lines
%    hold on    
% end
% 
% title('Historial Data (65-66\circS; 93-96\circE)')
% ylabel('(dbar)');
% xlabel('S')
% set(colorbar,'visible','off')
% 
% axes(ha(2));
% for k=1:si(1);
%     fit2=scatter(Sb(k,:),Pb(k,:),15,PTb(k,:),'filled');
%     fit2.MarkerFaceAlpha = .2;
%     hold on;
% end
% cmap=cmocean('thermal',4)
% colormap(cmap)
% h=colorbar
% caxis([-2,0.7])
% t=get(h,'Limits');   %Azzi Abdelmalek contribution. Great Matalab answers contributor
% T=linspace(t(1),t(2),5)
% set(h,'Ticks',T)
% TL=arrayfun(@(x) sprintf('%.2f',x),T,'un',0)
% set(h,'TickLabels',TL)
% ylabel(h, '\theta (\circC)', 'FontSize',14)
% 
% set(gca,'Ydir','reverse')
% h = gca; h.YAxis.Visible = 'off'; h.FontSize = 18; 
% %xlim([33.3,34.8]);
% hold on;
% plot([34.4 34.4],[0 1200],'LineStyle','--','Color','k',...
%     'LineWidth',2);
% ylim([0,1200]);
% set(gca, ...
%   'Box'         , 'off'     , ...
%   'TickDir'     , 'out'     , ...
%   'TickLength'  , [.02 .02] , ...
%   'XMinorTick'  , 'on'      , ...
%   'YMinorTick'  , 'on'      , ...
%   'XGrid'       , 'on'      , ...
%   'LineWidth'   , 1         );
% hold on;
% % gridlines ---------------------------
% g_y=[0:100:1200]; % user defined grid Y [start:spaces:end]
% g_x=[33.5:0.5:34.5]; % user defined grid X [start:spaces:end]
% s=xlim;
% % for i=1:length(g_x)
% %    plot([g_x(i) g_x(i)],[g_y(1) g_y(end)],'k:') %y grid lines
% %    hold on    
% % end
% for i=1:length(g_y)
%    plot([s(1) s(2)],[g_y(i) g_y(i)],'LineStyle','-','Color',[.8 .8 .8]) %x grid lines
%    hold on    
% end
% 
% title('Historial Data (65-66\circS; 93-96\circE)')
% ylabel('(dbar)');
% xlabel('S')
% 
