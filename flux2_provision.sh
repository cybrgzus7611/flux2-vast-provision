#!/bin/bash
set -e

#!/bin/bash
set -e

# Run Vast default ComfyUI provisioning
curl -fsSL \
  https://raw.githubusercontent.com/vast-ai/base-image/refs/heads/main/derivatives/pytorch/derivatives/comfyui/provisioning_scripts/default.sh \
  | bash

# Hugging Face tooling
python -m pip install -U huggingface_hub hf_transfer
export HF_HUB_ENABLE_HF_TRANSFER=1

# Absolute, persistent paths
COMFY=/workspace/ComfyUI
MODELS=$COMFY/models

mkdir -p \
  $MODELS/checkpoints \
  $MODELS/clip \
  $MODELS/vae

# Downloads MUST go directly into ComfyUI folders
huggingface-cli download black-forest-labs/FLUX.2-dev flux2-dev.safetensors \
  --local-dir $MODELS/checkpoints --token "$HF_TOKEN"

huggingface-cli download Comfy-Org/flux2-dev mistral_3_small_flux2_bf16.safetensors \
  --local-dir $MODELS/clip --token "$HF_TOKEN"

huggingface-cli download Comfy-Org/flux2-dev flux2-vae.safetensors \
  --local-dir $MODELS/vae --token "$HF_TOKEN"


