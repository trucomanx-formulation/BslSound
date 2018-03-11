function Y=func(INSTR,fs,f,n)

    TN=round(fs/f);
    LN=length(n);
    if iscolumn(INSTR)
        INSTR=INSTR';
    end
    LI=length(INSTR);


    Y=zeros(1,LN);
    %disp('generating');

    for II=1:TN:LN
        if((LN-II)>LI)
            LIT=LI;
        else
            LIT=LN-II;
        end
        %II
        %LIT
        Y( [1:LIT]+(II-1) ) = Y( [1:LIT]+(II-1) ) + INSTR([1:LIT]);
    end
    

end
