/**
 * 示例名称：动画效果
 * 语法模块：第2.2节 - Engine 动画系统
 * 难度：advanced
 * 
 * 本示例演示：
 * - 属性动画
 * - 显式动画
 * - 转场动画
 * - 动画回调
 */
import cjmp.ui.*
import cjmp.animation.*

@Entry
class AnimationExample {
    @State private var scale: Float64 = 1.0
    @State private var rotate: Float64 = 0.0
    @State private var opacity: Float64 = 1.0
    @State private var translate: Float64 = 0.0
    
    // 属性动画
    func playScaleAnimation(): Unit {
        animateTo(
            duration: 1000,
            curve: Curve.EaseInOut,
            onFinish: { => 
                AppLog.info("缩放动画完成")
            }
        ) {
            scale = if (scale == 1.0) { 1.5 } else { 1.0 }
        }
    }
    
    // 旋转动画
    func playRotateAnimation(): Unit {
        animateTo(duration: 2000, curve: Curve.Linear) {
            rotate = rotate + 360.0
        }
    }
    
    // 淡入淡出
    func playFadeAnimation(): Unit {
        animateTo(duration: 500) {
            opacity = if (opacity == 1.0) { 0.3 } else { 1.0 }
        }
    }
    
    // 平移动画
    func playTranslateAnimation(): Unit {
        animateTo(duration: 800, curve: Curve.Spring) {
            translate = if (translate == 0.0) { 100.0 } else { 0.0 }
        }
    }
    
    func build() {
        Column {
            Text("动画示例")
                .fontSize(24)
                .margin(bottom: 30)
            
            // 动画目标
            Column {
                Text("动画")
                    .fontSize(20)
                    .fontColor(0xFFFFFF)
            }
            .width(100)
            .height(100)
            .backgroundColor(0x007DFF)
            .borderRadius(10)
            .scale(x: scale, y: scale)
            .rotate(angle: rotate)
            .opacity(opacity)
            .translate(x: translate)
            .margin(bottom: 40)
            
            // 控制按钮
            Row {
                Button("缩放")
                    .width(80)
                    .height(40)
                    .onClick { e => playScaleAnimation() }
                
                Button("旋转")
                    .width(80)
                    .height(40)
                    .onClick { e => playRotateAnimation() }
                    .margin(left: 10)
                
                Button("淡入淡出")
                    .width(80)
                    .height(40)
                    .onClick { e => playFadeAnimation() }
                    .margin(left: 10)
                
                Button("平移")
                    .width(80)
                    .height(40)
                    .onClick { e => playTranslateAnimation() }
                    .margin(left: 10)
            }
        }
        .width(100.percent)
        .height(100.percent)
        .justifyContent(FlexAlign.Center)
    }
}
