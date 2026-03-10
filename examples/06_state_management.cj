/**
 * 示例名称：状态管理
 * 语法模块：第2.3节 - CJFrontend 状态
 * 难度：intermediate
 * 
 * 本示例演示：
 * - @State 状态装饰器
 * - 状态更新触发 UI 刷新
 * - 双向绑定
 */
import cjmp.ui.*

@Entry
class StateExample {
    @State private var count: Int64 = 0
    @State private var message: String = "Hello"
    
    func build() {
        Column {
            Text("计数器: ${count}")
                .fontSize(24)
                .margin(bottom: 20)
            
            Row {
                Button("-")
                    .width(60)
                    .height(40)
                    .onClick { e => 
                        count = count - 1
                    }
                
                Text("${count}")
                    .width(80)
                    .textAlign(TextAlign.Center)
                    .fontSize(20)
                
                Button("+")
                    .width(60)
                    .height(40)
                    .onClick { e => 
                        count = count + 1
                    }
            }
            .margin(bottom: 30)
            
            Text("消息: ${message}")
                .fontSize(20)
                .margin(bottom: 10)
            
            TextInput(placeholder: "输入消息")
                .width(200)
                .height(40)
                .onChange { value => 
                    message = value
                }
        }
        .width(100.percent)
        .height(100.percent)
        .justifyContent(FlexAlign.Center)
    }
}
