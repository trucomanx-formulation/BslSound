function Y=generator(A,Amax,Fmax,fs,N)

    Nsteps=length(A);


    n=[0:N-1];
    
    f=A(1)*Fmax/Amax;
    Y = sin(2*pi*f*n/fs);
    
    for II=2:Nsteps
        f=A(II)*Fmax/Amax;
        Y = [Y sin(2*pi*f*n/fs)];
    end

    Y = [Y zeros(1,N)];
end
