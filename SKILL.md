---
name: cjmp-doc-query
description: CJMP文档查询工具。用于查询CJMP项目文档、API规范和代码示例。当用户需要查询仓颉跨平台开发文档、UI引擎文档或代码示例时调用此技能。
---

# CJMP 文档查询工作手册

---

## 目录

- [第1章：项目概述](#第1章项目概述)
- [第2章：文档仓库详解](#第2章文档仓库详解)
  - [2.1 Docs 文档仓库](#21-docs-文档仓库)
  - [2.2 Engine 引擎仓库](#22-engine-引擎仓库)
  - [2.3 CJFrontend 前端仓库](#23-cjfrontend-前端仓库)
  - [2.4 SystemLibs 系统库仓库](#24-systemlibs-系统库仓库)
  - [2.5 cangjie_multiplatform_interop 互操作仓库](#25-cangjie_multiplatform_interop-互操作仓库)
  - [2.6 Community 社区仓库](#26-community-社区仓库)
- [第3章：CJMP 开发基础](#第3章cjmp-开发基础)
  - [3.1 应用入口](#31-应用入口)
  - [3.2 UI 组件](#32-ui-组件)
  - [3.3 布局系统](#33-布局系统)
  - [3.4 状态管理](#34-状态管理)
  - [3.5 路由导航](#35-路由导航)
- [第4章：MCP工具集成](#第4章mcp工具集成)
- [第5章：查询策略](#第5章查询策略)
- [第6章：使用示例](#第6章使用示例)
- [第7章：常见问题](#第7章常见问题)

---

## 第1章：项目概述

### 1.1 CJMP 是什么

CJMP（Cangjie Multi-Platform）是仓颉语言的跨平台开发框架，提供：

- **跨平台 UI 开发** - 一套代码，多端运行（Android、iOS、HarmonyOS、Web）
- **高性能渲染引擎** - 自研渲染管线，接近原生性能
- **统一的系统接口** - 三端一致的系统能力 API
- **语言互操作** - 与 Java、Objective-C 无缝互操作

### 1.2 文档统计

| 类型 | 数量 |
|------|------|
| 文档总数 | 2,131 |
| 代码示例 | 4,211 |
| 文档仓库 | 6 |
| 支持的文件类型 | Markdown、仓颉代码、JSON、YAML、GN |

### 1.3 核心架构

```
┌─────────────────────────────────────────────────────────┐
│                    CJMP 架构层次                         │
├─────────────────────────────────────────────────────────┤
│  应用层    │  CJFrontend (仓颉 UI 组件)                  │
├─────────────────────────────────────────────────────────┤
│  框架层    │  SystemLibs (系统能力接口)                  │
├─────────────────────────────────────────────────────────┤
│  引擎层    │  Engine (渲染引擎、图形引擎、布局引擎)       │
├─────────────────────────────────────────────────────────┤
│  互操作层  │  cangjie_multiplatform_interop             │
├─────────────────────────────────────────────────────────┤
│  平台层    │  Android │ iOS │ HarmonyOS │ Web          │
└─────────────────────────────────────────────────────────┘
```

### 1.4 平台支持

| 平台 | 最低版本 | 架构 |
|------|----------|------|
| Android | 8.0+ (API 26+) | arm64 |
| iOS | 12.0+ | arm64 |
| HarmonyOS | 5.1.0+ | arm64 |

---

## 第2章：文档仓库详解

### 2.1 Docs 文档仓库

**仓库地址**: https://gitcode.com/CJMP/Docs

**文档数量**: 54 个

**主要内容**:
- 应用开发者快速入门
- 框架开发者快速入门
- SDK 版本说明
- 贡献指南
- 编码规范

**核心文档**:

| 文档名 | 说明 |
|--------|------|
| cjmp-sdk-0.2.1.md | SDK 0.2.1 版本说明 |
| systemlibs-design.md | 系统库设计文档 |
| systemlibs-build.md | 系统库构建指南 |
| systemlibs-demo.md | 系统库示例 |
| java-coding-style.md | Java 编码规范 |
| cpp-codeing-style.md | C++ 编码规范 |

**适用场景**:
- 初次接触 CJMP 项目
- 了解项目贡献流程
- 查看编码规范

---

### 2.2 Engine 引擎仓库

**仓库地址**: https://gitcode.com/CJMP/Engine

**文档数量**: 1,165 个

**主要内容**:
- 渲染管线实现
- 图形引擎
- 布局引擎
- 动画系统
- 事件处理
- 平台适配

**核心模块**:

| 模块 | 说明 |
|------|------|
| render | 渲染管线，负责将 UI 树渲染到屏幕 |
| graphics | 图形引擎，提供 2D/3D 绘图能力 |
| layout | 布局引擎，计算 UI 元素的位置和大小 |
| animation | 动画系统，支持属性动画和转场动画 |
| event | 事件处理，处理触摸、键盘等输入事件 |
| platform | 平台适配，封装各平台差异 |

**适用场景**:
- 深入了解渲染原理
- 性能优化
- 平台适配开发
- 自定义渲染效果

---

### 2.3 CJFrontend 前端仓库

**仓库地址**: https://gitcode.com/CJMP/CJFrontend

**文档数量**: 691 个

**主要内容**:
- 仓颉 UI 组件
- 组件 API 文档
- 样式系统
- 状态管理
- 路由导航

**核心组件分类**:

| 分类 | 组件示例 |
|------|----------|
| 基础组件 | Text、Image、Button、Input |
| 容器组件 | Container、Stack、Flex、Grid |
| 列表组件 | List、Grid、Waterfall |
| 导航组件 | Navigator、Tab、Drawer |
| 反馈组件 | Dialog、Toast、Loading |
| 表单组件 | Form、Checkbox、Radio、Switch |

**适用场景**:
- 使用仓颉开发 UI 界面
- 查询组件 API
- 实现特定 UI 效果
- 状态管理方案

---

### 2.4 SystemLibs 系统库仓库

**仓库地址**: https://gitcode.com/CJMP/SystemLibs

**文档数量**: 185 个

**主要内容**:
- 系统能力接口定义
- 三端一致性 API
- 平台能力封装

**核心能力模块**:

| 模块 | 说明 |
|------|------|
| NetworkKit | 网络请求能力 |
| ArkData | 数据存储能力 |
| SensorServiceKit | 传感器能力 |
| MediaKit | 多媒体能力 |
| CameraKit | 相机能力 |
| ConnectivityKit | 连接能力（WiFi、蓝牙等） |

**设计原则**:
- 三端 API 一致性
- 最小权限原则
- 异步调用模式
- 错误处理规范

**适用场景**:
- 调用系统能力
- 平台适配开发
- 权限管理
- 性能优化

---

### 2.5 cangjie_multiplatform_interop 互操作仓库

**仓库地址**: https://gitcode.com/Cangjie/cangjie_multiplatform_interop

**文档数量**: 32 个

**主要内容**:
- 仓颉与 Java 互操作
- 仓颉与 Objective-C 互操作
- 跨语言调用规范
- 类型映射规则

**互操作能力**:

| 平台 | 互操作对象 | 说明 |
|------|-----------|------|
| Android | Java/Kotlin | 调用 Android SDK 和第三方库 |
| iOS | Objective-C/Swift | 调用 iOS SDK 和第三方库 |
| HarmonyOS | ArkTS | 调用 HarmonyOS API |

**适用场景**:
- 调用平台原生 API
- 集成第三方 SDK
- 平台特定功能实现
- 遗留代码复用

---

### 2.6 Community 社区仓库

**仓库地址**: https://gitcode.com/CJMP/Community

**文档数量**: 4 个

**主要内容**:
- 跨平台框架 SIG 例会材料
- 会议纪要
- 社区活动记录

**适用场景**:
- 了解社区动态
- 参与社区讨论
- 查看发展路线图

---

## 第3章：CJMP 开发基础

### 3.1 应用入口

CJMP 应用使用 `@Entry` 装饰器标记入口类：

```cj
import cjmp.ui.*

@Entry
class MainAbility {
    func onCreate(want: Want, launchParam: LaunchParam): Unit {
        AppLog.info("MainAbility OnCreated")
    }

    func build() {
        Column {
            Text("Hello CJMP!")
                .fontSize(24)
        }
        .width(100.percent)
        .height(100.percent)
    }
}
```

**示例参考**: `examples/01_hello_world.cj`

---

### 3.2 UI 组件

#### 基础组件

**Text - 文本**:
```cj
Text("文本内容")
    .fontSize(16)
    .fontColor(0x333333)
    .textAlign(TextAlign.Center)
```

**Button - 按钮**:
```cj
Button("点击我")
    .width(120)
    .height(40)
    .onClick { e => 
        // 处理点击
    }
```

**Image - 图片**:
```cj
Image("https://example.com/image.png")
    .width(100)
    .height(100)
    .objectFit(ImageFit.Cover)
```

**示例参考**: `examples/02_basic_components.cj`

---

### 3.3 布局系统

#### Column - 垂直布局

```cj
Column {
    Text("第一行")
    Text("第二行")
}
.width(100.percent)
.justifyContent(FlexAlign.Center)
```

#### Row - 水平布局

```cj
Row {
    Text("左侧")
    Text("右侧")
}
.width(100.percent)
.justifyContent(FlexAlign.SpaceBetween)
```

#### Flex - 弹性布局

```cj
Flex(FlexParams(
    justifyContent: FlexAlign.Start,
    alignItems: ItemAlign.Center
)) {
    Text("项目1")
    Text("项目2")
}
```

**示例参考**: `examples/03_layout_components.cj`

---

### 3.4 状态管理

使用 `@State` 装饰器管理组件状态：

```cj
@Entry
class StateExample {
    @State private var count: Int64 = 0
    
    func build() {
        Column {
            Text("计数: ${count}")
            Button("增加") { e => 
                count = count + 1  // 自动触发 UI 更新
            }
        }
    }
}
```

**状态装饰器**:
- `@State` - 组件内状态
- `@Prop` - 从父组件接收属性
- `@Link` - 与父组件双向绑定
- `@Provide` / `@Consume` - 跨组件层级传递

**示例参考**: `examples/06_state_management.cj`

---

### 3.5 路由导航

```cj
import cjmp.router.Router

// 页面跳转
Router.push(url: "DetailPage", params: "id=123")

// 获取参数
let params = Router.getParams()
match (params) {
    case Some(v) => // 处理参数
    case None => // 无参数
}

// 返回
Router.back()
```

**示例参考**: `examples/05_router_navigation.cj`

---

## 第4章：MCP工具集成

### 4.1 可用工具列表

当 MCP 服务器启动后，可以使用以下工具：

#### 1. cjmp_overview - 获取文档总览

**参数**:
- `category` (可选): 指定分类
- `view_type` (可选): 视图类型 (overview/map/tree)，默认 overview
- `max_items` (可选): 最大显示条目数，默认 50

**示例**:
```python
cjmp_overview()  # 获取所有分类统计
cjmp_overview(category="Engine", view_type="tree")  # 获取 Engine 的树形导航
```

#### 2. cjmp_list_docs - 列出文档

**参数**:
- `category` (必需): 主分类
- `subcategory` (可选): 子分类路径
- `max_items` (可选): 最大返回数量，默认 100
- `include_preview` (可选): 是否包含内容预览，默认 false

**示例**:
```python
cjmp_list_docs(category="Docs")  # 列出 Docs 分类下的文档
cjmp_list_docs(category="Engine", subcategory="render")  # 列出渲染模块文档
```

#### 3. cjmp_search - 搜索文档

**参数**:
- `query` (必需): 搜索查询词，支持多关键词空格分隔（AND 匹配）
- `category` (可选): 分类过滤
- `max_results` (可选): 最大结果数，默认 10
- `min_confidence` (可选): 最小置信度，默认 0.3

**示例**:
```python
cjmp_search(query="渲染管线")  # 搜索渲染管线相关文档
cjmp_search(query="UI 组件", category="CJFrontend")  # 在 CJFrontend 中搜索
```

#### 4. cjmp_get_doc - 获取文档内容

**参数**:
- `doc_id` (必需): 文档 ID
- `section` (可选): 获取特定章节
- `format` (可选): 输出格式 (markdown/json/plain)，默认 markdown

**示例**:
```python
cjmp_get_doc(doc_id="98be5f3244b37e313d87ad92843b946c")
```

#### 5. cjmp_get_code_examples - 获取代码示例

**参数**:
- `query` (可选): 功能描述
- `language` (可选): 编程语言
- `max_results` (可选): 最大结果数，默认 10

**示例**:
```python
cjmp_get_code_examples(query="Button")
cjmp_get_code_examples(query="网络请求", language="cj")
```

### 4.2 工具使用策略

**优先级**:
1. **本 SKILL.md**（核心查询手册）
2. **examples/**（代码示例）
3. **templates/**（代码模板）
4. **MCP 工具**（实际文档查询）

**触发条件**:
- 用户询问文档内容时
- 用户需要代码示例时
- 用户需要了解项目架构时
- 用户需要查询 API 使用方法时

---

## 第5章：查询策略

### 5.1 按需求类型选择仓库

| 需求类型 | 推荐仓库 | 查询关键词示例 |
|----------|----------|----------------|
| 快速入门 | Docs | 快速入门、入门指南 |
| UI 开发 | CJFrontend | 组件、Button、Text、布局 |
| 渲染原理 | Engine | 渲染、管线、图形 |
| 系统能力 | SystemLibs | 网络、存储、传感器 |
| 平台互操作 | cangjie_multiplatform_interop | Java、ObjC、互操作 |
| 社区动态 | Community | 会议、SIG |

### 5.2 搜索技巧

**精确搜索**:
```
查询: Button 点击事件
结果: 同时包含 "Button" 和 "点击事件" 的文档
```

**分类过滤**:
```
查询: 渲染管线
分类: Engine
结果: 仅在 Engine 仓库中搜索
```

---

## 第6章：使用示例

### 6.1 查询快速入门文档

**用户提问**:
```
查询 CJMP 快速入门文档
```

**工具调用**:
```python
cjmp_search(query="快速入门", category="Docs")
```

### 6.2 查询 UI 组件

**用户提问**:
```
如何使用仓颉开发 Button 组件？
```

**工具调用**:
```python
cjmp_search(query="Button", category="CJFrontend")
cjmp_get_code_examples(query="Button")
```

### 6.3 查询系统接口

**用户提问**:
```
如何使用网络请求能力？
```

**工具调用**:
```python
cjmp_search(query="网络请求", category="SystemLibs")
```

### 6.4 查询互操作

**用户提问**:
```
如何在仓颉中调用 Java 代码？
```

**工具调用**:
```python
cjmp_search(query="Java 互操作", category="cangjie_multiplatform_interop")
```

---

## 第7章：常见问题

### 7.1 开发环境

**Q: 如何配置开发环境？**

A: 参考 Docs 仓库中的开发准备文档，配置以下环境：
- 仓颉 SDK (CANGJIE_IOS_HOME, CANGJIE_ANDROID_HOME)
- Android SDK (ANDROID_SDK_ROOT, ANDROID_NDK)
- iOS SDK (XCODE_HOME)

### 7.2 组件使用

**Q: 组件找不到类型？**

A: 确保正确导入组件包：
```cj
import cjmp.ui.*
```

**Q: 状态更新不触发 UI 刷新？**

A: 使用 `@State` 装饰器：
```cj
@State private var count: Int64 = 0
```

### 7.3 系统能力

**Q: 网络请求失败？**

A: 检查：
1. 网络权限配置
2. URL 是否正确
3. 使用异步回调处理响应

### 7.4 互操作

**Q: Java 类型映射？**

A: 参考 `examples/08_java_interop.cj` 中的类型映射表：
- int → Int32
- long → Int64
- String → String
- boolean → Bool

---

## 附录A：代码示例索引

| 示例文件 | 内容 | 难度 |
|----------|------|------|
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

---

## 附录B：模板索引

| 模板文件 | 用途 |
|----------|------|
| templates/basic/ability_entry.cj.template | 应用入口模板 |
| templates/basic/page_component.cj.template | 页面组件模板 |
| templates/components/custom_component.cj.template | 自定义组件模板 |
| templates/data/data_source.cj.template | 数据源模板 |
| templates/network/http_request.cj.template | 网络请求模板 |
| templates/storage/local_storage.cj.template | 本地存储模板 |
| templates/interop/java_bridge.cj.template | Java 互操作模板 |
| templates/testing/unit_test.cj.template | 单元测试模板 |

---

## 附录C：参考文档索引

| 文档文件 | 内容 |
|----------|------|
| reference/common_issues.md | 常见问题与最佳实践 |
| reference/api_reference.md | 组件 API 速查 |

---

## 附录D：仓库 URL

| 仓库名 | URL |
|--------|-----|
| Docs | https://gitcode.com/CJMP/Docs |
| Engine | https://gitcode.com/CJMP/Engine |
| CJFrontend | https://gitcode.com/CJMP/CJFrontend |
| SystemLibs | https://gitcode.com/CJMP/SystemLibs |
| cangjie_multiplatform_interop | https://gitcode.com/Cangjie/cangjie_multiplatform_interop |
| Community | https://gitcode.com/CJMP/Community |

---

## 附录E：版本历史

- **v1.0.0** (2025-03-10) - 初始版本
  - 支持 6 个文档仓库
  - 索引 2131 个文档
  - 提取 4211 个代码示例
  - 10 个代码示例
  - 8 个代码模板
  - 2 个参考文档

---

**文档维护**: CJMP 社区
**最后更新**: 2025-03-10
**版本**: v1.0.0
