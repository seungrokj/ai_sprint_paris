# Dev Cloud quick start

## ⭐ Step 1
- Click GPU Droplets
![DO_1](./assets/DO_1.jpg)
 
## ⭐Step 2
- Select AMD MI300X (1 GPU)
- Choose an image (vLLM image)
- Add your SSH public key and select your key
- Click "Create GPU Droplet"

![DO_2](./assets/DO_2_vllm.jpg)

## ⭐Step 3
- Please add TAGs with your name to easily identify your instance
- Check out SSH IP
- Networking: You can skip this (this is only for en/disabling additional in/out bound ports other than ssh 22 port) 
![DO_3](./assets/DO_3.jpg)

## ⭐Step 4: Docker Launch
- Open a terminal and access the instance IP along with PORTs to connect to the instance

```sh
ssh root@YOUR_OP
```
- Check out GPU status by "rocm-smi"
- ![DO_4](./assets/DO_4_rocmsmi.jpg)

Now navigate to [hackathon_start](https://github.com/seungrokj/ai_sprint_paris/tree/main/hackathon_guides/1_developing_vllm)
