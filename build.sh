#!/bin/bash
# CJMP 文档查询 MCP 打包脚本
# 使用 PyInstaller 将 MCP 服务器打包成独立可执行文件

set -e

echo "======================================"
echo "CJMP 文档查询 MCP 打包脚本"
echo "======================================"
echo ""

# 检查 Python
if ! command -v python3 &> /dev/null; then
    echo "错误: 未找到 Python 3"
    exit 1
fi

# 创建虚拟环境
echo "创建虚拟环境..."
if [ ! -d "venv" ]; then
    python3 -m venv venv
fi

# 激活虚拟环境
source venv/bin/activate

# 安装 PyInstaller
echo "安装 PyInstaller..."
pip install --upgrade pip
pip install pyinstaller

# 清理旧的构建文件
echo "清理旧的构建文件..."
rm -rf build/ dist/ __pycache__/

# 使用 PyInstaller 打包
echo ""
echo "开始打包..."
echo ""

pyinstaller --onefile \
    --name cjmp-docs-mcp \
    --add-data "mcp-server/index-data:index-data" \
    --add-data "mcp-server/config.json:." \
    --hidden-import json \
    --hidden-import hashlib \
    --hidden-import re \
    --hidden-import pathlib \
    --console \
    --clean \
    mcp-server/server_mcp.py

echo ""
echo "======================================"
echo "打包完成！"
echo "======================================"
echo ""
echo "可执行文件位置: dist/cjmp-docs-mcp"
echo ""

# 显示文件大小
if [ -f "dist/cjmp-docs-mcp" ]; then
    size=$(du -h dist/cjmp-docs-mcp | cut -f1)
    echo "文件大小: $size"
    echo ""
    
    # 测试可执行文件
    echo "测试可执行文件..."
    chmod +x dist/cjmp-docs-mcp
    echo "✅ 可执行文件已生成"
fi

echo ""
echo "下一步:"
echo "1. 将 dist/cjmp-docs-mcp 复制到目标位置"
echo "2. 在 VSCode 中配置 MCP 服务器"
echo "3. 重启 VSCode 即可使用"
