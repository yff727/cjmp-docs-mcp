# CJMP 文档 MCP 服务器与 Skill

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)](https://github.com/yff727/cjmp-docs-mcp)

> CJMP (Cangjie Multi-Platform) 文档查询 MCP 服务器与 Claude Skill，提供 2131 个文档和 4211 个代码示例的查询能力。

---

## 📖 项目简介

本项目为 CJMP 跨平台开发框架提供 AI 辅助查询能力，包含：

- **MCP 服务器** - 提供 5 个文档查询工具
- **Claude Skill** - 提供完整的开发手册、代码示例和模板
- **预索引数据** - 无需下载源码即可使用

---

## 🚀 快速开始

### 方式一：使用预编译可执行文件（推荐）

1. **下载可执行文件**
   ```bash
   # macOS (arm64)
   # 从 GitHub Releases 下载
   chmod +x cjmp-docs-mcp
   ```

2. **配置 VSCode**
   
   编辑 VSCode 的 MCP 配置文件：
   
   **路径**: `~/Library/Application Support/Code/User/globalStorage/anthropic.claude-code/settings/cline_mcp_settings.json`
   
   ```json
   {
     "mcpServers": {
       "cjmp-docs": {
         "command": "/path/to/cjmp-docs-mcp",
         "args": []
       }
     }
   }
   ```

3. **重启 VSCode** 即可使用

### 方式二：从源码运行

1. **克隆仓库**
   ```bash
   git clone https://github.com/yff727/cjmp-docs-mcp.git
   cd cjmp-docs-mcp
   ```

2. **运行 MCP 服务器**
   ```bash
   python3 mcp-server/server_mcp.py
   ```

---

## 🛠️ MCP 工具列表

| 工具名 | 功能 | 必需参数 |
|--------|------|----------|
| `cjmp_overview` | 获取文档总览 | 无 |
| `cjmp_list_docs` | 列出文档列表 | category |
| `cjmp_search` | 搜索文档 | query |
| `cjmp_get_doc` | 获取文档内容 | doc_id |
| `cjmp_get_code_examples` | 获取代码示例 | 无 |

### 使用示例

```python
# 获取文档总览
cjmp_overview()

# 搜索 UI 组件文档
cjmp_search(query="Button", category="CJFrontend")

# 获取代码示例
cjmp_get_code_examples(query="网络请求")
```

---

## 📚 Skill 内容

### 代码示例（10个）

| 示例 | 内容 | 难度 |
|------|------|------|
| 01_hello_world.cj | 应用入口 | beginner |
| 02_basic_components.cj | 基础组件 | beginner |
| 03_layout_components.cj | 布局组件 | intermediate |
| 04_list_components.cj | 列表组件 | intermediate |
| 05_router_navigation.cj | 路由导航 | intermediate |
| 06_state_management.cj | 状态管理 | intermediate |
| 07_system_capabilities.cj | 系统能力 | intermediate |
| 08_java_interop.cj | Java 互操作 | advanced |
| 09_form_components.cj | 表单组件 | intermediate |
| 10_animation.cj | 动画效果 | advanced |

### 代码模板（8个）

- `ability_entry.cj.template` - 应用入口模板
- `page_component.cj.template` - 页面组件模板
- `custom_component.cj.template` - 自定义组件模板
- `data_source.cj.template` - 数据源模板
- `http_request.cj.template` - 网络请求模板
- `local_storage.cj.template` - 本地存储模板
- `java_bridge.cj.template` - Java 互操作模板
- `unit_test.cj.template` - 单元测试模板

---

## 📂 项目结构

```
cjmp-docs-mcp/
├── SKILL.md                    # Claude Skill 主文件
├── README.md                   # 项目说明
├── mcp-server/                 # MCP 服务器
│   ├── server_mcp.py           # MCP 主程序
│   ├── config.json             # 配置文件
│   └── index-data/             # 预索引数据
│       ├── index.json          # 文档索引
│       ├── code_examples.json  # 代码示例
│       └── metadata.json       # 元数据
├── examples/                   # 代码示例
├── templates/                  # 代码模板
├── reference/                  # 参考文档
└── dist/                       # 预编译可执行文件
    └── cjmp-docs-mcp           # macOS 可执行文件
```

---

## 📊 数据统计

| 类型 | 数量 |
|------|------|
| 文档总数 | 2,131 |
| 代码示例 | 4,211 |
| 文档仓库 | 6 |

### 文档仓库

| 仓库 | 文档数 | 说明 |
|------|--------|------|
| Docs | 54 | 快速入门、贡献指南 |
| Engine | 1,165 | 渲染引擎、图形引擎 |
| CJFrontend | 691 | UI 组件、状态管理 |
| SystemLibs | 185 | 系统能力接口 |
| cangjie_multiplatform_interop | 32 | 语言互操作 |
| Community | 4 | 社区文档 |

---

## 🔗 相关链接

- [CJMP 官方仓库](https://gitcode.com/CJMP)
- [仓颉语言官网](https://developer.huawei.com/consumer/cn/cangjie/)
- [MCP 协议文档](https://modelcontextprotocol.io/)

---

## 📝 许可证

本项目采用 [MIT License](LICENSE) 开源许可证。

---

## 🤝 贡献

欢迎贡献代码、示例和文档！

1. Fork 本仓库
2. 创建 feature 分支
3. 提交改动
4. 发起 Pull Request

---

**维护者**: CJMP 社区
**版本**: v1.0.0
**最后更新**: 2025-03-10
