#!/bin/sh

##Author: Ryan Burns

mkdir $SRC_DIR/{build,install}

##Workaround for PROJ_LIB clobbering by mm internally
export RECIPE_CONDA_PROJ_LIB=$PROJ_LIB
unset PROJ_LIB

##PYTHON is also clobbered by mm in configuration
export RECIPE_CONDA_PYTHON=$PYTHON

export BLD_CONFIG=$SRC_DIR/config
export EXPORT_ROOT=$PREFIX
export PATH=$PATH:$PREFIX/bin
export PYTHONPATH=$PYTHONPATH:$PREFIX/packages
export LD_LIBRARY_PATH=$LD_LIBRARYPATH:$PREFIX/lib
export MM_INCLUDES=$PREFIX/include
export MM_LIBPATH=$PREFIX/lib

cd $SRC_DIR/pyre

export PYTHON=`$RECIPE_CONDA_PYTHON -c "import sysconfig; print(sysconfig.get_config_var('CONFINCLUDEPY').split('/')[-1])"`
export PYTHON_INCDIR=`$RECIPE_CONDA_PYTHON -c "from sysconfig import get_paths; print(get_paths()['include'])"`
export PYTHON_LIB=$PYTHON
export PYTHON_LIBDIR=`$RECIPE_CONDA_PYTHON -c "from sysconfig import get_config_var; print(get_config_var('LIBDEST'))"`
export PYTHON_PYCFLAGS=-b

$RECIPE_CONDA_PYTHON $SRC_DIR/config/make/mm.py build

# symlink libraries, binaries, python packages, etc.
mv $PREFIX/packages/* $SP_DIR
rm -d $PREFIX/packages

##Restore environment
export PROJ_LIB=$RECIPE_CONDA_PROJ_LIB
export PYTHON=$RECIPE_CONDA_PYTHON
unset RECIPE_CONDA_PROJ_LIB
unset RECIPE_CONDA_PYTHON
