MODEL="mistralai/Mixtral-8x7B-Instruct-v0.1"
MODEL="amd/Mixtral-8x7B-Instruct-v0.1-FP8-KV"
lm_eval --model vllm \
    --model_args pretrained=${MODEL},dtype=auto,add_bos_token=True,tensor_parallel_size=1,gpu_memory_utilization=0.7,max_model_len=20000,enforce_eager=True \
    --tasks wikitext \
    --gen_kwargs "do_sample=False,num_beams=1,top_p=1,temperature=0" \
    --batch_size 64 \
    --device cuda
