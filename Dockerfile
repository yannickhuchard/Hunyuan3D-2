FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y \
    python3 python3-pip git libgl1-mesa-glx libglib2.0-0 ninja-build \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .

RUN pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118
RUN pip3 install -r requirements.txt

COPY . .
RUN pip3 install -e .

RUN cd hy3dgen/texgen/custom_rasterizer && python3 setup.py install && cd ../../..
RUN cd hy3dgen/texgen/differentiable_renderer && python3 setup.py install

EXPOSE 7860
