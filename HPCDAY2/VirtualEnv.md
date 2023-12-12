# Virtual environment

## Use existing virtual environment

- Load Anaconda3
```shell
module load Anaconda3
```
- List the existing environments
```shell
conda env list
```
- Output in Simlab
```shell
[...]
base                  *  /home/team1337/.local/easybuild_new/software/Anaconda3/2020.11
cling                    /home/team1337/.local/easybuild_new/software/Anaconda3/2020.11/envs/cling
r_env                    /home/team1337/.local/easybuild_new/software/Anaconda3/2020.11/envs/r_env
renv                     /home/team1337/.local/easybuild_new/software/Anaconda3/2020.11/envs/renv
tensorflow-gpu           /home/team1337/.local/easybuild_new/software/Anaconda3/2020.11/envs/tensorflow-gpu
```
- Source the Anaconda environment In Simlab
```shell
source $ANACONDA_HOME/etc/profile.d/conda.sh
```
- Source the Anaconda environment In Toubkal
```shell
source /srv/software/easybuild/software/Anaconda3/2020.11/etc/profile.d/conda.sh
```
- Activate the tensorflow (using gpu) environment:
```shell
conda activate tensorflow-gpu
```
***You can now run tensorflow using gpus.***