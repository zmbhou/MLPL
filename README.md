# MLPL
# Code and Datasets for paper ["Multi-task Learning and Prototype Learning for Weakly Supervised Semantic Segmentation"] 

## 1. You can download the Localization Maps from the following links:
CAM: [Link](https://drive.google.com/file/d/1VfHr3-kUa8MnWuQXZWXVm3i-7dpaOHC3/view?usp=sharing)
SeeNet: [Link](https://drive.google.com/file/d/1OBoPcXqeDGGpiYHKd08kSs5hI2gGdY7M/view?usp=sharing)
OAA+: [Link](https://drive.google.com/file/d/1XtCeDckML0o5icOvAqulEQgmpUb_U5Bd/view?usp=sharing)
PLLM: [Link](https://drive.google.com/file/d/1-8_kyivFSKOeYEYukiFTu8FeMfVW7Yg8/view?usp=sharing)
MLLM: [Link](https://drive.google.com/file/d/1pfxQPOHhHQOIE2iuZsTBOnhREuisRvt1/view?usp=sharing)
MLPL:[Link](https://drive.google.com/file/d/1bkOI-IOiioakQPess7vwd13j_eDWF9Hg/view)

## 2. Testing:

Step 1: download the compressed model from [Google Driver model](https://drive.google.com/file/d/1F_HcZKZmVPOXwEzGTZkmUV9GzCM4m5OW/view). Put it in the folder "./model" and unzip it. We have release the model corresponding to steps P5 presented in TABLE VI in the sumbitted manuscript. mIoU of 58.4 can be achieved for the single model.

Step 2: Run SAL_Net_VGG16_mstest.py for SAL-Net-VGG16 evaluation, the predictions with multiscale fusion will be saved in SAVE_DIR = './result/'. Mean IoU of 59.0 can be achieved on PASCAL VOC 2012 validation dataset.

Step 3: Run SAL_Net_VGG16_mscrftest.py for SAL-Net-VGG16 with multiscale fusion and CRF. 
Thre results will be saved in './result/'. Mean IoU of 61.3 can be achieved on PASCAL VOC 2012 validation dataset.

Step 4: we have provided the matlab code for evaluation. You can evaluate the resutls and obtain Iou youself. 
Please refer to https://github.com/zmbhou/IoUeval.
