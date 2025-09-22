# tim


根据腾讯云文档内容，腾讯云即时通信 IM Flutter SDK 对 Web 端的支持情况如下：

### 一、版本支持
1. **起始版本**：从无 UI SDK(tencent_cloud_chat_sdk) **3.5.2**（2021.11.12）开始实验性支持 Web 端
2. **稳定版本**：**4.1.1+2**（2022.08.25）全面支持 Flutter Web

### 二、环境要求
1. **Flutter 版本**：
    - 最低要求：Flutter 3.x（推荐使用最新稳定版）
    - 性能优化：Flutter 3.x 针对 Web 端进行了多项性能优化

2. **兼容性**：
    - 支持主流现代浏览器（Chrome/Edge/Firefox/Safari）
    - 需要额外的 JS 依赖安装

### 三、配置要求
1. **依赖安装**：
   ```bash
   cd web/
   npm install tim-js-sdk@latest --save  # 或使用 yarn add
   ```

2. **JS 引入**：
   在 `web/index.html` 文件中添加：
   ```html
   <script src="./node_modules/tim-js-sdk/tim-js.js"></script>
   <script src="./node_modules/tim-js-sdk/tim-js-friendship.js"></script>
   ```

### 四、版本演进
| 版本号 | 更新内容 | 发布时间 |
|--------|---------|---------|
| 3.5.2 | 实验性 Web 支持 | 2021.11.12 |
| 3.9.3 | 完善 Web 端群消息已读回执功能 | 2022.04.20 |
| 4.1.1+2 | 全面支持 Flutter Web | 2022.08.25 |
| 4.1.3 | 修复 Web 端已知问题 | 2022.09.21 |

### 五、注意事项
1. 首次运行需执行 `flutter clean` 清除缓存
2. 遇到依赖安装失败时，建议配置国内镜像源
3. Web 端不支持原生音视频通话功能（需通过 WebRTC 实现）


@@@@@@
web端 运行。详见 此页面
https://github.com/TencentCloud/chat-uikit-flutter


常见问题
1. iOS 端 Pods 依赖无法安装成功
   方案一：手动删除 ios/Pods 文件夹，及 ios/Podfile.lock 文件，并执行如下命令，重新安装依赖。
   cd ios
   sudo gem install ffi
   pod install --repo-update
   方案二：配置运行后，如果报错，可以单击 Product > Clean Build Folder，清除产物后重新运行 pod install 或 flutter run
   ﻿
   ﻿﻿
2. 佩戴 Apple Watch 时，真机调试 iOS 报错
   ﻿
   ﻿﻿
   请将您的 Apple Watch 调整至飞行模式，并将 iPhone 的蓝牙功能通过 设置 => 蓝牙 彻底关闭。
   重新启动 Xcode（若打开），并重新运行 flutter run 即可。
3. Flutter 环境问题
   如您需得知 Flutter 的环境是否存在问题，请运行 Flutter doctor 检测 Flutter 环境是否装好。
4. 使用 Flutter 自动生成的项目，引入TUIKit 后，运行 Android 端报错