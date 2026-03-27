#!/bin/bash
set -e

echo "Starting Hunyuan3D-2 Weight Sync from GCS..."
mkdir -p /tmp/weights
# Use gsutil -m rsync for maximum speed (streams directly from GCS to local SSD)
gsutil -m rsync -r gs://vmess-c5e2f-hunyuan-weights/ /tmp/weights/

echo "Sync complete. Starting API Server..."
# Set HY3DGEN_MODELS so smart_load_model resolves paths as:
# /tmp/weights + /app/weights/mini + subfolder => needs HY3DGEN_MODELS to point to /tmp/weights
# Actually: smart_load_model does: os.path.join(HY3DGEN_MODELS, model_path, subfolder)
# model_path = /tmp/weights/mini, subfolder = hunyuan3d-dit-v2-mini
# So we set HY3DGEN_MODELS=/ => / + /tmp/weights/mini + hunyuan3d-dit-v2-mini = /tmp/weights/mini/hunyuan3d-dit-v2-mini
export HY3DGEN_MODELS=/

exec python3 api_server.py --host 0.0.0.0 --port 8081 --model_path /tmp/weights/mini --tex_model_path /tmp/weights/paint
