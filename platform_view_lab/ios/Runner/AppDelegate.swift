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
      
      
      
      
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

//In case of plugin
public class SwiftWebViewPlugin: NSObject, FlutterPlugin {
       
    public static func register(with registrar: FlutterPluginRegistrar) {
        registrar.register(FLNativeViewFactory(messenger: registrar.messenger()), withId: "mySwiftUIView")
    }
}
