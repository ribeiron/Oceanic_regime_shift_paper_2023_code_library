%%Fig.6 new

%%newFig6
addpath 'C:\Users\nribeiro\Desktop\Seal Data\matlab_tools\TOOLBOX\cmocean'                    

%%trying out gade line profiles for the shackleton 
%%figs with map + Vertical T + Vertical S + TS
%load massa_dagua_index_shack+west index
cd 'C:\Users\nribeiro\Desktop\Chapter 2'
load West_Shack_VB_Totten_triado_coast.mat
%load ShackCTD_data_coast.mat
load ShackCTD_data_coast_no_interp.mat
hold on;

addpath 'C:\Users\nribeiro\Desktop\Seal Data\matlab_tools\TOOLBOX\seawater'
addpath 'C:\Users\nribeiro\Desktop\Seal Data\matlab_tools' %for gade_line
addpath 'C:\Users\nribeiro\Desktop\Seal Data\matlab_tools\TOOLBOX\cbdate\cbdate'
load isolines_all_years.mat

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
CT_17=temp_pot_vcb(:,ie);
PR_17=pres_adj_vcb(:,ie);
lat_17=lat_vcb(:,ie);
lon_17=lon_vcb(:,ie);

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

%subset the depth below 200m
s=size(SA_17);
SA_17b=nan(s(1),s(2));
CT_17b=nan(s(1),s(2));
PR_17b=nan(s(1),s(2));
for k=1:s(2);
    kk=find(PR_17(:,k)>=200);
    SA_17b(kk,k)=SA_17(kk,k);
    CT_17b(kk,k)=CT_17(kk,k);
    PR_17b(kk,k)=PR_17(kk,k);
end


%sort data
u=isnan(SA_17b);
uu=find(u==0);
SA_17b=SA_17b(uu);
CT_17b=CT_17b(uu);
PR_17b=PR_17b(uu);
[f,g]=sort(PR_17b);
SA_17b=SA_17b(g);
CT_17b=CT_17b(g);
PR_17b=f;

%ctd
ie=find(x(1,:) > 90 & x(1,:) <= 96.5);

S=S(:,ie);
PT=PT(:,ie);
P=P(:,ie);
yr=yr(ie);
mth=month(ie);

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


%ctd 90s
% start_date=datenum(1950,1,1);
% end_date=datenum(1999,12,31)
% ih=find(D2>=start_date & D2<=end_date);
% 
% yaki2=[255,255,217;...
%     237,248,177;...
%     199,233,180;...
%     127,205,187;...
%     65,182,196;...
%     29,145,192;...
%     34,94,168;...
%     37,52,148;...
%     8,29,88;...
%     129,15,124;...
%     231,41,138;...
%     247,104,161]
% 
% yaki2=yaki2/256;
% 
fig=figure;
fig.Position = [5 5 1000 600]; 
subplot(2,2,1)
hold on;
sz=1;

scatter(S2,PT2,8,P2,'o','filled')
% scatter(S2,PT2,20,D2,'o','fille')

hold on;
ylabel({'\theta (\circC)'});
%xlabel('Salinity');
title('Historical data (W)')
ax = gca;
ax.FontSize = 16; 
caxis([200,1000]);
 
h=colorbar
set( h, 'YDir', 'reverse' );
ylabel(h, 'Pressure (dbar)')
t=get(h,'Limits');   %Azzi Abdelmalek contribution. Great Matalab answers contributor
T=linspace(t(1),t(2),5)
set(h,'Ticks',T)
set(colorbar,'visible','off')
hold on%, box on
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
%a=gade_line(-1.8,34.5,1000,'r')
%a=gade_line(-1.4,34.46,500,'k')
%a=gade_line(-1.55,34.53,500,'g')
% load gadeVanderford.mat
% gade_line(gT,gS,P,'c');
gade_line(-1.35,34.48,300,'k')
gade_line(-1.55,34.53,300,'g')
xlim([34.1,34.6]);
ylim([-2 -1]);
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
h=text(34.12,-1.2,'27.7','Color',[0.75,0.75, 0.75],'Fontsize',11);
set(h,'Rotation',80); % tilt
hold on;
h=text(34.45,-1.2,'28','Color',[0.75,0.75, 0.75],'Fontsize',11);
set(h,'Rotation',75); % tilt
hold on;
h=text(34.54,-1.2,'28.27','Color',[0.75,0.75, 0.75],'Fontsize',11);
set(h,'Rotation',72); % tilt
line(SA_axis_ctd,CT_freezing_ctd,'LineStyle','--','LineWidth',1.5);

% saveas(gcf,'fig3_part2_before90.png');
% print -depsc2 fig3_part2_ctd_before90.eps

%%
%2014 % this one is alright
 
%%seals
% start_date=datenum(2000,1,1);
% end_date=datenum(2020,12,31)
% ig=find(date_s>=start_date & date_s<=end_date);


%fig=figure;
subplot(2,2,2)
hold on;
sz=1;

fit1=scatter(SA_17b,CT_17b,8,PR_17b,'o','filled')
fit1.MarkerFaceAlpha = .2;
hold on;

%subset the depth below 200m
s=size(SA_17);
SA_17b=nan(s(1),s(2));
CT_17b=nan(s(1),s(2));
PR_17b=nan(s(1),s(2));
for k=1:s(2);
    kk=find(PR_17(:,k)>=200);
    SA_17b(kk,k)=SA_17(kk,k);
    CT_17b(kk,k)=CT_17(kk,k);
    PR_17b(kk,k)=PR_17(kk,k);
end

%testing
% ig2=[806,807
%ig2=[876,878,879,908]; out of iso 
%ig2=[832,836,838,847,855] out of iso
%ig2=[92,93,81,82,122] out of iso
%yr17(ig2)
%lon_17(ig2)
%plot(SA_17b(:,ig2),CT_17b(:,ig2),'LineWidth',2)

ig2=[784,795,796,817];
%works but has to go: 818
%works but only when together with others 820,823,824,825,881
ig3=[351,352];
a=yr17(ig2)
%ylabel({'\theta (\circC)'});
title('Seal data (W)')
%xlabel('Salinity');
ax = gca;
ax.FontSize = 16; 
caxis([200,1000]);
 
h=colorbar
set( h, 'YDir', 'reverse' );
ylabel(h, 'Pressure (dbar)')
t=get(h,'Limits');   %Azzi Abdelmalek contribution. Great Matalab answers contributor
T=linspace(t(1),t(2),5)
set(h,'Ticks',T)
hold on%, box on

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
%gade_line(-1.36,34.46,500,'k') old
gade_line(-1.35,34.48,300,'k')
gade_line(-1.55,34.53,300,'g')
xlim([34.1,34.6]);
ylim([-2 -1]);


%% mean profiles do before sorting
S1=SA_17b(:,ig2)
C1=CT_17b(:,ig2)
PR1=PR_17b(:,ig2)

%// define a "uniform" grid without holes (same boundaries and sampling than original grid)
[AI,BI] = meshgrid(1,1:10:1001) ;
s=size(S1);
PR_interp=repmat(BI,1,s(2))
%// re-interpolate scattered data (only valid indices) over the "uniform" grid

t_seal = [];
s_seal = [];
for i=2:s(2);
    %// identify indices valid for the 3 matrix 
    idxgood=~(isnan(C1(:,i)) | isnan(PR1(:,i))); 

    %interp s & t 
    t = interp1(PR1(idxgood,i),C1(idxgood,i),BI);
    sal = interp1(PR1(idxgood,i),S1(idxgood,i),BI);
    t_seal = [t_seal t];
    s_seal = [s_seal sal];
end

%plot(SA_17b(:,ig2),PR_17b(:,ig2))
plot(nanmean(s_seal,2),nanmean(t_seal,2),'Color','r','LineWidth',2)

%% mean profiles do before sorting
S1=SA_17b(:,ig3)
C1=CT_17b(:,ig3)
PR1=PR_17b(:,ig3)


%// define a "uniform" grid without holes (same boundaries and sampling than original grid)
[AI,BI] = meshgrid(1,1:10:1001) ;
s=size(S1);
PR_interp=repmat(BI,1,s(2))
%// re-interpolate scattered data (only valid indices) over the "uniform" grid

t_seal = [];
s_seal = [];
for i=2:s(2);
    %// identify indices valid for the 3 matrix 
    idxgood=~(isnan(C1(:,i)) | isnan(PR1(:,i))); 

    %interp s & t 
    t = interp1(PR1(idxgood,i),C1(idxgood,i),BI);
    sal = interp1(PR1(idxgood,i),S1(idxgood,i),BI);
    t_seal = [t_seal t];
    s_seal = [s_seal sal];
end

plot(nanmean(s_seal,2),nanmean(t_seal,2),'Color','m','LineWidth',2)
% hold on;
% plot(nanmean(SA_17b(:,ig3),2),nanmean(CT_17b(:,ig3),2),'LineWidth',5)
% for i=1:length(ig2);
% scatter(SA_17b(:,ig2(i)),CT_17b(:,ig2(i)),90,'r.')
% end
% for i=1:length(ig3);
% scatter(SA_17b(:,ig3(i)),CT_17b(:,ig3(i)),90,'m.')
% end

% load gadeVanderford.mat
% gade_line(gT,gS,P,'c');
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
h=text(34.12,-1.2,'27.7','Color',[0.75,0.75, 0.75],'Fontsize',11);
set(h,'Rotation',80); % tilt
hold on;
h=text(34.45,-1.2,'28','Color',[0.75,0.75, 0.75],'Fontsize',11);
set(h,'Rotation',75); % tilt
hold on;
h=text(34.54,-1.2,'28.27','Color',[0.75,0.75, 0.75],'Fontsize',11);
set(h,'Rotation',72); % tilt
%load freezingpoint
line(SA_axis_seal,CT_freezing_seal,'LineStyle','--','LineWidth',1.4);



subplot(2,2,4)
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

ig2=[784,795,796,817];
ig3=[351,352];
ig4=[801,836,915,931,937];

    m_proj('mercator','lon',[92 100],'lat',[-67 -64]);
    [c,hContour]=m_contour(lon,lat,bed,[-400,-600,-800,-1000,-1500, -2000, -2500, -3000],'color',[.75 .75 .75]);
    hold on;
    %[c,hContour]=m_contour(lon,lat,bed,[-1000,-1000],'-k','linewidth',2);
    %m_elev('contourf'); colormap gray;
    m_gshhs_h('patch',[.5 .5 .5]); %usando o pacote de alta resolucao
    hold on;
    ax = gca;
    ax.FontSize = 16;
    [c,h(1)]=m_contour(lon,lat,n,[1,1])
    hold on;
    m_grid('linewi',2,'tickdir','out');
    hold on;
    pointsize=35;
    hold on;
    h2=m_plot(lon_17(ig2),lat_17(ig2),'ro','markersize',6,'markeredgecolor','k','markerfacecolor','r');
    h2=m_plot(lon_17(ig3),lat_17(ig3),'mo','markersize',6,'markeredgecolor','k','markerfacecolor','m');
    h2=m_plot(lon_17(ig4),lat_17(ig4),'ko','markersize',3,'markeredgecolor','k','markerfacecolor','k');
    hold on
    [c,hContour]=m_contour(lon,lat,icemask,[1,1],'LineColor'...
    ,'k','LineWidth',1);
    m_gshhs_h('Color','k');
    title('');
    gade_line(-1.35,34.48,300,'k')
    gade_line(-1.55,34.53,300,'g')
    xlabel('Longitude')
    ylabel('Latitude')


%labeling the isolines
hold on;
h=text(34.12,-1.2,'27.7','Color',[0.75,0.75, 0.75],'Fontsize',11);
set(h,'Rotation',80); % tilt
hold on;
h=text(34.45,-1.2,'28','Color',[0.75,0.75, 0.75],'Fontsize',11);
set(h,'Rotation',75); % tilt
hold on;
h=text(34.54,-1.2,'28.27','Color',[0.75,0.75, 0.75],'Fontsize',11);
set(h,'Rotation',72); % tilt
%load freezingpoint
line(SA_axis_seal,CT_freezing_seal,'LineStyle','--','LineWidth',1.4);

%east
%load massa_dagua_index_shack+west index
cd 'C:\Users\nribeiro\Desktop\Chapter 2'
load West_Shack_VB_Totten_triado_coast.mat
%load ShackCTD_data_coast.mat
load ShackCTD_data_coast_no_interp.mat
hold on;

addpath 'C:\Users\nribeiro\Desktop\Seal Data\matlab_tools\TOOLBOX\seawater'
addpath 'C:\Users\nribeiro\Desktop\Seal Data\matlab_tools' %for gade_line
addpath 'C:\Users\nribeiro\Desktop\Seal Data\matlab_tools\TOOLBOX\cbdate\cbdate'
load isolines_all_years.mat

ie=find(lon_vcb(1,:) > 97 & lon_vcb(1,:) <= 102);

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
CT_17=temp_pot_vcb(:,ie);
PR_17=pres_adj_vcb(:,ie);
lat_17=lat_vcb(:,ie);
lon_17=lon_vcb(:,ie);

%subset the depth below 200m
s=size(SA_17);
SA_17b=nan(s(1),s(2));
CT_17b=nan(s(1),s(2));
PR_17b=nan(s(1),s(2));
for k=1:s(2);
    kk=find(PR_17(:,k)>=200);
    SA_17b(kk,k)=SA_17(kk,k);
    CT_17b(kk,k)=CT_17(kk,k);
    PR_17b(kk,k)=PR_17(kk,k);
end

%
%have to do this to find the right profiles for the gade line later
lon_17=repmat(lon_17,30,1);
lat_17=repmat(lat_17,30,1);

%sort data
u=isnan(SA_17b);
uu=find(u==0);
SA_17b=SA_17b(uu);
CT_17b=CT_17b(uu);
PR_17b=PR_17b(uu);
[f,g]=sort(PR_17b);
SA_17b=SA_17b(g);
CT_17b=CT_17b(g);
PR_17b=f;

                   
%ctd
ie=find(x(1,:) > 97 & x(1,:) <= 102);
S=S(:,ie);
PT=PT(:,ie);
P=P(:,ie);
yr=yr(ie);
mth=month(ie);

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

subplot(2,2,3)
hold on;
sz=1;

scatter(S2,PT2,25,P2,'s','filled','MarkerEdgeColor','k')
scatter(SA_17b,CT_17b,15,PR_17b,'o','filled')
hold on;
%gade_line(-1.8,34.5,1000,'r')
%gade_line(-1.4,34.46,500,'k')
%gade_line(-1.4,34.53,500,'g')

% hold on;
% for i=1:length(d)
% scatter(SA_17b(d(i)),CT_17b(d(i)),90,'r.')
% end
% 
hold on;
ylabel({'\theta (\circC)'});
xlabel('Salinity');
title('Historical/Seal data (E)')
ax = gca;
ax.FontSize = 16; 
caxis([200,1000]);

h=colorbar
set( h, 'YDir', 'reverse' );
ylabel(h, 'Pressure (dbar)')
t=get(h,'Limits');   %Azzi Abdelmalek contribution. Great Matalab answers contributor
T=linspace(t(1),t(2),5)
set(h,'Ticks',T)
hold on%, box on
hold on; %loading neutral surfaces values
[c1,h] = contour(SA_gridded,CT_gridded,smoothdata(isopycs_gridded,'gaussian'),isopycs,'Color',[0.75,0.75, 0.75],'Linewidth',2);
% plot(smoothdata(c1(1,:),'rloess'),smoothdata(c1(2,:),'rloess'),'Color',[0.75,0.75, 0.75],'Linewidth',2)
% hold on;
% plot(smoothdata(c2(1,:),'rloess'),smoothdata(c2(2,:),'rloess'),'Color',[0.75,0.75, 0.75],'Linewidth',2)
% hold on;
% plot(smoothdata(c3(1,:),'rloess'),smoothdata(c3(2,:),'rloess'),'Color',[0.75,0.75, 0.75],'Linewidth',2)
hold on;
line([34.52,34.85],[-1.8 -1.8],'Color','k','LineStyle',':','LineWidth',3)%line for D
% load gadeVanderford.mat
% gade_line(gT,gS,P,'c');
xlim([34.1,34.6]);
ylim([-2 -1]);
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
h=text(34.12,-1.2,'27.7','Color',[0.75,0.75, 0.75],'Fontsize',11);
set(h,'Rotation',80); % tilt
hold on;
h=text(34.45,-1.2,'28','Color',[0.75,0.75, 0.75],'Fontsize',11);
set(h,'Rotation',75); % tilt
hold on;
h=text(34.54,-1.2,'28.27','Color',[0.75,0.75, 0.75],'Fontsize',11);
set(h,'Rotation',72); % tilt
%load freezingpoint
line(SA_axis_seal,CT_freezing_seal,'LineStyle','--','LineWidth',1.4);
gade_line(-1.35,34.48,300,'k')
gade_line(-1.55,34.53,300,'g')

saveas(gcf,'fig6_new.png');
print -depsc2 fig6_new.eps




%%%%%%%%%%%%%%%%%%%%%%
%%the mean fig

%%newFig6
addpath 'C:\Users\nribeiro\Desktop\Seal Data\matlab_tools\TOOLBOX\cmocean'                    

%%trying out gade line profiles for the shackleton 
%%figs with map + Vertical T + Vertical S + TS
%load massa_dagua_index_shack+west index
cd 'C:\Users\nribeiro\Desktop\Chapter 2'
load West_Shack_VB_Totten_triado_coast.mat
%load ShackCTD_data_coast.mat
load ShackCTD_data_coast_no_interp.mat
hold on;

addpath 'C:\Users\nribeiro\Desktop\Seal Data\matlab_tools\TOOLBOX\seawater'
addpath 'C:\Users\nribeiro\Desktop\Seal Data\matlab_tools' %for gade_line
addpath 'C:\Users\nribeiro\Desktop\Seal Data\matlab_tools\TOOLBOX\cbdate\cbdate'
load isolines_all_years.mat

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
CT_17=temp_pot_vcb(:,ie);
PR_17=pres_adj_vcb(:,ie);
lat_17=lat_vcb(:,ie);
lon_17=lon_vcb(:,ie);

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

%subset the depth below 200m
s=size(SA_17);
SA_17b=nan(s(1),s(2));
CT_17b=nan(s(1),s(2));
PR_17b=nan(s(1),s(2));
for k=1:s(2);
    kk=find(PR_17(:,k)>=200);
    SA_17b(kk,k)=SA_17(kk,k);
    CT_17b(kk,k)=CT_17(kk,k);
    PR_17b(kk,k)=PR_17(kk,k);
end


%sort data
u=isnan(SA_17b);
uu=find(u==0);
SA_17b=SA_17b(uu);
CT_17b=CT_17b(uu);
PR_17b=PR_17b(uu);
[f,g]=sort(PR_17b);
SA_17b=SA_17b(g);
CT_17b=CT_17b(g);
PR_17b=f;

%ctd
ie=find(x(1,:) > 90 & x(1,:) <= 96.5);
S=S(:,ie);
PT=PT(:,ie);
P=P(:,ie);
yr=yr(ie);
mth=month(ie);

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


%%%
%%mean values
fig=figure;
fig.Position = [5 5 1000 600]; 

%subset the depth below 200m
s=size(SA_17);
SA_17b=nan(s(1),s(2));
CT_17b=nan(s(1),s(2));
PR_17b=nan(s(1),s(2));
for k=1:s(2);
    kk=find(PR_17(:,k)>=200);
    SA_17b(kk,k)=SA_17(kk,k);
    CT_17b(kk,k)=CT_17(kk,k);
    PR_17b(kk,k)=PR_17(kk,k);
end

subplot(2,2,1)
sz=1;
hold on; %loading neutral surfaces values
% plot(smoothdata(c1(1,:),'rloess'),smoothdata(c1(2,:),'rloess'),'Color',[0.75,0.75, 0.75],'Linewidth',2)
hold on; %loading neutral surfaces values
[c1,h] = contour(SA_gridded,CT_gridded,smoothdata(isopycs_gridded,'gaussian'),isopycs,'Color',[0.75,0.75, 0.75],'Linewidth',2);
% plot(smoothdata(c1(1,:),'rloess'),smoothdata(c1(2,:),'rloess'),'Color',[0.75,0.75, 0.75],'Linewidth',2)
% hold on;
% plot(smoothdata(c2(1,:),'rloess'),smoothdata(c2(2,:),'rloess'),'Color',[0.75,0.75, 0.75],'Linewidth',2)
% hold on;
% plot(smoothdata(c3(1,:),'rloess'),smoothdata(c3(2,:),'rloess'),'Color',[0.75,0.75, 0.75],'Linewidth',2)

%3-point mixing
%ig2=[833];
%ig2=[801,836]
%ig2=[809,810];
%ig2=[820,824,825];
%ig2=[801,836,915,931,937]; works
ig2=[801,836,915,931,937];
%% mean profiles do before sorting
S1=SA_17b(:,ig2)
C1=CT_17b(:,ig2)
PR1=PR_17b(:,ig2)

%// define a "uniform" grid without holes (same boundaries and sampling than original grid)
[AI,BI] = meshgrid(1,1:10:1001) ;
s=size(S1);
PR_interp=repmat(BI,1,s(2))
%// re-interpolate scattered data (only valid indices) over the "uniform" grid

t_seal = [];
s_seal = [];
for i=2:s(2);
    %// identify indices valid for the 3 matrix 
    idxgood=~(isnan(C1(:,i)) | isnan(PR1(:,i))); 

    %interp s & t 
    t = interp1(PR1(idxgood,i),C1(idxgood,i),BI);
    sal = interp1(PR1(idxgood,i),S1(idxgood,i),BI);
    t_seal = [t_seal t];
    s_seal = [s_seal sal];
end

%plot(nanmean(s_seal,2),nanmean(t_seal,2),'Color','k','LineWidth',2)
for i=1:length(ig2);
scatter(SA_17b(:,ig2(i)),CT_17b(:,ig2(i)),120,'k.')
end

load fig4_meanvalues
%[a]=gade_line(-1.55,34.43,500,'k')
hold on;
line([34.52,34.85],[-1.8 -1.8],'Color','k','LineStyle',':','LineWidth',3)%line for D
%ctd before
[d1a] = line([S_cdwb+S_cdwbSTD,S_cdwb-S_cdwbSTD],[PT_cdwb,PT_cdwb],...
    'LineStyle','-','LineWidth',1.5,'color','r');
hold on;
[d1a] = line([S_cdwb,S_cdwb],[PT_cdwb+PT_cdwbSTD,PT_cdwb-PT_cdwbSTD],...
    'LineStyle','-','LineWidth',1.5,'color','r');  
% [d1b] = plot(S_cdwb-S_cdwbSTD,PT_cdwb-PT_cdwbSTD,'.','color','r');
% [d1c] = plot(S_cdwb+S_cdwbSTD,PT_cdwb+PT_cdwbSTD,'.','color','r');
[d1] = plot(S_cdwb,PT_cdwb,'.','color',[44 127 184]./255);
set(d1,'Marker','d','MarkerSize',7*sz,'MarkerEdgeColor','black', ...
  'MarkerFaceColor','r');

hold on;

[d1a] = line([S_dswb+S_dswbSTD,S_dswb-S_dswbSTD],[PT_dswb,PT_dswb],...
    'LineStyle','-','LineWidth',1.5,'color','c');
hold on;
[d1a] = line([S_dswb,S_dswb],[PT_dswb+PT_dswbSTD,PT_dswb-PT_dswbSTD],...
    'LineStyle','-','LineWidth',1.5,'color','c');  
% [d1b] = plot(S_cdwb-S_cdwbSTD,PT_cdwb-PT_cdwbSTD,'.','color','r');
% [d1c] = plot(S_cdwb+S_cdwbSTD,PT_cdwb+PT_cdwbSTD,'.','color','r');
[d1] = plot(S_dswb,PT_dswb,'.','color',[44 127 184]./255);
set(d1,'Marker','d','MarkerSize',7*sz,'MarkerEdgeColor','black', ...
  'MarkerFaceColor','c');

[d1a] = line([S_iswb+S_iswbSTD,S_iswb-S_iswbSTD],[PT_iswb,PT_iswb],...
    'LineStyle','-','LineWidth',1.5,'color',[0.4940 0.1840 0.5560]);
hold on;
[d1a] = line([S_iswb,S_iswb],[PT_iswb+PT_iswbSTD,PT_iswb-PT_iswbSTD],...
    'LineStyle','-','LineWidth',1.5,'color',[0.4940 0.1840 0.5560]);  
% [d1b] = plot(S_cdwb-S_cdwbSTD,PT_cdwb-PT_cdwbSTD,'.','color','r');
% [d1c] = plot(S_cdwb+S_cdwbSTD,PT_cdwb+PT_cdwbSTD,'.','color','r');
[d1] = plot(S_iswb,PT_iswb,'.','color',[44 127 184]./255);
set(d1,'Marker','d','MarkerSize',7*sz,'MarkerEdgeColor','black', ...
  'MarkerFaceColor',[0.4940 0.1840 0.5560]);


[d1a] = line([S_wwb+S_wwbSTD,S_wwb-S_wwbSTD],[PT_wwb,PT_wwb],...
    'LineStyle','-','LineWidth',1.5,'color','g');
hold on;
[d1a] = line([S_wwb,S_wwb],[PT_wwb+PT_wwbSTD,PT_wwb-PT_wwbSTD],...
    'LineStyle','-','LineWidth',1.5,'color','g');  
% [d1b] = plot(S_cdwb-S_cdwbSTD,PT_cdwb-PT_cdwbSTD,'.','color','r');
% [d1c] = plot(S_cdwb+S_cdwbSTD,PT_cdwb+PT_cdwbSTD,'.','color','r');
[d1] = plot(S_wwb,PT_wwb,'.','color','g');
set(d1,'Marker','d','MarkerSize',7*sz,'MarkerEdgeColor','black', ...
  'MarkerFaceColor','g');

% %ctd after
% [d1] = plot(S_cdwa,PT_cdwa,'.','color',[44 127 184]./255);
% set(d1,'Marker','s','MarkerSize',7*sz,'MarkerEdgeColor','black', ...
%   'MarkerFaceColor','r');
% [d1] = plot(S_dswa,PT_dswa,'.','color',[44 127 184]./255);
% set(d1,'Marker','s','MarkerSize',7*sz,'MarkerEdgeColor','black', ...
%   'MarkerFaceColor','cyan');
% hold on;
% [d1] = plot(S_iswa,PT_iswa,'.','color',[44 127 184]./255);
% set(d1,'Marker','s','MarkerSize',7*sz,'MarkerEdgeColor','black', ...
%   'MarkerFaceColor',[0.4940 0.1840 0.5560]);

%seal
[d1a] = line([SA_cdw+SA_cdwSTD,SA_cdw-SA_cdwSTD],[CT_cdw,CT_cdw],...
    'LineStyle','-','LineWidth',1.5,'color','r');
hold on;
[d1a] = line([SA_cdw,SA_cdw],[CT_cdw+CT_cdwSTD,CT_cdw-CT_cdwSTD],...
    'LineStyle','-','LineWidth',1.5,'color','r');  
% [d1b] = plot(S_cdwb-S_cdwbSTD,PT_cdwb-PT_cdwbSTD,'.','color','r');
% [d1c] = plot(S_cdwb+S_cdwbSTD,PT_cdwb+PT_cdwbSTD,'.','color','r');
[d1] = plot(SA_cdw,CT_cdw,'.','color',[44 127 184]./255);
set(d1,'Marker','o','MarkerSize',7*sz,'MarkerEdgeColor','black', ...
  'MarkerFaceColor','r');


hold on;
[d1a] = line([SA_dsw+SA_dswSTD,SA_dsw-SA_dswSTD],[CT_dsw,CT_dsw],...
    'LineStyle','-','LineWidth',1.5,'color','c');
hold on;
[d1a] = line([SA_dsw,SA_dsw],[CT_dsw+CT_dswSTD,CT_dsw-CT_dswSTD],...
    'LineStyle','-','LineWidth',1.5,'color','c');  
% [d1b] = plot(S_cdwb-S_cdwbSTD,PT_cdwb-PT_cdwbSTD,'.','color','r');
% [d1c] = plot(S_cdwb+S_cdwbSTD,PT_cdwb+PT_cdwbSTD,'.','color','r');
[d1] = plot(SA_dsw,CT_dsw,'.','color',[44 127 184]./255);
set(d1,'Marker','o','MarkerSize',7*sz,'MarkerEdgeColor','black', ...
  'MarkerFaceColor','c');

hold on;
[d1a] = line([SA_isw+SA_iswSTD,SA_isw-SA_iswSTD],[CT_isw,CT_isw],...
    'LineStyle','-','LineWidth',1.5,'color',[0.4940 0.1840 0.5560]);
hold on;
[d1a] = line([SA_isw,SA_isw],[CT_isw+CT_iswSTD,CT_isw-CT_iswSTD],...
    'LineStyle','-','LineWidth',1.5,'color',[0.4940 0.1840 0.5560]);  
% [d1b] = plot(S_cdwb-S_cdwbSTD,PT_cdwb-PT_cdwbSTD,'.','color','r');
% [d1c] = plot(S_cdwb+S_cdwbSTD,PT_cdwb+PT_cdwbSTD,'.','color','r');
[d1] = plot(SA_isw,CT_isw,'.','color',[44 127 184]./255);
set(d1,'Marker','o','MarkerSize',7*sz,'MarkerEdgeColor','black', ...
  'MarkerFaceColor',[0.4940 0.1840 0.5560]);

hold on;
[d1a] = line([SA_ww+SA_wwSTD,SA_ww-SA_wwSTD],[CT_ww,CT_ww],...
    'LineStyle','-','LineWidth',1.5,'color','g');
hold on;
[d1a] = line([SA_ww,SA_ww],[CT_ww+CT_wwSTD,CT_ww-CT_wwSTD],...
    'LineStyle','-','LineWidth',1.5,'color','g');  
% [d1b] = plot(S_cdwb-S_cdwbSTD,PT_cdwb-PT_cdwbSTD,'.','color','r');
% [d1c] = plot(S_cdwb+S_cdwbSTD,PT_cdwb+PT_cdwbSTD,'.','color','r');
[d1] = plot(SA_ww,CT_ww,'.','color',[44 127 184]./255);
set(d1,'Marker','o','MarkerSize',7*sz,'MarkerEdgeColor','black', ...
  'MarkerFaceColor','g');

%east
hold on;
[d1a] = line([SA_e+SA_eSTD,SA_e-SA_eSTD],[CT_e,CT_e],...
    'LineStyle','-','LineWidth',1.5,'color',[0.9290 0.6940 0.1250]);
hold on;
[d1a] = line([SA_e,SA_e],[CT_e+CT_eSTD,CT_e-CT_eSTD],...
    'LineStyle','-','LineWidth',1.5,'color',[0.9290 0.6940 0.1250]);  
% [d1b] = plot(S_cdwb-S_cdwbSTD,PT_cdwb-PT_cdwbSTD,'.','color','r');
% [d1c] = plot(S_cdwb+S_cdwbSTD,PT_cdwb+PT_cdwbSTD,'.','color','r');
[d1] = plot(SA_e,CT_e,'.','color',[44 127 184]./255);
set(d1,'Marker','o','MarkerSize',7*sz,'MarkerEdgeColor','black', ...
  'MarkerFaceColor',[0.9290 0.6940 0.1250]);

%
hold on;
[d1a] = line([S_e+S_eSTD,S_e-S_eSTD],[PT_e,PT_e],...
    'LineStyle','-','LineWidth',1.5,'color',[0.9290 0.6940 0.1250]);
hold on;
[d1a] = line([S_e,S_e],[PT_e+PT_eSTD,PT_e-PT_eSTD],...
    'LineStyle','-','LineWidth',1.5,'color',[0.9290 0.6940 0.1250]);  
% [d1b] = plot(S_cdwb-S_cdwbSTD,PT_cdwb-PT_cdwbSTD,'.','color','r');
% [d1c] = plot(S_cdwb+S_cdwbSTD,PT_cdwb+PT_cdwbSTD,'.','color','r');
[d1] = plot(S_e,PT_e,'.','color',[44 127 184]./255);
set(d1,'Marker','d','MarkerSize',7*sz,'MarkerEdgeColor','black', ...
  'MarkerFaceColor',[0.9290 0.6940 0.1250]);

hold on; 
ax = gca;
ax.FontSize = 14; 
xlim([34,34.6]);
ylim([-2 -1]);

%ylabel('\theta (^{\circ}C)');
xlabel('Salinity');
title('Avg values')
ax = gca;
ax.FontSize = 16; 
h=colorbar
set(h,'Color','none');
set(h,'visible','off')

%labeling the isolines
hold on;
h=text(34.12,-1.2,'27.7','Color',[0.75,0.75, 0.75],'Fontsize',11);
set(h,'Rotation',80); % tilt
hold on;
h=text(34.45,-1.2,'28','Color',[0.75,0.75, 0.75],'Fontsize',11);
set(h,'Rotation',75); % tilt
hold on;
h=text(34.54,-1.2,'28.27','Color',[0.75,0.75, 0.75],'Fontsize',11);
set(h,'Rotation',72); % tilt
%load freezingpoint
line(SA_axis_seal,CT_freezing_seal,'LineStyle','--','LineWidth',1.4);
set(h,'Rotation',80); % tilt
set(gca, ...
  'Box'         , 'off'     , ...
  'TickDir'     , 'out'     , ...
  'TickLength'  , [.02 .02] , ...
  'XMinorTick'  , 'on'      , ...
  'YMinorTick'  , 'on'      , ...
  'LineWidth'   , 1         );

saveas(gcf,'fig6_new2.png');
print -depsc2 fig6_new2.eps


