# CCBotManager

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

iOS 9.0 and XCode 11.3 or higher since the framework is compiled with Swift 5.0.
It's compatible with Swift 5.0.


## Set Up

In your ViewController, create your global `ccBotManager`.
`superViewController`: SuperView for ChatBot Button.
`button`: ChatBot Button on the Screen.
`ccBotCategory`: Project Category.
`isOpen`: ChatBot Button control with `UISwitch`, default is `true`.
`delegate`: Delegate of `CCBotViewController`, default is `nil`.
```swift
import CCBotManager

let ccBotManager = CCBotManager.shared

class ViewController: UIViewController {

  @IBOutlet weak var ccBotButton: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()

    ccBotManager.setting(superViewController: self,
                         button: ccBotButton,
                         ccBotCategory: .utravel,
                         isOpen: Bool = true,
                         delegate: self)
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

### Delegate

Skip this step if already assigned at beginning:
```swift
ccBotManager.delegate = self

```
Confirm protocol of Delegate :
```swift
extension ViewController: CCBotNewsDelegate {
    
    func showNextNews(categaryID: Int, storyID: Int) {
        print("categaryID: \(categaryID)\nstoryID: \(storyID)")
    }
}

extension ViewController: CCBotTravelDelegate {
    
    func showNextTour(categaryID: Int, storyID: Int) {
        print("categaryID: \(categaryID)\nstoryID: \(storyID)")
    }
}
```


## Release
1.0.0:
- Deployment Target: iOS 9.0
- Features: Create ChatBot for App.


## License

Copyright 2020 羅翊修 @ 聯合報行動發展部
