# Sử dụng Python 3.10 để tránh lỗi build với pandas
FROM python:3.10-slim

# Cài các thư viện hệ thống cần thiết cho pandas, openpyxl, bcrypt,...
RUN apt-get update && apt-get install -y \
    build-essential \
    libffi-dev \
    libssl-dev \
    python3-dev \
    cargo \
    && rm -rf /var/lib/apt/lists/*

# Đặt thư mục làm việc
WORKDIR /app

# Sao chép và cài đặt requirements
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Sao chép toàn bộ mã nguồn vào container
COPY . .

# Expose port
EXPOSE 8000

# Render tự gán biến môi trường PORT, nhưng để mặc định 8000
ENV PORT=8000

# Dùng gunicorn với uvicorn worker
CMD ["gunicorn", "-k", "uvicorn.workers.UvicornWorker", "app:app"]
