# Running vllm online serving benchmark

First, clone the repo
```sh
git clone git clone https://github.com/seungrokj/ai_sprint_paris
cd guide_2_perf_accuracy_measurement
```
## Run vllm container
---
```sh
./0_container.sh
```
## Run vllm server & benchmarks (In the container)
---
```sh
./1_bench.sh server
```
(In the container), Run performance benchmark (client)
```sh
./1_bench.sh perf
```
(In the container), Run accuracy benchmark (client)
```sh
./1_bench.sh accu
```
(In the container), Or, run server & performance and accuracy client sequentially 
```sh
./1_bench.sh all
```
## You will see this performance metrics
1. Performance
---
result_Jun26_10_34_48.json

| median_ttft_ms| median_tpot_ms| median_itl_ms| median_e2el_ms| total_token_throughput|
| --------------| --------------| -------------| --------------| ----------------------|

2. Accuracy
---
| Tasks  |Version|Filter|n-shot|    Metric     |   |Value |   |Stderr|
|--------|------:|------|-----:|---------------|---|-----:|---|------|
|wikitext|      2|none  |     0|bits_per_byte  |↓  |0.4956|±  |   N/A|
|        |       |none  |     0|byte_perplexity|↓  |1.4100|±  |   N/A|
|        |       |none  |     0|word_perplexity|↓  |6.2787|±  |   N/A|
