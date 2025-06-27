# Running vllm online serving profiling

> [!NOTE]  
> Scripts referred throughout this guide are available at https://github.com/seungrokj/ai_sprint_paris/blob/main/scripts.

First, clone the repo

```sh
git clone git clone https://github.com/seungrokj/ai_sprint_paris
cd ai_sprint_paris/scripts
```

## Run vllm container

This script will [start a docker container](https://github.com/seungrokj/ai_sprint_paris/blob/main/scripts/0_container.sh) with vllm pre-installed, and mounts your local vLLM clone into `/vllm-dev` in the container. The container runs the image `rocm/vllm-dev:nightly_0610_rc2_0610_rc2_20250605`.

```sh
./0_container.sh
```

## Run vllm server & profile (In the container)

```sh
./1_profile.sh server
```

Run performance profile (client)

```sh
./1_bench.sh prof
```

## Now you can visualize GPU kernels 
profile dump is saved under ./profile/*.pt.trace.json.gz

for example, 
./profile/09c1eb36108d_137.1750940187968632644.pt.trace.json.gz

In the terminal, scp the dump file to the local machine

```sh
scp root@YOUR_IP:~/ai_sprint_paris/guide_3_kernel_profile/profile/*.pt.trace.json.gz .
```

Open a profile visualization tool [Perfetto](https://ui.perfetto.dev/) at the webbrowser

Then you will see CPU-side 1 token decoding activities during decode-only phase

![CPU](./assets/ws_paris_prof_cpu.jpg)


Also, you will see GPU-side 1 layer out of 1 token decoding activities during decode-only phase: These are optimization target kernels

![GPU](./assets/ws_paris_prof_gpu.jpg)

