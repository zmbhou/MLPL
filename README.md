# MLPL
# Code and Datasets for paper ["Multi-task Learning and Prototype Learning for Weakly Supervised Semantic Segmentation"] 

## 1. You can download the Localization Maps from the following links:
CAM: [Link](https://drive.google.com/file/d/1VfHr3-kUa8MnWuQXZWXVm3i-7dpaOHC3/view?usp=sharing)
SeeNet: [Link](https://drive.google.com/file/d/1OBoPcXqeDGGpiYHKd08kSs5hI2gGdY7M/view?usp=sharing)
OAA+: [Link](https://drive.google.com/file/d/1XtCeDckML0o5icOvAqulEQgmpUb_U5Bd/view?usp=sharing)
PLLM: [Link](https://drive.google.com/file/d/1-8_kyivFSKOeYEYukiFTu8FeMfVW7Yg8/view?usp=sharing)
MLLM: [Link](https://drive.google.com/file/d/1pfxQPOHhHQOIE2iuZsTBOnhREuisRvt1/view?usp=sharing)
MLPL:[Link](https://drive.google.com/file/d/1bkOI-IOiioakQPess7vwd13j_eDWF9Hg/view)

## 2. PR curves:
By running the code: PRcurve/drawPR.m, you can reproduce the PR curves in Figure 9.

## 3. Generating proxy annotations on attention maps:
By running the code GTgeneration/CRFrefinementforGT.m, you can generate the proxy annotations on MLPL.

## 4. Retraining the network with proxy annotations:
By running Training code in the 2nd stage/main.py, the segmentation network will be optimized by the proxy annotations.
