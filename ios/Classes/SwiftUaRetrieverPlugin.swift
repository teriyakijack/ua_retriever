import Flutter
import Foundation
import UIKit
    
public class SwiftUaRetrieverPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "ua_retriever", binaryMessenger: registrar.messenger())
    let instance = SwiftUaRetrieverPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if call.method == "UAString" {
        result(UAString())
    } else {
        result(FlutterMethodNotImplemented)
    }
  }

  //eg. Darwin/16.3.0
  func DarwinVersion() -> String {
      var sysinfo = utsname()
      uname(&sysinfo)
      let dv = String(bytes: Data(bytes: &sysinfo.release, count: Int(_SYS_NAMELEN)), encoding: .ascii)!.trimmingCharacters(in: .controlCharacters)
      return "Darwin/\(dv)"
  }
  //eg. CFNetwork/808.3
  func CFNetworkVersion() -> String {
      let dictionary = Bundle(identifier: "com.apple.CFNetwork")?.infoDictionary!
      let version = dictionary?["CFBundleShortVersionString"] as! String
      return "CFNetwork/\(version)"
  }

  //eg. iOS/10_1
  func deviceVersion() -> String {
      let currentDevice = UIDevice.current
      return "\(currentDevice.systemName)/\(currentDevice.systemVersion)"
  }
  //eg. iPhone5,2
  func deviceName() -> String {
      var sysinfo = utsname()
      uname(&sysinfo)
      return String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)!.trimmingCharacters(in: .controlCharacters)
  }
  //eg. MyApp/1
  func appNameAndVersion() -> String {
      let dictionary = Bundle.main.infoDictionary!
      let version = dictionary["CFBundleShortVersionString"] as! String
      let name = dictionary["CFBundleName"] as! String
      return "\(name)/\(version)"
  }

  func UAString() -> String {
      return "\(appNameAndVersion()) \(deviceName()) \(deviceVersion()) \(CFNetworkVersion()) \(DarwinVersion())"
  }
}
