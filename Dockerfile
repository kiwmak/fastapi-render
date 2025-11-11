# --- Bước 1: Chọn base image nhẹ và ổn định ---
FROM python:3.10-slim

# --- Bước 2: Thiết lập thư mục làm việc ---
WORKDIR /app

# --- Bước 3: Sao chép file requirements trước để tận dụng cache ---
COPY requirements.txt .

# --- Bước 4: Cài đặt các thư viện cần thiết ---
RUN pip install --no-cache-dir -r requirements.txt

# --- Bước 5: Sao chép toàn bộ mã nguồn vào container ---
COPY . .

# --- Bước 6: Khai báo biến môi trường ---
ENV PORT=8000

# --- Bước 7: Mở cổng mà ứng dụng chạy ---
EXPOSE 8000

# --- Bước 8: Lệnh khởi chạy ứng dụng ---
CMD ["gunicorn", "-k", "uvicorn.workers.UvicornWorker", "app:app", "--bind", "0.0.0.0:8000"]