function [DATA00 DATA01 DATA1 F1c F2c F3c]=func_divide_pack(DATA,Fs)

ORDER=48;

F_3=9.0/9.0;
F_2=6.0/9.0;
F_1=3.0/9.0;


F1=F_1*Fs/2;
F2=F_2*Fs/2;
F3=F_3*Fs/2;

F1c=F1/2;
F2c=(F1/2)*(F1+F2)/2;
F3c=(F1/2)*(F3+F2)/2;

H0 = get_fir_filter(ORDER,F_2,'low');
G0 = get_fir_filter(ORDER,F_1,'low');
[DATA0  DATA1 ] = firfilterbank(DATA,H0,'mode0');
clear DATA
[DATA00 DATA01] = firfilterbank(DATA0,G0,'mode0');

%%         |---------------DATA1----
%% DATA ---|
%%         |           |---DATA01---
%%         |---DATA0---|
%%                     |---DATA00---

end
