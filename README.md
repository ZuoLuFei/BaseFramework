### 项目初始化步骤
1. 打开 .xcodeproj ,将PROJECT及TARGETS 的  Build Settings-> Swift Language Version 设置为 Swift 4
2. pod init 
3. 在Podfile中写入如下库
```swift
    pod 'Moya/RxSwift',:inhibit_warnings => true
    pod 'Then'
    pod 'Kingfisher', '~> 4.9.0',:inhibit_warnings => true # 日志输出库 #图片加载
    pod 'SwifterSwift'
    pod 'SnapKit'
    pod 'ObjectMapper'
    pod 'SwiftyJSON'
    pod 'RxSwift'
    pod 'RxCocoa'
    pod 'RxGesture'
    pod 'Toaster',:inhibit_warnings => true # 日志输出库 # toast弹窗组件
    pod 'SwiftyBeaver',:inhibit_warnings => true # 日志输出库
    pod 'RTRootNavigationController'
    pod 'MJRefresh',:inhibit_warnings => true
    pod 'IQKeyboardManagerSwift'
    pod 'Fusuma'  # 相册库
    pod 'RealmSwift'
```
4. pod install
5. 打开 .xcworkspace
6. 将BaseFramework文件夹拖入项目
7. 在PROJECT及TARGETS 的  Build Settings-> Objective-C Bridging Header 中 加入   实际项目/BaseFramework/BaseFramework-Bridging-Header.h
8. 将PROJECT及TARGETS 的  Build Settings-> inhibit All Warning 设置为 true
9. 参考BaseFramework Demo 在AppDelegate中初始化项目
