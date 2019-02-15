# recipes-test
Testing playground for recipes

Original instructions from Ryan Burns. 

1. Change your working directory to the recipe that you want to build

```
cd travis/pyre
```

2. Build conda recipe

```
conda-build .
```

3. Login to anaconda

```
anaconda login
```

4. Upload to anaconda channel

```
anaconda upload pathtotar/pyre-1.0-py37_0.tar.bz2
```

5. Test in a different virtual environment that the new package is available

```
conda install -c channel_name pyre
```
