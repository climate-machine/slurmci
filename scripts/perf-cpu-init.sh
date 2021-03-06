#!/bin/bash

#SBATCH --time=1:00:00     # walltime
#SBATCH --nodes=1          # number of nodes
#SBATCH --mem-per-cpu=5G   # memory per CPU core

set -euo pipefail
set -x #echo on
hostname

cd ${CI_SRCDIR}

export JULIA_DEPOT_PATH="$(pwd)/.slurmdepot_cpu"
export JULIA_CUDA_USE_BINARYBUILDER=false
export JULIA_MPI_BINARY=system
export OPENBLAS_NUM_THREADS=1

# disable download progress bars
export CURL_HOME="$(pwd)"
printf -- "--silent\n--show-error\n" > "$CURL_HOME/.curlrc"

module load openmpi/4.0.3 julia/1.4.2 hdf5/1.10.1 netcdf-c/4.6.1

julia --color=no --project -e 'using Pkg; Pkg.instantiate(); Pkg.build(;verbose=true)'
julia --color=no --project -e 'using Pkg; Pkg.precompile()'

cat Manifest.toml
