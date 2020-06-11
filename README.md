# Deciphering Serous Ovarian Carcinoma Histopathology and Platinum Response by Convolutional Neural Networks

All histopathology models are trained by Caffe version 1.0. Caffe is developed by Berkeley AI Research (BAIR)/The Berkeley Vision and Learning Center (BVLC) and community contributors and released under the [BSD 2-Clause license](https://github.com/BVLC/caffe/blob/master/LICENSE). The source codes of this software dependency are included under the caffe directory.

Due to the file size limit of GitHub, we uploaded our convolutional neural networks models at the links below:

## 1. Serous ovarian carcinoma versus adjacent benign tissue:
AlexNet-based Model: [https://www.dropbox.com/s/cvom9wced4ltuhs/alexnet.caffemodel?dl=0](https://www.dropbox.com/s/cvom9wced4ltuhs/alexnet.caffemodel?dl=0)

GoogLeNet-based Model: [https://www.dropbox.com/s/l8gjebhvgpyre13/googlenet.caffemodel?dl=0](https://www.dropbox.com/s/l8gjebhvgpyre13/googlenet.caffemodel?dl=0)

VGGNet-based Model: [https://www.dropbox.com/s/w7zmkjsmpxxvikd/vgg.caffemodel?dl=0](https://www.dropbox.com/s/w7zmkjsmpxxvikd/vgg.caffemodel?dl=0)

## 2. Serous ovarian carcinoma grade classification:
AlexNet-based Model: [https://www.dropbox.com/s/nou416u1b0gw3bg/alexnet.caffemodel?dl=0](https://www.dropbox.com/s/nou416u1b0gw3bg/alexnet.caffemodel?dl=0)

GoogLeNet-based Model: [https://www.dropbox.com/s/5v56ikpy6js29oc/googlenet.caffemodel?dl=0](https://www.dropbox.com/s/5v56ikpy6js29oc/googlenet.caffemodel?dl=0)

VGGNet-based Model: [https://www.dropbox.com/s/e9b4gnjksrjnt5o/vgg.caffemodel?dl=0](https://www.dropbox.com/s/e9b4gnjksrjnt5o/vgg.caffemodel?dl=0)

## 3. Platinum-free interval prediction:
VGGNet-based Model: [https://www.dropbox.com/s/7i9siypn1asp572/VggModel.h5?dl=0](https://www.dropbox.com/s/7i9siypn1asp572/VggModel.h5?dl=0)

## Proteomics and transcriptomics analyses of tumor grade and platinum response
The models for the differential expression analyses and predictive analyses are under omics_analyses/.


## To install Caffe in Ubuntu 16.04 or later:
### Step 1: Install the general dependencies:
```
sudo apt-get install libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libhdf5-serial-dev protobuf-compiler
sudo apt-get install --no-install-recommends libboost-all-dev
```

### Step 2: Install Caffe
```
sudo apt build-dep caffe-cpu        # dependencies for CPU-only version
sudo apt build-dep caffe-cuda       # dependencies for CUDA version
```

### Step 3: Compile with 'Make'
```
make all
make test
make runtest
```

## To use the models in the command line:
```
caffe test -model model.prototxt -weights model.caffemodel
```

### Additional documentation:
Caffe Installation: http://caffe.berkeleyvision.org/installation.html

Caffe Tutorial: http://caffe.berkeleyvision.org/tutorial/

Caffe Command Line Interfaces: https://caffe.berkeleyvision.org/tutorial/interfaces.html
