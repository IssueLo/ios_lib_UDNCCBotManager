# ios_lib_UDNCCBotManager

聊天機器人（Chat Bot）原來由 Web 端開發，應用在有行旅 Web。
此套件的目的為將 Web 端聊天機器人應用在 udnNews（or 其他 App） 的 iOS App 上。


## Installation

To integrate `CCBotManager` into your Xcode project using CocoaPods, specify it in your `Podfile`:
```ruby

platform :ios, '9.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'CCBotManager', :git => 'ssh://git-codecommit.ap-northeast-1.amazonaws.com/v1/repos/ios_lib_TTSManager', :tag => '版本號'
end
```
Then, run the following command:
```
$ pod install
```


## Reqirements
// to do
iOS 9.0 and XCode 10.2 or higher since the framework is compiled with Swift 5.
It's compatible with Swift 5.0


## Set Up

In your ViewController, create your global `ccBotManager`. 
Setting with `superViewController` and `ccBotCategory`:
```swift
import CCBotManager

let ccBotManager = CCBotManager.shared

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    ccBotManager.setting(superViewController: self, ccBotCategory: .udnNews)
  }
}
```


## Usage

### UISwitch of CCBotButton

Create a `UISwitch`, setOn with `ccBotManager.isOpen`:
```swift
@IBOutlet weak var ccBotSwitch: UISwitch!

ccBotSwitch.setOn(ccBotManager.isOpen, animated: true)

@IBAction func test(_ sender: UISwitch) {
    
  if sender.isOn {
    ccBotManager.isOpen = true
  } else {
    ccBotManager.isOpen = false
  }
}
```


## Release
1.0.0:
- Deployment Target: iOS 9.0
- Features: Download and play with news TTS mp3 files.


## License

Copyright 2020 羅翊修 @ 聯合報行動發展部
