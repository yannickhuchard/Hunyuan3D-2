from huggingface_hub import snapshot_download
import os

# Define explicit local directories for weights
MINI_DIR = './weights/mini'
PAINT_DIR = './weights/paint'

os.makedirs(MINI_DIR, exist_ok=True)
os.makedirs(PAINT_DIR, exist_ok=True)

print(f"Pre-downloading Hunyuan3D-2mini weights to {MINI_DIR}...")
snapshot_download(
    repo_id='tencent/Hunyuan3D-2mini', 
    local_dir=MINI_DIR,
    local_dir_use_symlinks=False
)

print(f"Pre-downloading Hunyuan3D-2 weights to {PAINT_DIR}...")
snapshot_download(
    repo_id='tencent/Hunyuan3D-2', 
    local_dir=PAINT_DIR,
    local_dir_use_symlinks=False
)

print("Download complete!")
