# 使用 Python 3.11 slim 镜像作为基础镜像
FROM python:3.11-slim

# 设置工作目录
WORKDIR /app

# 设置环境变量
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PORT=80

# 安装系统依赖（curl 用于健康检查）
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl \
    && rm -rf /var/lib/apt/lists/*

# 复制依赖文件
COPY requirements.txt .

# 安装 Python 依赖
RUN pip install --no-cache-dir -r requirements.txt

# 复制应用代码
COPY main.py .

# 暴露端口（微信小程序平台期望 80 端口）
EXPOSE 80

# 健康检查（使用 80 端口）
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:80/ || exit 1

# 启动应用（监听 80 端口，微信小程序平台要求）
CMD sh -c "uvicorn main:app --host 0.0.0.0 --port ${PORT:-80}"
