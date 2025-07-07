import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
      weak var registrant = self.registrar(forPlugin: "plugin-name")
      let factory = FLNativeViewFactory(messenger: registrant!.messenger())
      self.registrar(forPlugin: "<plugin-name>")!.register(factory, withId: "mySwiftUIView")
      setupFlutterPigeon()
      
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

public class SwiftWebViewPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        registrar.register(FLNativeViewFactory(messenger: registrar.messenger()), withId: "mySwiftUIView")
    }
}

extension AppDelegate : MessageApi {
    
    func getRoundedNumberFromNative(value: Double, completion: @escaping (Result<String, any Error>) -> Void) {
        let response = value.rounded().description + "IOS"
        completion(.success(response))
    }
    
    func getMessageFromNative(message: String, completion: @escaping (Result<String, any Error>) -> Void) {
        let response = "Hello \(message)"
        completion(.success("This is native message \(response)"))
    }
    
    func setupFlutterPigeon() {
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        MessageApiSetup.setUp(binaryMessenger: controller.binaryMessenger, api: self)
    }
}
