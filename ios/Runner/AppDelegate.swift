import UIKit
import Flutter
import google_maps_flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey("AIzaSyB77oBq865jOSjJ5bHo8_JR7xlFjrcm2z4")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
