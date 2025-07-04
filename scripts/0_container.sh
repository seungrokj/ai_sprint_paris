CONTAINER_NAME="vllm-container"
DOCKER_IMG="rocm/vllm-dev:nightly_0610_rc2_0610_rc2_20250605"


running_container=$(docker ps -q --filter "name=$CONTAINER_NAME")

if [ $running_container ]; then
    echo "Stopping the already running $CONTAINER_NAME container"
    docker stop $CONTAINER_NAME
fi


if ! test -f vllm/setup.py; then echo "WARNING: This script assumes it is launched from a directory containing a cloned vllm, but it was not found. Make sure vllm is cloned at ${PWD}/vllm."; fi

echo "Starting a container based off $DOCKER_IMG..."
echo "With the following mounted folders:"
echo "$PWD/.hf_cache -> /root/.cache/huggingface/hub"
echo "$PWD/.vllm_cache -> /root/.cache/vllm/"
echo "$PWD -> /workspace"
echo "$PWD/vllm -> /vllm-dev"

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
