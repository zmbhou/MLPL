clc; clear; close all;
addpath('..\src/');

clc;
close all;
clear all;

FGPATH='..\pascalvoc2012\SegmentationClassAug\'
PATH='..\pascalvoc2012\ClassCategories\'
imgpath='..\pascalvoc2012/JPEGImages/';
attenpath='path for MLPL..';
OUTPUT='GToutdir/';
mkdir(OUTPUT);

LIST=dir(imgpath);
COT=0;

% parameter setting
fullcrfPara.uw = 1; 
fullcrfPara.sw = 8; 
fullcrfPara.bw = 9;
fullcrfPara.s = 5;  
fullcrfPara.bl = 31; 
fullcrfPara.bc = 15;
numlabels = 21;
COT=0;

for ii=3:length(LIST)
    ii
   NAME=LIST(ii).name
   Iname=NAME(1:end-4);
  
   if exist([OUTPUT  Iname '.png'])
      continue;
   end
   
 img=imread([imgpath Iname '.jpg']);
 A=textread([PATH Iname '.txt']);
   
   Newp=ones(size(img,1),size(img,2),numlabels)*(0);
   maxvalue=zeros([size(img,1),size(img,2)]);
   %%%%%%%%%%%%%%%%%%%%%
     fugt=imread([FGPATH Iname '.png']);
             %gt3(find(gt3==255))=0;
             fugt(find(fugt==255))=0;  
             fugt(find(fugt>0))=10;
    
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
   %%%%%%%%%%%%%%%%%%%%%
    bkatten=im2double(imread([attenpath Iname '_allbk.png'])); %%To read the background attention map.
    salmap=bkatten;
    bkmap=(salmap-min(salmap(:)))/(max(salmap(:))-min(salmap(:)));   
   
    for ppp=1:size(A) 
      if ~exist([attenpath Iname '_' num2str(A(ppp)-1) '.png'])
          continue;
      end
      atten=im2double(imread([attenpath Iname '_' num2str(A(ppp)-1) '.png']));
      salmap=atten;
      atten=(salmap-min(salmap(:)))/(max(salmap(:))-min(salmap(:)));
     
  Newp(:,:,A(ppp)+1)=atten; 
  maxvalue=max(maxvalue,atten);
  end
   BK1=1-maxvalue;
   Newp(:,:,1)=bkmap+0.15;
  unary=reshape(Newp,size(img,1)*size(img,2),numlabels);
  unary=log(Newp+0.001)*1;
   u = -5*unary;
   u = reshape(u, size(img, 1), size(img, 2), numlabels);
u = permute(u, [2 1 3]);
u = reshape(u, size(img, 1)*size(img, 2), numlabels);
u = u'*fullcrfPara.uw;

tmpImg = reshape(img, [], 3);
tmpImg = tmpImg';
tmpImg = reshape(tmpImg, 3, size(img, 1), size(img, 2));
tmpImg = permute(tmpImg, [1 3 2]);

% Do the hard work
tic;
%note: the weight of the unary should be set outside the function
%{
@params
  	unary (num_labels*num_pixels) 
  	img (channel  * width * height) 
    ...
@output:
	map (0 - num_label-1)
	probability
%}

[L, prob] = fullCRFinfer(single(u), uint8(tmpImg), fullcrfPara.s, fullcrfPara.s, ...  
    fullcrfPara.sw, fullcrfPara.bl, fullcrfPara.bl, fullcrfPara.bc, fullcrfPara.bc, ... 
    fullcrfPara.bc, fullcrfPara.bw, size(img, 2), size(img, 1));
toc;

map11 = (reshape(L, size(img, 2), size(img, 1)))';

CRFgt=map11;
CRFgt(find(CRFgt>0))=10;

p = reshape(prob, numlabels, size(img, 2), size(img, 1));
p = permute(p, [3 2 1]);
imwrite(uint8(map11),[OUTPUT  Iname '.png']);
end


