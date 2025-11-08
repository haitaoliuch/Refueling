% clc,clear, close all, warning off
%  N=1000; P='SI1'; R =500;
%  folder = fullfile('..\GPUCB\Result\PerComSI');
%  [~,~]  = mkdir(folder); epson = [0,0.1];
% for index =1:5
%     if index ==1 
%         [reward,est_price,GP] = GPUCB(N,P,R);  method ='GPUCB';
%         save(fullfile(folder,sprintf('%s_%s_N%d.mat',method,P,N)),'reward','est_price');
%     elseif index ==2
%         tic
%         [reward,est_price,GP] = GPAOAP3(N,P,R);  method ='GPAOAP3';
%         save(fullfile(folder,sprintf('%s_%s_N%d.mat',method,P,N)),'reward','est_price');
%         toc
%     elseif index ==3
%         [reward] = Rule1(P,R);  method ='Rule1';
%         save(fullfile(folder,sprintf('%s_%s_N%d.mat',method,P,N)),'reward');
%     elseif index ==4
%         [reward]=Rule2(P,R); method ='Rule2';
%         save(fullfile(folder,sprintf('%s_%s_N%d.mat',method,P,N)),'reward');
%     elseif index ==5
%         for e=1:length(epson)
%             [reward,est_price,GP] = GPAOAPg(N,P,R,epson(e));  method ='GPAOAPg';
%             save(fullfile(folder,sprintf('%s_%s_N%d_Eps%d.mat',method,P,N,epson(e)*100)),'reward','est_price');
%         end
%     end
% end 

clc,clear, close all, warning off
 N=1000; P='SI2'; R =500;
 folder = fullfile('..\GPUCB\Result\PerComSI');
 [~,~]  = mkdir(folder); epson = [0,0.1];
for index =2:5
    if index ==1 
        [reward,est_price,GP] = GPUCB(N,P,R);  method ='GPUCB';
        save(fullfile(folder,sprintf('%s_%s_N%d.mat',method,P,N)),'reward','est_price');
    elseif index ==2
        tic
        [reward,est_price,GP] = GPAOAP3(N,P,R);  method ='GPAOAP3';
        save(fullfile(folder,sprintf('%s_%s_N%d.mat',method,P,N)),'reward','est_price');
        toc
    elseif index ==3
        [reward] = Rule1(P,R);  method ='Rule1';
        save(fullfile(folder,sprintf('%s_%s_N%d.mat',method,P,N)),'reward');
    elseif index ==4
        [reward]=Rule2(P,R); method ='Rule2';
        save(fullfile(folder,sprintf('%s_%s_N%d.mat',method,P,N)),'reward');
    elseif index ==5
        for e=1:length(epson)
            [reward,est_price,GP] = GPAOAPg(N,P,R,epson(e));  method ='GPAOAPg';
            save(fullfile(folder,sprintf('%s_%s_N%d_Eps%d.mat',method,P,N,epson(e)*100)),'reward','est_price');
        end
    end
end 

clc,clear, close all, warning off
 N=1000; P='SI3'; R =500;
 folder = fullfile('..\GPUCB\Result\PerComSI');
 [~,~]  = mkdir(folder); epson = [0,0.1];
for index =1:5
    if index ==1 
        [reward,est_price,GP] = GPUCB(N,P,R);  method ='GPUCB';
        save(fullfile(folder,sprintf('%s_%s_N%d.mat',method,P,N)),'reward','est_price');
    elseif index ==2
        tic
        [reward,est_price,GP] = GPAOAP3(N,P,R);  method ='GPAOAP3';
        save(fullfile(folder,sprintf('%s_%s_N%d.mat',method,P,N)),'reward','est_price');
        toc
    elseif index ==3
        [reward] = Rule1(P,R);  method ='Rule1';
        save(fullfile(folder,sprintf('%s_%s_N%d.mat',method,P,N)),'reward');
    elseif index ==4
        [reward]=Rule2(P,R); method ='Rule2';
        save(fullfile(folder,sprintf('%s_%s_N%d.mat',method,P,N)),'reward');
    elseif index ==5
        for e=1:length(epson)
            [reward,est_price,GP] = GPAOAPg(N,P,R,epson(e));  method ='GPAOAPg';
            save(fullfile(folder,sprintf('%s_%s_N%d_Eps%d.mat',method,P,N,epson(e)*100)),'reward','est_price');
        end
    end
end 