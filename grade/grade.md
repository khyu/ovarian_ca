# Deciphering Serous Ovarian Carcinoma Histopathology and Platinum Response by Convolutional Neural Networks

## Serous ovarian carcinoma grade classification:
Due to the file size limit of GitHub, we uploaded our convolutional neural networks models at the links below:

AlexNet-based Model: [https://www.dropbox.com/s/nou416u1b0gw3bg/alexnet.caffemodel?dl=0](https://www.dropbox.com/s/nou416u1b0gw3bg/alexnet.caffemodel?dl=0)

GoogLeNet-based Model: [https://www.dropbox.com/s/5v56ikpy6js29oc/googlenet.caffemodel?dl=0](https://www.dropbox.com/s/5v56ikpy6js29oc/googlenet.caffemodel?dl=0)

VGGNet-based Model: [https://www.dropbox.com/s/e9b4gnjksrjnt5o/vgg.caffemodel?dl=0](https://www.dropbox.com/s/e9b4gnjksrjnt5o/vgg.caffemodel?dl=0)

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
