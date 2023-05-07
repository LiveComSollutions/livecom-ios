## Example
Demo project can be found [here](https://github.com/LiveComSollutions/livecom-ios-demo)

## Installation
### Install via SPM
To integrate LiveComSDK using the Xcode-built-in SPM, choose File → Swift Packages → Add Package Dependency.
Enter the following url: https://github.com/LiveComSollutions/livecom-ios . In the following step, select LiveComSDKWrapper as the package product and click Finish.

### Install via CocoaPods
Add the following line to your Podfile
```sh
  pod 'LiveComSDK', :podspec => 'https://customers.s3.sbg.io.cloud.ovh.net/ios/latest.podspec'
```
For App Clip target it's necessary to SDK be linked statically. So you can write `use_frameworks! :linkage => :static` globally, or only for App Clip target:

```
target 'AppClip' do
  use_frameworks! :linkage => :static
  pod 'LiveComSDK', :podspec => 'https://customers.s3.sbg.io.cloud.ovh.net/ios/latest.podspec'
end
```

## Initialize SDK
To initialize LiveCom SDK, you need pass SDK Key, Appearence and ShareSettings objects.

SDK Key is a unique identifier of your application that connects to LiveCom service. You can take SDK Key from your account.

With Appearance you can specify your brand's colors and corner radiuses.

ShareSettings allow you to set links for sharing videos and products.

Call  this method as soon as possible. For example, in didFinishLaunchingWithOptions. Because it needs time to load some data.
```sh 
import LiveComSDK

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let theme = Appearence.AppTheme(
            primary: .blue,
            secondary: .red,
            gradientFirst: .cyan,
            gradientSecond: .yellow
        )
        let appearence = Appearence(theme: theme)

        LiveCom.shared.configure(
            sdkKey: sdkKey,
            appearence: appearence,
            shareSettings: .init(
                videoLinkTemplate: "https://mysite.com/s/{video_id}",
                productLinkTemplate: "https://mysite.com/{video_id}?p={product_id}"
            )
        )

  return true
}
```
Add the following code to AppDelegate:
```
func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void ) -> Bool {
  ...
    let linkHandled = LiveCom.shared.continue(userActivity: userActivity)
  ...
}
```
Or if you support SceneDelegate:
```
func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    ...        
    if let userActivity = connectionOptions.userActivities.first {
       LiveCom.shared.continue(userActivity: userActivity)
    }
    ...
}
```

## Usage
To present screen with list of streams above current top view controller just call:
```sh 
LiveCom.shared.presentStreams()
```

To present stream screen with specific id call:
```sh 
LiveCom.shared.presentStream(withId: streamId)
```

## Custom Checkout and Product screens
It is possible to display your own screens for product and checkout.
Return true in  infollowing methods and present your own controllers in your LiveComDelegate:
```sh
func userDidRequestOpenProductScreen(
    forSKU productSKU: String,
    presenting presentingViewController: UIViewController
) -> Bool
func userDidRequestOpenCheckoutScreen(
    productSKUs: [String],
    presenting presentingViewController: UIViewController
) -> Bool
```
