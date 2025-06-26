# Running vllm online serving benchmark

First, clone the repo
```sh
git clone git clone https://github.com/seungrokj/ai_sprint_paris
cd guide_2_perf_accuracy_measurement
```
---
Run vllm container
```sh
./0_container.sh
```
---
(In the container), Run vlm server
```sh
./1_bench.sh server
```

(In the container), Then run vlm client to check performance
```sh
./1_bench.sh client
```
(In the container), Or, run server & client sequentially 
```sh
./1_bench.sh all
```
You will see 

result_Jun26_10_34_48.json


| median_ttft_ms| median_tpot_ms| median_itl_ms| median_e2el_ms| total_token_throughput|
| --------------| --------------| -------------| --------------| ----------------------|

