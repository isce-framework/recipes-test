#!/bin/sh

##Author: Ryan Burns

mkdir $SRC_DIR/{build,install}

##Workaround for PROJ_LIB clobbering by mm internally
export RECIPE_CONDA_PROJ_LIB=$PROJ_LIB
unset PROJ_LIB

##PYTHON is also clobbered by mm in configuration
export RECIPE_CONDA_PYTHON=$PYTHON
export BLD_CONFIG=$SRC_DIR/config
export EXPORT_ROOT=$SRC_DIR/install
export PATH=$PATH:$EXPORT_ROOT/bin
export PYTHONPATH=$PYTHONPATH:$EXPORT_ROOT/packages
export LD_LIBRARY_PATH=$LD_LIBRARYPATH:$EXPORT_ROOT/lib
export MM_INCLUDES=$EXPORT_ROOT/include
export MM_LIBPATH=$EXPORT_ROOT/lib


touch $PREFIX/include/portinfo
cd $SRC_DIR/pyre


cat <<EOF >> .mm/config.def
PYTHON=`$RECIPE_CONDA_PYTHON -c "import sysconfig; print(sysconfig.get_config_var('CONFINCLUDEPY').split('/')[-1])"`
PYTHON_DIR=$PREFIX
PYTHON_INCDIR=`$RECIPE_CONDA_PYTHON -c "from sysconfig import get_paths; print(get_paths()['include'])"`
PYTHON_LIB=$PYTHON
PYTHON_LIBDIR=`$RECIPE_CONDA_PYTHON -c "from sysconfig import get_config_var; print(get_config_var('LIBDEST'))"`
PYTHON_PYCFLAGS=-b
EOF

export COMPILER_CXX_NAME=$CXX

echo "MM ENVIRONMENT-----------"
env
echo "MM END ------------------"
$RECIPE_CONDA_PYTHON $SRC_DIR/config/make/mm.py build

# symlink libraries, binaries, python packages, etc.
mv $EXPORT_ROOT/packages/* $SP_DIR
mv $EXPORT_ROOT/include/* $PREFIX/include/
mv $EXPORT_ROOT/bin/* $PREFIX/bin/
mv $EXPORT_ROOT/lib/* $PREFIX/lib/ 

##Restore environment
export PROJ_LIB=$RECIPE_CONDA_PROJ_LIB
export PYTHON=$RECIPE_CONDA_PYTHON
unset RECIPE_CONDA_PROJ_LIB
unset RECIPE_CONDA_PYTHON
