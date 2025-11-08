

clc,clear, close all, warning off;
 N=1000; P='CS'; R =200;
 folder = fullfile('..\Result\CaseStudy');
 [~,~]  = mkdir(folder);
for index =1:2
    if index ==1 
    [reward,est_price,GP] = GPAOAP3(N,P,R);  method ='GPAOAP3';
    save(fullfile(folder,sprintf('%s_%s_N%d.mat',method,P,N)),'reward','est_price','GP');
    elseif index ==2
    [reward,est_price,GP] = GPUCB(N,P,R);  method ='GPUCB';
    save(fullfile(folder,sprintf('%s_%s_N%d.mat',method,P,N)),'reward'); 
    elseif index ==3 
        [reward] = Rule1(P,R);  method ='Rule1';
        save(fullfile(folder,sprintf('%s_%s_N%d.mat',method,P,N)),'reward');
    elseif index ==4
        [reward]=Rule2(P,R); method ='Rule2';
        save(fullfile(folder,sprintf('%s_%s_N%d.mat',method,P,N)),'reward');
    end
end 

