# Bluedemo API 服务文档

## 服务说明

这是一个基于 FastAPI 的后端服务，提供简单的问候接口。

## 启动服务

### 安装依赖

```bash
pip install -r requirements.txt
```

### 运行服务

```bash
uvicorn main:app --host 0.0.0.0 --port 8000
```

服务启动后，访问 `http://localhost:8000/docs` 可以查看 API 文档。

## API 接口说明

### 1. 问候接口

**接口地址：** `POST /api/hello`

**请求头：**
```
Content-Type: application/json
```

**请求参数：**
```json
{
  "name": "字符串类型，用户输入的姓名"
}
```

**请求示例：**
```json
{
  "name": "张三"
}
```

**响应格式：**
```json
{
  "message": "Hello Word 张三"
}
```

**响应示例：**
```json
{
  "message": "Hello Word 张三"
}
```

**错误处理：**
- 如果 name 参数缺失或为空，将返回 422 错误
- 如果服务异常，将返回 500 错误

## 部署说明

生产环境部署时，建议使用以下命令：

```bash
uvicorn main:app --host 0.0.0.0 --port 8000 --workers 4
```

或者使用 gunicorn：

```bash
gunicorn main:app -w 4 -k uvicorn.workers.UvicornWorker --bind 0.0.0.0:8000
```

## 注意事项

1. 服务已配置 CORS，允许跨域请求
2. 生产环境建议配置 HTTPS
3. 建议配置适当的请求频率限制
