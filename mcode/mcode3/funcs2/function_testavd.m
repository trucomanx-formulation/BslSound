%
function [DATA THSP POINTS]=function_testavd(DIRECTORY,IIDD,PATTERN,Min,Max)

set(0,'DefaultFigureColormap',feval('jet'));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%IMAGESDIR='~/data/cafe-biospeckle/sem1';
IMAGESDIR=fullfile(DIRECTORY,['sem' num2str(IIDD)]);
OUTPUT=fullfile(IMAGESDIR,'output_testfilter');

NNN=1;

RADIUS =10;
NPOINTS=200;


fs=4096;
NSAMPLES=0.5*fs;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rmdir(OUTPUT);
mkdir(OUTPUT);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%close all;
DATAT =datapack(IMAGESDIR,PATTERN,Min,Max,'bmp');
ORDER=24;
H0 = get_fir_filter(ORDER,2.0/3.0,'low');
G0 = get_fir_filter(ORDER,1.0/3.0,'low');
[DATA0  DATA1 ] = firfilterbank(DATAT,H0,'mode0');
[DATA00 DATA01] = firfilterbank(DATA0,G0,'mode0');
clear DATA0
%%% DATA00 DATA01 DATA1 DATAT
close all
[C D E]=stdcont(DATAT);
figure(1);
figure(2);
figure(3);
FONTSIZE=20;
print(figure(1),fullfile(OUTPUT,'total-mean.eps'),'-depsc',['-F:',int2str(FONTSIZE)]);
print(figure(2),fullfile(OUTPUT,'total-std.eps'),'-depsc',['-F:',int2str(FONTSIZE)]);
print(figure(3),fullfile(OUTPUT,'total-contrast.eps'),'-depsc',['-F:',int2str(FONTSIZE)]);
close all

[GBSI]=graphavd(DATAT);
figure(1);
print(figure(1),fullfile(OUTPUT,'total-avd.eps'),'-depsc',['-F:',int2str(FONTSIZE)]);
close all

DATA=cell(1,NNN);
THSP=cell(1,NNN);
POINTS=cell(1,NNN);
for II=1:NNN


    [THSP{II} POINTS{II}]= thsp_gaussian(DATAT,NPOINTS,RADIUS,GBSI,'on');


    [THSP1 ] = thsp_points(DATA1 , POINTS{II});
    [THSP01] = thsp_points(DATA01, POINTS{II});
    [THSP00] = thsp_points(DATA00, POINTS{II});

    hf=figure;
    imagesc_with_points(GBSI, POINTS{II});
    title('AVD');
    FONTSIZE=20;
    colorbar;
    colormap(jet);
    print(hf,fullfile(OUTPUT,['select_points' num2str(II) '.eps']),'-depsc',['-F:',int2str(FONTSIZE)]);
    close(hf);

    BSIA =avd(coom(THSP{II}));
    BSIT =mean(std(THSP{II}'));

    BSI1 =mean(std(THSP1'));%avd(coom(THSP1));
    BSI01=mean(std(THSP01'));%avd(coom(THSP01));
    BSI00=mean(std(THSP00'));%avd(coom(THSP00));
   

    DATA{II}.RADIUS=RADIUS;
    DATA{II}.NPOINTS=NPOINTS;
    DATA{II}.POINT0=[mean(POINTS{II}(:,1)) mean(POINTS{II}(:,2))];
    DATA{II}.BSIA=BSIA;
    DATA{II}.BSIT=BSIT;
    DATA{II}.BSI1=BSI1;
    DATA{II}.BSI01=BSI01;
    DATA{II}.BSI00=BSI00;

    if II==1
    MAT=[      DATA{II}.BSI00,DATA{II}.BSI01, DATA{II}.BSI1];
    else
    MAT=[ MAT; DATA{II}.BSI00,DATA{II}.BSI01, DATA{II}.BSI1];
    end
end

save(fullfile(OUTPUT,'data-multi.dat'),'DATA');

end
