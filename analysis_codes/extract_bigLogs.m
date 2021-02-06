function [ finalWPs,finalparams,logsFID,logsSXERES,initWPs, logsSXMAGS ] = extract_bigLogs( bigLogs,before_after )
%EXTRACT_BIGLOGS Summary of this function goes here
%   Detailed explanation goes here


    finalWPs = [];
    finalparams = [];
    logsFID = [];
    logsSXERES = [];
    logsSXMAGS = [];

    initWPs = [];
    for i = 1:length(bigLogs)
        
        bigLog = bigLogs(i);
        initWP = bigLog.logZTF_1.logs(1).WPstart;
        initWPs = [initWPs, initWP];
        
        finalWP = bigLog.finalWP;
        finalParameters = bigLog.FinalParameters;
        
        logsFID = [logsFID , bigLog.logXFID];
%         logsSXERES = [logsSXERES, bigLog.logSXERES];
        
        finalWPs =[finalWPs, finalWP];
        finalparams = [finalparams, finalParameters];
        
        logsSXMAGS = [logsSXMAGS, bigLog.logSXMAGS];
        
        
    end


end

