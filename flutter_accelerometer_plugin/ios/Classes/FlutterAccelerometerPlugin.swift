// import Flutter
// import UIKit
// import CoreMotion

// public class FlutterAccelerometerPlugin: NSObject, FlutterPlugin {
//   private var motionManager: CMMotionManager?
//   private var eventSink: FlutterEventSink?

//   public static func register(with registrar: FlutterPluginRegistrar) {
//     let eventChannel = FlutterEventChannel(name: "flutter_accelerometer_plugin/stream", binaryMessenger: registrar.messenger())
//     let instance = FlutterAccelerometerPlugin()
//     eventChannel.setStreamHandler(instance)
//   }
// }

// extension FlutterAccelerometerPlugin: FlutterStreamHandler {
//   public func onListen(withArguments arguments: Any?, eventSink: @escaping FlutterEventSink) -> FlutterError? {
//     self.eventSink = eventSink
//     motionManager = CMMotionManager()
    
//     if motionManager?.isAccelerometerAvailable ?? false {
//       motionManager?.accelerometerUpdateInterval = 0.1
//       motionManager?.startAccelerometerUpdates(to: .main) { data, error in
//         if let data = data {
//           let event: [String: Double] = [
//             "x": data.acceleration.x,
//             "y": data.acceleration.y,
//             "z": data.acceleration.z
//           ]
//           self.eventSink?(event)
//         }
//       }
//     }
//     return nil
//   }

//   public func onCancel(withArguments arguments: Any?) -> FlutterError? {
//     motionManager?.stopAccelerometerUpdates()
//     eventSink = nil
//     return nil
//   }
// }



import Flutter
import UIKit
import CoreMotion

public class SwiftAccelerometerPlugin: NSObject, FlutterPlugin, FlutterStreamHandler {
    private var eventSink: FlutterEventSink?
    private let motionManager = CMMotionManager()

    public static func register(with registrar: FlutterPluginRegistrar) {
        let instance = SwiftAccelerometerPlugin()

        let channel = FlutterMethodChannel(name: "accelerometer_plugin", binaryMessenger: registrar.messenger())
        registrar.addMethodCallDelegate(instance, channel: channel)

        let eventChannel = FlutterEventChannel(name: "accelerometer_events", binaryMessenger: registrar.messenger())
        eventChannel.setStreamHandler(instance)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "startListening":
            startListening(result: result)
        case "stopListening":
            stopListening(result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    private func startListening(result: @escaping FlutterResult) {
        motionManager.accelerometerUpdateInterval = 0.1
        motionManager.startAccelerometerUpdates(to: OperationQueue()) { data, error in
            if let data = data {
                let accelerometerData = [
                    "x": data.acceleration.x,
                    "y": data.acceleration.y,
                    "z": data.acceleration.z
                ]
                self.eventSink?(accelerometerData)
            }
        }
        result(nil)
    }

    private func stopListening(result: @escaping FlutterResult) {
        motionManager.stopAccelerometerUpdates()
        result(nil)
    }

    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        eventSink = events
        return nil
    }

    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        eventSink = nil
        return nil
    }
}