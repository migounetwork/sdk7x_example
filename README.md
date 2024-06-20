

This is a react-native template which includes 3 main dependencies:
 - [react-native-navigation](https://wix.github.io/react-native-navigation/docs/before-you-start/)
   - Native navigation for react native
 - [react-native-config](https://github.com/luggit/react-native-config)
   - Config all the Environment Variable including JS side and native code side

 <br> 


# 1. Prepare the environment and install react native dependencies

### You will need Node, Watchman, the React Native command line interface, Xcode, and CocoaPods.
### While you can use any editor of your choice to develop your app, you will need to install Xcode to set up the necessary tooling to build your React Native app for iOS.
 <br>

## Node & Watchman

### We recommend installing Node and Watchman using Homebrew. Run the following commands in a Terminal after installing Homebrew:

```sh
> brew install node@20  
> brew install watchman
```
> 注意：
> 1. 请确认`node -v`是20以上版号

<br>

### If you have already installed Node on your system, make sure it is Node 20 or newer.
### Watchman is a tool by Facebook for watching changes in the filesystem. It is highly recommended you install it for better performance.
 <br>


## Xcode
### The easiest way to install Xcode is via the Mac App Store. Installing Xcode will also install the iOS Simulator and all the necessary tools to build your iOS app.
### If you have already installed Xcode on your system, make sure it is version 10 or newer.
 <br>

## Command Line Tools
### You will also need to install the Xcode Command Line Tools. Open Xcode, then choose "Preferences..." from the Xcode menu. Go to the Locations panel and install the tools by selecting the most recent version in the Command Line Tools dropdown.
![Alt text](https://reactnative.dev/assets/images/GettingStartedXcodeCommandLineTools-8259be8d3ab8575bec2b71988163c850.png)
<br>

## CocoaPods
### CocoaPods is built with Ruby and it will be installable with the default Ruby available on macOS. You can use a Ruby Version manager, however, we recommend that you use the standard Ruby available on macOS unless you know what you're doing.
### Using the default Ruby install will require you to use sudo when installing gems. (This is only an issue for the duration of the gem installation, though.)
```sh
sudo gem install cocoapods
```
<br>

### For more information, please visit [CocoaPods Getting Started guide](https://guides.cocoapods.org/using/getting-started.html).
<br>


# 2. Clone this Repo
```sh
> git clone https://github.com/migounetwork/sdk7x_example.git sdk7x_example
> cd sdk7x_example
```
<br>


# 3. Config global variable
### Please modify global variables in `.env.production` file. Those variables could be used in`Info.plist` to define your app bundle_id, version number, version code, app name, and `白包 view controller name` which is defined in the `AppDelegate.m`.
```sh
# sdk7x_example/.env.production

export APP_ID_IOS="com.sdkExample"
export APP_NAME="SDK Example"
export IOS_VER_CODE="1"
export IOS_VER_MAJOR="1.0"
export EXT_NAME="我的外部新包" ## 白包view controller name
```
> 注意：
> 1. .env.production是隐藏文档，你先开启macos隐藏文档才能在xcode里看到。
> 2. 不要用Xcode改变app名和bundle identifier包括版号，请一律使用 `.env.production` 来设置
> 3. 设置完后，每次run/build/archive都会自动引入到Info.plist
> * `APP_NAME`:      CFBundleDisplayName
> * `APP_ID_IOS`:    CFBundleIdentifier
> * `IOS_VER_MAJOR`: CFBundleShortVersionString
> * `IOS_VER_CODE`:  CFBundleVersion
> * `EXT_NAME`:      白包名称，需要和`AppDelegate.m`一致 (详见步骤7)
<br>


# 4. Install project dependency and rename project
```sh
## cd sdk7x_example

> sudo npm install -g yarn
> yarn set version stable
> yarn install
> ./scripts/rename.js --skipGitStatusCheck "新包名"
> pod update --project-directory=ios
> pod install --project-directory=ios
```
> 注意：
> 1. 新包名会统一替换file、folder以及源码内容，才不会都以sdk7x_example做路径和档名。
> 2. 跑完请重载xcode。
> 3. 如果已安装pod，需要再重新跑pod install才能顺利运行。
> 4. 透过 `yarn --version` 确认版号，必需是3.6.4以上，太低请自行升版。
<br>


# 5. Unpack SDK bundle
### We will have all the control logic in javascript which will be bundled to a `sdk_yyyymmdd.tar.gz` zip file and placed in the project root folder.
### The SDK zip will be unzipped and combined to the build folder before running on the simulator or archived to ipa when you run/archive this project in xCode (refer `xcode -> build phases`).
> 注意： 请确认在run/archive前， `sdk_yyyymmdd.tar.gz` 已经备妥并有放置在Project根目录. 

<br>

# 6. Run your project
### Please make sure `.env.projection` and `sdk.tar.gz` is ready before run in the simulator or archive to ipa.

<br>

# 7. Add custom native modulel
### The ExternalComponent layout allows you to display any native view as a screen. To use the External Component we'll need to register it with a string name. This name is then used when declaring layouts in JS.

<br>

## ViewController registration
### Import your custom view controller to `ios/sdk7x_example/AppDelegate.mm`
```objc
#import "RNNCustomViewController.h"
```
### Register custom view controller in `ios/sdk7x_example/AppDelegate.mm` as a specific register name `我的外部新包`
```objc
[super application:application didFinishLaunchingWithOptions:launchOptions];
[ReactNativeNavigation
  registerExternalComponent:@"我的外部新包"
    callback:^UIViewController *(NSDictionary *props, RCTBridge *bridge) {
      return [[RNNCustomViewController alloc] initWithProps:props];
}];
```
### Setup registered component name `我的外部新包` to the global variable `EXT_NAME` in `.env.production`:
```sh
export EXT_NAME="我的外部新包" ## 白包view controller name
```

> 注意：
> 1. `RNNCustomViewController.h` 是事先准备好的白包示例，请在`AppDelegate.m` 替换成其它白包的view controller
> 2. 可以更动 "我的外部新包" ，但请确认在 `AppDelegate.m` 和 `.env.production` 里边是一致如上示例
> 3. 正确启动在模拟器，要跑出内键自带的白包 `RNNCustomViewController.h` 的 View
