/**
 * 示例名称：基础 UI 组件
 * 语法模块：第2.3节 - CJFrontend 组件
 * 难度：beginner
 * 
 * 本示例演示：
 * - Text 组件的使用
 * - Button 组件的使用
 * - Image 组件的使用
 * - 组件属性设置
 */
import cjmp.ui.*

@Entry
class BasicComponents {
    func build() {
        Column {
            // Text 组件
            Text("欢迎使用 CJMP")
                .fontSize(20)
                .fontColor(0x333333)
                .margin(bottom: 20)
            
            // Button 组件
            Button("点击我")
                .width(120)
                .height(40)
                .onClick { e => 
                    AppLog.info("Button clicked")
                }
                .margin(bottom: 20)
            
            // Image 组件
            Image("https://example.com/image.png")
                .width(100)
                .height(100)
                .objectFit(ImageFit.Cover)
        }
        .width(100.percent)
        .height(100.percent)
        .justifyContent(FlexAlign.Center)
    }
}
