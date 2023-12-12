#!/bin/bash                                                                           

#SBATCH --partition=special      # partition name   
#SBATCH --job-name=kerascpu      # name of the job
#SBATCH --nodes=1                # number of nodes
#SBATCH --time=00:30:00          # maximum execution time requested (HH:MM:SS)
#SBATCH --output=kerascpu-%j.out        # name of output file
#SBATCH --error=cpu-%j.out         # name of error file (here, in common with output)                          

# cleans out the modules loaded in interactive and inherited by default
module purge

# load modules
module load Anaconda3

python3 keras_example.py
