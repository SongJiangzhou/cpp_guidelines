# CLAUDE.md

本文件为 Claude Code (claude.ai/code) 提供项目工作指南。

## 项目概述

C++ 编码规范 MCP 服务器 - 提供 C++ 代码规范检查、最佳实践建议和代码审查支持的 MCP (Model Context Protocol) 服务器。

## 语言规范
- 所有对话和文档使用中文
- 代码注释使用中文
- 错误提示使用中文

## 核心架构

**cpp_style_server.py** - MCP 服务器主文件
- 使用 `FastMCP` 框架构建
- 提供 5 个工具、4 类资源、2 个提示模板

**cpp_style/** - 核心功能模块
- `tools/` - 5 个代码分析工具实现
- `resources/` - 4 类规范文档资源

## 开发命令

```bash
# 安装依赖
uv sync

# 运行服务器（stdio 模式）
uv run mcp run cpp_style_server.py

# 测试工具调用
uv run mcp dev cpp_style_server.py
```

## MCP 组件开发规范

添加新功能时遵循：

1. **工具 (Tools)** - 在 `cpp_style/tools/` 创建模块
2. **资源 (Resources)** - 在 `cpp_style/resources/` 创建模块
3. **提示 (Prompts)** - 在 `cpp_style_server.py` 中定义

详细说明参考 [README.md](./README.md)

## 项目配置

- **Python**: >= 3.12
- **包管理**: uv
- **MCP 框架**: FastMCP >= 1.21.0
- **容器化**: Docker (用于 Smithery 部署)

## 本地安装到 Claude Desktop

项目包含 `.mcp.json` 配置文件，或手动添加到 Claude Desktop 配置：

```json
{
  "mcpServers": {
    "cpp-style": {
      "command": "uv",
      "args": ["run", "mcp", "run", "cpp_style_server.py"],
      "cwd": "/path/to/cpp_guidelines"
    }
  }
}
```

## 通过 Smithery 安装

```bash
npx -y @smithery/cli install cpp-style-guide-mcp --client claude
```

完整的使用说明和示例请参考 [README.md](./README.md)
