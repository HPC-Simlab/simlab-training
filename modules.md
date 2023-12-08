<h1 align="center">Module commands</h1>

### Display the installed GCC versions

```shell
module avail -t 2>&1 | grep -i '^\(gcc\)'
```
- Output:
```shell
gcc/7.2.0
GCC/8.3.0
GCC/9.3.0
GCC/10.2.0
GCCcore/8.3.0
GCCcore/9.3.0
GCCcore/10.2.0
```
### Load a module (default one)

```shell
module load GCC
```
### List the loaded modules

```shell
module list
```
- Output:
```shell
Currently Loaded Modulefiles:
 1) GCCcore/10.2.0   2) zlib/1.2.11-GCCcore-10.2.0   3) binutils/2.35-GCCcore-10.2.0   4) GCC/10.2.0  
```
### Unload module
```shell
module unload binutils/2.35-GCCcore-10.2.0
```
- Output (after module list):
```shell
Currently Loaded Modulefiles:
 1) GCCcore/10.2.0   2) zlib/1.2.11-GCCcore-10.2.0   3) GCC/10.2.0  
```
### Unload all modules
```shell
module purge
```
- Output (after module list):
```shell

No Modulefiles Currently Loaded
```
### Install modules: EasyBuild

####  Load EasyBuild (version 4.4.2)

```shell
module load EasyBuild
```
#### Looking for available easyconfigs files (gmsh)
```shell
eb --modules-tool EnvironmentModules --module-syntax Tcl -S gmsh
```
```shell
== found valid index for /cm/shared/apps/easybuild/4.4.2/lib/python3.5/site-packages/easybuild_easyconfigs-4.4.2-py3.5.egg/easybuild/easyconfigs, so using it...
CFGS1=/cm/shared/apps/easybuild/4.4.2/lib/python3.5/site-packages/easybuild_easyconfigs-4.4.2-py3.5.egg/easybuild/easyconfigs
* $CFGS1/g/gmsh/gmsh-3.0.6-foss-2017b-Python-2.7.14.eb
* $CFGS1/g/gmsh/gmsh-3.0.6-foss-2018b-Python-3.6.6.eb
* $CFGS1/g/gmsh/gmsh-4.2.2-foss-2018b-Python-3.6.6.eb
[...]
```
#### Installation option:

- --robot: to enable dependency resolution.
- --detect-loaded-modules=error: to print a clear error and stop when any (non-allowed) loaded modules are detected.
- --detect-loaded-modules=purge: to run module purge if any (non-allowed) loaded modules are detected.
- --optarch=GENERIC: to optimize for a generic processor architecture.

#### Installing gmsh:
```shell
mkdir EASYBUILD
```

```shell
 eb --modules-tool EnvironmentModules --module-syntax Tcl --prefix=$HOME/EASYBUILD --robot --detect-loaded-modules=error --detect-loaded-modules=purge --optarch=GENERIC gmsh-4.7.1-foss-2020a-Python-3.8.2.eb
```

