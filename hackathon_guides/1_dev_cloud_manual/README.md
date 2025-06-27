# Dev Cloud quick start

# If you already have an SSH IP of the Dev Cloud, please skip this and go to Step 4. Docker launch 
## ⭐ Step 1
![DO_1](./assets/DO_1.jpg)
 - Click GPU Droplets

## ⭐Step 2
![DO_2](./assets/DO_2.jpg)
- Select AMD MI300X (1 GPU)
- Choose an image (ws201 needs to select ROCm SoftWare base image)
- Add your SSH public key and select your key
- Click "Create GPU Droplet"

## ⭐Step 3
![DO_3](./assets/DO_3.jpg)
- Please add TAGs with your name to easily identify your instance
- Check out SSH IP
- (Optional) If you need to allow in/outbound PORTs, click "Networking" and register additional PORTs to the instance

## ⭐Step 4: Docker Launch
- Open a terminal and access the instance IP along with PORTs to connect to the instance

```sh
ssh root@YOUR_OP
```

- Check out GPU status by "rocm-smi"
- You can launch a vLLM docker by this command: 

```sh
docker pull rocm/vllm-dev:nightly_0624_rc2_0624_rc2_20250620
docker run -it \
  --device /dev/dri \
  --device /dev/kfd \
  --network host \
  --ipc host \
  --group-add video \
  --security-opt seccomp=unconfined \
  -v $(pwd):/workspace \
  -w /workspace \
  rocm/vllm-dev:nightly_0624_rc2_0624_rc2_20250620
```

Launch server in background
```sh
HSA_NO_SCRATCH_RECLAIM=1 VLLM_USE_V1=1 VLLM_WORKER_MULTIPROC_METHOD=spawn SAFETENSORS_FAST_GPU=1 vllm serve amd/Mixtral-8x7B-Instruct-v0.1-FP8-KV &
```

Sed request
```sh
curl http://localhost:8000/v1/completions \
    -H "Content-Type: application/json" \
    -d '{
        "prompt": "San Francisco is a",
        "max_tokens": 7,
        "temperature": 0
    }'
```

Expected results
```sh
{"id":"cmpl-e672df9a11db4e4f81df9f4482cf94d1","object":"text_completion","created":1750867347,"model":"amd/Mixtral-8x7B-Instruct-v0.1-FP8-KV","choices":[{"index":0,"text":" city that is known for its steep","logprobs":null,"finish_reason":"length","stop_reason":null,"prompt_logprobs":null}],"usage":{"prompt_tokens":5,"total_tokens":12,"completion_tokens":7,"prompt_tokens_details":null},"kv_transfer_params":nul
```


- Additionally, you can access the instance from the Visual Stuido Code
