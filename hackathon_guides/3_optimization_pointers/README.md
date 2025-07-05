# Optimization pointers

You are free to go in any direction, but here are some ideas and references to help you!

## Tuning `vllm serve` parameters

The [script provided to start vllm server](https://github.com/seungrokj/ai_sprint_paris/blob/cac59feb95236fe764ca2357862c6792d946a816/scripts/1_bench.sh#L30) uses a default configuration. It is likely not optimal, and some vllm server parameters may be tunable (https://github.com/vllm-project/vllm/blob/main/vllm/engine/arg_utils.py).

Similarly, vLLM has some ROCm-specific environment variables that trigger different code paths: https://github.com/vllm-project/vllm/blob/ffe00ef77a540087032aa23222a8c06cb7675994/vllm/envs.py#L646-L723

## References

### vLLM

* Documentation: https://docs.vllm.ai/en/latest/
* ROCm fork of vLLM might have some features on top of upstream vLLM that may give inspiration: https://github.com/rocm/vllm

### AMD Instinct MI300X

AMD Instinct MI300X GPU uses the CDNA3 architecture. Here are some good references:

* Instruction Set Architecture: https://www.amd.com/content/dam/amd/en/documents/instinct-tech-docs/instruction-set-architectures/amd-instinct-mi300-cdna3-instruction-set-architecture.pdf
* AMD Instinct MI300X performance guides: https://rocm.docs.amd.com/en/latest/how-to/gpu-performance/mi300x.html
* vLLM performance optimizations: https://rocm.docs.amd.com/en/latest/how-to/rocm-for-ai/inference-optimization/workload.html#vllm-performance-optimization
* ROCm library tuning: https://rocm.docs.amd.com/en/latest/how-to/rocm-for-ai/inference-optimization/workload.html#rocm-library-tuning

### ROCm and AMD libraries

External AMD libraries that are used in the ROCm distribution of vLLM are good references too:

* AITER: https://github.com/ROCm/aiter
* Composable Kernel: https://github.com/ROCm/composable_kernel

### Community

* GPU MODE Discord: https://discord.gg/gpumode and especially the ROCm channel.
* Researching issues and PRs in https://github.com/vllm-project/vllm can be helpful. There might be some optimization ideas proposed in open issues.
* Trying out other serving frameworks (https://github.com/sgl-project/sglang, https://github.com/huggingface/text-generation-inference/, https://github.com/InternLM/lmdeploy, others).

* AMD Developer Challenge 2025 results: https://www.datamonsters.com/amd-developer-challenge-2025. FP8 GEMM, Fused MOE were part of the challenge.

Results are available at https://www.gpumode.com/ and https://www.gpumode.com/news gives a few pointers where top submitters explained there solutions. Here are some links:
* [ColorsWind's Grand Prize Winning Kernel](https://github.com/ColorsWind/AMD-Developer-Challenge-2025)
* [Luong The Cong's FP8 Quant MatMul](https://github.com/luongthecong123/fp8-quant-matmul)
* [Seb V's Fast GPU Matrix Implementation](https://seb-v.github.io/optimization/update/2025/01/20/Fast-GPU-Matrix-multiplication.html)
* [Akash Karnatak's Challenge Solutions](https://akashkarnatak.github.io/amd-challenge/)
* [Fan Wenjie Technical Analysis](https://www.bilibili.com/read/cv41954307/?opus_fallback=1) and [solutions](https://gitee.com/fanwenjie/reference-kernels/)
* [Snektron's FP8 Matrix Multiplication](https://github.com/Snektron/gpumode-amd-fp8-mm)

Check out the channel `#amd-competition` on GPU MODE for more info.