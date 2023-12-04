# px-bench

## A framework for running storage performance benchmarks on Kubernetes based platforms. 

* `git clone` the repository to a Linux (macOS may work but not tested) system with `kubectl` access to the K8s cluster.
* If necessary, build the image and push to your registry:
```
cd image
docker build -t px-bench .
docker push ...
```
* Create a namespace for your benchmarking, and set your context to it (or ensure that you are applying all YAML below to that namespace)
* TBD: Create a wrapper script that will create the namespace and apply all YAML in order and with correct timing!
* Create the px-bench namespace with `kubectl create ns px-bench`
* Edit `px-bench-env.yml` to set the ConfigMap `env` to set desired values. If necessary, update `image:` to reflect the image you built. NOTE: SET YOUR STORAGECLASSES IN THIS FILE!
* Do NOT edit `px-bench-main.yml` (unless you are attempting to change the behavior of the benchmark!)
* In order to consume most of the available RAM so it is not used for buffering, run `kubectl apply -f chewram.yml`.
* Wait for `kubectl -n px-bench get pod -n chewram` for all the pods to show as `1/1 Running`.
* `kubectl apply -f px-bench-env.yml` to apply the configuration settings.
* `kubectl apply -f px-bench.yml` to start the run.
* Monitor progress with `kubectl logs -n px-bench -l px-bench=fio -f`. With the defaults, runtime is expected to be around 15 minutes.
* Wait for `kubectl get pod -n px-bench` for all the pods to show as Completed.

This will iterate through the combinations of `blocksize_list`, `readwrite_list`, and `storageclass_list` set in the ConfigMap, and runs those as independent `fio` jobs. Output will go the ConfigMap `fio-output`. Configurations will go to the ConfigMap `fio-config`.

To retrieve the output for processing, run `kubectl get cm csv -n px-bench -o jsonpath='{.data.csv}'`. Open the [spreadsheet](https://docs.google.com/spreadsheets/d/1MZ4yRnZQA59WjcarMTrr2j3BW6X8_3gS68ywdU1BNzQ/edit?usp=sharing) and make a copy. Paste the CSV into the sheet at A1 and make sure "Split text to columns" is selected.

![split values screenshot](/docs/split-values.png?raw=true "Screenshot from Google Sheets")

Click the Extensions menu and select "Apps Script". Click Run. This should create a number of new sheets populated with some bar charts.
