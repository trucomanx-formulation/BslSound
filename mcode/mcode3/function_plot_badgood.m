function [IDDEAD IDLIVE BSI1_DEAD BSI1_LIVE BSI01_DEAD BSI01_LIVE BSI00_DEAD BSI00_LIVE BSIA_DEAD BSIA_LIVE BSIT_DEAD BSIT_LIVE]=function_plot_badgood(FILENAME)
    pkg load statistics
    DATA=load(FILENAME);
    IDDEAD=DATA.CONFDATA.IDDEAD;
    IDLIVE=DATA.CONFDATA.IDLIVE;
    DATADEAD=DATA.CONFDATA.DATADEAD;
    DATALIVE=DATA.CONFDATA.DATALIVE;

    N=7;
    BSI1_DEAD=zeros(1,N);
    BSI1_LIVE=zeros(1,N);
    BSI01_DEAD=zeros(1,N);
    BSI01_LIVE=zeros(1,N);
    BSI00_DEAD=zeros(1,N);
    BSI00_LIVE=zeros(1,N);
    BSIA_DEAD=zeros(1,N);
    BSIA_LIVE=zeros(1,N);
    BSIT_DEAD=zeros(1,N);
    BSIT_LIVE=zeros(1,N);
    for II=1:N
        BSI1_DEAD(II)=DATADEAD{II}{1}.BSI1;
        BSI1_LIVE(II)=DATALIVE{II}{1}.BSI1;

        BSI01_DEAD(II)=DATADEAD{II}{1}.BSI01;
        BSI01_LIVE(II)=DATALIVE{II}{1}.BSI01;

        BSI00_DEAD(II)=DATADEAD{II}{1}.BSI00;
        BSI00_LIVE(II)=DATALIVE{II}{1}.BSI00;

        BSIA_DEAD(II)=DATADEAD{II}{1}.BSIA;
        BSIA_LIVE(II)=DATALIVE{II}{1}.BSIA;

        BSIT_DEAD(II)=DATADEAD{II}{1}.BSIT;
        BSIT_LIVE(II)=DATALIVE{II}{1}.BSIT;
    end
    POS_DEAD=-0.1*ones(1,N);
    POS_LIVE= 0.1*ones(1,N);
    FONTSIZE=20;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    figure;
    scatter ([BSI1_LIVE BSI1_DEAD], [POS_LIVE POS_DEAD], 500, [0.33*ones(1,N) 0.66*ones(1,N)],"filled");
    ylim([-1 1]);
    for II=1:N
    text (BSI1_LIVE(II), POS_LIVE(II)+0.1,num2str(IDLIVE(II)));
    text (BSI1_DEAD(II), POS_DEAD(II)-0.1,num2str(IDDEAD(II)));
    end
    xlabel('std index in DATA1')
    print(gcf,'DATA1-STD.eps','-depsc',['-F:',int2str(FONTSIZE)]);

    figure
    pts1=[BSI1_DEAD' BSI1_LIVE'];
    boxplot(pts1);
    ylabel('std index in DATA1')
    set(gca (), "xtick", [1 2], "xticklabel", {"Dead", "Alive"});
    print(gcf,'DATA1-STD-box.eps','-depsc',['-F:',int2str(FONTSIZE)]);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    figure;
    scatter ([BSI01_LIVE BSI01_DEAD], [POS_LIVE POS_DEAD], 500, [0.33*ones(1,N) 0.66*ones(1,N)],"filled");
    ylim([-1 1]);
    for II=1:N
    text (BSI01_LIVE(II), POS_LIVE(II)+0.1,num2str(IDLIVE(II)));
    text (BSI01_DEAD(II), POS_DEAD(II)-0.1,num2str(IDDEAD(II)));
    end
    xlabel('std index in DATA01')
    print(gcf,'DATA01-STD.eps','-depsc',['-F:',int2str(FONTSIZE)]);

    figure
    pts1=[BSI01_DEAD' BSI01_LIVE'];
    boxplot(pts1);
    ylabel('std index in DATA01')
    set(gca (), "xtick", [1 2], "xticklabel", {"Dead", "Alive"});
    print(gcf,'DATA01-STD-box.eps','-depsc',['-F:',int2str(FONTSIZE)]);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    figure;
    scatter ([BSI00_LIVE BSI00_DEAD], [POS_LIVE POS_DEAD], 500, [0.33*ones(1,N) 0.66*ones(1,N)],"filled");
    ylim([-1 1]);
    for II=1:N
    text (BSI00_LIVE(II), POS_LIVE(II)+0.1,num2str(IDLIVE(II)));
    text (BSI00_DEAD(II), POS_DEAD(II)-0.1,num2str(IDDEAD(II)));
    end
    xlabel('std index in DATA00')
    print(gcf,'DATA00-STD.eps','-depsc',['-F:',int2str(FONTSIZE)]);

    figure;
    pts1=[BSI00_DEAD' BSI00_LIVE'];
    boxplot(pts1);
    ylabel('std index in DATA00')
    set(gca (), "xtick", [1 2], "xticklabel", {"Dead", "Alive"});
    print(gcf,'DATA00-STD-box.eps','-depsc',['-F:',int2str(FONTSIZE)]);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    figure;
    scatter ([BSIA_LIVE BSIA_DEAD], [POS_LIVE POS_DEAD], 500, [0.33*ones(1,N) 0.66*ones(1,N)],"filled");
    ylim([-1 1]);
    for II=1:N
    text (BSIA_LIVE(II), POS_LIVE(II)+0.1,num2str(IDLIVE(II)));
    text (BSIA_DEAD(II), POS_DEAD(II)-0.1,num2str(IDDEAD(II)));
    end
    xlabel('avd index in DATAT')
    print(gcf,'DATAT-AVD.eps','-depsc',['-F:',int2str(FONTSIZE)]);

    figure;
    pts1=[BSIA_DEAD' BSIA_LIVE'];
    boxplot(pts1);
    ylabel('avd index in DATAT')
    set(gca (), "xtick", [1 2], "xticklabel", {"Dead", "Alive"});
    print(gcf,'DATAT-AVD-box.eps','-depsc',['-F:',int2str(FONTSIZE)]);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    figure;
    scatter ([BSIT_LIVE BSIT_DEAD], [POS_LIVE POS_DEAD], 500, [0.33*ones(1,N) 0.66*ones(1,N)],"filled");
    ylim([-1 1]);
    for II=1:N
    text (BSIT_LIVE(II), POS_LIVE(II)+0.1,num2str(IDLIVE(II)));
    text (BSIT_DEAD(II), POS_DEAD(II)-0.1,num2str(IDDEAD(II)));
    end
    xlabel('std index in DATAT')
    print(gcf,'DATAT-STD.eps','-depsc',['-F:',int2str(FONTSIZE)]);

    figure;
    pts1=[BSIT_DEAD' BSIT_LIVE'];
    boxplot(pts1);
    ylabel('std index in DATAT')
    set(gca (), "xtick", [1 2], "xticklabel", {"Dead", "Alive"});
    print(gcf,'DATAT-STD-box.eps','-depsc',['-F:',int2str(FONTSIZE)]);

    close all

end

