%

[y3, fs] = audioread (fullfile(OUTPUT,'audio-multi3.wav'));fs
[y2, fs] = audioread (fullfile(OUTPUT,'audio-multi2.wav'));fs
[y1, fs] = audioread (fullfile(OUTPUT,'audio-multi1.wav'));fs

N=4096/2;

n=[1:round(N/48)];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subplot (3, 3, 1)
plot((n-1)/fs,y1(n),'r');grid;
ylabel('$y^1_1$');
xlabel('t - secs');
%title('S1');
xlim([min((n-1)/fs) max((n-1)/fs)]);

subplot (3, 3, 2)
plot((N+n-1)/fs,y1(N+n),'r');grid;
ylabel('$y^2_1$');
xlabel('t - secs');
%title('S1');
xlim([min((N+n-1)/fs) max((N+n-1)/fs)]);


subplot (3, 3, 3)
plot((2*N+n-1)/fs,y1(2*N+n),'r');grid;
ylabel('$y^3_1$');
xlabel('t - secs');
%title('S1');
xlim([min((2*N+n-1)/fs) max((2*N+n-1)/fs)]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subplot (3, 3, 4)
plot((n-1)/fs,y2(n),'r');grid;
ylabel('$y^1_2$');
xlabel('t - secs');
%title('S1');
xlim([min((n-1)/fs) max((n-1)/fs)]);

subplot (3, 3, 5)
plot((N+n-1)/fs,y2(N+n),'r');grid;
ylabel('$y^2_2$');
xlabel('t - secs');
%title('S1');
xlim([min((N+n-1)/fs) max((N+n-1)/fs)]);


subplot (3, 3, 6)
plot((2*N+n-1)/fs,y2(2*N+n),'r');grid;
ylabel('$y^3_2$');
xlabel('t - secs');
%title('S1');
xlim([min((2*N+n-1)/fs) max((2*N+n-1)/fs)]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subplot (3, 3, 7)
plot((n-1)/fs,y3(n),'r');grid;
ylabel('$y^1_3$');
xlabel('t - secs');
%title('S1');
xlim([min((n-1)/fs) max((n-1)/fs)]);

subplot (3, 3, 8)
plot((N+n-1)/fs,y3(N+n),'r');grid;
ylabel('$y^2_3$');
xlabel('t - secs');
%title('S1');
xlim([min((N+n-1)/fs) max((N+n-1)/fs)]);


subplot (3, 3, 9)
plot((2*N+n-1)/fs,y3(2*N+n),'r');grid;
ylabel('$y^3_3$');
xlabel('t - secs');
%title('S1');
xlim([min((2*N+n-1)/fs) max((2*N+n-1)/fs)]);

%%print('yfuncs.eps','-deps');

print(gcf,'yfuncs.tex','-depslatexstandalone');

