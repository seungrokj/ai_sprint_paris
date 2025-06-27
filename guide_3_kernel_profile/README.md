# Running vllm online serving profiling

> [!NOTE]  
> Scripts referred throughout this guide are available at https://github.com/seungrokj/ai_sprint_paris/blob/main/scripts.

First, clone the repo

```sh
git clone git clone https://github.com/seungrokj/ai_sprint_paris
cd ai_sprint_paris/scripts
```

## Start vLLM docker container

This script will [start a docker container](https://github.com/seungrokj/ai_sprint_paris/blob/main/scripts/0_container.sh) with vllm pre-installed. The container runs the image `rocm/vllm-dev:nightly_0610_rc2_0610_rc2_20250605`.

```sh
cd ai_sprint_paris/scripts
./0_container.sh
```

Once the docker container is started, you should should see the scripts from https://github.com/seungrokj/ai_sprint_paris/blob/main/scripts mounted into the container at `/workspace`.

## Start vllm server

```sh
VLLM_TORCH_PROFILER_DIR=./profile ./2_profile.sh server
```

## Attach an other terminal to the running container

We recommend you to use multiple terminals (or termux, or equivalent) `ssh`ed into your MI300 VM.

Once logged into the VM and once vLLM container is started (previous step), you can run:

```bash
docker exec -it vllm-container /bin/bash
```

to log interactively into the running container in an other shell.

## Run profiling

Run performance profile (client)

```sh
./2_profile.sh prof
```

## Visualizing the profiling trace

Profile dump is saved under `./profile/*.pt.trace.json.gz`, for example `./profile/09c1eb36108d_137.1750940187968632644.pt.trace.json.gz`.

In the terminal, scp the profile dump file to your local machine:

```sh
scp root@YOUR_IP:~/ai_sprint_paris/guide_3_kernel_profile/profile/*.pt.trace.json.gz .
```

Open a profile visualization tool [Perfetto](https://ui.perfetto.dev/) in your web browser and load the trace there.

Then you will see CPU-side 1 token decoding activities during decode-only phase

![CPU](./assets/ws_paris_prof_cpu.jpg)

Also, you will see GPU-side 1 layer out of 1 token decoding activities during decode-only phase: These are optimization target kernels

![GPU](./assets/ws_paris_prof_gpu.jpg)

