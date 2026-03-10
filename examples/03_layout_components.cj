/**
 * 示例名称：布局组件
 * 语法模块：第2.3节 - CJFrontend 布局
 * 难度：intermediate
 * 
 * 本示例演示：
 * - Column 垂直布局
 * - Row 水平布局
 * - Flex 弹性布局
 * - Stack 堆叠布局
 */
import cjmp.ui.*

@Entry
class LayoutComponents {
    func build() {
        Column {
            // Row 水平布局
            Row {
                Text("左侧")
                    .width(50.percent)
                Text("右侧")
                    .width(50.percent)
            }
            .width(100.percent)
            .height(50)
            .backgroundColor(0xF5F5F5)
            
            // Column 垂直布局
            Column {
                Text("第一行")
                Text("第二行")
                Text("第三行")
            }
            .width(100.percent)
            .margin(top: 20)
            
            // Flex 弹性布局
            Flex(FlexParams(
                justifyContent: FlexAlign.SpaceBetween,
                alignItems: ItemAlign.Center
            )) {
                Text("项目1")
                Text("项目2")
                Text("项目3")
            }
            .width(100.percent)
            .height(60)
            .margin(top: 20)
            
            // Stack 堆叠布局
            Stack {
                Image("background.png")
                    .width(100.percent)
                    .height(200)
                Text("叠加文字")
                    .fontSize(24)
                    .fontColor(0xFFFFFF)
            }
            .width(100.percent)
            .height(200)
            .margin(top: 20)
        }
        .width(100.percent)
        .height(100.percent)
        .padding(20)
    }
}
