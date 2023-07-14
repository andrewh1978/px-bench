# px-bench

## A framework for running storage performance benchmarks on Kubernetes based platforms. 

* `git clone` the repository to a Linux (macOS may work but not tested) system with `kubectl` access to the K8s cluster.
* If necessary, build the image:
```
cd image
docker build -t px-bench .
docker push ...
```
* Edit `px-bench.yml` to set the ConfigMap `env` to set desired values. If necessary, update `image:` to reflect the image you built.
* `kubectl apply -f chewram.yml` to start the run.
* Wait for `kubectl get pod -n chewram` for all the pods to show as `1/1 Running`.
* `kubectl apply -f px-bench.yml` to start the run.
* Wait for `kubectl get pod -n px-bench` for all the pods to show as Completed.

This will iterate through the combinations of `blocksize_list`, `readwrite_list`, and `storageclass_list` set in the ConfigMap, and runs those as independent `fio` jobs. Output will go the ConfigMap `fio-output`. Configurations will go to the ConfigMap `fio-config`.
