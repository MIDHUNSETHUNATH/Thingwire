
import 'dart:async';
import 'package:get/get.dart';
import 'package:sensors_plus/sensors_plus.dart';

class AccelerometerController extends GetxController {
  var x = 0.0.obs;
  var y = 0.0.obs;
  var z = 0.0.obs;
  var isListening = false.obs;
  var timerValue = 00.obs;

  StreamSubscription? _accelerometerSubscription;
  Timer? _timer;

  void startListening() {
    if (isListening.value) return; 
    isListening.value = true;
    timerValue.value = 0; 

    _accelerometerSubscription?.cancel();

    _accelerometerSubscription = accelerometerEvents.listen((event) {
      x.value = event.x;
      y.value = event.y;
      z.value = event.z;
    });

   
    debounce(x, (_) => _printValues(), time: Duration(milliseconds: 100));
    debounce(y, (_) => _printValues(), time: Duration(milliseconds: 100));
    debounce(z, (_) => _printValues(), time: Duration(milliseconds: 100));

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      timerValue.value += 1;
    });
  }

  void stopListening() {
    _accelerometerSubscription?.cancel();
    _timer?.cancel();
    isListening.value = false;
  }

  void _printValues() {
    print("Updated Accelerometer Values: X=${x.value}, Y=${y.value}, Z=${z.value}");
  }

  @override
  void onClose() {
    _accelerometerSubscription?.cancel();
    _timer?.cancel(); 
    super.onClose();
  }
}





















































// import 'dart:async';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';

// class AccelerometerController extends GetxController {
//  static const EventChannel _channel = EventChannel('flutter_accelerometer_plugin/stream');


//   RxDouble x = 0.0.obs;
//   RxDouble y = 0.0.obs;
//   RxDouble z = 0.0.obs;
//   RxBool isListening = false.obs;

//   StreamSubscription? _subscription;

//   void startListening() {
//     if (isListening.value) return;
//     _subscription?.cancel();
//     _subscription = _channel.receiveBroadcastStream().listen((event) {
//       if (event is List && event.length >= 3) {
//         x.value = event[0];
//         y.value = event[1];
//         z.value = event[2];
//       } else if (event is Map) {
//         x.value = event["x"];
//         y.value = event["y"];
//         z.value = event["z"];
//       } else {
//         print("Unexpected accelerometer data format: $event");
//       }
//     }, onError: (error) {
//       print("Error receiving accelerometer data: $error");
//     });

//     isListening.value = true;
//   }

//   void stopListening() {
//     _subscription?.cancel();
//     isListening.value = false;
//   }

//   @override
//   void onClose() {
//     stopListening();
//     super.onClose();
//   }
// }





// import 'dart:async';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';

// class AccelerometerController extends GetxController {
//   static const EventChannel _channel = EventChannel('flutter_accelerometer_plugin/stream');

//   RxDouble x = 0.0.obs;
//   RxDouble y = 0.0.obs;
//   RxDouble z = 0.0.obs;
//   RxBool isListening = false.obs;
//   RxInt timerValue = 0.obs; // Timer in seconds

//   StreamSubscription? _subscription;
//   Timer? _timer;

//   void startListening() {
//     if (isListening.value) return;
    
//     // Start timer
//     _timer?.cancel();
//     timerValue.value = 0; // Reset timer
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       timerValue.value++;
//     });

//     _subscription?.cancel();
//     _subscription = _channel.receiveBroadcastStream().listen((event) {
//       if (event is List && event.length >= 3) {
//         x.value = event[0];
//         y.value = event[1];
//         z.value = event[2];
//       } else if (event is Map) {
//         x.value = event["x"];
//         y.value = event["y"];
//         z.value = event["z"];
//       } else {
//         print("Unexpected accelerometer data format: $event");
//       }
//     }, onError: (error) {
//       print("Error receiving accelerometer data: $error");
//     });

//     isListening.value = true;
//   }

//   void stopListening() {
//     _subscription?.cancel();
//     _timer?.cancel(); // Stop timer
//     isListening.value = false;
//   }

//   @override
//   void onClose() {
//     stopListening();
//     super.onClose();
//   }
// }



