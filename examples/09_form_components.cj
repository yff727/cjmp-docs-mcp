/**
 * 示例名称：表单组件
 * 语法模块：第2.3节 - CJFrontend 表单
 * 难度：intermediate
 * 
 * 本示例演示：
 * - TextInput 输入框
 * - Toggle 开关
 * - Checkbox 复选框
 * - Radio 单选框
 * - 表单验证
 */
import cjmp.ui.*

@Entry
class FormExample {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var rememberMe: Bool = false
    @State private var gender: String = "male"
    @State private var agreed: Bool = false
    
    func submitForm(): Unit {
        if (username.size == 0) {
            AppLog.warn("用户名不能为空")
            return
        }
        if (password.size < 6) {
            AppLog.warn("密码至少6位")
            return
        }
        if (!agreed) {
            AppLog.warn("请同意用户协议")
            return
        }
        
        AppLog.info("提交表单: ${username}, ${gender}, ${rememberMe}")
    }
    
    func build() {
        Column {
            Text("用户注册")
                .fontSize(24)
                .margin(bottom: 30)
            
            // 用户名输入
            TextInput(placeholder: "用户名")
                .width(280)
                .height(45)
                .onChange { value => username = value }
                .margin(bottom: 15)
            
            // 密码输入
            TextInput(placeholder: "密码")
                .width(280)
                .height(45)
                .type(InputType.Password)
                .onChange { value => password = value }
                .margin(bottom: 15)
            
            // 记住我开关
            Row {
                Toggle(ToggleType.Switch, isOn: rememberMe)
                    .onChange { isOn => rememberMe = isOn }
                Text("记住我")
                    .margin(left: 10)
            }
            .width(280)
            .margin(bottom: 15)
            
            // 性别单选
            Row {
                Text("性别:")
                    .width(60)
                Radio(value: "male", group: "gender")
                    .checked(gender == "male")
                    .onChange { checked => 
                        if (checked) { gender = "male" }
                    }
                Text("男")
                    .margin(left: 5, right: 20)
                Radio(value: "female", group: "gender")
                    .checked(gender == "female")
                    .onChange { checked => 
                        if (checked) { gender = "female" }
                    }
                Text("女")
                    .margin(left: 5)
            }
            .width(280)
            .margin(bottom: 15)
            
            // 同意协议
            Row {
                Checkbox(isOn: agreed)
                    .onChange { isOn => agreed = isOn }
                Text("我已阅读并同意用户协议")
                    .margin(left: 10)
            }
            .width(280)
            .margin(bottom: 30)
            
            Button("注册")
                .width(280)
                .height(45)
                .onClick { e => submitForm() }
        }
        .width(100.percent)
        .height(100.percent)
        .justifyContent(FlexAlign.Center)
    }
}
