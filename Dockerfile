FROM python:3.10-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt \
    && pip install streamlit==1.28.0


# Copy full project
COPY . .

# Install local package
RUN pip install -e .

# Download spaCy model
RUN python -m spacy download en_core_web_sm

# Expose port
EXPOSE 8501

# Run streamlit app
CMD ["streamlit", "run", "examples/01_out-of-the-box.py", "--server.port=8501", "--server.address=0.0.0.0"]

