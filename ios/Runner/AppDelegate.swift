import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController;
    let batteryChannel = FlutterMethodChannel.init(name: "lloldmenll.flutter.sample/battery", binaryMessenger: controller);
    
    batteryChannel.setMethodCallHandler { (call, result) in
        if(call.method == "getBatteryLevel"){
            self.receiveBatteryLevel(result: result)
        } else {
            result(FlutterMethodNotImplemented);
        }
    }
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    private func receiveBatteryLevel(result: FlutterResult){
        let device = UIDevice.current;
        device.isBatteryMonitoringEnabled = true;
        if(device.batteryState == UIDeviceBatteryState.unknown){
            result(FlutterError.init(code: "UNAVAILABLE", message: "Battery info unavailable", details: nil));
        } else {
            result(Int(device.batteryLevel * 100));
        }
    }
}
