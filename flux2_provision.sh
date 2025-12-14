#!/bin/bash
set -e

# ---- Run Vast's default ComfyUI provisioning first ----
curl -fsSL \
  https://raw.githubusercontent.com/vast-ai/base-image/refs/heads/main/derivatives/pytorch/derivatives/comfyui/provisioning_scripts/default.sh \
  | bash

# ---- Install Hugging Face download tools ----
python -m pip install -U huggingface_hub hf_transfer
export HF_HUB_ENABLE_HF_TRANSFER=1

# ---- Model directories ----
BASE=/workspace/ComfyUI/models
mkdir -p $BASE/diffusion_models $BASE/text_encoders $BASE/vae

# ---- Download FLUX.2 full-precision models ----
huggingface-cli download black-forest-labs/FLUX.2-dev flux2-dev.safetensors \
  --local-dir $BASE/diffusion_models --token "$HF_TOKEN"

huggingface-cli download Comfy-Org/flux2-dev mistral_3_small_flux2_bf16.safetensors \
  --local-dir $BASE/text_encoders --token "$HF_TOKEN"

huggingface-cli download Comfy-Org/flux2-dev flux2-vae.safetensors \
  --local-dir $BASE/vae --token "$HF_TOKEN"

