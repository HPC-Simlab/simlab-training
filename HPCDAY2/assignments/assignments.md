# Exercises for Simlab cluster

## Exercice 1: Basic Job Submission

 - Create a simple Slurm script to run a basic job. Include information such as the job name, requested resources (nodes=1 (node03), tasks=1), and run `ex1.py`. 
 - Submit the job using the sbatch command.
 - Add this script to you batch file

```shell
# Run the python script
python -c "  
import os
import socket

print('Hello from ex1.py!')
# Check the allocated resources
nodes = int(os.environ.get('SLURM_JOB_NUM_NODES', 1))
tasks_per_node = int(os.environ.get('SLURM_CPUS_PER_TASK', 1))
hostname = socket.gethostname()

assert nodes==1
assert tasks_per_node==1
assert hostname=='node03'
print('Resource allocation checks passed.')
"
```
- Output:
```shell
Hello from ex1.py!
Resource allocation checks passed.
```

## Exercice 2: 

- Create a Slurm script (`slurm_script_gpu.sh`) to submit a job that requires GPU resources. Include information such as the job name, requested resources (tasks=10, GPUs=2), and run `ex2.py`.
- Run the python file `ex2.py`

- Output:
```shell
Hello from ex2.py!
Resource allocation checks passed.
```

### Exercice 3:
- Run the batch file below:
```shell
#!/bin/bash

#SBATCH --job-name=my_job
#SBATCH --partition=shortq
#SBATCH --ntasks=1
#SBATCH --time=00:10:00

python3 ex3.py
```
1. did the job complete successfully? 
2. If not, what type of problem(s) did you encounter?

3. If the job did not complete successfully, fix the problem by requesting more resources as needed (CPU and/or memory). Then submit your script to the cluster again.
		- how much resources (CPU and memory) did you request to run your job successfully?

4. Inspect the resource usage of the job you just completed with the following command. Verify whether you are really using all the CPU and memory that you requested:  
    `sacct -j <jobid> --format=jobid,jobname%15,partition,account%30,alloctres%40,cputime,`  
    `totalcpu,maxrss,submit,state%15,exitcode,elapsed`
    
5. Are the resources requested for your job adequate, or is it possible to make them fit better to the actual requirements of the job?  
		- If needed, adapt the resource requirements of your job and run it again.

### Exercice 4:


