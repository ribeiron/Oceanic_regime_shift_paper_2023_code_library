%%figs with map + Vertical T + Vertical S + TS
clear all
cd 'C:\Users\nribeiro\Desktop\Chapter 2'
load West_Shack_VB_Totten_triado_coast.mat
%%set the CTD bit
load ShackCTD_data_coast_no_interp.mat

addpath 'C:\Users\nribeiro\Desktop\Seal Data\matlab_tools\TOOLBOX\seawater'
addpath 'C:\Users\nribeiro\Desktop\Seal Data\matlab_tools' %for gade_line
addpath 'C:\Users\nribeiro\Desktop\Seal Data\matlab_tools\TOOLBOX\tight_subplot'
addpath 'C:\Users\nribeiro\Desktop\Seal Data\matlab_tools\TOOLBOX\suplabel'

load isolines_all_years.mat


%seals west trimming 
ie=find(lon_vcb(1,:) > 90 & lon_vcb(1,:) <= 96.5);

yr17=yr_vcb(1,ie);
mth17=mth_vcb(1,ie);
day17=day_vcb(1,ie);
hr17=hr_vcb(1,ie);
mi17=mi_vcb(1,ie);
sec17=sec_vcb(1,ie);
sn=seal_vcb(1,ie);

SA_17=sal_adj_vcb(:,ie);
ND_17=ND_vcb(:,ie);
CT_17=temp_pot_vcb(:,ie);
PR_17=pres_adj_vcb(:,ie);
lat_17=lat_vcb(:,ie);
lon_17=lon_vcb(:,ie);

%sort data to plot deepest last
date17=[yr17' mth17' day17' hr17' mi17' sec17'];
date17=datenum(date17);

date_rev=repmat(date17',30,1)

%subset the depth below 200m
s=size(SA_17);
SA_17b=nan(s(1),s(2));
CT_17b=nan(s(1),s(2));
PR_17b=nan(s(1),s(2));
date_17b=nan(s(1),s(2));
for k=1:s(2);
    kk=find(PR_17(:,k)>=200);
    SA_17b(kk,k)=SA_17(kk,k);
    CT_17b(kk,k)=CT_17(kk,k);
    PR_17b(kk,k)=PR_17(kk,k);
    date_17b(kk,k)=date_rev(kk,k);
end


%sort data
u=isnan(SA_17b);
uu=find(u==0);
SA_17b=SA_17b(uu);
CT_17b=CT_17b(uu);
PR_17b=PR_17b(uu);
date_17b=date_17b(uu);
[f,g]=sort(PR_17b);
SA_17b=SA_17b(g);
CT_17b=CT_17b(g);
date_17b=date_17b(g);
PR_17b=f;

%ctd west trimming
ie=find(x(1,:) > 90 & x(1,:) <= 96.5);

S=S(:,ie);
GA=GA(:,ie);
PT=PT(:,ie);
P=P(:,ie);
y=y(:,ie);
x=x(:,ie);

%subset the depth below 200m
s=size(S);
S2=nan(s(1),s(2));
PT2=nan(s(1),s(2));
P2=nan(s(1),s(2));
for k=1:s(2);
    kk=find(P(:,k)>=200);
    S2(kk,k)=S(kk,k);
    PT2(kk,k)=PT(kk,k);
    P2(kk,k)=P(kk,k);
end

%sort data
u=isnan(S2);
uu=find(u==0);
S2=S2(uu);
PT2=PT2(uu);
P2=P2(uu);
[f,g]=sort(P2);
S2=S2(g);
PT2=PT2(g);
P2=f;

%to get variables to draw freezing point line
TS_seawater_ND_joint(S,PT,x,y,0);
close all 
load freezingpoint
SA_axis_ctd=SA_axis;
CT_freezing_ctd=CT_freezing;

%to get variables to draw freezing point line
TS_seawater_ND_joint(SA_17,CT_17,lon_17,lat_17,0);
close all 
load freezingpoint
SA_axis_seal=SA_axis;
CT_freezing_seal=CT_freezing;

%%to get the values for the isolines
TS_seawater_ND(SA_17,CT_17,lon_17,lat_17,0,[27.7 28.00 28.27],'Feb');
load ND_isogrid.mat
% figure;
% [c1,h] = contour(SA_gridded,CT_gridded,smoothdata(isopycs_gridded,'rloess'),isopycs,':','Color','r');
% [c1,h] = contour(SA_gridded,CT_gridded,isopycs_gridded,isopycs,'Color',[0.75,0.75, 0.75],'Linewidth',2);

s=size(S2);
fig=figure;
[ha, pos] = tight_subplot(1, 2, [0.1 0.04],[.18 .1],[.07 .05])
axes(ha(1));
% subplot(1,2,1);
hold on;
sz=1;
for i=1:s(2);
scatter(S2,PT2,20,P2,'o','filled')
end
hold on;

ylabel({'\theta (\circC)'});
xlabel('Salinity');
%title('CTD 87-96.5 ^{\circ}E')
ax = gca;
ax.FontSize = 16; 
caxis([200,1000]);
 
h=colorbar
set(h, 'YDir', 'reverse' );
%ylabel(h, 'Depth (m)')
t=get(h,'Limits');   %Azzi Abdelmalek contribution. Great Matalab answers contributor
T=linspace(t(1),t(2),5)
set(h,'Ticks',T)
set(h,'visible','off')

hold on, box on
hold on; %loading neutral surfaces values
[c1,h] = contour(SA_gridded,CT_gridded,smoothdata(isopycs_gridded,'gaussian'),isopycs,'Color',[0.75,0.75, 0.75],'Linewidth',2);
% plot(smoothdata(c1(1,:),'rloess'),smoothdata(c1(2,:),'rloess'),'Color',[0.75,0.75, 0.75],'Linewidth',2)
% hold on;
% plot(smoothdata(c2(1,:),'rloess'),smoothdata(c2(2,:),'rloess'),'Color',[0.75,0.75, 0.75],'Linewidth',2)
% hold on;
% plot(smoothdata(c3(1,:),'rloess'),smoothdata(c3(2,:),'rloess'),'Color',[0.75,0.75, 0.75],'Linewidth',2)
hold on;
line([34.52,34.85],[-1.8 -1.8],'Color','k','LineStyle',':','LineWidth',3)%line for D
hold on;
%gade_line(-1.8,34.5,1000,'r')
%gade_line(-1.55,34.46,500,'k')
%gade_line(-1.052,34.51,500,'g')

xlim([34,34.8]);
%ylim([-2.1 -0.8]);
ylim([-2.1, 0.6]);
set(gca, ...
  'Box'         , 'off'     , ...
  'TickDir'     , 'out'     , ...
  'TickLength'  , [.02 .02] , ...
  'XMinorTick'  , 'on'      , ...
  'YMinorTick'  , 'on'      , ...
  'LineWidth'   , 1         );
hold on;
 
%labeling the isolines
hold on;
h=text(34.18,0,'27.7','Color',[0.75,0.75, 0.75],'Fontsize',14);
set(h,'Rotation',75); % tilt
hold on;
h=text(34.51,0,'28','Color',[0.75,0.75, 0.75],'Fontsize',14);
set(h,'Rotation',75); % tilt
hold on;
h=text(34.65,0,'28.27','Color',[0.75,0.75, 0.75],'Fontsize',14);
set(h,'Rotation',72); % tilt
line(SA_axis_ctd,CT_freezing_ctd,'LineStyle','--','LineWidth',1.5);
 
%saveas(gcf,'fig_scatterTSb_ctd.png');
%print -depsc2 fig_scatterTSb_ctd.eps

%close all
%%
%2014 % this one is alright
 
 
%fig=figure;
hold on;
s=size(SA_17b);
axes(ha(2));
% subplot(1,2,2);
hold on;
sz=1;
for i=1:s(2);
scatter(SA_17b,CT_17b,20,PR_17b,'o','filled')
end
% for_rev=datevec(date_17b);
% for i=1:s(2);
% scatter(SA_17b,CT_17b,20,for_rev(:,2),'o','filled')
% end
ylabel({'\theta (\circC)'});
xlabel('Salinity');
%title('Seals 87-96.5 ^{\circ}E')
ax = gca;
ax.FontSize = 16; 
caxis([200,1000]);
%colormap(parula(9))
%caxis([1,10]);

 
h=colorbar
set( h, 'YDir', 'reverse' );
ylabel(h, 'Pressure (dbar)')
t=get(h,'Limits');   %Azzi Abdelmalek contribution. Great Matalab answers contributor
T=linspace(t(1),t(2),5)
%T=linspace(t(1),t(2),10)
set(h,'Ticks',T)
hold on, box on
hold on; %loading neutral surfaces values
[c1,h] = contour(SA_gridded,CT_gridded,smoothdata(isopycs_gridded,'gaussian'),isopycs,'Color',[0.75,0.75, 0.75],'Linewidth',2);
%hold on; %loading neutral surfaces values
%plot(smoothdata(c1(1,:),'rloess'),smoothdata(c1(2,:),'rloess'),'Color','r','Linewidth',2)
% hold on;
% plot(smoothdata(c2(1,:),'rloess'),smoothdata(c2(2,:),'rloess'),'Color',[0.75,0.75, 0.75],'Linewidth',2)
% hold on;
%plot(smoothdata(c3(1,:),'rloess'),smoothdata(c3(2,:),'rloess'),'Color',[0.75,0.75, 0.75],'Linewidth',2)
%hold on;
line([34.52,34.85],[-1.8 -1.8],'Color','k','LineStyle',':','LineWidth',3)%line for D
hold on;
%gade_line(-1.8,34.5,1000,'r')
%gade_line(-1.35,34.46,500,'k')
%gade_line(-1.052,34.51,500,'g')
% load gadeVanderford.mat
% gade_line(gT,gS,P,'c');
xlim([34,34.8]);
ylim([-2.1, 0.6]);
set(gca, ...
  'Box'         , 'off'     , ...
  'TickDir'     , 'out'     , ...
  'TickLength'  , [.02 .02] , ...
  'XMinorTick'  , 'on'      , ...
  'YMinorTick'  , 'on'      , ...
  'LineWidth'   , 1         );
hold on;
 
%labeling the isolines
hold on;
h=text(34.18,0,'27.7','Color',[0.75,0.75, 0.75],'Fontsize',14);
set(h,'Rotation',75); % tilt
hold on;
h=text(34.51,0,'28','Color',[0.75,0.75, 0.75],'Fontsize',14);
set(h,'Rotation',75); % tilt
hold on;
h=text(34.65,0,'28.27','Color',[0.75,0.75, 0.75],'Fontsize',14);
set(h,'Rotation',72); % tilt
%load freezingpoint
line(SA_axis_seal,CT_freezing_seal,'LineStyle','--','LineWidth',1.4);
 

%saveas(gcf,'fig_scatterTSb_seal.png');
%print -depsc2 fig_scatterTSb_seal.eps 
fig.PaperPositionMode = 'auto';
saveas(gcf,'fig_3c_TS.png');
print -depsc2 fig_3c_TS.eps 
print('fig_3c_TS','-dpng', '-r600')
%%%%%%%%%%%%%

%testing the east


