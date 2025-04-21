FROM nvidia/cuda:12.1.1-cudnn8-runtime-ubuntu22.04

# Install core packages
RUN apt update && \
    apt install -y python3 python3-pip git build-essential && \
    ln -sf /usr/bin/python3 /usr/bin/python && \
    ln -sf /usr/bin/pip3 /usr/bin/pip

# Upgrade pip just in case
RUN pip install --upgrade pip

# Install required libraries
RUN pip install vllm accelerate transformers

# Optional performance libraries (ignore errors)
RUN pip install flash-attn xformers || true

# Create working directory
WORKDIR /app

# Expose vLLM API port
EXPOSE 8000

# Start the model API server
CMD ["python3", "-m", "vllm.entrypoints.api_server", \
     "--model", "mistralai/Mistral-Nemo-Instruct-2407", \
     "--tokenizer", "mistralai/Mistral-Nemo-Instruct-2407", \
     "--host", "0.0.0.0", "--port", "8000"]
