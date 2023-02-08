# px-bench

## A framework for running storage performance benchmarks on Kubernetes based platforms. 

* `git clone` the repository to a Linux (macOS may work but not tested) system with `kubectl` access to the K8s cluster.
* Edit `config.env` for the desired values.
* Run `run_jobs.sh` to start the run.

`run_jobs.sh` iterates through the combinations of `blocksize_list`, `readwrite_list`, and `storageclass_list` set in `config.env`, and runs those as independent `fio` jobs.
