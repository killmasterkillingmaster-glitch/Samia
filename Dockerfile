FROM python:3.10-slim

# Install system dependencies (FFmpeg for Hugging Face container fallback)
RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg \
    fonts-liberation \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Step 1: Copy only requirements first to utilize Docker Layer Cache
COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Step 2: Copy rest of the application
COPY . /app

# Permissions for Hugging Face
RUN chmod -R 777 /app

EXPOSE 7860
CMD ["python", "main.py"]
