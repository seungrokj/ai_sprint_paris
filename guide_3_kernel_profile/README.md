# Running vllm online serving profiling

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
## Run vllm server & profile (In the container)
---
```sh
./1_profile.sh server
```
Run performance profile (client)
```sh
./1_bench.sh prof
```
## You will see these performance metrics
1. Profile dump
---
./profile/09c1eb36108d_137.1750940187968632644.pt.trace.json.gz

In the terminal, scp the dump file to the local machine

```sh
scp root@YOUR_IP:~/ai_sprint_paris/guide_3_kernel_profile/profile/*.pt.trace.json.gz .
```

Open a profile dump visualization tool [Perfetto](https://ui.perfetto.dev/)

Then you will see CPU-side 1 token decoding activities during decode-only phase

![CPU](./assets/ws_paris_prof_cpu.jpg)


Also, you will see GPU-side 1 layer out of 1 token decoding activities during decode-only phase: These are optimization target kernels

![GPU](./assets/ws_paris_prof_cpu.jpg)

