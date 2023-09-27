%%laura 2 vertical plots together
addpath 'C:\Users\nribeiro\Desktop\Seal Data\matlab_tools\TOOLBOX\tight_subplot'
addpath 'C:\Users\nribeiro\Desktop\Seal Data\matlab_tools\TOOLBOX\suplabel'

%catching dates and sorting matrix
clear all
%cd 'D:\Chapter 2'
load West_Shack_VB_Totten_triado_coast.mat

yaki1=[255,255,217;...
    127,205,187;...
    29,145,192;...
    34,94,168;...
    37,52,148;...
    8,29,88;...
    129,15,124]

yaki1=yaki1/256;

% Number of colors in the blended colorbar
%%umColors = 256;
%% Create a vector of indices for the base colors
%indices = linspace(1, size(yaki2, 1), numColors);
%% Interpolate the colors
%blended_yaki = interp1(1:size(yaki2, 1), yaki2, indices, 'linear');

%Shackleton West
ie=find(lon_vcb(1,:) >= 90 & lon_vcb(1,:) <= 96.5 & yr_vcb==2014);

%create a different sec matrix if you still find repeated date
% B=repmat(1:59,[1 100]); 
% sec17=B(1,1:length(ie));

yr17=yr_vcb(1,ie);
mth17=mth_vcb(1,ie);
day17=day_vcb(1,ie);
hr17=hr_vcb(1,ie);
mi17=mi_vcb(1,ie);
sec17=sec_vcb(1,ie);


SA_17=sal_adj_vcb(:,ie);%SA_17=SA_17(:,s_17);
ND_17=ND_vcb(:,ie);%ND_17=ND_17(:,s_17);
temp_pot_vcb=temp_pot_vcb(:,ie);%temp_pot_vcb=temp_pot_vcb(:,s_17);
PR_17=pres_adj_vcb(:,ie);%PR_17=PR_17(:,s_17);
lat_17=lat_vcb(:,ie);%lat_17=lat_17(:,s_17);
lon_17=lon_vcb(:,ie);%lon_17=lon_17(:,s_17);


%for the reviwer
num_prof=[];
for i=1:4
a=find(mth17==i);
aa=size(a);
num_prof=[num_prof,aa(2)];
end

%have to this to be able to sort
mth_sort=repmat(mth17,30,1)


%sort so salty values come on top
n=isnan(SA_17);
nn=find(n==0);
[SA_17,c]=sort(SA_17(nn));
PR_17=PR_17(nn);PR_17=PR_17(c);
temp_pot_vcb=temp_pot_vcb(nn);temp_pot_vcb=temp_pot_vcb(c);
mth_sort=mth_sort(nn);mth_sort=mth_sort(c);


a=size(temp_pot_vcb)
%%FIG 1 temp: 2014 JAN-APR
figure;
[ha, pos] = tight_subplot(2, 4, [0.1 -0.02],[.1 .1],[.1 .03])
%subplot(2,2,1);

axes(ha(1));
%subplot(2,2,1);
i=find(mth_sort==1);%fev
fit2=scatter(temp_pot_vcb(i),PR_17(i),15,SA_17(i),'filled');
% for k=1:a(1);
%     fit2=scatter(temp_pot_vcb(k,i),pres_vcb(k,i),15,SA_17(k,i),'filled');
%     fit2.MarkerFaceAlpha = .2;
%     hold on;
% end
hold on;
ax = gca;
ax.FontSize = 14; 
set(gca,'Ydir','reverse')
xlim([-2,-0.5]);
set(gca, ...
  'Box'         , 'off'     , ...
  'TickDir'     , 'out'     , ...
  'TickLength'  , [.02 .02] , ...
  'XMinorTick'  , 'on'      , ...
  'YMinorTick'  , 'on'      , ...
  'XGrid'       , 'on'      , ...
  'LineWidth'   , 1         );
hold on;
ylabel('Pressure (dbar)');
cmap=yaki1
colormap(flipud(cmap))
h=colorbar
caxis([34 34.7]);
t=get(h,'Limits');   %Azzi Abdelmalek contribution. Great Matalab answers contributor
T=linspace(t(1),t(2),8)
set(h,'Ticks',T)
TL=arrayfun(@(x) sprintf('%.2f',x),T,'un',0)
set(h,'TickLabels',TL)
set(h,'visible','off')

% gridlines ---------------------------
hold on
g_y=[0:100:1000]; % user defined grid Y [start:spaces:end]
g_x=[-2:1:-0.5]; % user defined grid X [start:spaces:end]
s=xlim;
% for i=1:length(g_x)
%    plot([g_x(i) g_x(i)],[g_y(1) g_y(end)],'k:') %y grid lines
%    hold on    
% end
for i=1:length(g_y)
   plot([g_x(1) s(2)],[g_y(i) g_y(i)],'LineStyle','-','Color',[.8 .8 .8]) %x grid lines
   hold on    
end
title('Jan') 
line([-1.8 -1.8],[0 1000],'LineStyle','--','LineWidth',1.5,'Color','k')
line([-1.92 -1.92],[0 1000],'LineStyle','--','LineWidth',1.5,'Color','k')

ylabel(sprintf('Biologging Data (2014)\nPressure (dbar)'));
xlabel('\theta (\circC)')


hold on;
axes(ha(2));
i=find(mth_sort==2);%fev
fit2=scatter(temp_pot_vcb(i),PR_17(i),15,SA_17(i),'filled');
% for k=1:a(1);
%     fit2=scatter(temp_pot_vcb(k,i),pres_vcb(k,i),15,SA_17(k,i),'filled');
%     %fit2.MarkerFaceAlpha = .2;
%     hold on;
% end
hold on;
ax = gca;
ax.FontSize = 14; 
set(gca,'Ydir','reverse')
xlim([-2,-0.5]);
set(gca, ...
  'Box'         , 'off'     , ...
  'TickDir'     , 'out'     , ...
  'TickLength'  , [.02 .02] , ...
  'XMinorTick'  , 'on'      , ...
  'YMinorTick'  , 'on'      , ...
  'XGrid'       , 'on'      , ...
  'LineWidth'   , 1         );
hold on;
ylabel('Pressure (dbar)');
cmap=yaki1
colormap(flipud(cmap))
h=colorbar
caxis([34 34.7]);
t=get(h,'Limits');   %Azzi Abdelmalek contribution. Great Matalab answers contributor
T=linspace(t(1),t(2),8)
set(h,'Ticks',T)
TL=arrayfun(@(x) sprintf('%.2f',x),T,'un',0)
set(h,'TickLabels',TL)
ylabel(h, 'S', 'FontSize',14)
set(h,'visible','off')
h = gca; h.YAxis.Visible = 'off'; h.FontSize = 14; 
% gridlines ---------------------------
hold on
g_y=[0:100:1000]; % user defined grid Y [start:spaces:end]
g_x=[-2:1:-0.5]; % user defined grid X [start:spaces:end]
s=xlim;
% for i=1:length(g_x)
%    plot([g_x(i) g_x(i)],[g_y(1) g_y(end)],'k:') %y grid lines
%    hold on    
% end
for i=1:length(g_y)
   plot([g_x(1) s(2)],[g_y(i) g_y(i)],'LineStyle','-','Color',[.8 .8 .8]) %x grid lines
   hold on    
end
title('Feb')
line([-1.8 -1.8],[0 1000],'LineStyle','--','LineWidth',1.5,'Color','k')
line([-1.92 -1.92],[0 1000],'LineStyle','--','LineWidth',1.5,'Color','k')


hold on;
axes(ha(3));
%subplot(2,2,2);
i=find(mth_sort==3);%mar
fit2=scatter(temp_pot_vcb(i),PR_17(i),15,SA_17(i),'filled');
% for k=1:a(1);
%     fit2=scatter(temp_pot_vcb(k,i),pres_vcb(k,i),15,SA_17(k,i),'filled');
%     %fit2.MarkerFaceAlpha = .2;
%     hold on;
% end
hold on;
ax = gca;
ax.FontSize = 14; 
set(gca,'Ydir','reverse')
cmap=yaki1
colormap(flipud(cmap))
h=colorbar
caxis([34 34.7]);
t=get(h,'Limits');   %Azzi Abdelmalek contribution. Great Matalab answers contributor
T=linspace(t(1),t(2),8)
set(h,'Ticks',T)
TL=arrayfun(@(x) sprintf('%.2f',x),T,'un',0)
set(h,'TickLabels',TL)
set(h,'visible','off')
h = gca; h.YAxis.Visible = 'off'; h.FontSize = 14; 
xlim([-2,-0.5]);
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
g_y=[0:100:1000]; % user defined grid Y [start:spaces:end]
g_x=[-2:1:0.3]; % user defined grid X [start:spaces:end]
s=xlim;
% for i=1:length(g_x)
%    plot([g_x(i) g_x(i)],[g_y(1) g_y(end)],'k:') %y grid lines
%    hold on    
% end
ylim([0,1000])
for i=1:length(g_y)
   plot([g_x(1) s(2)],[g_y(i) g_y(i)],'LineStyle','-','Color',[.8 .8 .8]) %x grid lines
   hold on    
end
title('Mar')
line([-1.8 -1.8],[0 1000],'LineStyle','--','LineWidth',1.5,'Color','k')
line([-1.92 -1.92],[0 1000],'LineStyle','--','LineWidth',1.5,'Color','k')

axes(ha(4));
i=find(mth_sort==4);%apr
fit2=scatter(temp_pot_vcb(i),PR_17(i),15,SA_17(i),'filled');
% for k=1:a(1);
%     fit5=scatter(temp_pot_vcb(k,i),pres_vcb(k,i),15,SA_17(k,i),'filled');
%     %fit5.MarkerFaceAlpha = .2;
%     hold on;
% end
hold on;
set(gca,'Ydir','reverse')
cmap=yaki1
colormap(flipud(cmap))
h=colorbar
caxis([34 34.7]);
t=get(h,'Limits');   %Azzi Abdelmalek contribution. Great Matalab answers contributor
T=linspace(t(1),t(2),8)
set(h,'Ticks',T)
TL=arrayfun(@(x) sprintf('%.2f',x),T,'un',0)
set(h,'TickLabels',TL)
ylabel(h, 'S', 'FontSize',14)
set(h,'visible','off')
h = gca; h.YAxis.Visible = 'off'; h.FontSize = 14; 
xlim([-2,-0.5]);
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
g_y=[0:100:1000]; % user defined grid Y [start:spaces:end]
g_x=[-2:1:0.3]; % user defined grid X [start:spaces:end]
s=xlim;
% for i=1:length(g_x)
%    plot([g_x(i) g_x(i)],[g_y(1) g_y(end)],'k:') %y grid lines
%    hold on    
% end
for i=1:length(g_y)
   plot([g_x(1) s(2)],[g_y(i) g_y(i)],'LineStyle','-','Color',[.8 .8 .8]) %x grid lines
   hold on    
end
title('Apr')
line([-1.8 -1.8],[0 1000],'LineStyle','--','LineWidth',1.5,'Color','k')
line([-1.92 -1.92],[0 1000],'LineStyle','--','LineWidth',1.5,'Color','k')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% historical
%cd 'D:\Chapter 2'
load ShackCTD_data_coast_no_interp.mat

ie=find(x(1,:) >= 90 & x(1,:) <= 96.5 & yr==1966);

yr18=yr(1,ie);
mth18=month(1,ie);

SA_18=S(:,ie);%SA_17=SA_17(:,s_17);
ND_18=GA(:,ie);%ND_17=ND_17(:,s_17);
temp_pot_vcb18=PT(:,ie);%temp_pot_vcb=temp_pot_vcb(:,s_17);
PR_18=P(:,ie);%PR_17=PR_17(:,s_17);
lat_18=y(:,ie);%lat_17=lat_17(:,s_17);
lon_18=x(:,ie);%lon_17=lon_17(:,s_17);

%for the reviwer
num_prof=[];
for i=2:4
a=find(mth18==i);
aa=size(a);
num_prof=[num_prof,aa(2)];
end


%have to this to be able to sort
mth_sort18=repmat(mth18,185,1)


%sort so salty values come on top
n=isnan(SA_18);
nn=find(n==0);
[SA_18,c]=sort(SA_18(nn));
PR_18=PR_18(nn);PR_18=PR_18(c);
temp_pot_vcb18=temp_pot_vcb18(nn);temp_pot_vcb18=temp_pot_vcb18(c);
mth_sort18=mth_sort18(nn);mth_sort18=mth_sort18(c);

a=size(temp_pot_vcb18)

hold on;
axes(ha(5))
h = gca; 
set(h,'visible','off')

hold on;
axes(ha(6));
i=find(mth_sort18==2);%fev
fit2=scatter(temp_pot_vcb18(i),PR_18(i),15,SA_18(i),'filled');
% for k=1:a(1);
%     fit2=scatter(temp_pot_vcb(k,i),pres_vcb(k,i),15,SA_17(k,i),'filled');
%     %fit2.MarkerFaceAlpha = .2;
%     hold on;
% end
hold on;
ax = gca;
ax.FontSize = 14; 
set(gca,'Ydir','reverse')
xlim([-2,-0.5]);
set(gca, ...
  'Box'         , 'off'     , ...
  'TickDir'     , 'out'     , ...
  'TickLength'  , [.02 .02] , ...
  'XMinorTick'  , 'on'      , ...
  'YMinorTick'  , 'on'      , ...
  'XGrid'       , 'on'      , ...
  'LineWidth'   , 1         );
hold on;
ylabel('Pressure (dbar)');
cmap=yaki1
colormap(flipud(cmap))
h=colorbar
caxis([34 34.7]);
t=get(h,'Limits');   %Azzi Abdelmalek contribution. Great Matalab answers contributor
T=linspace(t(1),t(2),8)
set(h,'Ticks',T)
TL=arrayfun(@(x) sprintf('%.2f',x),T,'un',0)
set(h,'TickLabels',TL)
ylabel(h, 'S', 'FontSize',14)
set(h,'visible','off')
%h = gca; h.YAxis.Visible = 'off'; h.FontSize = 14; 
% gridlines ---------------------------
hold on
g_y=[0:100:1000]; % user defined grid Y [start:spaces:end]
g_x=[-2:1:-0.5]; % user defined grid X [start:spaces:end]
s=xlim;
% for i=1:length(g_x)
%    plot([g_x(i) g_x(i)],[g_y(1) g_y(end)],'k:') %y grid lines
%    hold on    
% end
for i=1:length(g_y)
   plot([g_x(1) s(2)],[g_y(i) g_y(i)],'LineStyle','-','Color',[.8 .8 .8]) %x grid lines
   hold on    
end
%title('Feb')
line([-1.8 -1.8],[0 1000],'LineStyle','--','LineWidth',1.5,'Color','k')
line([-1.92 -1.92],[0 1000],'LineStyle','--','LineWidth',1.5,'Color','k')

ylabel(sprintf('Historical Data (1966)\nPressure (dbar)'));
xlabel('\theta (\circC)')


hold on;
axes(ha(7));
%subplot(2,2,2);
i=find(mth_sort18==3);%mar
fit2=scatter(temp_pot_vcb18(i),PR_18(i),15,SA_18(i),'filled');
% for k=1:a(1);
%     fit2=scatter(temp_pot_vcb(k,i),pres_vcb(k,i),15,SA_17(k,i),'filled');
%     %fit2.MarkerFaceAlpha = .2;
%     hold on;
% end
hold on;
ax = gca;
ax.FontSize = 14; 
set(gca,'Ydir','reverse')
cmap=yaki1
colormap(flipud(cmap))
h=colorbar
caxis([34 34.7]);
t=get(h,'Limits');   %Azzi Abdelmalek contribution. Great Matalab answers contributor
T=linspace(t(1),t(2),8)
set(h,'Ticks',T)
TL=arrayfun(@(x) sprintf('%.2f',x),T,'un',0)
set(h,'TickLabels',TL)
set(h,'visible','off')
h = gca; h.YAxis.Visible = 'off'; h.FontSize = 14; 
xlim([-2,-0.5]);
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
g_y=[0:100:1000]; % user defined grid Y [start:spaces:end]
g_x=[-2:1:0.3]; % user defined grid X [start:spaces:end]
s=xlim;
% for i=1:length(g_x)
%    plot([g_x(i) g_x(i)],[g_y(1) g_y(end)],'k:') %y grid lines
%    hold on    
% end
ylim([0,1000])
for i=1:length(g_y)
   plot([g_x(1) s(2)],[g_y(i) g_y(i)],'LineStyle','-','Color',[.8 .8 .8]) %x grid lines
   hold on    
end
%title('Mar')
line([-1.8 -1.8],[0 1000],'LineStyle','--','LineWidth',1.5,'Color','k')
line([-1.92 -1.92],[0 1000],'LineStyle','--','LineWidth',1.5,'Color','k')

xlabel('\theta (\circC)')

axes(ha(8));
i=find(mth_sort18==4);%apr
fit2=scatter(temp_pot_vcb18(i),PR_18(i),15,SA_18(i),'filled');
% for k=1:a(1);
%     fit5=scatter(temp_pot_vcb(k,i),pres_vcb(k,i),15,SA_17(k,i),'filled');
%     %fit5.MarkerFaceAlpha = .2;
%     hold on;
% end
hold on;
set(gca,'Ydir','reverse')
cmap=yaki1
colormap(flipud(cmap))
h=colorbar
caxis([34 34.7]);
t=get(h,'Limits');   %Azzi Abdelmalek contribution. Great Matalab answers contributor
T=linspace(t(1),t(2),8)
set(h,'Ticks',T)
TL=arrayfun(@(x) sprintf('%.2f',x),T,'un',0)
set(h,'TickLabels',TL)
ylabel(h, 'S', 'FontSize',14)
set(h,'visible','off')
h = gca; h.YAxis.Visible = 'off'; h.FontSize = 14; 
xlim([-2,-0.5]);
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
g_y=[0:100:1000]; % user defined grid Y [start:spaces:end]
g_x=[-2:1:0.3]; % user defined grid X [start:spaces:end]
s=xlim;
% for i=1:length(g_x)
%    plot([g_x(i) g_x(i)],[g_y(1) g_y(end)],'k:') %y grid lines
%    hold on    
% end
for i=1:length(g_y)
   plot([g_x(1) s(2)],[g_y(i) g_y(i)],'LineStyle','-','Color',[.8 .8 .8]) %x grid lines
   hold on    
end
%title('Apr')
line([-1.8 -1.8],[0 1000],'LineStyle','--','LineWidth',1.5,'Color','k')
line([-1.92 -1.92],[0 1000],'LineStyle','--','LineWidth',1.5,'Color','k')

xlabel('\theta (\circC)')


fig.PaperPositionMode = 'auto';
saveas(gcf,'Seasonal2014_S_W_T&S14+hist_different_colour.png');
print -depsc2 Seasonal2014_S_W_T&S14+hist_different_colour.eps
close all
