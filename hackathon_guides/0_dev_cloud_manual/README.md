# Dev Cloud quick start

## ⭐ Step 1
- Click GPU Droplets
![DO_1](./assets/DO_1_n.jpg)
 
## ⭐Step 2
- Select AMD MI300X (1 GPU)
- Choose an image (vLLM image)
- Add your SSH public key and select your key
- Click "Create GPU Droplet"
![DO_2](./assets/DO_2_vllm.jpg)

## ⭐Step 3
- Please add TAGs with your name to easily identify your instance
- Check out SSH IP
![DO_3](./assets/DO_3_n.jpg)

## ⭐Step 4: Docker Launch
- Make sure you selected "vLLM Image" also check if TAGS is correctly applied
- Open a terminal and access the instance IP along with PORTs to connect to the instance

```sh
# for example, ssh root@129.212.176.203
ssh root@YOUR_OP
```
- Check out GPU status by "rocm-smi"
![DO_4](./assets/DO_4_rocmsmi.jpg)

Now navigate to 🏃‍➡️ [hackathon_start](https://github.com/seungrokj/ai_sprint_paris/tree/main/hackathon_guides/1_developing_vllm)
