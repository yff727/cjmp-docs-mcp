/**
 * 示例名称：Java 互操作
 * 语法模块：第2.5节 - cangjie_multiplatform_interop
 * 难度：advanced
 * 
 * 本示例演示：
 * - 仓颉调用 Java 类
 * - JNI 桥接层
 * - 类型映射
 * - Android SDK 调用
 */

// Android 平台互操作示例

// 1. 定义 Java 类的仓颉接口
// 通过 FFI 调用 Java 层

// Java 侧代码 (WifiDevicePlugin.java):
// public class WifiDevicePlugin {
//     public List<ScanResult> getScanInfoList() {
//         // 获取 WiFi 扫描结果
//     }
// }

// C++ 桥接层 (wifi_device_jni.cpp):
// extern "C" {
//     const char* getScanInfoList() {
//         // 通过 JNI 调用 Java 方法
//         // 返回 JSON 格式的扫描结果
//     }
// }

// 仓颉调用示例
import std.collection.ArrayList

class WifiScanInfo {
    public var ssid: String = ""
    public var bssid: String = ""
    public var rssi: Int64 = 0
    public var frequency: Int64 = 0
}

class WifiManager {
    // FFI 声明
    foreign func getScanInfoList(): CPointer<UInt8>
    
    // 封装方法
    public func scanWifi(): ArrayList<WifiScanInfo> {
        let result = ArrayList<WifiScanInfo>()
        let jsonPtr = getScanInfoList()
        
        // 解析 JSON 结果
        // let json = CPointerUtils.toString(jsonPtr)
        // ... 解析逻辑
        
        return result
    }
}

// 使用示例
@Entry
class WifiExample {
    @State private var wifiList: ArrayList<WifiScanInfo> = ArrayList<WifiScanInfo>()
    
    func scanNetworks(): Unit {
        let manager = WifiManager()
        wifiList = manager.scanWifi()
    }
    
    func build() {
        Column {
            Text("WiFi 扫描")
                .fontSize(24)
                .margin(bottom: 20)
            
            Button("扫描 WiFi")
                .width(200)
                .height(50)
                .onClick { e => 
                    scanNetworks()
                }
            
            List(space: 10) {
                ForEach(wifiList, itemGeneratorFunc: { info: WifiScanInfo, idx: Int64 =>
                    ListItem() {
                        Column {
                            Text("SSID: ${info.ssid}")
                            Text("信号强度: ${info.rssi} dBm")
                        }
                        .padding(10)
                        .backgroundColor(0xF0F0F0)
                    }
                })
            }
            .width(100.percent)
            .height(300)
        }
        .width(100.percent)
        .height(100.percent)
    }
}
