#Usage:
# ./1_bench.sh server
# ./1_bench.sh perf
# ./1_bench.sh accuracy
# ./1_bench.sh all

mkdir -p results
MODEL="amd/Mixtral-8x7B-Instruct-v0.1-FP8-KV"

if [ $1 == "server" ]; then
    echo "INFO: server"
    vllm serve $MODEL \
	--disable-log-requests \
	--no-enable-prefix-caching \
	--kv_cache_dtype fp8 \
	--compilation-config '{"full_cuda_graph": true}'
fi


if [ $1 == "perf" ] || [ $1 == "all" ] ; then
    until curl -s localhost:8000/v1/models > /dev/null; 
    do
	sleep 1
    done
    echo "INFO: performance"
    INPUT_LENGTH=128
    OUTPUT_LENGTH=128
    CONCURRENT=16
    date=$(date +'%b%d_%H_%M_%S')
    rpt=result_${date}.json
    python /vllm-dev/benchmarks/benchmark_serving.py \
        --model $MODEL \
        --dataset-name random \
        --random-input-len ${INPUT_LENGTH} \
        --random-output-len ${OUTPUT_LENGTH} \
        --num-prompts $(( $CONCURRENT * 2 )) \
        --max-concurrency $CONCURRENT \
        --request-rate inf \
        --ignore-eos \
        --save-result \
        --result-dir ./results/ \
        --result-filename $rpt \
        --percentile-metrics ttft,tpot,itl,e2el
    python show_results.py 
fi


# TODO: do not use 8 months old baberabb/lm-evaluation-harness/wikitext-tokens
if [ $1 == "accuracy" ] || [ $1 == "all" ] ; then
    until curl -s localhost:8000/v1/models > /dev/null; 
    do
	sleep 1
    done
    echo "INFO: accuracy"
    if [ "$(which lm_eval)" == "" ] ; then
	git clone https://github.com/baberabb/lm-evaluation-harness.git -b wikitext-tokens
	cd lm-evaluation-harness
	pip install -e .
	pip install lm-eval[api]
    fi
    lm_eval --model local-completions --model_args model=$MODEL,base_url=http://0.0.0.0:8000/v1/completions,num_concurrent=10,max_retries=3 --tasks wikitext
fi
