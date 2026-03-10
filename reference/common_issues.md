# CJMP 开发常见问题与最佳实践

> 本文档整理了 CJMP 开发过程中的常见问题和最佳实践，帮助开发者避免常见错误。

---

## 目录

- [环境配置相关](#环境配置相关)
- [UI 开发相关](#ui-开发相关)
- [状态管理相关](#状态管理相关)
- [系统能力相关](#系统能力相关)
- [互操作相关](#互操作相关)
- [性能优化相关](#性能优化相关)

---

## 环境配置相关

### ⚠️ 问题1：环境变量配置不完整

**问题描述**：
编译时提示找不到 CJMP SDK 或仓颉工具链。

**解决方案**：
确保配置了所有必需的环境变量：

```bash
# 仓颉 SDK
export CANGJIE_IOS_HOME=~/path/to/cangjie-sdk-mac-aarch64-ios-x.xx.x/
export CANGJIE_ANDROID_HOME=~/path/to/cangjie-sdk-mac-aarch64-android-x.xx.x/
export CANGJIE_OHOS_HOME=~/path/to/cangjie-sdk-mac-aarch64-ohos-x.xx.x/

# Android SDK
export ANDROID_SDK_ROOT=~/path/to/Android/sdk
export ANDROID_NDK=$ANDROID_SDK_ROOT/ndk/26.3.11579264

# iOS SDK
export XCODE_HOME=/Applications/Xcode.app
export IOS_SDK=$XCODE_HOME/.../iPhoneOS.sdk
```

### ⚠️ 问题2：平台版本不兼容

**问题描述**：
编译产物在某些设备上无法运行。

**解决方案**：
确认平台版本要求：
- Android: 8.0+ (API 26+)
- iOS: 12.0+
- HarmonyOS: 5.1.0+

---

## UI 开发相关

### ⚠️ 问题3：组件未导入

**问题描述**：
使用组件时提示找不到类型。

**解决方案**：
确保正确导入组件包：

```cj
import cjmp.ui.*  // 导入所有 UI 组件

// 或导入特定组件
import cjmp.ui.{Text, Button, Column, Row}
```

### ⚠️ 问题4：布局溢出

**问题描述**：
组件显示不完整或超出屏幕边界。

**解决方案**：
使用正确的布局约束：

```cj
Column {
    Text("内容")
}
.width(100.percent)  // 设置宽度
.height(100.percent) // 设置高度
.padding(20)         // 添加内边距
```

### ⚠️ 问题5：列表性能问题

**问题描述**：
长列表滚动卡顿。

**解决方案**：
使用 `LazyForEach` 进行懒加载：

```cj
List(space: 10) {
    LazyForEach(dataSource, itemGeneratorFunc: { item, idx =>
        ListItem() {
            // 列表项内容
        }
    })
}
```

---

## 状态管理相关

### ⚠️ 问题6：状态更新不触发 UI 刷新

**问题描述**：
修改了变量但 UI 没有更新。

**解决方案**：
确保使用 `@State` 装饰器：

```cj
@Entry
class MyPage {
    @State private var count: Int64 = 0  // 使用 @State
    
    func build() {
        Column {
            Text("${count}")
            Button("增加") { e => 
                count = count + 1  // 直接修改会触发刷新
            }
        }
    }
}
```

### ⚠️ 问题7：状态在子组件中不更新

**问题描述**：
父组件传递的状态在子组件中不更新。

**解决方案**：
使用 `@Prop` 接收父组件传递的状态：

```cj
@Component
class ChildComponent {
    @Prop var title: String  // 使用 @Prop 接收
    
    func build() {
        Text(title)
    }
}
```

---

## 系统能力相关

### ⚠️ 问题8：网络请求失败

**问题描述**：
网络请求返回错误或无响应。

**解决方案**：
1. 检查网络权限配置
2. 使用正确的请求方式：

```cj
let request = HttpRequest(
    url: "https://api.example.com/data",
    method: HttpMethod.GET
)

HttpClient.send(request) { response =>
    match (response) {
        case Some(resp) =>
            if (resp.statusCode == 200) {
                // 处理成功响应
            }
        case None =>
            // 处理网络错误
    }
}
```

### ⚠️ 问题9：存储数据丢失

**问题描述**：
应用重启后存储的数据丢失。

**解决方案**：
使用正确的存储 API：

```cj
// 保存
Preferences.put("key", "value")

// 读取（带默认值）
let value = Preferences.get("key", defaultValue: "default")
```

---

## 互操作相关

### ⚠️ 问题10：Java 互操作类型映射错误

**问题描述**：
调用 Java 方法时类型不匹配。

**解决方案**：
了解类型映射规则：

| Java 类型 | 仓颉类型 |
|-----------|----------|
| int | Int32 |
| long | Int64 |
| float | Float32 |
| double | Float64 |
| String | String |
| boolean | Bool |

### ⚠️ 问题11：JNI 调用失败

**问题描述**：
通过 JNI 调用 Java 方法时崩溃。

**解决方案**：
确保：
1. Java 类和方法签名正确
2. JNI 函数签名匹配
3. 正确处理返回值类型

---

## 性能优化相关

### ⚠️ 问题12：应用启动慢

**问题描述**：
应用启动时间过长。

**解决方案**：
1. 延迟加载非必要资源
2. 使用懒加载列表
3. 优化图片资源

### ⚠️ 问题13：内存占用过高

**问题描述**：
应用内存占用持续增长。

**解决方案**：
1. 及时释放不用的资源
2. 避免内存泄漏
3. 使用弱引用

```cj
// 使用 Option 处理可能为空的引用
private var listenerOp: Option<DataChangeListener> = None

// 及时清理
func cleanup(): Unit {
    listenerOp = None
}
```

---

## 最佳实践

### 代码组织

```
项目根目录/
├── src/
│   ├── pages/          # 页面组件
│   ├── components/     # 可复用组件
│   ├── models/         # 数据模型
│   ├── services/       # 服务层
│   └── utils/          # 工具函数
├── resources/          # 资源文件
└── tests/              # 测试代码
```

### 命名规范

- 类名：大驼峰 (PascalCase)
- 函数名：小驼峰 (camelCase)
- 变量名：小驼峰 (camelCase)
- 常量名：全大写下划线 (UPPER_SNAKE_CASE)

### 错误处理

```cj
func fetchData(): Unit {
    HttpClient.send(request) { response =>
        match (response) {
            case Some(resp) =>
                if (resp.statusCode == 200) {
                    // 成功处理
                } else {
                    AppLog.error("请求失败: ${resp.statusCode}")
                }
            case None =>
                AppLog.error("网络错误")
        }
    }
}
```

---

**文档维护**: CJMP 社区
**最后更新**: 2025-03-10
