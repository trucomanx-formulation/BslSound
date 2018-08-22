%
close all;
pkg load bsltl

NPOINTS=200;
RADIUS =10;
K=4.0;
A=1.0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

IMAGESDIR='~/data/cafe-biospeckle/sem1';
DATA=datapack(IMAGESDIR,'',1,128,'bmp');

figure(1);
[C D E]=stdcont(DATA,'off');
D=mwindowing(D,8,8);

imagesc(D);
ht=title('STD index in analysis windows of 8x8 pixels');
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

N=3;
Y=cell(1,N);
STD=cell(1,N);
POINTS=cell(1,N);
for II=1:N
    hf=figure;
    [C D E]=stdcont(DATA,'off');
    D=mwindowing(D,8,8);
    imagesc(D);
    ht=title('STD index in analysis windows of 8x8 pixels');
    colormap(jet);
    colorbar;

    msgbox('Selecciona un punto');
    [x,y] = ginput(1);
    P0=[y x];

    if(II==1) 
        [THSP POINTS{II}]=thsp_gaussian(DATA,NPOINTS,RADIUS,P0,hf,'on-black-filled');
    elseif(II==2) 
        [THSP POINTS{II}]=thsp_gaussian(DATA,NPOINTS,RADIUS,P0,hf,'on-gray-filled');
    elseif(II==3) 
        [THSP POINTS{II}]=thsp_gaussian(DATA,NPOINTS,RADIUS,P0,hf,'on-white-filled');
    elseif(II>3) 
        [THSP POINTS{II}]=thsp_gaussian(DATA,NPOINTS,RADIUS,P0,hf,'on-white');
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

    STD{II}=mean(std(THSP'));

    fs=8000;    N=1024*8;
    n=[0:N-1];  t=n/fs;

    fref=fs/2;
    fi=K*(STD{II}/256)*fref;

    Y{II}=sin(2*pi*fi*t);
    
    obj=audioplayer (Y{II}, fs);
    play(obj);

    wavwrite (Y{II}, fs, 8, ['audio-single',num2str(II) ,'.wav']);

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hfx=figure;
imagesc(D);
ht=title('STD index in analysis windows of 8x8 pixels');
colormap(jet);
colorbar;
hold on;
scatter(POINTS{1}(:,2),POINTS{1}(:,1),'k','filled');
hold off;
hold on;
scatter(POINTS{2}(:,2),POINTS{2}(:,1),[],0.7*ones(NPOINTS,3),'filled');
hold off;
hold on;
scatter(POINTS{3}(:,2),POINTS{3}(:,1),'w','filled');
hold off;


FONTSIZE=20;
ha = gca();%% current axis object. 
set(ha,'fontsize',FONTSIZE);%% cambia solamente los ejes
set(ht,'fontsize',FONTSIZE);%% cambia solamente el titulo


print(hfx,'image-freq-single-allinone.eps','-depsc',['-F:',int2str(FONTSIZE)]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hf2=figure(2);
MZ=12;
plot(   n/(N),abs(fft(Y{1})),'-k<','markersize',MZ ,...
        n/(N),abs(fft(Y{2})),'-ko','markersize',MZ , ...
        n/(N),abs(fft(Y{3})),'-k>','markersize',MZ );
grid on
xlim([0 0.25]);
hx=xlabel('Normalized frequency (f/fs)');
hy=ylabel('|FFT(yi)|');
hl=legend('Black points','Gray points','White points');


FONTSIZE=20;
ha = gca();%% current axis object. 
set(ha,'fontsize',FONTSIZE);%% cambia solamente los ejes
%set(ht,'fontsize',FONTSIZE);%% cambia solamente el titulo
set(hx,'fontsize',FONTSIZE);%% cambia solamente el texto de x
set(hy,'fontsize',FONTSIZE);%% cambia solamente el texto de y
set(hl,'fontsize',FONTSIZE);%% cambia solamente el texto de legend

print(hf2,'image-freq-single.eps','-depsc',['-F:',int2str(FONTSIZE)]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


save('data-single-std.dat','STD')
save('data-single-audio.dat','Y')

