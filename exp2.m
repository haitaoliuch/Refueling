% clc,clear, close all, warning off
%  N=1000; P='P3'; R =100;
%  folder = fullfile('..\GPUCB\Result\Seasonality');
%  [~,~]  = mkdir(folder);
%  pro = Problem(P); 
%  set=[18];
% for index =2:2
%     if index ==1 
%         [reward,est_price,GP] = GPUCB(N,P,R);  method ='GPUCB';
%         save(fullfile(folder,sprintf('%s_%s_N%d.mat',method,P,N)),'reward','est_price');
%     elseif index ==2
%         tic
%         [reward,est_price,GP] = GPAOAP4(N,pro,R);  method ='GPAOAP4';
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
%             [reward,est_price,GP] = GPEg(N,P,R,epson(e));  method ='GPEg';
%             save(fullfile(folder,sprintf('%s_%s_N%d_Eps%d.mat',method,P,N,epson(e)*100)),'reward','est_price');
%         end
%     end
% end 

clc,clear, close all, warning off
 N=1000; P='S5'; R =200;
 folder = fullfile('..\GPUCB\Result\PerComCor2M');
 [~,~]  = mkdir(folder);  pro = Problem(P); 
for index =1:4
    if index ==1 
        [reward,est_price,GP] = GPUCB(N,P,R);  method ='GPUCB';
        save(fullfile(folder,sprintf('%s_%s_N%d.mat',method,P,N)),'reward','est_price');
    elseif index ==2
        tic
        [reward,est_price,GP,GMM] = GPAOAP3(N,pro,R);  method ='GPAOAP3';
        save(fullfile(folder,sprintf('%s_%s_N%d.mat',method,P,N)),'reward','est_price','GP','GMM');
        toc
    elseif index ==3
        [reward] = Rule1(P,R);  method ='Rule1';
        save(fullfile(folder,sprintf('%s_%s_N%d.mat',method,P,N)),'reward');
    elseif index ==4
        [reward]=Rule2(P,R); method ='Rule2';
        save(fullfile(folder,sprintf('%s_%s_N%d.mat',method,P,N)),'reward');
    elseif index ==5
        for e=1:length(epson)
            [reward,est_price,GP] = GPEg(N,P,R,epson(e));  method ='GPEg';
            save(fullfile(folder,sprintf('%s_%s_N%d_Eps%d.mat',method,P,N,epson(e)*100)),'reward','est_price');
        end
    end
end 

clc,clear, close all, warning off
 N=1000; P='S6'; R =200;
 folder = fullfile('..\GPUCB\Result\PerComCor2M');
 [~,~]  = mkdir(folder);  pro = Problem(P); 
for index =1:4
    if index ==1 
        [reward,est_price,GP] = GPUCB(N,P,R);  method ='GPUCB';
        save(fullfile(folder,sprintf('%s_%s_N%d.mat',method,P,N)),'reward','est_price');
    elseif index ==2
        tic
        [reward,est_price,GP,GMM] = GPAOAP3(N,pro,R);  method ='GPAOAP3';
        save(fullfile(folder,sprintf('%s_%s_N%d.mat',method,P,N)),'reward','est_price','GP','GMM');
        toc
    elseif index ==3
        [reward] = Rule1(P,R);  method ='Rule1';
        save(fullfile(folder,sprintf('%s_%s_N%d.mat',method,P,N)),'reward');
    elseif index ==4
        [reward]=Rule2(P,R); method ='Rule2';
        save(fullfile(folder,sprintf('%s_%s_N%d.mat',method,P,N)),'reward');
    elseif index ==5
        for e=1:length(epson)
            [reward,est_price,GP] = GPEg(N,P,R,epson(e));  method ='GPEg';
            save(fullfile(folder,sprintf('%s_%s_N%d_Eps%d.mat',method,P,N,epson(e)*100)),'reward','est_price');
        end
    end
end 

clc,clear, close all, warning off
 N=1000; P='S7'; R =200;
 folder = fullfile('..\GPUCB\Result\PerComCor2M');
 [~,~]  = mkdir(folder);  pro = Problem(P); 
for index =1:4
    if index ==1 
        [reward,est_price,GP] = GPUCB(N,P,R);  method ='GPUCB';
        save(fullfile(folder,sprintf('%s_%s_N%d.mat',method,P,N)),'reward','est_price');
    elseif index ==2
        tic
        [reward,est_price,GP,GMM] = GPAOAP3(N,pro,R);  method ='GPAOAP3';
        save(fullfile(folder,sprintf('%s_%s_N%d.mat',method,P,N)),'reward','est_price','GP','GMM');
        toc
    elseif index ==3
        [reward] = Rule1(P,R);  method ='Rule1';
        save(fullfile(folder,sprintf('%s_%s_N%d.mat',method,P,N)),'reward');
    elseif index ==4
        [reward]=Rule2(P,R); method ='Rule2';
        save(fullfile(folder,sprintf('%s_%s_N%d.mat',method,P,N)),'reward');
    elseif index ==5
        for e=1:length(epson)
            [reward,est_price,GP] = GPEg(N,P,R,epson(e));  method ='GPEg';
            save(fullfile(folder,sprintf('%s_%s_N%d_Eps%d.mat',method,P,N,epson(e)*100)),'reward','est_price');
        end
    end
end 

clc,clear, close all, warning off
 N=1000; P='S8'; R =200;
 folder = fullfile('..\GPUCB\Result\PerComCor2M');
 [~,~]  = mkdir(folder);  pro = Problem(P); 
for index =1:4
    if index ==1 
        [reward,est_price,GP] = GPUCB(N,P,R);  method ='GPUCB';
        save(fullfile(folder,sprintf('%s_%s_N%d.mat',method,P,N)),'reward','est_price');
    elseif index ==2
        tic
        [reward,est_price,GP,GMM] = GPAOAP3(N,pro,R);  method ='GPAOAP3';
        save(fullfile(folder,sprintf('%s_%s_N%d.mat',method,P,N)),'reward','est_price','GP','GMM');
        toc
    elseif index ==3
        [reward] = Rule1(P,R);  method ='Rule1';
        save(fullfile(folder,sprintf('%s_%s_N%d.mat',method,P,N)),'reward');
    elseif index ==4
        [reward]=Rule2(P,R); method ='Rule2';
        save(fullfile(folder,sprintf('%s_%s_N%d.mat',method,P,N)),'reward');
    elseif index ==5
        for e=1:length(epson)
            [reward,est_price,GP] = GPEg(N,P,R,epson(e));  method ='GPEg';
            save(fullfile(folder,sprintf('%s_%s_N%d_Eps%d.mat',method,P,N,epson(e)*100)),'reward','est_price');
        end
    end
end 