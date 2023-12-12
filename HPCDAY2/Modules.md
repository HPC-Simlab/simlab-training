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
### Add modules to bashrc file

- Open `~/.bashrc` file, and add the modules that you load most of the time

```shell
module load Python/3.8.2-GCCcore-9.3.0 
```
