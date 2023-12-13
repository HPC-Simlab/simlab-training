
## Exercice 1: Basic Job Submission

 - Create a simple Slurm script to run a basic job. Include information such as the job name, requested resources (nodes=1 (node11), tasks=1), and run `ex1.py`. 
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
assert hostname=='node11'
print('Resource allocation checks passed.')
"
```
- Output:
```shell
Hello from ex1.py!
Resource allocation checks passed.
```

## Exercice 2: 

- Create a Slurm script (`slurm_script_gpu.sh`) to submit a job that requires GPU resources. Include information such as the job name, requested resources (nodes=1, tasks=10, GPUs=1), and run `ex2.py`.
- Run the python file ex2.py

- Output:
```shell
Hello from ex2.py!
GPU check passed.
```
