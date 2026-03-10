/**
 * 示例名称：系统能力调用
 * 语法模块：第2.4节 - SystemLibs
 * 难度：intermediate
 * 
 * 本示例演示：
 * - 网络请求能力
 * - 存储能力
 * - 设备信息能力
 * - 异步调用模式
 */
import cjmp.ui.*
import cjmp.network.*
import cjmp.storage.*
import cjmp.device.*

@Entry
class SystemCapabilities {
    @State private var result: String = "等待请求..."
    @State private var deviceInfo: String = ""
    
    func aboutToAppear(): Unit {
        // 获取设备信息
        getDeviceInfo()
    }
    
    // 网络请求示例
    func fetchData(): Unit {
        let request = HttpRequest(
            url: "https://api.example.com/data",
            method: HttpMethod.GET
        )
        
        HttpClient.send(request) { response =>
            match (response) {
                case Some(resp) =>
                    if (resp.statusCode == 200) {
                        result = resp.body
                    } else {
                        result = "请求失败: ${resp.statusCode}"
                    }
                case None =>
                    result = "网络错误"
            }
        }
    }
    
    // 存储示例
    func saveData(key: String, value: String): Unit {
        Preferences.put(key, value)
    }
    
    func loadData(key: String): String {
        return Preferences.get(key, defaultValue: "")
    }
    
    // 设备信息示例
    func getDeviceInfo(): Unit {
        let info = DeviceInfo.getDeviceInfo()
        deviceInfo = "品牌: ${info.brand}, 型号: ${info.model}"
    }
    
    func build() {
        Column {
            Text("系统能力示例")
                .fontSize(24)
                .margin(bottom: 20)
            
            Text("设备信息: ${deviceInfo}")
                .margin(bottom: 20)
            
            Text("请求结果: ${result}")
                .margin(bottom: 20)
            
            Button("发起网络请求")
                .width(200)
                .height(50)
                .onClick { e => 
                    fetchData()
                }
                .margin(bottom: 10)
            
            Button("保存数据")
                .width(200)
                .height(50)
                .onClick { e => 
                    saveData("test_key", "test_value")
                }
                .margin(bottom: 10)
            
            Button("读取数据")
                .width(200)
                .height(50)
                .onClick { e => 
                    result = loadData("test_key")
                }
        }
        .width(100.percent)
        .height(100.percent)
        .justifyContent(FlexAlign.Center)
    }
}
