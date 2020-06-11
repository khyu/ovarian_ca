# Deciphering Serous Ovarian Carcinoma Histopathology and Platinum Response by Convolutional Neural Networks

## Platinum-free interval prediction:
Due to the file size limit of GitHub, we uploaded our convolutional neural networks models at the links below:

VGGNet-based Model: [https://www.dropbox.com/s/7i9siypn1asp572/VggModel.h5?dl=0](https://www.dropbox.com/s/7i9siypn1asp572/VggModel.h5?dl=0)

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
