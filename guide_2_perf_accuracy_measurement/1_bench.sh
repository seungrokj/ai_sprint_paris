#Usage:
# ./1_bench.sh server
# ./1_bench.sh client
# ./1_bench.sh all

mkdir -p results
MODEL="amd/Mixtral-8x7B-Instruct-v0.1-FP8-KV"


if [ $1 == "server" ] || [ $1 == "all" ]; then
    echo "INFO: server"
    vllm serve $MODEL \
	--disable-log-requests \
	--no-enable-prefix-caching \
	--kv_cache_dtype fp8 \
	--compilation-config '{"full_cuda_graph": true}' \
	&
fi


if [ $1 == "client" ] || [ $1 == "all" ] ; then
    until curl -s localhost:8000/v1/models > /dev/null; 
    do
	sleep 1
    done
    echo "INIFO: client"
    ISL=128
    OSL=128
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
        --result-dir ./results/ \
        --result-filename $rpt \
        --percentile-metrics ttft,tpot,itl,e2el
    python show_results.py 
fi
