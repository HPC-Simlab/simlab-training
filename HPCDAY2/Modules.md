<h1 align="center">Module commands</h1>

### Display the installed GCC versions:
- In simlab:
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
- In Toubkal:
```shell
module --terse avail 2>&1 | grep -i '^\(gcc\)'
```
```shell
GCC/
GCC/7.3.0-2.30
GCC/8.2.0-2.31.1
GCC/8.3.0
GCC/9.3.0
GCC/10.2.0
GCC/10.3.0
GCC/11.2.0
GCC/11.3.0
GCCcore/
GCCcore/7.3.0
GCCcore/8.2.0
GCCcore/8.3.0
GCCcore/9.3.0
GCCcore/10.2.0
GCCcore/10.3.0
GCCcore/11.2.0
GCCcore/11.3.0
GCCcore/12.2.0
gcccuda/
gcccuda/2018b
gcccuda/2020b
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
### Modules conflict handling
**In simlab:** 
- Load default GCC version
```shell
module load GCC
```
- Now try to load another GCC version

```shell
module load GCC/9.3.0
```
```shell
WARNING: GCC/9.3.0 cannot be loaded due to a conflict.
HINT: Might try "module unload GCC" first.
```
```shell
module unload GCC
```
- Try again to load GCC/9.3.0
```shell
module load GCC/9.3.0
```
```shell
WARNING: GCCcore/9.3.0 cannot be loaded due to a conflict.
HINT: Might try "module unload GCCcore" first.
```
***Now GCCcore/9.3.0 create the conflict, because GCC depends on this module***

***All modules finishing by `10.2.0` and `GCCcore-10.2.0` should be unloaded. In that case:***
- GCCcore/10.2.0, zlib/1.2.11-GCCcore-10.2.0, binutils/2.35-GCCcore-10.2.0 and GCC/10.2.0
***The best solution is to `purge` all modules.***

**In Toubkal**
```shell
module load GCC
```
```shell
module load GCC/9.3.0
```
```shell
Les modules suivants ont été rechargés avec un changement de version :
  1) GCC/11.3.0 => GCC/9.3.0     2) GCCcore/11.3.0 => GCCcore/9.3.0     3) binutils/2.38-GCCcore-11.3.0 => binutils/2.34-GCCcore-9.3.0     4) zlib/1.2.12-GCCcore-11.3.0 => zlib/1.2.11-GCCcore-9.3.0
```
***The depend modules will be reloaded automatically with the new gcc version.***

### Add modules to `~/.bashrc` file

- Open `~/.bashrc` file, and add the modules that you load most of the time

```shell
module load Python/3.8.2-GCCcore-9.3.0 
```
