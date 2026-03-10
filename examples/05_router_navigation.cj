/**
 * 示例名称：路由导航
 * 语法模块：第2.3节 - CJFrontend 路由
 * 难度：intermediate
 * 
 * 本示例演示：
 * - Router 路由管理
 * - 页面跳转
 * - 参数传递
 * - 页面返回
 */
import cjmp.ui.*
import cjmp.router.Router

// 首页
@Entry
class HomePage {
    func build() {
        Column {
            Text("首页")
                .fontSize(24)
                .margin(bottom: 20)
            
            Button("跳转到详情页")
                .width(200)
                .height(50)
                .onClick { e => 
                    Router.push(
                        url: "DetailPage",
                        params: "id=123&name=test"
                    )
                }
        }
        .width(100.percent)
        .height(100.percent)
        .justifyContent(FlexAlign.Center)
    }
}

// 详情页
class DetailPage {
    private var message: String = ""
    
    func aboutToAppear(): Unit {
        var str: Option<String> = Router.getParams()
        match (str) {
            case Some(v) => 
                this.message = v
            case None => 
                this.message = ""
        }
    }
    
    func build() {
        Column {
            Text("详情页")
                .fontSize(24)
                .margin(bottom: 20)
            
            Text("参数: ${message}")
                .margin(bottom: 20)
            
            Button("返回")
                .width(200)
                .height(50)
                .onClick { e => 
                    Router.back()
                }
        }
        .width(100.percent)
        .height(100.percent)
        .justifyContent(FlexAlign.Center)
    }
}
