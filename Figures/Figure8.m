%%laura 2 vertical plots together
addpath 'C:\Users\nribeiro\Desktop\Seal Data\matlab_tools\TOOLBOX\tight_subplot'
addpath 'C:\Users\nribeiro\Desktop\Seal Data\matlab_tools\TOOLBOX\suplabel'
addpath 'C:\Users\nribeiro\Desktop\Seal Data\matlab_tools\TOOLBOX\cmocean' 
%figure Laura 2

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


%Shackleton West
ie=find(lon_vcb(1,:) >= 90 & lon_vcb(1,:) <= 96.5 & yr_vcb==2011);

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
for i=2:8
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

%%FIG 2 temp: 2009, FEB, MAR,JUL, AGO, SEP
a=size(temp_pot_vcb);

figure;
[ha, pos] = tight_subplot(2, 4, [0.1 -0.02],[.1 .1],[.1 .03])
%subplot(2,2,1);

% axes(ha(1));
% %subplot(2,2,1);
% i=find(mth_sort==1);%fev
% fit2=scatter(temp_pot_vcb(i),PR_17(i),15,SA_17(i),'filled');
% % for k=1:a(1);
% %     fit2=scatter(temp_pot_vcb(k,i),pres_vcb(k,i),15,SA_17(k,i),'filled');
% %     fit2.MarkerFaceAlpha = .2;
% %     hold on;
% % end
% hold on;
% ax = gca;
% ax.FontSize = 14; 
% set(gca,'Ydir','reverse')
% xlim([-2,-0.5]);
% set(gca, ...
%   'Box'         , 'off'     , ...
%   'TickDir'     , 'out'     , ...
%   'TickLength'  , [.02 .02] , ...
%   'XMinorTick'  , 'on'      , ...
%   'YMinorTick'  , 'on'      , ...
%   'XGrid'       , 'on'      , ...
%   'LineWidth'   , 1         );
% hold on;
% ylabel('Pressure (dbar)');
% cmap=yaki1
% colormap(flipud(cmap))
% h=colorbar
% caxis([34 34.7]);
% t=get(h,'Limits');   %Azzi Abdelmalek contribution. Great Matalab answers contributor
% T=linspace(t(1),t(2),8)
% set(h,'Ticks',T)
% TL=arrayfun(@(x) sprintf('%.2f',x),T,'un',0)
% set(h,'TickLabels',TL)
% set(h,'visible','off')
% 
% % gridlines ---------------------------
% hold on
% g_y=[0:100:1000]; % user defined grid Y [start:spaces:end]
% g_x=[-2:1:-0.5]; % user defined grid X [start:spaces:end]
% s=xlim;
% % for i=1:length(g_x)
% %    plot([g_x(i) g_x(i)],[g_y(1) g_y(end)],'k:') %y grid lines
% %    hold on    
% % end
% for i=1:length(g_y)
%    plot([g_x(1) s(2)],[g_y(i) g_y(i)],'LineStyle','-','Color',[.8 .8 .8]) %x grid lines
%    hold on    
% end
% title('Jan') 
% line([-1.8 -1.8],[0 1000],'LineStyle','--','LineWidth',1.5,'Color','k')
% line([-1.92 -1.92],[0 1000],'LineStyle','--','LineWidth',1.5,'Color','k')
% 
% hold on;

axes(ha(1));
i=find(mth_sort==2);%fev
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
title('Feb')
ylabel('Pressure (dbar)')
line([-1.8 -1.8],[0 1000],'LineStyle','--','LineWidth',1.5,'Color','k')
line([-1.92 -1.92],[0 1000],'LineStyle','--','LineWidth',1.5,'Color','k')

hold on;
axes(ha(2));
%subplot(2,2,2);
i=find(mth_sort==3);%mar
fit2=scatter(temp_pot_vcb(i),PR_17(i),15,SA_17(i),'filled');
% for k=1:a(1);
%     fit2=scatter(temp_pot_vcb(k,i),pres_vcb(k,i),15,SA_17(k,i),'filled');
%     fit2.MarkerFaceAlpha = .2;
%     hold on;
% end
hold on;
set(gca,'Ydir','reverse')
colormap(cmocean('haline'))
caxis([33.3,34.5])
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

axes(ha(3));
i=find(mth_sort==4);%apr
fit2=scatter(temp_pot_vcb(i),PR_17(i),15,SA_17(i),'filled');
% for k=1:a(1);
%     fit5=scatter(temp_pot_vcb(k,i),pres_vcb(k,i),15,SA_17(k,i),'filled');
%     fit5.MarkerFaceAlpha = .2;
%     hold on;
% end
hold on;
set(gca,'Ydir','reverse')
colormap(cmocean('haline'))
caxis([33.3,34.5])
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
for i=1:length(g_y)
   plot([g_x(1) s(2)],[g_y(i) g_y(i)],'LineStyle','-','Color',[.8 .8 .8]) %x grid lines
   hold on    
end
title('Apr')
line([-1.8 -1.8],[0 1000],'LineStyle','--','LineWidth',1.5,'Color','k')
line([-1.92 -1.92],[0 1000],'LineStyle','--','LineWidth',1.5,'Color','k')

axes(ha(4));
i=find(mth_sort==5);%may
fit2=scatter(temp_pot_vcb(i),PR_17(i),15,SA_17(i),'filled');
% for k=1:a(1);
%     fit6=scatter(temp_pot_vcb(k,i),pres_vcb(k,i),15,SA_17(k,i),'filled');
%     fit6.MarkerFaceAlpha = .2;
%     hold on;
% end
hold on;
set(gca,'Ydir','reverse')
ax = gca;
ax.FontSize = 14; 
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
ylim([0,1000]);
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
title('May')
line([-1.8 -1.8],[0 1000],'LineStyle','--','LineWidth',1.5,'Color','k')
line([-1.92 -1.92],[0 1000],'LineStyle','--','LineWidth',1.5,'Color','k')

axes(ha(5));
i=find(mth_sort==6);%jun
fit2=scatter(temp_pot_vcb(i),PR_17(i),15,SA_17(i),'filled');
% for k=1:a(1);
%     fit9=scatter(temp_pot_vcb(k,i),pres_vcb(k,i),15,SA_17(k,i),'filled');
%     fit9.MarkerFaceAlpha = .2;
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
%h = gca; h.YAxis.Visible = 'off'; h.FontSize = 14; 
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
title('Jun')
xlabel('\theta (\circC)')
ylabel('Pressure (dbar)')
line([-1.8 -1.8],[0 1000],'LineStyle','--','LineWidth',1.5,'Color','k')
line([-1.92 -1.92],[0 1000],'LineStyle','--','LineWidth',1.5,'Color','k')

axes(ha(6));
i=find(mth_sort==7);%jul
fit2=scatter(temp_pot_vcb(i),PR_17(i),15,SA_17(i),'filled');
% for k=1:a(1);
%     fit5=scatter(temp_pot_vcb(k,i),pres_vcb(k,i),15,SA_17(k,i),'filled');
%     fit5.MarkerFaceAlpha = .2;
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
xlabel('\theta (\circC)')
title('Jul')
line([-1.8 -1.8],[0 1000],'LineStyle','--','LineWidth',1.5,'Color','k')
line([-1.92 -1.92],[0 1000],'LineStyle','--','LineWidth',1.5,'Color','k')

axes(ha(7));
i=find(mth_sort==8);%ago
fit2=scatter(temp_pot_vcb(i),PR_17(i),15,SA_17(i),'filled');
% for k=1:a(1);
%     fit6=scatter(temp_pot_vcb(k,i),pres_vcb(k,i),15,SA_17(k,i),'filled');
%     fit6.MarkerFaceAlpha = .2;
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
xlabel('\theta (\circC)')
title('Aug')
line([-1.8 -1.8],[0 1000],'LineStyle','--','LineWidth',1.5,'Color','k')
line([-1.92 -1.92],[0 1000],'LineStyle','--','LineWidth',1.5,'Color','k')


% axes(ha(9));
% i=find(mth_sort==9);%sep
% fit2=scatter(temp_pot_vcb(i),PR_17(i),15,SA_17(i),'filled');
% % for k=1:a(1);
% %     fit6=scatter(temp_pot_vcb(k,i),pres_vcb(k,i),15,SA_17(k,i),'filled');
% %     fit6.MarkerFaceAlpha = .5;
% %     hold on;
% % end
% hold on;
% set(gca,'Ydir','reverse')
% colormap(cmocean('haline'))
% caxis([33.3,34.5])
% cmap=yaki1
% colormap(flipud(cmap))
% h=colorbar
% caxis([34 34.7]);
% t=get(h,'Limits');   %Azzi Abdelmalek contribution. Great Matalab answers contributor
% T=linspace(t(1),t(2),8)
% set(h,'Ticks',T)
% TL=arrayfun(@(x) sprintf('%.2f',x),T,'un',0)
% set(h,'TickLabels',TL)
% h = gca; h.YAxis.Visible = 'off'; h.FontSize = 14; 
% xlim([-2,-0.5]);
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
% hold on
% g_y=[0:100:1000]; % user defined grid Y [start:spaces:end]
% g_x=[-2:1:0.3]; % user defined grid X [start:spaces:end]
% s=xlim;
% % for i=1:length(g_x)
% %    plot([g_x(i) g_x(i)],[g_y(1) g_y(end)],'k:') %y grid lines
% %    hold on    
% % end
% for i=1:length(g_y)
%    plot([g_x(1) s(2)],[g_y(i) g_y(i)],'LineStyle','-','Color',[.8 .8 .8]) %x grid lines
%    hold on    
% end
% xlabel('\theta (\circC)')
% sgtitle({'Shackleton West \theta & S Variability 2011';''},'Fontsize',15,...
%     'FontWeight','bold')
% title('Sep')
% xlabel('\theta(\circC)')
% line([-1.8 -1.8],[0 1000],'LineStyle','--','LineWidth',1.5,'Color','k')
% line([-1.92 -1.92],[0 1000],'LineStyle','--','LineWidth',1.5,'Color','k')
% 
axes(ha(8))
h = gca; 
set(h,'visible','off')
% % %custom legend because the dots are coming out transparent
% % h = zeros(7, 1);
% % h(1) = scatter(NaN,NaN,15,'b','filled');
% % h(2) = scatter(NaN,NaN,15,'g','filled');
% % h(3) = scatter(NaN,NaN,15,[0.9100 0.4100 0.1700],'filled');
% % h(4) = scatter(NaN,NaN,15,'k','filled');
% % h(5) = scatter(NaN,NaN,15,'r','filled');
% % h(6) = scatter(NaN,NaN,15,'m','filled');
% % h(7) = scatter(NaN,NaN,15,[.5 0 .5],'filled');
% % hh=legend(h, 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug',...
% %   'location', 'SouthEast');
% % 
% % [ax1,h1]=suplabel('\theta (^{\circ}C)'  ,'x');
% % [ax2,h2]=suplabel(['Shackleton West \theta Variability 2011','','']  ,'t');
% % set(h1,'FontSize',18)
% % set(h2,'FontSize',18)
   
fig.PaperPositionMode = 'auto';
saveas(gcf,'Seasonal2011_S_W_T&S11_different_colour.png');
print -depsc2 Seasonal2011_S_W_T&S11_different_colour.eps
close all
% 
% 
% %%FIG 2 S: 2011, FEB - AGO
% figure;
% [ha, pos] = tight_subplot(1, 7, 0.03,[.15 .1],[.1 .03])
% axes(ha(1));
% i=find(mth17==2);%fev
% for k=1:10:length(SA_17(:,i));
%     fit2=scatter(SA_17(k,i),pres_vcb(k,i),15,'filled','b');
%     fit2.MarkerFaceAlpha = .08;
%     hold on;
% end
% hold on;
% ax = gca;
% ax.FontSize = 18; 
% set(gca,'Ydir','reverse')
% ylabel('Depth (m)');
% xlim([33,35]);
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
% g_y=[0:100:1000]; % user defined grid Y [start:spaces:end]
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
% axes(ha(2));
% i=find(mth17==3);%mar
% for k=1:10:length(SA_17(:,i));
%     fit4=scatter(SA_17(k,i),pres_vcb(k,i),15,'filled','g');
%     fit4.MarkerFaceAlpha = .08;
%     hold on;
% end
% hold on;
% set(gca,'Ydir','reverse')
% h = gca; h.YAxis.Visible = 'off'; h.FontSize = 18; 
% xlim([33,35]);
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
% g_y=[0:100:1000]; % user defined grid Y [start:spaces:end]
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
% axes(ha(3));
% i=find(mth17==4);%apr
% for k=1:10:length(SA_17(:,i));
%     fit5=scatter(SA_17(k,i),pres_vcb(k,i),15,[ 0.9100 0.4100 0.1700],'filled');
%     fit5.MarkerFaceAlpha = .08;
%     hold on;
% end
% hold on;
% set(gca,'Ydir','reverse')
% h = gca; h.YAxis.Visible = 'off'; h.FontSize = 18; 
% xlim([33,35]);
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
% g_y=[0:100:1000]; % user defined grid Y [start:spaces:end]
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
% axes(ha(4));
% i=find(mth17==5);%may
% for k=1:10:length(SA_17(:,i));
%     fit6=scatter(SA_17(k,i),pres_vcb(k,i),15,'filled','k');
%     fit6.MarkerFaceAlpha = .08;
%     hold on;
% end
% hold on;
% set(gca,'Ydir','reverse')
% h = gca; h.YAxis.Visible = 'off'; h.FontSize = 18; 
% xlim([33,35]);
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
% g_y=[0:100:1000]; % user defined grid Y [start:spaces:end]
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
% axes(ha(5));
% i=find(mth17==6);%jun
% for k=1:10:length(SA_17(:,i));
%     fit9=scatter(SA_17(k,i),pres_vcb(k,i),15,'filled','r');
%     fit9.MarkerFaceAlpha = .08;
%     hold on;
% end
% hold on;
% set(gca,'Ydir','reverse')
% h = gca; h.YAxis.Visible = 'off'; h.FontSize = 18; 
% xlim([33,35]);
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
% g_y=[0:100:1000]; % user defined grid Y [start:spaces:end]
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
% %custom legend because the dots are coming out transparent
% h = zeros(7, 1);
% h(1) = scatter(NaN,NaN,15,'b','filled');
% h(2) = scatter(NaN,NaN,15,'g','filled');
% h(3) = scatter(NaN,NaN,15,[0.9100 0.4100 0.1700],'filled');
% h(4) = scatter(NaN,NaN,15,'k','filled');
% h(5) = scatter(NaN,NaN,15,'r','filled');
% h(6) = scatter(NaN,NaN,15,'m','filled');
% h(7) = scatter(NaN,NaN,15,[.5 0 .5],'filled');
% hh=legend(h, 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug',...
%   'location', 'SouthWest');
% hold on;
% 
% axes(ha(6));
% i=find(mth17==7);%jul
% for k=1:10:length(SA_17(:,i));
%     fit5=scatter(SA_17(k,i),pres_vcb(k,i),15,'m','filled');
%     fit5.MarkerFaceAlpha = .08;
%     hold on;
% end
% hold on;
% set(gca,'Ydir','reverse')
% h = gca; h.YAxis.Visible = 'off'; h.FontSize = 18; 
% xlim([33,35]);
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
% g_y=[0:100:1000]; % user defined grid Y [start:spaces:end]
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
% axes(ha(7));
% i=find(mth17==8);%ago
% for k=1:10:length(SA_17(:,i));
%     fit6=scatter(SA_17(k,i),pres_vcb(k,i),15,[.5 0 .5],'filled');
%     fit6.MarkerFaceAlpha = .08;
%     hold on;
% end
% hold on;
% set(gca,'Ydir','reverse')
% h = gca; h.YAxis.Visible = 'off'; h.FontSize = 18; 
% xlim([33,35]);
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
% g_y=[0:100:1000]; % user defined grid Y [start:spaces:end]
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
% [ax1,h1]=suplabel('Salinity'  ,'x');
% [ax2,h2]=suplabel('Shackleton West S Variability 2011'  ,'t');
% set(h1,'FontSize',18)
% set(h2,'FontSize',18)
%    
% fig.PaperPositionMode = 'auto';
% saveas(gcf,'S_W_vertprofS_11coast.tiff');
% saveas(gcf,'S_W_vertprofS_11coast.png');
% print -depsc2 S_W_vertprofS_11coast.eps
% close all
% 
