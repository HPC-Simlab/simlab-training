<h1 align="center">Reservation commands</h1>

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
squeue -u $USER
```
*** This command can display nothing if the job is very fast, but you can check the output of the job running
```shell
cat slurm-5858478.out
```
***The file slurm-jobid.out is generated automatically***


#### Slurm Parameters: nodes, tasks, cpus

- **--nodes**
  - *number of nodes to use where a node is one computer unit of many in an HPC cluster (optional)*
    - `--nodes=1` \# request 1 node (optional since default=1)
    - *used for multi-node jobs*
      - `--nodes=2`
    - *if the number of cpus per node is not specified then defaults to 1 cpu*
    - *defaults=1 node if `--nodes` not used & can use with `--ntasks-per-node` and `--cpus-per-task`
    - *do not use `--nodes` with `--array*

- **--ntasks**
  - *a task can be considered a command such as blastn, bwa, script.py, etc.*
    - `--ntasks=1` \# total tasks across all nodes per job
    - *when using `--ntasks` without `--nodes`, the values for `--ntasks-per-node` and `--cpus-per-task` will default to 1 node, 1 task per node, and 1 cpu per task*

- **--ntasks-per-node**
  - *use together with `--cpus-per-task`*
    - `--ntasks-per-node=1`

- **--cpus-per-task**
  - *number of CPUs (cores) for each task (command)*
    - `--cpus-per-task=44`

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

- **--partition**
  - *specify a partition (queue)*


- Display job information
```shell
scontrol show job 5858476
```
- Output:
```shell
JobId=5858476 JobName=bash
   UserId=ikissami(1063) GroupId=ikissami(1074) MCS_label=N/A
   Priority=102842 Nice=0 Account=novec-account QOS=normal
   JobState=RUNNING Reason=None Dependency=(null)
   Requeue=1 Restarts=0 BatchFlag=0 Reboot=0 ExitCode=0:0
   RunTime=00:02:10 TimeLimit=01:00:00 TimeMin=N/A
   SubmitTime=2023-12-08T21:44:05 EligibleTime=2023-12-08T21:44:05
   StartTime=2023-12-08T21:44:05 EndTime=2023-12-08T22:44:05 Deadline=N/A
   PreemptTime=None SuspendTime=None SecsPreSuspend=0
   LastSchedEval=2023-12-08T21:44:05
   Partition=defq AllocNode:Sid=master01:192503
   ReqNodeList=(null) ExcNodeList=(null)
   NodeList=node03
   BatchHost=node03
   NumNodes=1 NumCPUs=1 NumTasks=1 CPUs/Task=1 ReqB:S:C:T=0:0:*:*
   TRES=cpu=1,mem=8757M,node=1,billing=1
   Socks/Node=* NtasksPerN:B:S:C=0:0:*:* CoreSpec=*
   MinCPUsNode=1 MinMemoryCPU=8757M MinTmpDiskNode=0
   Features=(null) DelayBoot=00:00:00
   Gres=(null) Reservation=(null)
   OverSubscribe=OK Contiguous=0 Licenses=(null) Network=(null)
   Command=(null)
   WorkDir=/home/ikissami
   Power=
```




