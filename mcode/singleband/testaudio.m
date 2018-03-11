%
close all;


NPOINTS=200;
RADIUS =10;
K=4.0;
A=1.0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

IMAGESDIR='~/data/cafe-biospeckle/sem1';
DATA=datapack(IMAGESDIR,'',1,128,'bmp');

figure(1);
GAVD=graphavd(DATA,'off');
GAVD=mwindowing(GAVD,8,8);

imagesc(GAVD);
ht=title('AVD index in analysis windows of 8x8 pixels');
colormap(jet);
colorbar;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
FONTSIZE=20;
ha = gca();%% current axis object. 
set(ha,'fontsize',FONTSIZE);%% cambia solamente los ejes
set(ht,'fontsize',FONTSIZE);%% cambia solamente el titulo
print(gcf,['image-single',num2str(0) ,'.eps'],'-depsc',['-F:',int2str(FONTSIZE)]);
%Arregla con inkscape para colocar imagen como fondo y puntos como frente.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

N=4;
Y=cell(1,3);
AVD=cell(1,3);
for II=1:N
    hf=figure;
    GAVD=graphavd(DATA,'off');
    GAVD=mwindowing(GAVD,8,8);
    imagesc(GAVD);
    ht=title('AVD index in analysis windows of 8x8 pixels');
    colormap(jet);
    colorbar;

    msgbox('Selecciona un punto');
    [x,y] = ginput(1);
    P0=[y x];

    if(II==1) 
        THSP=thsp_gaussian(DATA,NPOINTS,RADIUS,P0,hf,'on-red');
    elseif(II==2) 
        THSP=thsp_gaussian(DATA,NPOINTS,RADIUS,P0,hf,'on-blue');
    elseif(II==3) 
        THSP=thsp_gaussian(DATA,NPOINTS,RADIUS,P0,hf,'on-green');
    elseif(II==4) 
        THSP=thsp_gaussian(DATA,NPOINTS,RADIUS,P0,hf,'on-white');
    end

    drawnow ();
    refresh ();
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    FONTSIZE=20;
    ha = gca();%% current axis object. 
    set(ha,'fontsize',FONTSIZE);%% cambia solamente los ejes
    set(ht,'fontsize',FONTSIZE);%% cambia solamente el titulo
    print(hf,['image-single',num2str(II) ,'.eps'],'-depsc',['-F:',int2str(FONTSIZE)]);
    %Arregla con inkscape para colocar imagen como fondo y puntos como frente.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    COM=coom(THSP);
    AVD{II}=avd(COM);

    fs=8000;    N=1024*8;
    n=[0:N-1];  t=n/fs;

    fref=fs/2;
    fi=K*(AVD{II}/256)*fref;

    Y{II}=sin(2*pi*fi*t);
    
    obj=audioplayer (Y{II}, fs);
    play(obj);

    wavwrite (Y{II}, fs, 8, ['audio-single',num2str(II) ,'.wav']);

end

hf2=figure(2);
MZ=12;
plot(   n/(N),abs(fft(Y{1})),'-r<','markersize',MZ ,...
        n/(N),abs(fft(Y{2})),'-bo','markersize',MZ , ...
        n/(N),abs(fft(Y{3})),'-g>','markersize',MZ );
grid on
xlim([0 0.25]);
hx=xlabel('Normalized frequency (f/fs)');
hy=ylabel('|FFT(yi)|');
hl=legend('Red points','Blue points','Green points');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
FONTSIZE=20;
ha = gca();%% current axis object. 
set(ha,'fontsize',FONTSIZE);%% cambia solamente los ejes
%set(ht,'fontsize',FONTSIZE);%% cambia solamente el titulo
set(hx,'fontsize',FONTSIZE);%% cambia solamente el texto de x
set(hy,'fontsize',FONTSIZE);%% cambia solamente el texto de y
set(hl,'fontsize',FONTSIZE);%% cambia solamente el texto de legend

print(hf2,'image-freq-single.eps','-depsc',['-F:',int2str(FONTSIZE)]);

save('data-single-avd.dat','AVD')
save('data-single-audio.dat','Y')

