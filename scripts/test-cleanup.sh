#!/bin/bash

#SBATCH --time=0:15:00     # walltime
#SBATCH --ntasks=1         # number of processor cores (i.e. tasks)
#SBATCH --nodes=1          # number of nodes
#SBATCH --mem-per-cpu=1G   # memory per CPU core

set -euo pipefail
set -x #echo on
hostname

module load julia/1.4.2

julia --project finalize-test.jl

rm /central/scratchio/esm/slurmci/downloads/${CI_SHA}.tar.gz
rm -rf /central/scratchio/esm/slurmci/sources/${CI_SHA}
