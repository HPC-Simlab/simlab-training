<h1 align="center">Reservation commands</h1>

## Reserve resources

### `srun` command
- to obtain a terminal on a CPU compute node within which you can execute your code,
- or to directly execute your code on the CPU partition.

It is possible to open a terminal directly on a compute node on which the resources have been reserved for you (here 4 cores) by using the following command:

#### Example 1: Connecting to a compute node 
```shell
srun --pty --ntasks=1 bash
```
- Running this command will redirect you directly to a compute node
- An interactive terminal is obtained with the --pty option.
- By default, the allocated CPU memory is proportional to the number of reserved cores. For example, if you request 1/4 of the cores of a node, you will have access to 1/4 of its memory.
- In simlab 1 cpu = 8.7GB
- In toubkal 1 cpu = 3.4GB

#### Example 2: Running python script 
- Create file `script.py`
```python
import socket

def get_host_info():
    # Get the hostname
    hostname = socket.gethostname()
    return hostname

if __name__ == "__main__":
    host = get_host_info()
    print(f"Hostname: {host}")
```
***Load the Python module***

- Run the script
```shell
srun --ntasks=1 python3 script.py
```
- Output:
```shell
Hostname: node03
```

### `salloc` command
```shell
salloc --ntasks=1
```
- Ouput
```shell
salloc: Granted job allocation 5858476
```
- Display the submitted jobs
```shell
squeue -u $USER
```
or 
```shell
ssqueue
```
- Output:
```shell
JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
           5858476      defq     bash ikissami  R       0:35      1 node03
```

### `sbatch` command

- Create file `job.slurm`

```shell
#!/bin/bash

#SBATCH --ntasks=1

# unload any modules to start with a clean environment
module purge
# load software modules
module load Python/3.8.2-GCCcore-9.3.0
# run commands
python3 script.py
```
- Run the job file
```sbatch job.slurm
```
- Output:
```shell
Submitted batch job 5858478
```
- Display jobs
```shell
squeue -j 5858478
```
***This command can display nothing if the job is very fast, but you can check the output of the job running***
```shell
cat slurm-5858478.out
```
***The file slurm-jobid.out is generated automatically***

## Check the available resources using `sinfo` and `squeue` commands

- `sinfo` command
```shell
sinfo
```
- Output
```shell
PARTITION AVAIL  TIMELIMIT  NODES  STATE NODELIST
defq*        up    1:00:00      2   resv node[01-02]
defq*        up    1:00:00      3    mix node[03-04,14]
defq*        up    1:00:00      1  alloc node15
defq*        up    1:00:00      1   idle node05
gpu          up 2-00:00:00      2    mix node[06,14]
gpu          up 2-00:00:00      9  alloc node[07-10,12-13,15-17]
gpu          up 2-00:00:00      1   idle node11
shortq       up    4:00:00      2   resv node[01-02]
shortq       up    4:00:00      3    mix node[03-04,14]
shortq       up    4:00:00      1  alloc node15
shortq       up    4:00:00      1   idle node05
longq        up 30-00:00:0      2   resv node[01-02]
longq        up 30-00:00:0      3    mix node[03-04,14]
longq        up 30-00:00:0      1  alloc node15
longq        up 30-00:00:0      1   idle node05
visu         up 1-00:00:00      1    mix visu01
special      up      30:00      2   resv node[01-02]
special      up      30:00      4    mix node[03-04,06,14]
special      up      30:00      9  alloc node[07-10,12-13,15-17]
special      up      30:00      2   idle node[05,11]
```

- Display the state for each node
```shell
sinfo -o "%n %G %C %t"
```
- Output
```shell
HOSTNAMES GRES CPUS(A/I/O/T) STATE
node01 (null) 0/40/0/40 resv
node02 (null) 0/40/0/40 resv
node03 (null) 30/14/0/44 mix
node04 (null) 30/14/0/44 mix
node14 gpu:1 43/1/0/44 mix
node15 gpu:1 44/0/0/44 alloc
node05 (null) 0/44/0/44 idle
node06 gpu:1 6/38/0/44 mix
node07 gpu:1 44/0/0/44 alloc
node08 gpu:1 44/0/0/44 alloc
node12 gpu:1 44/0/0/44 alloc
node13 gpu:1 44/0/0/44 alloc
node16 gpu:1 44/0/0/44 alloc
node09 gpu:1 0/44/0/44 idle
node10 gpu:1 0/44/0/44 idle
node11 gpu:1 0/44/0/44 idle
node17 gpu:1 0/44/0/44 idle
visu01 gpu:1 1/43/0/44 mix
```
- Display the nodes for each state
```shell
sinfo -o "%N %t %C"
```
- Output
```shell
NODELIST STATE CPUS(A/I/O/T)
node[01-02] resv 0/80/0/80
node[03-04,06,14],visu01 mix 110/110/0/220
node[07-08,12-13,15-16] alloc 264/0/0/264
node[05,09-11,17] idle 0/220/0/220
```
- Display the available gpus
```shell
squeue -t RUNNING --partition=gpu -o '%b %N'
```
- Output
```shell
GRES NODELIST
GRES NODELIST
(null) node14
(null) node06
(null) node13
(null) node16
gpu:1 node08
gpu:1 node07
gpu:1 node12
gpu:1 node06
```

#### Slurm Parameters: nodes, tasks, cpus

- **--nodes**
  - *number of nodes to use where a node is one computer unit of many in an HPC cluster (optional)*
    - `--nodes=1` \# request 1 node (optional since default=1)
    - *used for multi-node jobs*
      - `--nodes=2`
    - *if the number of cpus per node is not specified then defaults to 1 cpu*
    - *defaults=1 node if `--nodes` not used & can use with `--ntasks-per-node` and `--cpus-per-task`

```shell
srun --nodes=2 --pty bash
```
***Oups!!! It does not work***
```shell
srun: error: Unable to allocate resources: Node count specification invalid
```
***The number of nodes that could be allocated in the `defq` partition is limited to 1.

- **--partition**
  - *specify a partition (queue)*
- `defq`: partition is automatically used if no partition is specified by all jobs. The execution time by default is 4 hours.
- `shortq`: partition used for short jobs (max. 12 hours), with max of two nodes per job (88 cores max.)
- `longq`: partition used for long jobs (max 30 days), with only one node per job (44 cores max.).
- `special`: used for running parallel jobs (max 30 minutes).
- `visu`: partition used for visualization.
- `gpu`: partition used for gpu computations (all nodes in this partition have gpu card P100 or P40), with max of two nodes per job (88 cores max.).

| Partition | Max. Cpu Time | Nodes available for the partition | Max nodes per job | Min-Max cores per job     |
|-----------|---------------|-------------------------------------------------------|-------------------|---------------------------|
| defq      | 4 hours       |              5 (node01, node02 node03, node14, node15)  |             1       |     1-44          |
| shortq    | 12 hours      |              5 (node01, node02 node03, node14, node15)  |             2       |     1-88          |
| longq     | 30 days       |              5 (node01, node02 node03, node14, node15)  |             1       |     1-44          |
| special   | 30 minutes    |              15 (all nodes)                             |            15       |     1-652         |
| visu      | 24 hours      |              1  (visu01)                                |             1       |     1-44          |
| gpu       | 48 hours      |              12 (node[06-17])                           |             2       |     1-88          |

```shell
srun --partition=shortq --nodes=2 --pty bash
```
- Display jobs information
```shell
JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
           5858482    shortq     bash ikissami  R       0:06      2 node[03-04]
```
- This command will reserve 2 nodes, with 1 cpu in each node and 2*8.7GB. To check this, run this command:
```shell
scontrol show jobid 5858482
```
- Output:
```shell
JobId=5858482 JobName=bash
   UserId=ikissami(1063) GroupId=ikissami(1074) MCS_label=N/A
   Priority=105683 Nice=0 Account=novec-account QOS=normal
   JobState=RUNNING Reason=None Dependency=(null)
   Requeue=1 Restarts=0 BatchFlag=0 Reboot=0 ExitCode=0:0
   RunTime=00:00:12 TimeLimit=04:00:00 TimeMin=N/A
   SubmitTime=2023-12-08T22:18:20 EligibleTime=2023-12-08T22:18:20
   StartTime=2023-12-08T22:18:20 EndTime=2023-12-09T02:18:21 Deadline=N/A
   PreemptTime=None SuspendTime=None SecsPreSuspend=0
   LastSchedEval=2023-12-08T22:18:20
   Partition=shortq AllocNode:Sid=master01:192503
   ReqNodeList=(null) ExcNodeList=(null)
   NodeList=node[03-04]
   BatchHost=node03
   NumNodes=2 NumCPUs=2 NumTasks=2 CPUs/Task=1 ReqB:S:C:T=0:0:*:*
   TRES=cpu=2,mem=17514M,node=2,billing=2
   Socks/Node=* NtasksPerN:B:S:C=0:0:*:* CoreSpec=*
   MinCPUsNode=1 MinMemoryCPU=8757M MinTmpDiskNode=0
   Features=(null) DelayBoot=00:00:00
   Gres=(null) Reservation=(null)
   OverSubscribe=OK Contiguous=0 Licenses=(null) Network=(null)
   Command=bash
   WorkDir=/home/ikissami/TRAINING
   Power=
```  
    - You can reserve a job using `gpu` partition with max of two nodes (88 cores)
    - You can reserve a job using `special` partition with max of 15 nodes (652 cores)
    
- **--ntasks**
  - *a task can be considered a command such as blastn, bwa, script.py, etc.*
    - `--ntasks=1` \# total tasks across all nodes per job
    - *when using `--ntasks` without `--nodes`, the values for `--ntasks-per-node` and `--cpus-per-task` will default to 1 node, 1 task per node, and 1 cpu per task*

- Create file `mpiscript.py`
```python
from mpi4py import MPI
COMM = MPI.COMM_WORLD
SIZE = COMM.Get_size()
RANK = COMM.Get_rank()

if RANK==0: print("the number of cpus is:", SIZE)
```
- Run the script using 44 cores in one node (load python/3.8.2-GCCcore-9.3.0 and OpenMPI/4.0.3-GCC-9.3.0)
```shell
srun --partition=shortq --nodes=1 --ntasks=44 --pty bash
```
- Then run
```shell
 mpirun python3 mpiscript.py
```
- Display job information after getting the jobid using `ssqueue` or `squeue -u $USER`
```shell
JobId=5858486 JobName=bash
   UserId=ikissami(1063) GroupId=ikissami(1074) MCS_label=N/A
   Priority=105584 Nice=0 Account=novec-account QOS=normal
   JobState=RUNNING Reason=None Dependency=(null)
   Requeue=1 Restarts=0 BatchFlag=0 Reboot=0 ExitCode=0:0
   RunTime=00:00:11 TimeLimit=04:00:00 TimeMin=N/A
   SubmitTime=2023-12-08T22:20:58 EligibleTime=2023-12-08T22:20:58
   StartTime=2023-12-08T22:20:58 EndTime=2023-12-09T02:20:58 Deadline=N/A
   PreemptTime=None SuspendTime=None SecsPreSuspend=0
   LastSchedEval=2023-12-08T22:20:58
   Partition=shortq AllocNode:Sid=master01:192503
   ReqNodeList=(null) ExcNodeList=(null)
   NodeList=node05
   BatchHost=node05
   NumNodes=1 NumCPUs=44 NumTasks=44 CPUs/Task=1 ReqB:S:C:T=0:0:*:*
   TRES=cpu=44,mem=385308M,node=1,billing=44
   Socks/Node=* NtasksPerN:B:S:C=0:0:*:* CoreSpec=*
   MinCPUsNode=1 MinMemoryCPU=8757M MinTmpDiskNode=0
   Features=(null) DelayBoot=00:00:00
   Gres=(null) Reservation=(null)
   OverSubscribe=OK Contiguous=0 Licenses=(null) Network=(null)
   Command=bash
   WorkDir=/home/ikissami/TRAINING
   Power=
```
or run this command if your application uses distributed computing (this command can reserve more than one node if it's needed
```shell
srun --partition=shortq --ntasks=44 --pty bash
```

#### Additional Slurm Parameters

- **--time**
  - *max runtime for job (required); format: days-hours:minutes:seconds (days- is optional)*
    - `--time=24:00:00`   *# max runtime 24 hours (same as `--time=1-00:00:00`)*
    - `--time=7-00:00:00` *# max runtime 7 days*

- **--mem**
  - *total memory for each node (required)*
    - `--mem=376G` *# request 376GB total memory (max available on 384gb nodes)*

- **--job-name**
  - *set the job name, keep it short and concise without spaces (optional but highly recommended)*
    - `--job-name=myjob`

- **--output**
  - *save all stdout to a specified file (optional but highly recommended for debugging)*
    - `--output=stdout.%x.%j` *# saves stdout to a file named stdout.jobname.JobID*

- **--error**
  - *save all stderr to a specified file (optional but highly recommended for debugging)*
    - `--error=stderr.%x.%j` *# saves stderr to a file named stderr.jobname.JobID*
    - *use just `--output` to save stdout and stderr to the same output file:* `--output=output.%j.log`

#### Multi nodes & cores reservation
```shell
#!/bin/bash                                                                                                                                                                                                 

#SBATCH --partition=gpu           # longq partition                                                                                                                                                         
#SBATCH --job-name=mpijob         # keep job name short with no spaces                                                                                                                                      
#SBATCH --time=1-00:00:00         # request 1 day; Format: days-hours:minutes:seconds                                                                                                                       
#SBATCH --nodes=2                 # request 1 node (optional since default=1)                                                                                                                               
#SBATCH --ntasks-per-node=2       # request 1 task (command) per node                                                                                                                                       
#SBATCH --mem=7500M               # request 7.5GB total memory per node;                                                                                                                                    
#SBATCH --output=stdout.%x.%j     # save stdout to a file with job name and JobID appended to file name                                                                                                     
#SBATCH --error=stderr.%x.%j      # save stderr to a file with job name and JobID appended to file name                                                                                                     

# unload any modules to start with a clean environment                                                                                                                                                      
module purge
# load software modules                                                                                                                                                                                     
module load slurm Python/3.8.2-GCCcore-9.3.0 OpenMPI/4.0.3-GCC-9.3.0

mpirun python3 mpiscript.py
```
- Output: (display the content of stdout.jobname.jobid) 
```shell
cat stdout.mpijob.5858504 
```
```shell
the number of cpus is: 4
```

#### Multi nodes & GPU reservation

```shell
#!/bin/bash                                                                                                                                                                                                 

#SBATCH --partition=gpu           # longq partition                                                                                                                                    
#SBATCH --job-name=gpujob         # keep job name short with no spaces                                                                                                                                      
#SBATCH --time=1-00:00:00         # request 1 day; Format: days-hours:minutes:seconds                                                                                                                       
#SBATCH --nodes=2                 # request 1 node (optional since default=1)
#SBATCH --gres=gpu:1              # request 1 GPU;                                                                                                                         
#SBATCH --ntasks-per-node=2       # request 1 task (command) per node                                                                                                                                       
#SBATCH --mem=7500M               # request 7.5GB total memory per node;                                                                                                                                    
#SBATCH --output=stdout.%x.%j     # save stdout to a file with job name and JobID appended to file name                                                                                                     
#SBATCH --error=stderr.%x.%j      # save stderr to a file with job name and JobID appended to file name                                                                                                     

# unload any modules to start with a clean environment                                                                                                                                                      
module purge
# load software modules                                                                                                                                                                                     
module load slurm Python/3.8.2-GCCcore-9.3.0 OpenMPI/4.0.3-GCC-9.3.0


```
- Output: (display the content of stdout.jobname.jobid) 
```shell
cat stdout.mpijob.5858504 
```
```shell
the number of cpus is: 4
```