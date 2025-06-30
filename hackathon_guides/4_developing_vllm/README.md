# Getting started developing on top of vLLM

> [!NOTE]  
> Scripts referred throughout this guide are available at https://github.com/seungrokj/ai_sprint_paris/blob/main/scripts.

First, clone the repo

```sh
git clone git clone https://github.com/seungrokj/ai_sprint_paris
cd ai_sprint_paris/scripts
```

We suggest you to refer to https://github.com/seungrokj/ai_sprint_paris/tree/main/hackathon_guides/2_perf_accuracy_measurement first. Reference bash scripts to launch a docker container to develop from, and commands to evaluate latency, throughput, accuracy are provided.

This guide gives a few more details to simplify development.

## Clone vLLM for local development in the devcloud VM

```bash
git clone https://github.com/vllm-project/vllm.git 
```

## Start the vLLM development and evaluation docker container

This script will [start a docker container](https://github.com/seungrokj/ai_sprint_paris/blob/main/scripts/0_container.sh) with vllm pre-installed. The container runs the image `rocm/vllm-dev:nightly_0610_rc2_0610_rc2_20250605`.

```sh
cd ai_sprint_paris/scripts
./0_container.sh
```

Once the docker container is started, you should should see the scripts from https://github.com/seungrokj/ai_sprint_paris/blob/main/scripts mounted into the container at `/workspace`.

## Install your vLLM local version instead of the provided reference in the docker container

The vLLM docker container already has a reference `vllm` installed, which is used as a baseline for evaluation. However, it is not practical to modify it locally.

Thus, the vLLM docker container launch script provided at https://github.com/seungrokj/ai_sprint_paris/blob/main/scripts/0_container.sh mounts a local `${PWD}/vllm` into `/vllm-dev` in the container (`-v ${PWD}/vllm:/vllm-dev`). This is to ease development e.g. through remote VS Code usage.

Once in the container, you can run

```bash
pip uninstall vllm -y
cd /vllm-dev
python setup.py develop
```

to install your editable vLLM version. Modifications done from the VM on vLLM's Python source code will then be immediately be visible in the container, and when rerunning `vllm serve`, or `1_bench.sh` and `2_profile` scripts.

## Available ROCm dependencies

Some ROCm dependencies are available in the base container `rocm/vllm-dev:nightly_0610_rc2_0610_rc2_20250605` that is provided:

```bash
pip freeze | grep aiter
# aiter @ file:///install/aiter-0.1.3.dev25%2Bg64876494-py3-none-any.whl#sha256=72290db37bac124739cf37ad0486d73b78cb91796dbbd346e3611e1e7dc410c1
pip freeze | grep torch
# torch @ file:///install/torch-2.7.0%2Bgitf717b2a-cp312-cp312-linux_x86_64.whl#sha256=f5a514d055081411e3a1779889f06840cff490eadc0bf83f587b6b3e8cab6f4b
pip freeze | grep triton
# triton @ file:///install/triton-3.2.0%2Bgite5be006a-cp312-cp312-linux_x86_64.whl#sha256=5ab00b333450c7179db7034795d0c70be6fa5e9a6ed2e203b11fb52cea116efc
```

TODO: check if CK is available? any other ones? need quark for fp8 or not?

Depending on which code path gets executed on vLLM, some of these dependencies may be used. There may be room for optimization in these dependencies as well.

In this case, a recommended approach could be to clone locally these dependencies, and also mount them into vLLM container with `-v $(pwd)/path/to/aiter:/aiter-dev`.

Read more: https://stackoverflow.com/questions/23439126/how-to-mount-a-host-directory-in-a-docker-container

## VS Code usage

If you would like to use VS Code for remote development, refer to: https://code.visualstudio.com/docs/remote/ssh. You may need to install the [Remote - SSH](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh) extension, and attach VS Code to the VM with:

```
CTRL + ATL + P
> Remote-SSH: Connect to Host...
Add New SSH Host
ssh root@{your VM ip}
```

## Cleaning up vLLM install

In our experience, if you modify vLLM version and/or kernels, it can be a good practice to clean the previous compiled vLLM shared objects, as in some cases they are not.

```bash
rm -r vllm/*.so
rm -r ./build
```

## References

### vLLM

* Documentation: https://docs.vllm.ai/en/latest/
* Researching issues and PRs in https://github.com/vllm-project/vllm can be helpful.

### AMD Instinct MI300X

AMD Instinct MI300X GPU uses the CDNA3 architecture. Its Instruction Set Architecture is a good reference: https://www.amd.com/content/dam/amd/en/documents/instinct-tech-docs/instruction-set-architectures/amd-instinct-mi300-cdna3-instruction-set-architecture.pdf

### ROCm and AMD libraries

External AMD libraries that are used in the ROCm distribution of vLLM are good references too:

* AITER: https://github.com/ROCm/aiter
* Composable Kernel: https://github.com/ROCm/composable_kernel
