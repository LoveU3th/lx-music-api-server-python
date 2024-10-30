# 构建阶段
FROM python:3.10-alpine as builder

WORKDIR /build

# 添加编译依赖
RUN apk add --no-cache \
    gcc \
    musl-dev \
    python3-dev \
    libffi-dev \
    openssl-dev \
    cargo \
    make

# 复制依赖文件
COPY requirements.txt .

# 安装依赖到指定目录
RUN pip install --no-cache-dir -i https://pypi.mirrors.ustc.edu.cn/simple -r requirements.txt -t /python-packages

# 运行阶段
FROM python:3.10-alpine

WORKDIR /app

# 从构建阶段复制安装好的依赖
COPY --from=builder /python-packages /usr/local/lib/python3.10/site-packages/

# 复制应用代码
COPY ./main.py .
COPY ./common ./common
COPY ./modules ./modules

# 运行应用
CMD [ "python", "main.py" ]
