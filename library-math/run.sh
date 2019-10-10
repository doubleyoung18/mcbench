export LD_LIBRARY_PATH=$MKLROOT/lib/intel64_lin/:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$MKLDNNROOT/lib:$LD_LIBRARY_PATH


MKL_PATH=mkl
MKLDNN_PATH=mkldnn
EIGEN_PATH=eigen 

mkdir $MKL_PATH
mkdir $MKLDNN_PATH
mkdir $EIGEN_PATH

for SIZE in 4096 8192  #128 256 512 1024 2048 4096 8192 16384
do
  LOOP=100

  OMP_NUM_THREADS=4 MKL_NUM_THREADS=4 ./mkl.o $SIZE $SIZE $SIZE $LOOP 1>$MKL_PATH/size_$SIZE.out
  ./mkldnn.o $SIZE $SIZE $SIZE $LOOP 0 1>$MKLDNN_PATH/size_$SIZE.out
  OMP_NUM_THREADS=4 ./eigen.o $SIZE $SIZE $SIZE $LOOP 1>$EIGEN_PATH/size_$SIZE.out
done
