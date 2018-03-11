%
close all
addpath('funcs');
pkg load bsltl
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%IMAGESDIR='~/data/cafe-biospeckle/sem1';
IMAGESDIR='/home/fernando/data/cafe-biospeckle/sem1';
OUTPUT=fullfile(IMAGESDIR,'output');

NNN=3;

RADIUS =10;
NPOINTS=200;
K=1.0;
A=1.0;


fs=4096;
NSAMPLES=0.5*fs;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mkdir(OUTPUT);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%close all;
DATA                 =datapack(IMAGESDIR,'%d',1,128,'bmp');
[DATA00 DATA01 DATA1 F1c F2c F3c]=func_divide_pack(DATA,fs);
[C D E]=stdcont(DATA,'off');
D=mwindowing(D,8,8);
BSImax=max(max(D))




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% hf=figure;
%%%% imagesc(D);
%%%% FONTSIZE=20;
%%%% ht=title('STD index in analysis windows of 8x8 pixels');
%%%% colormap(jet)
%%%% colorbar;
%%%% print(hf,fullfile(OUTPUT,'select_points0.eps'),'-depsc',['-F:',int2str(FONTSIZE)]);

close(gcf());


DATA=cell(1,NNN);
for II=1:NNN
    disp('Select a point')

    hf=figure;
    imagesc(D);
    FONTSIZE=20;
    ht=title('STD index in analysis windows of 8x8 pixels');
    colormap(jet)
    colorbar;


    if II==1
        [THSP1 POINTS]= thsp_gaussian(DATA1,NPOINTS,RADIUS,hf,'on-red');
    elseif II==2
        [THSP1 POINTS]= thsp_gaussian(DATA1,NPOINTS,RADIUS,hf,'on-blue');
    elseif II==3
        [THSP1 POINTS]= thsp_gaussian(DATA1,NPOINTS,RADIUS,hf,'on-green');
    elseif II==4
        [THSP1 POINTS]= thsp_gaussian(DATA1,NPOINTS,RADIUS,hf,'on-white');
    end
    [THSP01]      = thsp_points(DATA01, POINTS);
    [THSP00]      = thsp_points(DATA00, POINTS);


    print(hf,fullfile(OUTPUT,['select_points' num2str(II) '.eps']),'-depsc',['-F:',int2str(FONTSIZE)]);

    BSI1 =mean(std(THSP1' ));
    BSI01=mean(std(THSP01'));
    BSI00=mean(std(THSP00'));
    


    y=generator([BSI00 BSI01 BSI1],BSImax,fs/3.0,fs,NSAMPLES);
    y=[y y y y];
    
    %%figure(2)
    %%plot(y(1:fs/8),'-o')

    y=y/max(y);
    obj=audioplayer (y, fs);
    play(obj);
    wavwrite (y, fs, 8, fullfile(OUTPUT,['audio-multi' num2str(II) '.wav']));

    DATA{II}.K=K;
    DATA{II}.A=A;
    DATA{II}.RADIUS=RADIUS;
    DATA{II}.NPOINTS=NPOINTS;
    DATA{II}.POINT0=[mean(POINTS(:,1)) mean(POINTS(:,2))];
    DATA{II}.BSImax=BSImax;
    %DATA{II}.y=y;
    DATA{II}.BSI1=BSI1;
    DATA{II}.BSI01=BSI01;
    DATA{II}.BSI00=BSI00;

    if II==1
    MAT=[      DATA{II}.BSI00,DATA{II}.BSI01, DATA{II}.BSI1];
    else
    MAT=[ MAT; DATA{II}.BSI00,DATA{II}.BSI01, DATA{II}.BSI1];
    end
end

save(fullfile(OUTPUT,'data-multi-std.dat'),'DATA');

save(fullfile(OUTPUT,'data-multi-std.txt'),'MAT','-ascii');

rmpath('funcs');
