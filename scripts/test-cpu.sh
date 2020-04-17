#!/bin/bash

#SBATCH --time=1:00:00     # walltime
#SBATCH --nodes=1          # number of nodes
#SBATCH --mem-per-cpu=5G   # memory per CPU core

set -euo pipefail
set -x #echo on

cd ${CI_SRCDIR}

export JULIA_DEPOT_PATH="$(pwd)/.slurmdepot/cpu"
export OPENBLAS_NUM_THREADS=1
export UCX_ERROR_SIGNALS="SIGILL,SIGBUS,SIGFPE" # SIGSEGV is used by Julia
export UCX_WARN_UNUSED_ENV_VARS=n
export CLIMA_GPU=false
export PATH="/groups/esm/common/julia-1.3:/usr/sbin:$PATH"

module load openmpi/4.0.3

mpiexec julia --color=no --project "$@"
