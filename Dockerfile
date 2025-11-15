# 使用 uv 官方镜像 (Python 3.12 Alpine)
FROM ghcr.io/astral-sh/uv:python3.12-alpine

# 设置工作目录
WORKDIR /app

# 优化 uv 配置
ENV UV_COMPILE_BYTECODE=1
ENV UV_LINK_MODE=copy

# 安装项目依赖 (不包括项目本身)
# 使用 cache mount 加速构建
RUN --mount=type=cache,target=/root/.cache/uv \
    --mount=type=bind,source=uv.lock,target=uv.lock \
    --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    uv sync --locked --no-install-project --no-dev

# 复制整个项目
COPY . /app

# 安装项目 (包括项目本身)
RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync --locked --no-dev

# 将虚拟环境添加到 PATH
ENV PATH="/app/.venv/bin:$PATH"

# 清空 ENTRYPOINT (允许 smithery.yaml 中的 commandFunction 控制启动)
ENTRYPOINT []

# 默认启动命令
CMD ["uv", "run", "mcp", "run", "cpp_style_server.py"]
