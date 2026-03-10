#!/usr/bin/env python3
"""
CJMP 文档查询 MCP 服务器
支持 MCP 协议的 stdio 通信方式
参考 cangjie-docs 的设计模式
"""

import json
import sys
import os
from pathlib import Path
from typing import Any, Dict, List, Optional
import hashlib
import re


class DocumentIndex:
    """文档索引管理"""
    
    def __init__(self, config: Dict[str, Any], base_path: Path):
        self.config = config
        self.base_path = base_path
        self.documents = {}
        self.api_specs = {}
        self.code_examples = {}
        self.index_built = False
        self.stats = {
            "documents": 0,
            "apis": 0,
            "examples": 0,
            "sources": {}
        }
    
    def load_from_file(self, index_file: Path) -> bool:
        """从文件加载预索引数据"""
        try:
            with open(index_file, 'r', encoding='utf-8') as f:
                data = json.load(f)
            
            if "metadata" in data:
                self.stats = data["metadata"].get("stats", self.stats)
            
            if "documents" in data:
                self.documents = data["documents"]
            
            if "api_specs" in data:
                self.api_specs = data["api_specs"]
            
            if "code_examples" in data:
                self.code_examples = data["code_examples"]
            
            self.index_built = True
            return True
            
        except Exception as e:
            return False
    
    def get_categories(self) -> List[str]:
        """获取所有分类（文档源）"""
        return list(self.stats.get("sources", {}).keys())
    
    def get_docs_by_category(self, category: str) -> List[Dict[str, Any]]:
        """按分类获取文档"""
        docs = []
        for doc_id, doc in self.documents.items():
            if doc["source"] == category:
                docs.append({
                    "id": doc["id"],
                    "name": doc["name"],
                    "type": doc["type"],
                    "size": doc["size"]
                })
        return docs
    
    def get_category_stats(self) -> Dict[str, Any]:
        """获取分类统计信息"""
        return self.stats.get("sources", {})


class CJMPDocQueryServer:
    """CJMP 文档查询 MCP 服务器"""
    
    def __init__(self, config_path: str = "config.json"):
        self.config_path = Path(config_path)
        self.base_path = self.config_path.parent
        
        self.config = self._load_config(config_path)
        self.index = DocumentIndex(self.config, self.base_path)
        self.initialized = False
    
    def _load_config(self, config_path: str) -> Dict[str, Any]:
        """加载配置"""
        try:
            with open(config_path, 'r', encoding='utf-8') as f:
                return json.load(f)
        except FileNotFoundError:
            return {"docSources": [], "indexConfig": {"enableIndex": True}}
    
    def initialize(self) -> Dict[str, Any]:
        """初始化服务器"""
        if self.initialized:
            return {"status": "already_initialized", "stats": self.index.stats}
        
        index_file = self.base_path / "index-data" / "index.json"
        if index_file.exists():
            if self.index.load_from_file(index_file):
                self.initialized = True
                return {"status": "initialized", "stats": self.index.stats}
        
        self.initialized = True
        return {"status": "initialized", "stats": self.index.stats}
    
    def overview(self, category: Optional[str] = None, view_type: str = "overview", 
                 max_items: int = 50) -> Dict[str, Any]:
        """获取文档总览"""
        if not self.initialized:
            self.initialize()
        
        if view_type == "overview":
            # 分类统计视图
            stats = self.index.get_category_stats()
            if category:
                return {
                    "category": category,
                    "document_count": stats.get(category, 0),
                    "total_documents": sum(stats.values())
                }
            else:
                return {
                    "categories": stats,
                    "total_documents": sum(stats.values())
                }
        
        elif view_type == "tree":
            # 树形视图
            categories = self.index.get_categories()
            tree = {}
            for cat in categories:
                docs = self.index.get_docs_by_category(cat)
                tree[cat] = docs[:max_items]
            return tree
        
        elif view_type == "map":
            # 文档地图
            categories = self.index.get_categories()
            doc_map = {}
            for cat in categories:
                docs = self.index.get_docs_by_category(cat)
                doc_map[cat] = [doc["name"] for doc in docs[:max_items]]
            return doc_map
        
        return {}
    
    def list_docs(self, category: Optional[str] = None, max_items: int = 100,
                  include_preview: bool = False) -> List[Dict[str, Any]]:
        """列出文档"""
        if not self.initialized:
            self.initialize()
        
        docs = []
        
        if category:
            # 列出特定分类的文档
            for doc_id, doc in self.index.documents.items():
                if doc["source"] == category:
                    doc_info = {
                        "id": doc["id"],
                        "name": doc["name"],
                        "type": doc["type"],
                        "size": doc["size"]
                    }
                    if include_preview:
                        doc_info["preview"] = doc.get("content", "")[:200]
                    docs.append(doc_info)
        else:
            # 列出所有文档
            for doc_id, doc in self.index.documents.items():
                doc_info = {
                    "id": doc["id"],
                    "name": doc["name"],
                    "source": doc["source"],
                    "type": doc["type"],
                    "size": doc["size"]
                }
                if include_preview:
                    doc_info["preview"] = doc.get("content", "")[:200]
                docs.append(doc_info)
        
        return docs[:max_items]
    
    def search(self, query: str, category: Optional[str] = None,
               max_results: int = 10) -> List[Dict[str, Any]]:
        """搜索文档"""
        if not self.initialized:
            self.initialize()
        
        results = []
        query_lower = query.lower()
        query_terms = query_lower.split()
        
        for doc_id, doc in self.index.documents.items():
            if category and doc["source"] != category:
                continue
            
            search_content = doc.get("content", "").lower()
            
            relevance = 0
            for term in query_terms:
                count = search_content.count(term)
                relevance += count
            
            if relevance > 0:
                results.append({
                    "id": doc["id"],
                    "name": doc["name"],
                    "source": doc["source"],
                    "type": doc["type"],
                    "relevance": relevance,
                    "snippet": self._get_snippet(doc.get("content", ""), query)
                })
        
        results.sort(key=lambda x: x["relevance"], reverse=True)
        return results[:max_results]
    
    def get_doc(self, doc_id: str, include_metadata: bool = True) -> Optional[Dict[str, Any]]:
        """获取文档"""
        if not self.initialized:
            self.initialize()
        
        doc = self.index.documents.get(doc_id)
        if doc:
            result = {
                "id": doc["id"],
                "name": doc["name"],
                "content": doc.get("content", ""),
                "type": doc["type"],
                "source": doc["source"]
            }
            
            if include_metadata:
                result["metadata"] = {
                    "size": doc["size"],
                    "type": doc["type"]
                }
            
            return result
        return None
    
    def get_code_examples(self, description: str, language: Optional[str] = None,
                         max_results: int = 5) -> List[Dict[str, Any]]:
        """获取代码示例"""
        if not self.initialized:
            self.initialize()
        
        results = []
        desc_lower = description.lower()
        
        for example_id, example in self.index.code_examples.items():
            if language and example["language"] != language:
                continue
            
            if desc_lower in example["name"].lower() or desc_lower in example["code"].lower():
                results.append({
                    "id": example["id"],
                    "name": example["name"],
                    "code": example["code"],
                    "language": example["language"],
                    "source": example["source"]
                })
        
        return results[:max_results]
    
    def _get_snippet(self, content: str, query: str, context_chars: int = 200) -> str:
        """获取内容片段"""
        content_lower = content.lower()
        query_lower = query.lower()
        
        pos = content_lower.find(query_lower)
        if pos == -1:
            return content[:context_chars] + "..."
        
        start = max(0, pos - context_chars // 2)
        end = min(len(content), pos + len(query) + context_chars // 2)
        
        snippet = content[start:end]
        if start > 0:
            snippet = "..." + snippet
        if end < len(content):
            snippet = snippet + "..."
        
        return snippet


def handle_mcp_request(server: CJMPDocQueryServer, request: Dict[str, Any]) -> Dict[str, Any]:
    """处理 MCP 请求"""
    method = request.get("method", "")
    params = request.get("params", {})
    request_id = request.get("id", "unknown")
    
    if request_id is None:
        request_id = "unknown"
    
    try:
        if method == "initialize":
            server.initialize()
            return {
                "jsonrpc": "2.0",
                "id": request_id,
                "result": {
                    "protocolVersion": "2024-11-05",
                    "capabilities": {
                        "tools": {}
                    },
                    "serverInfo": {
                        "name": "cjmp-doc-query",
                        "version": "1.0.0"
                    }
                }
            }
        
        elif method == "tools/list":
            return {
                "jsonrpc": "2.0",
                "id": request_id,
                "result": {
                    "tools": [
                        {
                            "name": "cjmp_overview",
                            "description": "获取 CJMP 文档总览，支持 tree（树形导航）/map（文档地图）/overview（分类统计）三种视图",
                            "inputSchema": {
                                "type": "object",
                                "properties": {
                                    "category": {
                                        "type": "string",
                                        "description": "指定分类 (Docs/Engine/CJFrontend/SystemLibs/cangjie_multiplatform_interop/Community)",
                                        "enum": ["Docs", "Engine", "CJFrontend", "SystemLibs", "cangjie_multiplatform_interop", "Community"]
                                    },
                                    "view_type": {
                                        "type": "string",
                                        "description": "视图类型 (默认overview)",
                                        "enum": ["overview", "map", "tree"],
                                        "default": "overview"
                                    },
                                    "max_items": {
                                        "type": "number",
                                        "description": "最大显示条目数 (默认50)",
                                        "default": 50
                                    }
                                },
                                "required": []
                            }
                        },
                        {
                            "name": "cjmp_list_docs",
                            "description": "列出 CJMP 文档，支持分类筛选",
                            "inputSchema": {
                                "type": "object",
                                "properties": {
                                    "category": {
                                        "type": "string",
                                        "description": "指定分类 (Docs/Engine/CJFrontend/SystemLibs/cangjie_multiplatform_interop/Community)",
                                        "enum": ["Docs", "Engine", "CJFrontend", "SystemLibs", "cangjie_multiplatform_interop", "Community"]
                                    },
                                    "max_items": {
                                        "type": "number",
                                        "description": "最大返回数量 (默认100)",
                                        "default": 100
                                    },
                                    "include_preview": {
                                        "type": "boolean",
                                        "description": "是否包含内容预览 (默认false)",
                                        "default": False
                                    }
                                },
                                "required": []
                            }
                        },
                        {
                            "name": "cjmp_search",
                            "description": "搜索 CJMP 文档，支持多关键词 AND 匹配和分类过滤",
                            "inputSchema": {
                                "type": "object",
                                "properties": {
                                    "query": {
                                        "type": "string",
                                        "description": "搜索查询词。单个关键词或多关键词（空格分隔，AND匹配）"
                                    },
                                    "category": {
                                        "type": "string",
                                        "description": "可选的分类过滤 (Docs/Engine/CJFrontend/SystemLibs/cangjie_multiplatform_interop/Community)",
                                        "enum": ["Docs", "Engine", "CJFrontend", "SystemLibs", "cangjie_multiplatform_interop", "Community"]
                                    },
                                    "max_results": {
                                        "type": "number",
                                        "description": "最大结果数 (默认10)",
                                        "default": 10
                                    }
                                },
                                "required": ["query"]
                            }
                        },
                        {
                            "name": "cjmp_get_doc",
                            "description": "获取 CJMP 指定文档的完整内容",
                            "inputSchema": {
                                "type": "object",
                                "properties": {
                                    "doc_id": {
                                        "type": "string",
                                        "description": "文档ID"
                                    },
                                    "include_metadata": {
                                        "type": "boolean",
                                        "description": "是否包含元数据 (默认true)",
                                        "default": True
                                    }
                                },
                                "required": ["doc_id"]
                            }
                        },
                        {
                            "name": "cjmp_get_code_examples",
                            "description": "获取仓颉代码示例",
                            "inputSchema": {
                                "type": "object",
                                "properties": {
                                    "description": {
                                        "type": "string",
                                        "description": "功能描述"
                                    },
                                    "language": {
                                        "type": "string",
                                        "description": "编程语言（可选，默认 cj）",
                                        "default": "cj"
                                    },
                                    "max_results": {
                                        "type": "number",
                                        "description": "最大结果数 (默认5)",
                                        "default": 5
                                    }
                                },
                                "required": ["description"]
                            }
                        }
                    ]
                }
            }
        
        elif method == "tools/call":
            tool_name = params.get("name", "")
            tool_args = params.get("arguments", {})
            
            if tool_name == "cjmp_overview":
                result = server.overview(
                    category=tool_args.get("category"),
                    view_type=tool_args.get("view_type", "overview"),
                    max_items=tool_args.get("max_items", 50)
                )
                return {
                    "jsonrpc": "2.0",
                    "id": request_id,
                    "result": {
                        "content": [
                            {
                                "type": "text",
                                "text": json.dumps(result, ensure_ascii=False, indent=2)
                            }
                        ]
                    }
                }
            
            elif tool_name == "cjmp_list_docs":
                result = server.list_docs(
                    category=tool_args.get("category"),
                    max_items=tool_args.get("max_items", 100),
                    include_preview=tool_args.get("include_preview", False)
                )
                return {
                    "jsonrpc": "2.0",
                    "id": request_id,
                    "result": {
                        "content": [
                            {
                                "type": "text",
                                "text": json.dumps(result, ensure_ascii=False, indent=2)
                            }
                        ]
                    }
                }
            
            elif tool_name == "cjmp_search":
                result = server.search(
                    query=tool_args.get("query", ""),
                    category=tool_args.get("category"),
                    max_results=tool_args.get("max_results", 10)
                )
                return {
                    "jsonrpc": "2.0",
                    "id": request_id,
                    "result": {
                        "content": [
                            {
                                "type": "text",
                                "text": json.dumps(result, ensure_ascii=False, indent=2)
                            }
                        ]
                    }
                }
            
            elif tool_name == "cjmp_get_doc":
                result = server.get_doc(
                    doc_id=tool_args.get("doc_id", ""),
                    include_metadata=tool_args.get("include_metadata", True)
                )
                return {
                    "jsonrpc": "2.0",
                    "id": request_id,
                    "result": {
                        "content": [
                            {
                                "type": "text",
                                "text": json.dumps(result, ensure_ascii=False, indent=2) if result else "Document not found"
                            }
                        ]
                    }
                }
            
            elif tool_name == "cjmp_get_code_examples":
                result = server.get_code_examples(
                    description=tool_args.get("description", ""),
                    language=tool_args.get("language"),
                    max_results=tool_args.get("max_results", 5)
                )
                return {
                    "jsonrpc": "2.0",
                    "id": request_id,
                    "result": {
                        "content": [
                            {
                                "type": "text",
                                "text": json.dumps(result, ensure_ascii=False, indent=2)
                            }
                        ]
                    }
                }
            
            else:
                return {
                    "jsonrpc": "2.0",
                    "id": request_id,
                    "error": {
                        "code": -32601,
                        "message": f"Unknown tool: {tool_name}"
                    }
                }
        
        else:
            return {
                "jsonrpc": "2.0",
                "id": request_id,
                "error": {
                    "code": -32601,
                    "message": f"Unknown method: {method}"
                }
            }
    
    except Exception as e:
        return {
            "jsonrpc": "2.0",
            "id": request_id,
            "error": {
                "code": -32603,
                "message": str(e)
            }
        }


def main():
    """主函数 - MCP 服务器入口（stdio 模式）"""
    server = CJMPDocQueryServer("config.json")
    server.initialize()
    
    for line in sys.stdin:
        line = line.strip()
        if not line:
            continue
        
        try:
            request = json.loads(line)
            response = handle_mcp_request(server, request)
            print(json.dumps(response))
            sys.stdout.flush()
        except json.JSONDecodeError as e:
            print(json.dumps({
                "jsonrpc": "2.0",
                "id": "unknown",
                "error": {
                    "code": -32700,
                    "message": f"Parse error: {str(e)}"
                }
            }))
            sys.stdout.flush()


if __name__ == "__main__":
    main()
