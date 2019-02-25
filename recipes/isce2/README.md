# Working with isce2 conda package

## Install isce2

We are currently developing and testing the conda package under a private channel. When ready, this will be moved to a more relevant channel.

```
conda install -c piyushrpt isce2
```

## Environment variables

Installation with conda should automatically set up two environment variables

1. ISCE\_HOME  : This reflects the path in site-packages folder where isce is installed
2. ISCE\_STACK: This reflects the path where the stack processors are installed

To directly access the scripts, add $ISCE\_HOME/applications to your environment. 
We do not want to modify PATH variable from within conda. 
The alternative solution is to copy the relevant applications to CONDA/bin but the applications need to be vetted first. 

## Where is mdx?

Conda's main channels currently do not have a recipe for openmotif. We do not build mdx in this current version. This version of isce2, should be perfect for deployment with conda and automated processing. 

Users can copy the mdx folder from the git repository and use the included Makefile, if they absolutely want mdx. 
