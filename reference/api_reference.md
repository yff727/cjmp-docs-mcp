# CJMP 组件 API 速查

> 本文档提供 CJMP 常用组件的 API 快速参考。

---

## 目录

- [基础组件](#基础组件)
- [布局组件](#布局组件)
- [列表组件](#列表组件)
- [表单组件](#表单组件)
- [导航组件](#导航组件)
- [媒体组件](#媒体组件)

---

## 基础组件

### Text - 文本组件

```cj
Text("文本内容")
    .fontSize(16)              // 字体大小
    .fontColor(0x333333)       // 字体颜色
    .fontWeight(FontWeight.Bold)  // 字体粗细
    .textAlign(TextAlign.Center)  // 文本对齐
    .maxLines(2)               // 最大行数
    .textOverflow(TextOverflow.Ellipsis)  // 溢出处理
    .lineHeight(24)            // 行高
    .letterSpacing(1)          // 字间距
```

### Button - 按钮组件

```cj
Button("按钮文本")
    .width(120)                // 宽度
    .height(40)                // 高度
    .fontSize(16)              // 字体大小
    .fontColor(0xFFFFFF)       // 字体颜色
    .backgroundColor(0x007DFF) // 背景色
    .borderRadius(8)           // 圆角
    .enabled(true)             // 是否启用
    .onClick { e =>            // 点击事件
        // 处理点击
    }
```

### Image - 图片组件

```cj
Image("https://example.com/image.png")
    .width(100)                // 宽度
    .height(100)               // 高度
    .objectFit(ImageFit.Cover) // 缩放模式
    .alt("加载失败")           // 加载失败提示
    .interpolation(ImageInterpolation.High)  // 插值质量
    .onLoad { =>               // 加载完成
        AppLog.info("图片加载完成")
    }
    .onError { =>              // 加载失败
        AppLog.error("图片加载失败")
    }
```

---

## 布局组件

### Column - 垂直布局

```cj
Column {
    Text("第一行")
    Text("第二行")
}
.width(100.percent)            // 宽度
.height(100.percent)           // 高度
.justifyContent(FlexAlign.Center)  // 主轴对齐
.alignItems(HorizontalAlign.Center)  // 交叉轴对齐
.padding(20)                   // 内边距
.margin(10)                    // 外边距
.backgroundColor(0xF5F5F5)      // 背景色
.borderRadius(10)              // 圆角
```

### Row - 水平布局

```cj
Row {
    Text("左侧")
    Text("右侧")
}
.width(100.percent)
.height(50)
.justifyContent(FlexAlign.SpaceBetween)  // 两端对齐
.alignItems(VerticalAlign.Center)        // 垂直居中
```

### Flex - 弹性布局

```cj
Flex(FlexParams(
    justifyContent: FlexAlign.Start,
    alignItems: ItemAlign.Center,
    wrap: FlexWrap.Wrap,
    direction: FlexDirection.Row
)) {
    Text("项目1")
    Text("项目2")
}
.width(100.percent)
```

### Stack - 堆叠布局

```cj
Stack {
    Image("background.png")
        .width(100.percent)
        .height(200)
    Text("叠加文字")
        .fontSize(24)
}
.width(100.percent)
.height(200)
.alignContent(Alignment.Center)  // 内容对齐
```

---

## 列表组件

### List - 列表

```cj
List(space: 10, initialIndex: 0) {
    ForEach(items, itemGeneratorFunc: { item, idx =>
        ListItem() {
            Text(item.name)
        }
    })
}
.width(100.percent)
.height(100.percent)
.onScroll { scrollOffset =>
    // 滚动事件
}
.onReachEnd {
    // 滚动到底部
}
```

### LazyForEach - 懒加载

```cj
LazyForEach(dataSource, itemGeneratorFunc: { item: Item, idx: Int64 =>
    ListItem() {
        Text(item.name)
    }
})
```

### Grid - 网格

```cj
Grid() {
    ForEach(items, itemGeneratorFunc: { item, idx =>
        GridItem() {
            Text(item.name)
        }
    })
}
.columnsTemplate("1fr 1fr 1fr")  // 三列
.rowsGap(10)                     // 行间距
.columnsGap(10)                  // 列间距
```

---

## 表单组件

### TextInput - 输入框

```cj
TextInput(placeholder: "请输入")
    .width(280)
    .height(45)
    .type(InputType.Normal)     // 输入类型
    .maxLength(100)             // 最大长度
    .onChange { value =>        // 值变化
        // 处理输入
    }
    .onSubmit { value =>        // 提交
        // 处理提交
    }
```

### Toggle - 开关

```cj
Toggle(ToggleType.Switch, isOn: false)
    .selectedColor(0x007DFF)    // 选中颜色
    .onChange { isOn =>         // 状态变化
        // 处理变化
    }
```

### Checkbox - 复选框

```cj
Checkbox(isOn: false)
    .selectColor(0x007DFF)      // 选中颜色
    .onChange { isOn =>
        // 处理变化
    }
```

### Radio - 单选框

```cj
Radio(value: "option1", group: "radioGroup")
    .checked(true)              // 是否选中
    .onChange { checked =>
        // 处理变化
    }
```

---

## 导航组件

### Router - 路由

```cj
// 页面跳转
Router.push(
    url: "DetailPage",
    params: "id=123"
)

// 获取参数
let params = Router.getParams()
match (params) {
    case Some(v) => 
        // 处理参数
    case None => 
        // 无参数
}

// 返回
Router.back()

// 返回指定页面
Router.backTo("HomePage")

// 替换当前页面
Router.replace("NewPage")
```

---

## 媒体组件

### Video - 视频

```cj
Video("https://example.com/video.mp4")
    .width(100.percent)
    .height(200)
    .autoPlay(true)             // 自动播放
    .controls(true)             // 显示控制条
    .loop(false)                // 是否循环
    .onFinish { =>              // 播放完成
        AppLog.info("播放完成")
    }
```

### Audio - 音频

```cj
Audio("https://example.com/audio.mp3")
    .autoPlay(true)
    .loop(false)
    .onPlay { =>
        AppLog.info("开始播放")
    }
    .onPause { =>
        AppLog.info("暂停播放")
    }
```

---

## 状态装饰器

```cj
@State     // 组件内状态，变化时触发重新渲染
@Prop      // 从父组件接收的属性
@Link      // 与父组件双向绑定
@Provide   // 提供数据给后代组件
@Consume   // 从祖先组件获取数据
@Watch     // 监听状态变化
```

---

## 事件处理

```cj
// 点击事件
.onClick { e => 
    // e: ClickEvent
}

// 触摸事件
.onTouch { e =>
    // e: TouchEvent
}

// 长按事件
.onLongPress { e =>
    // 长按处理
}

// 滚动事件
.onScroll { offset =>
    // 滚动处理
}

// 键盘事件
.onKeyEvent { e =>
    // e: KeyEvent
}
```

---

**文档维护**: CJMP 社区
**最后更新**: 2025-03-10
