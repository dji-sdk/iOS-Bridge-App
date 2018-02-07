# DJI Bridge App

#### This repository is now deprecated, please refer to DJI SDK Bridge App on App Store: <https://itunes.apple.com/us/app/sdk-bridge/id1263583917?ls=1&mt=8>. It is only compatible with DJI iOS SDK 4.2.2 and below. 

## What is This?

This is an open source project for DJI Bridge App. 

The DJI Bridge App supports for native Xcode debugging with breakpoints. You can use it to debug your [DJI Mobile SDK](https://github.com/dji-sdk/Mobile-SDK-iOS) application for Mavic Pro, Phantom 4, Phantom 3 Professional, Phantom 3 Advanced, Inspire 1, M100 and other products using USB/MFI connection between RC and your app. 

For more details, please check the [DJI Bridge App Tutorial](https://github.com/DJI-Mobile-SDK/DJIBridgeAppDemo).

## Prerequisites

- Xcode 8.0+ or higher
- Deployment target of 9.0 or higher

## SDK Installation with CocoaPods

Since this project has been integrated with [DJI iOS SDK CocoaPods](https://cocoapods.org/pods/DJI-SDK-iOS) now, please check the following steps to install **DJISDK.framework** using CocoaPods after you downloading this project:

**1.** Install CocoaPods

Open Terminal and change to the download project's directory, enter the following command to install it:

~~~
sudo gem install cocoapods
~~~

The process may take a long time, please wait. For further installation instructions, please check [this guides](https://guides.cocoapods.org/using/getting-started.html#getting-started).

**2.** Install SDK with CocoaPods in the Project

Run the following command in the project's directory:

~~~
pod install
~~~

If you install it successfully, you may get the messages similar to the followings:

~~~
Analyzing dependencies
Downloading dependencies
Installing DJI-SDK-iOS (4.2.2)
Generating Pods project
Integrating client project

[!] Please close any current Xcode sessions and use `DJIDebuger.xcworkspace` for this project from now on.
Pod installation complete! There is 1 dependency from the Podfile and 1 total pod
installed.
~~~

## What's More?

If you want, you can customize your own Bridge app with [DJI Mobile SDK](https://github.com/dji-sdk/Mobile-SDK-iOS), please check the project's source code.


## License

DJI Bridge App is released under the MIT license. See LICENSE for details.

## Join Us

DJI is looking for all kinds of Software Engineers to continue building the Future of Possible. Available positions in Shenzhen, China and around the world. If you are interested, please send your resume to <software-sz@dji.com>. For more details, and list of all our global offices, please check <https://we.dji.com/jobs_en.html>.

DJI 招软件工程师啦，based在深圳，如果你想和我们一起把DJI产品做得更好，请发送简历到 <software-sz@dji.com>.  详情请浏览 <https://we.dji.com/zh-CN/recruitment>.
