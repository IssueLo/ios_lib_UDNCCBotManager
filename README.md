# ios_lib_UDNCCBotManager

2019 年中旬，聯合報 App 提出了語音新聞的需求，意即使用微軟 Text-To-Speech 文字轉語音（TTS）技術，將新聞念出來。
為了方便管理，便建立 TTSManager 來統一管理，讓經濟日報與聯合報都使用同一份程式碼。程式碼架構初始規劃[在此](https://docs.google.com/document/d/1k9i6DZBC5nQaL1daAMC3blU6RRhfyhZVQD-_4K3qaDo/edit)； iOS 跟 Android 在實作上一定會有差異，但整體架構應相去不遠。  
[後端文件](https://docs.google.com/document/d/1owbrmO8YbDsBf2Tmj4K5C2s9f8NeU9ctPKFhJZuk3tU/edit)

## Installation

To integrate TTSManager into your Xcode project using CocoaPods, specify it in your `Podfile`:
```ruby

platform :ios, '9.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'TTSManager', :git => 'ssh://git-codecommit.ap-northeast-1.amazonaws.com/v1/repos/ios_lib_TTSManager', :tag => '版本號'
end
```
Then, run the following command:
```
$ pod install
```

## Reqirements
iOS 9.0 and XCode 10.2 or higher since the framework is compiled with Swift 5.
It's compatible with Swift 4.0, 4.2, and 5.0


## Demo
Clone this repository, run demo project and see how to use it. In addition, you need to use real device to try out remote command center.

## Set Up
In your Constants.swift, create your global `ttsManager`. 
Make sure to at least have "TTS" in `folderNames`. 
Your FileOperater needs to conform to `TTSFileManagerProtocol`.

```swift
import TTSManager

extension FileOperator: TTSFileManagerProtocol {}

let ttsManager = TTSManager(app: .EDN, environment: .release, fileOperator: FileOperator)
```

## Usage

### Play Audio
**`TTSManager`** only accepts `TTSNewsItem` data type. Preference will affact the behavior when playing the playlist.
```swift
ttsManager.playNewsArray(newsArray: newsArray, atIndex: 0)
```
 **`AudioPlayer`**  accepts String Path for general purpose. 
 ```
 AudioPlayer().play(atPath path: String)
 ```


### Monitor Audio currentTime and Status Change
Status from `TTSDownloader`, `AudioPlayer`, and  `TTSManager` will be gathered to TTSManagerState. 
Applying the framework correctly, you should see console log similiar as below:

```
TTSManagerState: managerChangedItem(TTSManager.TTSNewsItem(title: "用電大戶綠電辦法原訂11月上路 驚傳跳票", categoryId: "5591", newsId: "4178800", ttsManager: TTSManager.TTSManager, imageUrl: nil, userInfo: nil))
TTSManagerState: downloaderDownloading(progress: 0.12387886)
TTSManagerState: downloaderDownloading(progress: 0.24858694)
TTSManagerState: downloaderDownloading(progress: 0.3714181)
TTSManagerState: downloaderDownloading(progress: 0.49800307)
TTSManagerState: downloaderDownloading(progress: 0.6227112)
TTSManagerState: downloaderDownloading(progress: 0.74741924)
TTSManagerState: downloaderDownloading(progress: 0.8721273)
TTSManagerState: downloaderDownloading(progress: 1.0)
TTSManagerState: downloaderFinishDownload(url: https://a.a-p-i.io/tts/TTS?app_id=ednnews&category_id=5591&news_id=4178800)
TTSManagerState: managerChangedItem(TTSManager.TTSNewsItem(title: "用電大戶綠電辦法原訂11月上路 驚傳跳票", categoryId: "5591", newsId: "4178800", ttsManager: TTSManager.TTSManager, imageUrl: nil, userInfo: nil))
2019-11-22 16:16:08.424329+0800 Demo[5162:167265] [plugin] AddInstanceForFactory: No factory registered for id <CFUUID 0x600002810c60> F8BB1C28-BAE8-11D6-9C31-00039315CD46
TTSManagerState: playerEmpty
TTSManagerState: playerPlaying(TTSManager.TTSNewsItem(title: "用電大戶綠電辦法原訂11月上路 驚傳跳票", categoryId: "5591", newsId: "4178800", ttsManager: TTSManager.TTSManager, imageUrl: nil, userInfo: nil))
```

To monitor the status change, conform to the TTSManagerListener Protocol and register as a listener. 
Don't forget to remove listener after your view controller / class deinits.


```swift
import TTSManager

// Register as a listener 
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ttsManager.addListener(listener: self)
        ttsManager.startMonitoringPlayerCurrentTime()
    }
}


// Conform to the TTSManagerListener Protocol
extension ViewController: TTSManagerListener {
    
    func TTSManager(playerCurrentTimeChanged currentTime: TimeInterval) {}

    func TTSManager(stateChanged: TTSManagerState) {}
}

// Remove listener
class ViewController: UIViewController {
    
    deinit {
        ttsManager.stopMonitoringPlayerCurrentTime()
        ttsManager.removeListener(listener: self)
    }
}
```

### Background Audio
Remeber to ckeck **Audio, AirPlay, and Picture in Picture** under Capabilities.
```swift
ttsManager.player.startAudioControl(title: newsItem.title, artist: newsItem.artist)
if ttsManager.nextItemExists {
    ttsManager.player.addNextTrackCommand()
}
if ttsManager.previousItemExists {
    ttsManager.player.addPreviousTrackCommand()
}
```

## Release
1.0.0:
- Deployment Target: iOS 9.0
- Features: Download and play with news TTS mp3 files.

1.0.1:
- Allow Remote Command Center to affect UI with closure.

1.0.2:
- fix bug for updateing force ended playing item.


## License

Copyright 2019 吳登秝 @ 聯合報行動發展部
