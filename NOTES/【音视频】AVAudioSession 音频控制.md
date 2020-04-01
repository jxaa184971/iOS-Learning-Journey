# AVAudioSession 音频控制

AVAudioSession通过它可以实现对App当前上下文音频资源的控制，比如插拔耳机、接电话、是否和其他音频数据混音等。

### Session默认行为
* 可以进行播放，但是不能进行录制。
* 当用户将手机上的静音拨片拨到“静音”状态时，此时如果正在播放音频，那么播放内容会被静音。
* 当用户按了手机的锁屏键或者手机自动锁屏了，此时如果正在播放音频，那么播放会静音并被暂停。
* 如果你的App在开始播放的时候，此时QQ音乐等其他App正在播放，那么其他播放器会被静音并暂停。

默认的行为相当于设置了Category为AVAudioSessionCategorySoloAmbient。

AVAudioSession以一个单例实体的形式存在，通过类方法获得单例：
```objective-c
+ (AVAudioSession *)sharedInstance;
```

### Category

首先AVAudioSession将使用音频的场景分成七大类，通过设置Session为不同的类别，可以控制：
* 当App激活Session的时候，是否会打断其他不支持混音的App声音
* 当用户触发手机上的“静音”键时或者锁屏时，是否相应静音
* 当前状态是否支持录音
* 当前状态是否支持播放

每个App启动时都会设置成上面说的默认状态，即其他App会被中断同时相应“静音”键的播放模式。通过下表可以细分每个类别的支持情况：

| 类别 | 当按"静音"或者锁屏是是否静音 | 是否引起不支持混音的App中断 |
| - | - | - |
|AVAudioSessionCategoryAmbient |是 |否 |
|AVAudioSessionCategoryAudioProcessing | - |都不支持 |
|AVAudioSessionCategoryMultiRoute |否 |是 |
|AVAudioSessionCategoryPlayAndRecord |否 |默认不引起 |
|AVAudioSessionCategoryPlayback |否 |默认引起 |
|AVAudioSessionCategoryRecord |否 |是 |
|AVAudioSessionCategorySoloAmbient |是 |是 |

#### 类别的设置：
```objective-c
- (BOOL)setCategory:(NSString *)category error:(NSError **)outError;
```

### AVAudioSessionCategoryOptions

|选项|适用类别|作用|
| - | - | - |
|AVAudioSessionCategoryOptionMixWithOthers | AVAudioSessionCategoryPlayAndRecord, AVAudioSessionCategoryPlayback, AVAudioSessionCategoryMultiRoute | 是否可以和其他后台App进行混音 |
|AVAudioSessionCategoryOptionDuckOthers | AVAudioSessionCategoryAmbient, AVAudioSessionCategoryPlayAndRecord, AVAudioSessionCategoryPlayback, AVAudioSessionCategoryMultiRoute | 是否压低其他App声音 |
|AVAudioSessionCategoryOptionAllowBluetooth |AVAudioSessionCategoryRecord, AVAudioSessionCategoryPlayAndRecord |是否支持蓝牙耳机 |
|AVAudioSessionCategoryOptionDefaultToSpeaker |AVAudioSessionCategoryPlayAndRecord |是否默认用免提声音|
