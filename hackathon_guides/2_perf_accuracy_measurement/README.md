# Running vllm online serving benchmark

> [!NOTE]  
> Scripts referred throughout this guide are available at https://github.com/seungrokj/ai_sprint_paris/blob/main/scripts.

## First, remove the existing vLLM and reinstall the upstream vllm to the local folder in the container

First thing first, refer to the vllm local installation flow at [install local vllm](https://github.com/seungrokj/ai_sprint_paris/tree/main/hackathon_guides/4_developing_vllm#getting-started-developing-on-top-of-vllm)

Once you successfully installed the latest vllm, you can find you local vllm version is greater than **0.9.2**
```sh
root@7c35b3b04713:/workspace# pip list | grep vllm
vllm                                     0.9.2.dev321+g8fe7fc863.rocm641 /vllm-dev
```


## After vllm installation, attach an other terminal to the running container (1st terminal: server, 2nd terminal: client)

We recommend you to use multiple terminals (or termux, or equivalent) `ssh`ed into your MI300 VM.

Once logged into the VM and once vLLM container is started (previous step), you can run:

```bash
docker exec -it vllm-container /bin/bash
```

to log interactively into the running container in an other shell.

## Run vllm server & benchmarks (In the container)

Run `vllm serve` through our provided reference script to start the server that will be used for latency/throughput/accuracy evaluation:

Make sure you're at /workspace for running benchmarks

```sh
cd /workspace
```

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
