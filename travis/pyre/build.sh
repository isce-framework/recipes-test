#!/bin/sh

##Author: Ryan Burns

mkdir $SRC_DIR/{build,install}

export BLD_CONFIG=$SRC_DIR/config
export EXPORT_ROOT=$PREFIX
export PATH=$PATH:$PREFIX/bin
export PYTHONPATH=$PYTHONPATH:$PREFIX/packages
export LD_LIBRARY_PATH=$LD_LIBRARYPATH:$PREFIX/lib
export MM_INCLUDES=$PREFIX/include
export MM_LIBPATH=$PREFIX/lib

cd $SRC_DIR/pyre

export PYTHON=`python3 -c "import sysconfig; print(sysconfig.get_config_var('CONFINCLUDEPY').split('/')[-1])"`
export PYTHON_INCDIR=`python3 -c "from sysconfig import get_paths; print(get_paths()['include'])"`
export PYTHON_LIB=$PYTHON
export PYTHON_LIBDIR=`python3 -c "from sysconfig import get_config_var; print(get_config_var('LIBDEST'))"`
export PYTHON_PYCFLAGS=-b

python3 $SRC_DIR/config/make/mm.py build

# symlink libraries, binaries, python packages, etc.
pythonsite=`python3 -c "import site; print(site.getsitepackages()[0])"`
echo $pythonsite
echo `ls $PREFIX`
mv $PREFIX/packages/* $pythonsite
rm -d $PREFIX/packages

