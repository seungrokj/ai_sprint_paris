#Usage:
# ./1_profile.sh server
# ./1_profile.sh prof

mkdir -p results
MODEL="amd/Mixtral-8x7B-Instruct-v0.1-FP8-KV"

if [ $1 == "server" ] || [ $1 == "all" ]; then
    echo "INFO: server"
    VLLM_TORCH_PROFILER_DIR=./profile \
    vllm serve $MODEL \
	--disable-log-requests \
	--no-enable-prefix-caching \
	--kv_cache_dtype fp8 \
	--compilation-config '{"full_cuda_graph": true}' \
	&
fi


if [ $1 == "prof" ] || [ $1 == "all" ] ; then
    until curl -s localhost:8000/v1/models > /dev/null; 
    do
	sleep 1
    done
    echo "INIFO: performance"
    ISL=128
    OSL=10
    CON=16
    date=$(date +'%b%d_%H_%M_%S')
    rpt=result_${date}.json
    python /app/vllm/benchmarks/benchmark_serving.py \
        --model $MODEL \
        --dataset-name random \
        --random-input-len $ISL \
        --random-output-len $OSL \
        --num-prompts $(( $CON * 2 )) \
        --max-concurrency $CON \
        --request-rate inf \
        --ignore-eos \
        --save-result \
        --profile \
        --result-dir ./results_with_profile/ \
        --result-filename $rpt \
        --percentile-metrics ttft,tpot,itl,e2el
fi
