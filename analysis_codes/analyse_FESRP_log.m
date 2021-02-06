function [  ] = analyse_FESRP_log( logFESRP )

Niter = length(logFESRP.dAsteps_vpp);
for iter = 1:Niter
    iterlog = logFESRP.iterlogs(iter)
    iterlog.ZBPDlog
    iterlog.currfstep;
    iterlog.currAstep;
    iterlog.init_currfcent ;
    iterlog.init_currAcent;
    iterlog.fspan ;
    iterlog.Aspan ;
    
    iterlog.Xamp_resultsF;
    iterlog.Yamp_resultsF;
    iterlog.Xamp_resultsA;
    iterlog.Yamp_resultsA;
    
    figure(2226)
    subplot(2,1,1)
    plot(iterlog.fspan, iterlog.Xamp_resultsF)
    title(['Fspan iter ' num2str(iter)])
    subplot(2,1,2)
    plot(iterlog.Aspan , iterlog.Xamp_resultsA)
    title(['Aspan iter ' num2str(iter)])
    
    if(iter == 1)
        [~,fminind] = min(smooth(iterlog.Xamp_resultsF,3));
        [~,Aminind] = min(smooth(iterlog.Xamp_resultsA,3));
%         currfcent = fspan(fminind);
%         currAcent = Aspan(Aminind);
        figure(2226)
        subplot(2,1,1)
        hold on 
        plot(iterlog.fspan,  iterlog.Xamp_resultsF)
        subplot(2,1,2)
        hold on 
        plot(iterlog.Aspan , iterlog.Xamp_resultsA)
    
    else
        parabole_fit_F = polyfit(iterlog.fspan, iterlog.Xamp_resultsF, 2);
        parabole_fit_A = polyfit(iterlog.Aspan, iterlog.Xamp_resultsA, 2);
        currfcent = - parabole_fit_F(2)/(2*parabole_fit_F(1));
        currAcent = - parabole_fit_A(2)/(2*parabole_fit_A(1));
        figure(2226)
        subplot(2,1,1)
        hold on 
        plot(iterlog.fspan,  parabole_fit_F(1)*iterlog.fspan.^2 + parabole_fit_F(2)*iterlog.fspan + parabole_fit_F(3))
        subplot(2,1,2)
        hold on 
        plot(iterlog.Aspan,  parabole_fit_A(1)*iterlog.Aspan.^2 + parabole_fit_A(2)*iterlog.Aspan + parabole_fit_A(3))
    end

end

