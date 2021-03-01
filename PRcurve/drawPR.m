
clc
clear
close all
FGPATH='..\pascalvoc2012\SegmentationClassAug\'
PATH='..\pascalvoc2012\ClassCategories\'
imgpath='..\pascalvoc2012/JPEGImages/';


msattpath{1}='path for CAM'; %%CAM
msattpath{2}='path for SEENET\';
msattpath{3}='path for OAA+\'; %%OAA
msattpath{4}='path for MLPL\';
msattpath{5}='path for PLLM';
msattpath{6}='path for MLLM';

num=10582;

for M=5:5
    if exist(['save' num2str(M) '_s.mat'])
        continue;
    end
Precision=zeros(256,num)+0.01;
Recall=zeros(256,num)+0.01;
TP=zeros(256,num);
FP=zeros(256,num);
FN=zeros(256,num);
MAES=zeros(num,1);
for ii=1:length(LIST) %164
    NAME=LIST(ii).name
   Iname=NAME(1:end-4); 
  img=imread([imgpath Iname '.jpg']);
   A=textread([PATH Iname '.txt']);
   
    fugt=imread([FGPATH Iname '.png']);
             %gt3(find(gt3==255))=0;
             fugt(find(fugt==255))=0;  
             fugt=(fugt)>0;target0=fugt*1;
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
   %%%%%%%%%%%%%%%%%%%%%
   fgmask=zeros(size(fugt,1),size(fugt,2));
   
  for ppp=1:size(A)
      if exist([msattpath{M} Iname '_' num2str(A(ppp)-1) '.png'])
      attenms=im2double(imread([msattpath{M} Iname '_' num2str(A(ppp)-1) '.png']));
       salmap=attenms;%(attenms+attenppfd)/2;
      atten=(salmap-min(salmap(:)))/(max(salmap(:))-min(salmap(:))+0.001);
      else
         atten=zeros(size(fugt,1),size(fugt,2));
      end
      fgmask=max(fgmask,atten);
  end
  fgmask=fgmask*255;
  j=ii;
  for i=0:255
        %以i为阈值二值化Output
        output0=(fgmask)>i;
        output1=output0*2;
        TFNP=output1(:,:)-target0(:,:);
        TP(i+1,j)=length(find(TFNP==1));
        FP(i+1,j)=length(find(TFNP==2));
        FN(i+1,j)=length(find(TFNP==-1));
        Precision(i+1,j)=TP(i+1,j)/(TP(i+1,j)+FP(i+1,j)+0.001);
        Recall(i+1,j)=TP(i+1,j)/(TP(i+1,j)+FN(i+1,j)+0.001);
    end
    j
     
end
M
P{M}=mean(Precision,2);PRES=P{M};
R{M}=mean(Recall,2);RRES=R{M};
save(['save' num2str(M) '_s.mat'],'PRES','RRES');
end
%figure,plot(R,P) 

%读取数据库

%% load PRCurve.txt and draw PR curves
figure
hold on
methods={'CAM','SeeNet','OAA+','MLPL','PLLM','MLLM'}; %'MLLM'
methods_colors = distinguishable_colors(length(methods));
set(gcf,'PaperType','usletter');
for m = 1:length(methods)    
     load(['save' num2str(m) '_s.mat']);
    precision = PRES;
    recall = RRES;
    plot(recall(1:end-1), precision(1:end-1),'color',methods_colors(m,:),'linewidth',2);    
end
axis([0 1 0.2 1]);
hold off
grid on;
legend(methods, 'Location', 'SouthWest');
xlabel('Recall','fontsize',12);
ylabel('Precision','fontsize',12);
