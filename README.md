<h1 align="center">
  <img src="https://github.com/creantan/LookinLoader/blob/master/example/LookinLoader.png">
  <br/>
  LookinLoader
</h1>

<p align="center"><b>Compatible with iOS 8 to 12</b></p>

[Lookin](https://lookin.work) Free macOS App for iOS View Debugging

<p>
	Because Lookin official did not provide the jailbreak version of the integration, causing inconvenience to the reverse analyst, so refer to RevealLoader to write this plugin that supports iOS8~iOS12, named LookinLoader
</p>
<p>
	LookinLoader dynamically loads LookinServer (Lookin.app support) into iOS apps on jailbroken devices. Configuration is via the Lookin menu in Settings.app.
</p>

![preview](https://github.com/creantan/LookinLoader/blob/master/example/preview.jpg "lookin" )

<p>
	You can inspect and modify views in iOS app via Lookin, just like UI Inspector in Xcode, or another app called Reveal.
	And you can do more with features like Console or Method Trace.
	Moreover, Lookin can run on your iPhone or iPad without connecting to a Mac.
	And one more thing, Lookin is free.
</p>

## Features

+ Configure options from Settings
+ Shake to show UIDebug Menu


## Download

***[Download Lookin App](https://lookin.work)***

***[Download Tweak](https://github.com/creantan/LookinLoader/releases/download/1.0.3/com.chinapyg.lookinloader_1.0.3_iphoneos-arm.deb.zip)***

## Easy build

```bash
git clone --recursive https://github.com/creantan/LookinLoader.git
cd layout/usr/lib/Lookin/LookinServer.framework/
ldid -S LookinServer
cd ../../../../../
make package FINALPACKAGE=1
```

## Samples

![Setting](https://github.com/creantan/LookinLoader/blob/master/example/setting.jpeg "Setting" )

![start](https://github.com/creantan/LookinLoader/blob/master/example/start.jpg "start" )

![Shake](https://github.com/creantan/LookinLoader/blob/master/example/debugui.png "Shake" )

![3D Debug](https://github.com/creantan/LookinLoader/blob/master/example/3dvew.png "3dview" )

![UI](https://github.com/creantan/LookinLoader/blob/master/example/ui.png "UI" )

## For more information

### community：[www.chinapyg.com](https://www.chinapyg.com)

![公众号](https://github.com/creantan/LookinLoader/blob/master/example/qrcode.jpg "公众号" )

