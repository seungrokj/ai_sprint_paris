# Running vllm online serving benchmark

> [!NOTE]  
> Scripts referred throughout this guide are available at https://github.com/seungrokj/ai_sprint_paris/blob/main/scripts.

First, clone the repo
```sh
git clone git clone https://github.com/seungrokj/ai_sprint_paris
cd ai_sprint_paris/scripts
```

## Start the vLLM development and evaluation docker container

This script will [start a docker container](https://github.com/seungrokj/ai_sprint_paris/blob/main/scripts/0_container.sh) with vllm pre-installed, and mounts your local vLLM clone into `/vllm-dev` in the container. The container runs the image `rocm/vllm-dev:nightly_0610_rc2_0610_rc2_20250605`.

```sh
./0_container.sh
```

## Attach an other terminal to the running container

We recommend you to use multiple terminals (or termux, or equivalent) `ssh`ed into your MI300 VM.

Once logged into the VM, you can run:

```bash
docker exec -it vllm-container /bin/bash
```

to log interactively into the running container.

## Run vllm server & benchmarks (In the container)

Run `vllm serve` through our provided reference script to start the server that will be used for latency/throughput/accuracy evaluation:

```sh
./1_bench.sh server
```

### Run performance benchmark (client)
```sh
./1_bench.sh perf
```

### Run accuracy benchmark (client)
```sh
./1_bench.sh accuracy
```

### Run performance and accuracy benchmarks sequentially 
```sh
./1_bench.sh all
```

## You will see these performance metrics

1. Performance

result_Jun26_10_34_48.json

| median_ttft_ms| median_tpot_ms| median_itl_ms| median_e2el_ms| total_token_throughput|
| --------------| --------------| -------------| --------------| ----------------------|

2. Accuracy (word_perplexity) Compare PPL against [Official PPL score](https://huggingface.co/amd/Mixtral-8x7B-Instruct-v0.1-FP8-KV#evaluation-scores)

| Tasks  |Version|Filter|n-shot|    Metric     |   |Value |   |Stderr|
|--------|------:|------|-----:|---------------|---|-----:|---|------|
|wikitext|      2|none  |     0|bits_per_byte  |↓  |0.5400|±  |   N/A|
|        |       |none  |     0|byte_perplexity|↓  |1.4540|±  |   N/A|
|        |       |none  |     0|word_perplexity|↓  |4.1378|±  |   N/A|
