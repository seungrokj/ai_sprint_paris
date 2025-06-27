CONTAINER_NAME="vllm-container"
DOCKER_IMG="rocm/vllm-dev:nightly_0610_rc2_0610_rc2_20250605"

docker stop $CONTAINER_NAME


# PYTORCH_ROCM_ARCH="gfx942" is useful to later restrict kernel compilation only for CDNA3 architecture (MI300),
# speeding up compilation time.
docker run \
    --rm \
    -it \
    --ipc host \
    --name $CONTAINER_NAME \
    --privileged \
    --cap-add=CAP_SYS_ADMIN \
    --device=/dev/kfd \
    --device=/dev/dri \
    --device=/dev/mem \
    --cap-add=SYS_PTRACE \
    --security-opt seccomp=unconfined \
    -e PYTORCH_ROCM_ARCH="gfx942" \
    -e HSA_NO_SCRATCH_RECLAIM=1 \
    -e SAFETENSORS_FAST_GPU=1 \
    -e VLLM_USE_V1=1 \
    -e VLLM_V1_USE_PREFILL_DECODE_ATTENTION=1 \
    -v "$PWD/.hf_cache/":/root/.cache/huggingface/hub/ \
    -v "$PWD/.vllm_cache/":/root/.cache/vllm/ \
    -v "$PWD":/workspace \
    -v ${PWD}/vllm:/vllm-dev \
    -w /workspace \
    $DOCKER_IMG 
