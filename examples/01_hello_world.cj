/**
 * 示例名称：CJMP 应用入口
 * 语法模块：第2章 - CJMP 应用基础
 * 难度：beginner
 * 
 * 本示例演示：
 * - CJMP 应用的基本入口结构
 * - @Entry 装饰器的使用
 * - build() 方法的定义
 * - 基础 UI 组件的使用
 */
import cjmp.ui.*

@Entry
class MainAbility {
    func onCreate(want: Want, launchParam: LaunchParam): Unit {
        AppLog.info("MainAbility OnCreated.${want.abilityName}")
    }

    func build() {
        Column {
            Text("Hello CJMP!")
                .fontSize(24)
                .textAlign(TextAlign.Center)
        }
        .width(100.percent)
        .height(100.percent)
    }
}
