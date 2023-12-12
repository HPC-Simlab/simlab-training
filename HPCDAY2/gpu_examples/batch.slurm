#!/bin/bash

#SBATCH --partition=gpu              # partition name
#SBATCH --job-name=single_gpu        # name of job 
#SBATCH --gres=gpu:1                 # number of GPUs 
#SBATCH --nodes=1                    # we request one node   
#SBATCH --ntasks-per-node=1          # with one task per node
#SBATCH --time=00:10:00              # max. exec. time requested (HH:MM:SS)
#SBATCH --mem=128g                   # memory required per node
#SBATCH --constraint=V100            # Type of GPU 
#SBATCH --output=gpu_single%j.out    # name of output file
#SBATCH --error=gpu_single%j.out     # name of error file (here, in common with the output file)

module purge
module load Python/3.8.6-GCCcore-10.2.0 CUDA/11.1.1-GCC-10.2.0
python Cupy_example.py
