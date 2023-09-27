%%new time series figure with all plots, changes etc. 
%variables first 

addpath 'C:\Users\nribeiro\Desktop\Seal Data\matlab_tools\TOOLBOX\addaxisX\addaxis6'
addpath 'C:\Users\nribeiro\Desktop\Seal Data\matlab_tools\TOOLBOX\tight_subplot'
addpath 'C:\Users\nribeiro\Desktop\Seal Data\matlab_tools\TOOLBOX\suplabel'

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

%mcdw
s=size(index);
id_s=nan(s(1),s(2));
id_pt=nan(s(1),s(2));
id_ga=nan(s(1),s(2));
i=find(index==3);

id_s(i)=S(i);
id_pt(i)=PT(i);
id_ga(i)=GA(i);

S_mcdw=nanmean(id_s);
PT_mcdw=nanmean(id_pt);
GA_mcdw=nanmean(id_ga);

%%just to find how many profs within the box mcdw
a=isnan(id_pt);
aa=nanmin(a);
i=find(aa==0);
size(i);

data=[yr' PT_mcdw']
[meanByYear,yr2,yrcounts]=groupsummary(data(:,2),data(:,1),'all');
pt_mcdw=meanByYear(:,4);
pt_yr_mcdw=yr2;
bar_ctd_mcdw=meanByYear(:,11);
std_ctd_mcdw=meanByYear(:,9);

%mcdw
%seal
%%figs with map + Vertical T + Vertical S + TS
load West_Shack_VB_Totten_triado_coast.mat
load  massa_dagua_index_coast_d


%%seal west
%testing only summer seals for laura
%ig=find(lat_vcb>=-66 & lat_vcb<=-65 & lon_vcb>=93 & lon_vcb<=96 & mth_vcb<=3)

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

s=size(indexb);
id_s=nan(s(1),s(2));
id_pt=nan(s(1),s(2));
id_ga=nan(s(1),s(2));
i=find(indexb==3);

id_s(i)=Sb(i);
id_pt(i)=PTb(i);
id_ga(i)=GAb(i);

%%just to find how many profs within the box mcdw
a=isnan(id_pt);
aa=nanmin(a);
i=find(aa==0);
size(i)

S_mcdwb=nanmean(id_s);
PT_mcdwb=nanmean(id_pt);
GA_mcdwb=nanmean(id_ga);

data=[yrb' PT_mcdwb']
[meanByYear,yr2,yrcounts]=groupsummary(data(:,2),data(:,1),'all');
PT_mcdwb=meanByYear(:,4);
PT_mcdwb_yr=yr2;
bar_s_mcdw=meanByYear(:,11);
std_s_mcdw=meanByYear(:,9);

k=isnan(PT_mcdwb);
kk=find(k==0);
PT_mcdwb=PT_mcdwb(kk);
PT_mcdwb_yr=PT_mcdwb_yr(kk);
bar_s_mcdw=bar_s_mcdw(kk);
std_s_mcdw=std_s_mcdw(kk);


fig=figure;
fig.Position = [5 5 800 600]; 
left_color = [.0 .0 0];
right_color = [0 .0 .0];
set(fig,'defaultAxesColorOrder',[left_color; right_color]);
yyaxis left
fit1=errorbar(pt_yr_mcdw([1:4,6]),pt_mcdw([1:4,6]),2*std_ctd_mcdw([1:4,6]),'LineStyle','none',...
    'Color',[230,97,1]/256','linewidth', 1)
hold on;
fit1=plot(pt_yr_mcdw([1:4,6]),pt_mcdw([1:4,6]),'o')
set(fit1                          , ...
    'Color', [230,97,1]/256, ...
    'MarkerSize'       ,     8 , ...
    'Linewidth',            2);
hold on
fit2=errorbar(PT_mcdwb_yr,PT_mcdwb,2*std_s_mcdw,'LineStyle','none',...
    'Color',[230,97,1]/256','linewidth', 1)
hold on;
fit2=plot(PT_mcdwb_yr,PT_mcdwb,'s')
set(fit2                          , ...
    'Color', [230,97,1]/256, ...
    'MarkerSize'       ,     9 , ...
    'LineWidth'       ,     3       );
hold on
% fit3=plot([pt_yr_mcdw(7),PT_mcdwb_yr(1)],[pt_mcdw(7),PT_mcdwb(1)])
% set(fit3                          , ...
%     'Color', [.75,.75,.75], ...
%     'LineStyle', '--', ...
%   'LineWidth'       ,     1       );
ax=gca;
ylabel('\theta_{max} (^{\circ}C)');
hold on;
ax = gca;
ax.FontSize = 18; 
%ylim([34.2 34.7])
%xlim([1956 2016])
title('mCDW (65-66\circS; 94-96\circE)')
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

yyaxis right
b2=bar(pt_yr_mcdw,bar_ctd_mcdw,'FaceColor',[230,97,1]/256);
b2.FaceAlpha = 0.4;
b2.EdgeColor = 'none';
b1=bar(PT_mcdwb_yr,bar_s_mcdw,'FaceColor',[230,97,1]/256);
b1.FaceAlpha = 0.4;
b1.EdgeColor = 'none';
ylabel('N^{o} of Profiles')
ylim([0 50])
%BUILLD LEGEND. INCLUDE NO DATA AND BAR GRAPHS
a=plot(NaN,NaN,'k','LineStyle','-','LineWidth',2)
b=plot(NaN,NaN,'--k','LineWidth',2)
c=plot(NaN,NaN,'--','Color',[0.75 0.75 0.75],'LineWidth',1)
d=bar(NaN,NaN,'FaceColor',[0.75 0.75 0.75],'EdgeColor','none')
legend([a,b,c,d],{'CTD','Seals','no data','N^{o} of Profiles'}, 'location','NorthWest');

saveas(gcf,'mCDW_TS_2std.png');
saveas(gcf, 'mCDW_TS_2std.eps');


%%%
%%isw graph

%ISW t
%isw
%because the box is diffeent load it again
load ShackCTD_data_coast_no_interp.mat
load massa_dagua_index_ShackCTD_data_coast_no_interp

ig=find(y<-66)
ig2=find(x>90.5 & x<96.5 & y<-65.5);
ig3=find(x>92 & x<96.5 & y<-65.25);
ig4=find(x>93 & x<96.5 & y<-65);
ig5=find(x>95 & x<96.5 & y<-64.5);
ig=[ig ig2 ig3 ig4 ig5];
ig=unique(ig);

S=S(:,ig);
GA=GA(:,ig);
PT=PT(:,ig);
P=P(:,ig);
y=y(:,ig);
x=x(:,ig);
yr=yr(:,ig);
index=index(:,ig);

s=size(index);
id_s=nan(s(1),s(2));
id_pt=nan(s(1),s(2));
id_ga=nan(s(1),s(2));
i=find(index==2);

id_s(i)=S(i);
id_pt(i)=PT(i);
id_ga(i)=GA(i);

S_isw=nanmean(id_s);
PT_isw=nanmean(id_pt);
GA_isw=nanmean(id_ga);

data=[yr' PT_isw']
[meanByYear,yr2,yrcounts]=groupsummary(data(:,2),data(:,1),'all');
pt_isw=meanByYear(:,4); %1 eh o mean
pt_yr_isw=yr2;
bar_ctd_isw=meanByYear(:,11);
std_ctd_isw=meanByYear(:,9);

data=[yr' S_isw']
[meanByYear,yr2,yrcounts]=groupsummary(data(:,2),data(:,1),'all');
s_isw=meanByYear(:,4);
s_yr_isw=yr2;
bar_ctd_isw_sal=meanByYear(:,11);
std_ctd_isw_sal=meanByYear(:,9);

k=isnan(pt_isw);
kk=find(k==0);
pt_isw=pt_isw(kk);
pt_yr_isw=pt_yr_isw(kk);
bar_ctd_isw=bar_ctd_isw(kk);
std_ctd_isw=std_ctd_isw(kk);
s_isw=s_isw(kk);
s_yr_isw=s_yr_isw(kk);
bar_ctd_isw_sal=bar_ctd_isw_sal(kk);
std_ctd_isw_sal=std_ctd_isw_sal(kk);

%isw
%seal
%%figs with map + Vertical T + Vertical S + TS
load West_Shack_VB_Totten_triado_coast.mat
load  massa_dagua_index_coast_d

%testing for laura. Matrix has same size if only using summer-autumn seals
% %%seal west
% ig=find(lat_vcb<-66 & mth_vcb<=3)
% ig2=find(lon_vcb>90.5 & lon_vcb<96.5 & lat_vcb<-65.5 & mth_vcb<=3);
% ig3=find(lon_vcb>92 & lon_vcb<96.5 & lat_vcb<-65.25 & mth_vcb<=3);
% ig4=find(lon_vcb>93 & lon_vcb<96.5 & lat_vcb<-65 & mth_vcb<=3);
% ig5=find(lon_vcb>95 & lon_vcb<96.5 & lat_vcb<-64.5 & mth_vcb<=3);
% ig=[ig ig2 ig3 ig4 ig5];
% ig=unique(ig);
% 
%%seal west
ig=find(lat_vcb<-66)
ig2=find(lon_vcb>90.5 & lon_vcb<96.5 & lat_vcb<-65.5);
ig3=find(lon_vcb>92 & lon_vcb<96.5 & lat_vcb<-65.25);
ig4=find(lon_vcb>93 & lon_vcb<96.5 & lat_vcb<-65);
ig5=find(lon_vcb>95 & lon_vcb<96.5 & lat_vcb<-64.5);
ig=[ig ig2 ig3 ig4 ig5];
ig=unique(ig);

Sb=sal_adj_vcb(:,ig);
GAb=ND_vcb(:,ig);
PTb=temp_adj_vcb(:,ig);
Pb=pres_adj_vcb(:,ig);
yb=lat_vcb(:,ig);
xb=lon_vcb(:,ig);
yrb=yr_vcb(:,ig);
indexb=index(:,ig);

s=size(indexb);
id_s=nan(s(1),s(2));
id_pt=nan(s(1),s(2));
id_ga=nan(s(1),s(2));
i=find(indexb==2);

id_s(i)=Sb(i);
id_pt(i)=PTb(i);
id_ga(i)=GAb(i);

S_iswb=nanmean(id_s);
PT_iswb=nanmean(id_pt);
GA_iswb=nanmean(id_ga);

data=[yrb' PT_iswb']
[meanByYear,yr2,yrcounts]=groupsummary(data(:,2),data(:,1),'all');
PT_iswb=meanByYear(:,4); %1 eh o mean e o 4 eh o maximo/use help
PT_iswb_yr=yr2;
bar_s_isw=meanByYear(:,11);
std_s_isw=meanByYear(:,9);

data=[yrb' S_iswb']
[meanByYear,yr2,yrcounts]=groupsummary(data(:,2),data(:,1),'all');
S_iswb=meanByYear(:,4);
S_iswb_yr=yr2;
bar_s_isw_sal=meanByYear(:,11);
std_s_isw_sal=meanByYear(:,9);

k=isnan(PT_iswb);
kk=find(k==0);
PT_iswb=PT_iswb(kk);
PT_iswb_yr=PT_iswb_yr(kk);
bar_s_isw=bar_s_isw(kk);
std_s_isw=std_s_isw(kk);
S_iswb=S_iswb(kk);
S_iswb_yr=S_iswb_yr(kk);
bar_s_isw_sal=bar_s_isw_sal(kk);
std_s_isw_sal=std_s_isw_sal(kk);

fig=figure;
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
fit1=errorbar(s_yr_isw,s_isw,2*std_ctd_isw_sal,'LineStyle','none',...
    'Color',[94,60,153]/256,'linewidth', 1.8)
fit1=plot(s_yr_isw,s_isw,'o')
set(fit1                          , ...
    'Color', [94,60,153]/256, ...
    'MarkerSize'       ,    8, ...       
    'LineWidth'       ,     2       );
hold on
fit2=errorbar(S_iswb_yr,S_iswb,2*std_s_isw_sal,'LineStyle','none',...
    'Color',[94,60,153]/256,'linewidth', 1.8)
fit2=plot(S_iswb_yr,S_iswb,'s')
set(fit2                          , ...
    'Color', [94,60,153]/256, ...
    'MarkerSize'      ,     9, ...
    'LineWidth'       ,     3       );
hold on;
% fit3=plot([s_yr_isw(length(s_yr_isw)),S_iswb_yr(1)],...
%           [s_isw(length(s_yr_isw)),S_iswb(1)])
% set(fit3                          , ...
%     'Color', [.75,.75,.75], ...
%     'LineStyle', '--', ...
%   'LineWidth'       ,     1       );
title('ISW (West of SIS Domain)');
ylabel('S_{max}');
xlim([1956,2016])
ax=gca;
ax.YAxis(1).Color = [94,60,153]/256;
hold on;
ax = gca;
ax.FontSize = 22; 
hold on;

% Create a new axes in the same position as the first one, overlaid on top
h_ax = gca;
h_ax_line = axes('position', get(h_ax, 'position')); 
hold on;
fit3=errorbar(pt_yr_isw,pt_isw,2*std_ctd_isw,'LineStyle','none',...
    'Color',[230,97,1]/256,'linewidth', 1)
fit3=plot(pt_yr_isw,pt_isw,'o')
set(fit3                          , ...
  'Color', [230,97,1]/256, ...
  'MarkerSize'       , 8, ...           
  'LineWidth'       , 2           );
hold on
fit4=errorbar(PT_iswb_yr,PT_iswb,2*std_s_isw,'LineStyle','none',...
    'Color',[230,97,1]/256,'linewidth', 1)
fit4=plot(PT_iswb_yr,PT_iswb,'s')
set(fit4                          , ...
  'Color', [230,97,1]/256, ...
  'MarkerSize',      9, ...
  'LineWidth'       , 3           );
hold on;
% fit5=plot([pt_yr_isw(length(pt_yr_isw)),PT_iswb_yr(1)],...
%           [pt_isw(length(pt_yr_isw)),PT_iswb(1)])
% set(fit5                          , ...
%     'Color', [.75,.75,.75], ...
%     'LineStyle', '--', ...
%   'LineWidth'       ,     1       );
ylabel('\theta_{max} (^{\circ}C)');
% Put the new axes' y labels on the right, set the x limits the same as the original axes', and make the background transparent
set(h_ax_line, 'YAxisLocation', 'right', 'xlim', get(h_ax, 'xlim'), 'color', 'none'); 
set(gca,'XColor', 'none')
%fixing the graph box
set(gca, ...
  'Box'         , 'off'     , ...
  'TickDir'     , 'out'     , ...
  'TickLength'  , [.02 .02] , ...
  'XMinorTick'  , 'on'      , ...
  'YMinorTick'  , 'on'      , ...
  'LineWidth'   , 1         );

ax=gca;
ax.YAxis(1).Color = [230,97,1]/256;
ax = gca;
ax.FontSize = 22; 
hold on;

% Create a new axes in the same position as the first one, overlaid on top
h_ax = gca;
h_ax_line = axes('position', get(h_ax, 'position')); 
hold on;
b2=bar(pt_yr_isw,bar_ctd_isw,'FaceColor',[.75,.75,.75]);
b2.FaceAlpha = 0.6;
b2.EdgeColor = 'none';
b1=bar(PT_iswb_yr,bar_s_isw,'FaceColor',[.75,.75,.75]);
b1.FaceAlpha = 0.6;
b1.EdgeColor = 'none';
ylim([0 50])

% Put the new axes' y labels on the right, set the x limits the same as the original axes', and make the background transparent
set(h_ax_line, 'YAxisLocation', 'right', 'xlim', get(h_ax, 'xlim'), 'color', 'none'); 
set(gca,'XColor', 'none')
set(gca,'YColor', 'none')
ax = gca;
ax.FontSize = 22; 
hold on;


hAx(2)=axes('position',pos,'color','none');
pos=get(hAx(1),'position');
set(gca,'XColor', 'none')
%fixing the graph box
set(gca, ...
  'Box'         , 'off'     , ...
  'TickDir'     , 'out'     , ...
  'TickLength'  , [.02 .02] , ...
  'YMinorTick'  , 'on'      , ...
  'LineWidth'   , 1         );
hold on;
b2=bar(pt_yr_isw,bar_ctd_isw,'FaceColor',[.75 .75 .75]);
b2.FaceAlpha = 0.1;
b2.EdgeColor = 'none';
b1=bar(PT_iswb_yr,bar_s_isw,'FaceColor',[.75 .75 .75]);
b1.FaceAlpha = 0.1;
b1.EdgeColor = 'none';
ylabel('N^{o} of Profiles')
ylim([0 50])
ax = gca;
ax.FontSize = 22; 
hold on;

%BUILLD LEGEND. INCLUDE NO DATA AND BAR GRAPHS
%legend('CTD','Seals','no data','N^{o} of Profiles', 'Location', 'NorthWest');
saveas(gcf,'ISW_TS_2std.png.png');
print -depsc2 ISW_TS_2std.png.eps

% saveas(gcf,'fig_timeseriesISW_b_summer.png');
% saveas(gcf, 'fig_timeseriesISW_b_summer.eps');



%%%
%%dsw graph

%dsw s
%because the box is diffeent load it again
load ShackCTD_data_coast_no_interp.mat
load massa_dagua_index_ShackCTD_data_coast_no_interp

ig=find(y>=-66 & y<=-65.5 & x>=94 & x<=96)


S=S(:,ig);
GA=GA(:,ig);
PT=PT(:,ig);
P=P(:,ig);
y=y(:,ig);
x=x(:,ig);
yr=yr(:,ig);
index=index(:,ig);
mth=month(:,ig);

s=size(index);
id_s=nan(s(1),s(2));
id_pt=nan(s(1),s(2));
id_ga=nan(s(1),s(2));
i=find(index==1);

id_s(i)=S(i);
id_pt(i)=PT(i);
id_ga(i)=GA(i);


%%just to find how many profs within the box dsw
a=isnan(id_pt);
aa=nanmin(a);
i=find(aa==0);
size(i)

S_dsw=nanmean(id_s);
PT_dsw=nanmean(id_pt);
GA_dsw=nanmean(id_ga);

data=[yr' S_dsw']
[meanByYear,yr2,yrcounts]=groupsummary(data(:,2),data(:,1),'all');
pt_dsw=meanByYear(:,4);
pt_yr_dsw=yr2;
bar_ctd_dsw=meanByYear(:,11);
std_ctd_dsw=meanByYear(:,9);

% %%this is to give to the reviewer the months of DSW
% data=[mth' S_dsw']
% [meanByYear,yr2,yrcounts]=groupsummary(data(:,2),data(:,1),'all');
% pt_dsw=meanByYear(:,4);
% pt_yr_dsw=yr2;
% bar_ctd_dsw=meanByYear(:,11);
% std_ctd_dsw=meanByYear(:,9);

k=isnan(pt_dsw);
kk=find(k==0);
pt_dsw=pt_dsw(kk);
pt_yr_dsw=pt_yr_dsw(kk);
bar_ctd_dsw=bar_ctd_dsw(kk);
std_ctd_dsw=std_ctd_dsw(kk);

%dsw
%seal
%%figs with map + Vertical T + Vertical S + TS
load West_Shack_VB_Totten_triado_coast.mat
load  massa_dagua_index_coast_d

%%seal west
%test summer fo rlaura
%ig=find(lat_vcb>=-66 & lat_vcb<=-65.5 & lon_vcb>=93 & lon_vcb<=96 & mth<=3)


ig=find(lat_vcb>=-66 & lat_vcb<=-65.5 & lon_vcb>=94 & lon_vcb<=96)
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

s=size(indexb);
id_s=nan(s(1),s(2));
id_pt=nan(s(1),s(2));
id_ga=nan(s(1),s(2));
i=find(indexb==1);

id_s(i)=Sb(i);
id_pt(i)=PTb(i);
id_ga(i)=GAb(i);

%%just to find how many profs within the box dsw
a=isnan(id_pt);
aa=nanmin(a);
i=find(aa==0);
size(i)

%this is to give to the reviewer the months of DSW
% i=find(indexb>1);
% index_copy=indexb
% index_copy(i)=0
% index_copy=sum(index_copy)
% ii=find(index_copy<1);
% mthb(ii)

S_dswb=nanmean(id_s);
PT_dswb=nanmean(id_pt);
GA_dswb=nanmean(id_ga);

data=[yrb' S_dswb']
[meanByYear,yr2,yrcounts]=groupsummary(data(:,2),data(:,1),'all');
PT_dswb=meanByYear(:,6);
PT_dswb_yr=yr2;
bar_s_dsw=meanByYear(:,11);
std_s_dsw=meanByYear(:,9);

% %%this is to give to the reviewer the months of DSW
% data=[mthb' S_dswb']
% [meanByYear,yr2,yrcounts]=groupsummary(data(:,2),data(:,1),'all');
% PT_dswb=meanByYear(:,4);
% PT_dswb_yr=yr2;
% bar_s_dsw=meanByYear(:,11);
% std_s_dsw=meanByYear(:,9);
% 
% k=isnan(PT_dswb);
% kk=find(k==0);
% PT_dswb=PT_dswb(kk);
% PT_dswb_yr=PT_dswb_yr(kk);
% bar_s_dsw=bar_s_dsw(kk);
% std_s_dsw=std_s_dsw(kk);

fig=figure;
fig.Position = [5 5 800 600]; 
left_color = [.0 .0 0];
right_color = [0 .0 .0];
set(fig,'defaultAxesColorOrder',[left_color; right_color]);
yyaxis left
fit1=errorbar(pt_yr_dsw,pt_dsw,2*std_ctd_dsw,'LineStyle','none',...
    'Color',[94,60,153]/256,'linewidth', 1)
hold on;
fit1=plot(pt_yr_dsw,pt_dsw,'o')
set(fit1                          , ...
    'Color', [94,60,153]/256, ...
    'MarkerSize'      ,     8, ...
    'LineWidth'       ,     2       );
hold on;
fit2=errorbar(PT_dswb_yr,PT_dswb,2*std_s_dsw,'LineStyle','none',...
    'Color',[94,60,153]/256,'linewidth', 1)
hold on;
fit2=plot(PT_dswb_yr,PT_dswb,'s')
set(fit2                          , ...
    'Color', [94,60,153]/256, ...
    'MarkerSize'      ,    9, ...
    'LineWidth'       ,     3       );
% fit3=plot([pt_yr_dsw(length(pt_yr_dsw)),PT_dswb_yr(1)],...
%           [pt_dsw(length(pt_yr_dsw)),PT_dswb(1)])
% set(fit3                          , ...
%     'Color', [.75,.75,.75], ...
%     'LineStyle', '--', ...
%   'LineWidth'       ,     1       );
ax=gca;
ylabel('S_{max}');
hold on;
hold on;
ax = gca;
ax.FontSize = 18; 
ylim([34.45 34.65])
%xlim([1956 2016])
title('DSW (65.5-66\circS; 94-96\circE)')
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

yyaxis right
bar_s_dsw=[bar_s_dsw(1),0,0,bar_s_dsw(2)];
PT_dswb_yr=[2011,2012,2013,2014];
yyaxis right
b2=bar(pt_yr_dsw,bar_ctd_dsw,'FaceColor',[94,60,153]/256);
b2.FaceAlpha = 0.4;
b2.EdgeColor = 'none';
b1=bar(PT_dswb_yr,bar_s_dsw,'FaceColor',[94,60,153]/256);
b1.FaceAlpha = 0.4;
b1.EdgeColor = 'none';
ylabel('N^{o} of Profiles')

saveas(gcf,'DSW_TS_2std.png');
print -depsc2 DSW_TS_2std.eps

% saveas(gcf,'fig_timeseriesDSW_c_summer.png');
% saveas(gcf, 'fig_timeseriesDSW_c_summer.eps');


%%%bottom S T 

%CTD

%clear all
load ShackCTD_data_coast_no_interp.mat
load massa_dagua_index_ShackCTD_data_coast_no_interp


%%ctd west
ig=find(y>=-66 & y<=-65 & x>=94 & x<=96)
% ig=find(y<-66)
% ig2=find(x>90.5 & x<96.5 & y<-65.5);
% ig3=find(x>92 & x<96.5 & y<-65.25);
% ig4=find(x>93 & x<96.5 & y<-65);
% ig5=find(x>95 & x<96.5 & y<-64.5);
% ig=[ig ig2 ig3 ig4 ig5];
% ig=unique(ig);

S=S(:,ig);
GA=GA(:,ig);
PT=PT(:,ig);
P=P(:,ig);
y=y(:,ig);
x=x(:,ig);
yr=yr(:,ig);
index=index(:,ig);

%bottom
%calculating mCDW for max T
s=size(PT);

%tem que refazer isso
max_id=[];
bt_depth=[];
S_depth=[];
t=PT;
for i=1:s(2);
    a=isnan(t(:,i));
    ii=find(a==0); %achar o ponto maximo que seja numerico.
    if isempty(ii)==0
    MA1=nanmax(ii);
    max_id=[max_id,P(MA1,i)];
    bt_depth=[bt_depth,PT(MA1,i)];
    S_depth=[S_depth,S(MA1,i)];
    else
    max_id=[max_id,nan];    
    bt_depth=[bt_depth,nan];
    S_depth=[S_depth,nan];
    clear MA1 a i
    end
end

tt=find(max_id>=400);
bt_depth=bt_depth(tt);
S_depth=S_depth(tt);
yr=yr(tt);

% %%to verify the depths
% x1=x(tt);
% y1=y(tt);
% real_dth=max_id(tt);
% idx=find(yr==1956)
% real_dth(idx)
% bt_depth(idx)
% S_depth(idx)
% y2=y1(idx)
% x2=x1(idx)
% %determina um meshgrid de lat/lon para o bedmap fornecer os dados depois
% lat_gps = linspace(-71,55,400);
% lon_gps = linspace(40,160,400);
% 
% %pega os dados de matimetria do bedmap para um determiando range de lat/lon
% [y3,x3,bed] = bedmap2_data('bed',y2,x2); 
% d_bedmap=[]
% for i=1:5;
% ii=find(x3>=(x2(i)-0.0005) & x3<=(x2(i)+0.0005));
% a=y3(ii);
% [val,idx]=min(abs(a-y2(i)));
% minVal=a(idx);
% final_id=ii(idx);
% depth=bed(final_id)
% d_bedmap=[d_bedmap depth];
% end

% [meanByYear,yr2,yrcounts]=groupsummary(data(:,2),data(:,1),'all');
% bt_depth=meanByYear(:,4);
% bt_yr=yr2;
% bar_ctd_bt=meanByYear(:,11);

data=[yr' bt_depth']
[meanByYear,yr2,yrcounts]=groupsummary(data(:,2),data(:,1),'all');
bt_depth=meanByYear(:,4);
bt_yr=yr2;
bar_ctd_bt=meanByYear(:,11);
std_ctd_bt=meanByYear(:,9);

data=[yr' S_depth']
[meanByYear,yr2,yrcounts]=groupsummary(data(:,2),data(:,1),'all');
S_depth=meanByYear(:,4);
std_ctd_bt_sal=meanByYear(:,9);

k=isnan(bt_depth);
kk=find(k==0);
bt_depth=bt_depth(kk);
S_depth=S_depth(kk);
bar_ctd_bt=bar_ctd_bt(kk);
std_ctd_bt=std_ctd_bt(kk);
std_ctd_bt_sal=std_ctd_bt_sal(kk);

%seal
%%figs with map + Vertical T + Vertical S + TS
load West_Shack_VB_Totten_triado_coast.mat
load  massa_dagua_index_coast_d

%%seal west
%test summer for laura
%ig=find(lat_vcb>=-66 & lat_vcb<=-65 & lon_vcb>=93 & lon_vcb<=96 & mth_vcb<=3)

ig=find(lat_vcb>=-66 & lat_vcb<=-65 & lon_vcb>=94 & lon_vcb<=96)

% ig=find(lat_vcb<-66)
% ig2=find(lon_vcb>90.5 & lon_vcb<96.5 & lat_vcb<-65.5);
% ig3=find(lon_vcb>92 & lon_vcb<96.5 & lat_vcb<-65.25);
% ig4=find(lon_vcb>93 & lon_vcb<96.5 & lat_vcb<-65);
% ig5=find(lon_vcb>95 & lon_vcb<96.5 & lat_vcb<-64.5);
% ig=[ig ig2 ig3 ig4 ig5];
% ig=unique(ig);
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
%bottom
%calculating mCDW for max T
s=size(PTb);

%tem que refazer isso
max_idb=[];
bt_depthb=[];
S_depthb=[];
t=PTb;
for i=1:s(2);
    a=isnan(t(:,i));
    ii=find(a==0); %achar o ponto maximo que seja numerico.
    if isempty(ii)==0
    MA1=nanmax(ii);
    max_idb=[max_idb,Pb(MA1,i)];
    bt_depthb=[bt_depthb,PTb(MA1,i)];
    S_depthb=[S_depthb,Sb(MA1,i)];
    else
    max_idb=[max_idb,nan];    
    bt_depthb=[bt_depthb,nan];
    S_depthb=[S_depthb,nan];
    clear MA1 a i
    end
end

tt=find(max_idb>=400);
bt_depthb=bt_depthb(tt);
S_depthb=S_depthb(tt);
yrb=yrb(tt);
% 
data=[yrb' bt_depthb']
[meanByYear,yr2,yrcounts]=groupsummary(data(:,2),data(:,1),'all');
bt_depthb=meanByYear(:,4);
bt_yrb=yr2;
bar_s_bt=meanByYear(:,11);
std_s_bt=meanByYear(:,9);

data=[yrb' S_depthb']
[meanByYear,y2r,yrcounts]=groupsummary(data(:,2),data(:,1),'all');
S_depthb=meanByYear(:,4);
std_s_bt_sal=meanByYear(:,9);

k=isnan(bt_depthb);
kk=find(k==0);
bt_depthb=bt_depthb(kk);
S_depthb=S_depthb(kk);
bar_s_bt=bar_s_bt(kk);
std_s_bt=std_s_bt(kk);
std_s_bt_sal=std_s_bt_sal(kk);

fig=figure;
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
fit1=errorbar(bt_yr,S_depth,2*std_ctd_bt_sal,'LineStyle','none',...
    'Color',[94,60,153]/256,'linewidth', 1.5)
fit1=plot(bt_yr,S_depth,'o')
set(fit1                          , ...
  'Color', [94,60,153]/256, ...
  'MarkerSize',       8, ...
  'LineWidth'       , 2           );
hold on
fit2=errorbar(bt_yrb,S_depthb,2*std_s_bt_sal,'LineStyle','none',...
    'Color',[94,60,153]/256,'linewidth', 1.5)
fit2=plot(bt_yrb,S_depthb,'s')
set(fit2                          , ...
    'Color', [94,60,153]/256, ...
    'MarkerSize',          9, ...
    'LineWidth'       ,     3       );
hold on;
% fit3=plot([bt_yr(length(bt_yr)),bt_yrb(1)],...
%           [S_depth(length(bt_yr)),S_depthb(1)])
% set(fit3                          , ...
%     'Color', [.75,.75,.75], ...
%     'LineStyle', '--', ...
%   'LineWidth'       ,     1       );
title('Bottom \theta/S (65-66\circS; 94-96\circE)');
ylabel('Bottom S');
xlim([1956,2016])
ax=gca;
ax.YAxis(1).Color = [94,60,153]/256;
hold on;
ax = gca;
ax.FontSize = 22; 
hold on;

% Create a new axes in the same position as the first one, overlaid on top
h_ax = gca;
h_ax_line = axes('position', get(h_ax, 'position')); 
hold on;
fit3=errorbar(bt_yr,bt_depth,2*std_ctd_bt,'LineStyle','none',...
    'Color',[230,97,1]/256,'linewidth', 1)
fit3=plot(bt_yr,bt_depth,'o')
set(fit3                          , ...
  'Color', [230,97,1]/256, ...
  'MarkerSize',      8, ...
  'LineWidth'       , 2           );
hold on
fit4=errorbar(bt_yrb,bt_depthb,2*std_s_bt,'LineStyle','none',...
    'Color',[230,97,1]/256,'linewidth', 1)
fit4=plot(bt_yrb,bt_depthb,'s')
set(fit4                          , ...
  'Color', [230,97,1]/256, ...
  'MarkerSize', 9, ...
  'LineWidth'       , 3           );
hold on;
% fit5=plot([bt_yr(length(bt_yr)),bt_yrb(1)],...
%           [bt_depth(length(bt_yr)),bt_depthb(1)])
% set(fit5                          , ...
%     'Color', [.75,.75,.75], ...
%     'LineStyle', '--', ...
%   'LineWidth'       ,     1       );
ylabel('Bottom {\theta} (^{\circ}C)');
% Put the new axes' y labels on the right, set the x limits the same as the original axes', and make the background transparent
set(h_ax_line, 'YAxisLocation', 'right', 'xlim', get(h_ax, 'xlim'), 'color', 'none'); 
set(gca,'XColor', 'none')
%fixing the graph box
set(gca, ...
  'Box'         , 'off'     , ...
  'TickDir'     , 'out'     , ...
  'TickLength'  , [.02 .02] , ...
  'XMinorTick'  , 'on'      , ...
  'YMinorTick'  , 'on'      , ...
  'LineWidth'   , 1         );

ax=gca;
ax.YAxis(1).Color = [230,97,1]/256;
ax = gca;
ax.FontSize = 22; 
hold on;

% Create a new axes in the same position as the first one, overlaid on top
h_ax = gca;
h_ax_line = axes('position', get(h_ax, 'position')); 
hold on;
b2=bar(bt_yr,bar_ctd_bt,'FaceColor',[.75,.75,.75]);
b2.FaceAlpha = 0.6;
b2.EdgeColor = 'none';
b1=bar(bt_yrb,bar_s_bt,'FaceColor',[.75,.75,.75]);
b1.FaceAlpha = 0.6;
b1.EdgeColor = 'none';
ylim([0 50])

% Put the new axes' y labels on the right, set the x limits the same as the original axes', and make the background transparent
set(h_ax_line, 'YAxisLocation', 'right', 'xlim', get(h_ax, 'xlim'), 'color', 'none'); 
set(gca,'XColor', 'none')
set(gca,'YColor', 'none')
ax = gca;
ax.FontSize = 22; 
hold on;


hAx(2)=axes('position',pos,'color','none');
pos=get(hAx(1),'position');
set(gca,'XColor', 'none')
%fixing the graph box
set(gca, ...
  'Box'         , 'off'     , ...
  'TickDir'     , 'out'     , ...
  'TickLength'  , [.02 .02] , ...
  'YMinorTick'  , 'on'      , ...
  'LineWidth'   , 1         );
hold on;
b2=bar(bt_yr,bar_ctd_bt,'FaceColor',[.75 .75 .75]);
b2.FaceAlpha = 0.6;
b2.EdgeColor = 'none';
b1=bar(bt_yrb,bar_s_bt,'FaceColor',[.75 .75 .75]);
b1.FaceAlpha = 0.6;
b1.EdgeColor = 'none';
ylabel('N^{o} of Profiles')
ylim([0 50])
ax = gca;
ax.FontSize = 22; 
hold on;

saveas(gcf,'BT_TS_2std.png');
print -depsc2 BT_TS_2std.eps
