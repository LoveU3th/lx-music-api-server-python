FROM python:3.10-alpine

WORKDIR /app

# 添加编译依赖
RUN apk add --no-cache \
    gcc \
    musl-dev \
    python3-dev \
    libffi-dev \
    openssl-dev \
    cargo \
    make

COPY ./main.py .
COPY ./common ./common
COPY ./modules ./modules
COPY ./requirements.txt .

# 指定源, 如果后期源挂了, 更换个源就可以.
RUN pip install --no-cache-dir -i https://pypi.mirrors.ustc.edu.cn/simple -r requirements.txt

CMD [ "python", "main.py" ]
