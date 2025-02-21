
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thingwire/controller/accelerometer_controller.dart';

class AccelerometerScreen extends StatelessWidget {
  final AccelerometerController controller = Get.put(AccelerometerController());

  AccelerometerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
          title: Center(
            child: Text('Accelerometer Data',
                style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: width * 0.050,
                    fontWeight: FontWeight.bold)),
          )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text(
                  'X: ${controller.x.value.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: width * 0.06),
                )),
            Obx(() => Text(
                  'Y: ${controller.y.value.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: width * 0.06),
                )),
            Obx(() => Text(
                  'Z: ${controller.z.value.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: width * 0.06),
                )),
            SizedBox(height: height * 0.03),
            // Timer Display
            Obx(() => Text(
                  'Timer: ${controller.timerValue} s',
                  style: TextStyle(fontSize: width * 0.05, color: const Color.fromARGB(255, 13, 88, 149)),
                )),
            SizedBox(height: height * 0.03),
            Obx(() => ElevatedButton(
                  onPressed: controller.isListening.value
                      ? controller.stopListening
                      : controller.startListening,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.1,
                      vertical: height * 0.02,
                    ),
                    backgroundColor:
                        controller.isListening.value ? Colors.red : Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    controller.isListening.value
                        ? 'Stop Streaming'
                        : 'Start Streaming',
                    style: TextStyle(
                      fontSize: width * 0.045,
                      color: Colors.white,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}






















































// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:thingwire/controller/accelerometer_controller.dart';

// class AccelerometerScreen extends StatelessWidget {
//   final AccelerometerController controller = Get.put(AccelerometerController());

//  AccelerometerScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final double height = MediaQuery.of(context).size.height;
//     final double width = MediaQuery.of(context).size.width;

//     return   Scaffold(
//       appBar: AppBar(title: Text('Accelerometer Data',style: TextStyle(color: Colors.redAccent,fontSize: width * 0.050,fontWeight: FontWeight.bold))),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Obx(() => Text(
//                   'X: ${controller.x.value.toStringAsFixed(2)}',
//                   style: TextStyle(fontSize: width * 0.06), 
//                 )),
//             Obx(() => Text(
//                   'Y: ${controller.y.value.toStringAsFixed(2)}',
//                   style: TextStyle(fontSize: width * 0.06),
//                 )),
//             Obx(() => Text(
//                   'Z: ${controller.z.value.toStringAsFixed(2)}',
//                   style: TextStyle(fontSize: width * 0.06),
//                 )),
//             SizedBox(height: height * 0.03), 
//             Obx(() => ElevatedButton(
//                   onPressed: controller.isListening.value
//                       ? controller.stopListening
//                       : controller.startListening,
//                   style: ElevatedButton.styleFrom(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: width * 0.1, 
//                       vertical: height * 0.02, 
//                     ),
//                     backgroundColor:
//                         controller.isListening.value ? Colors.red : Colors.green,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(14),
//                     ),
//                   ),
//                   child: Text(
//                     controller.isListening.value ? 'Stop Streaming' : 'Start Streaming',
//                     style: TextStyle(
//                       fontSize: width * 0.045, 
//                       color: Colors.white,
//                     ),
//                   ),
//                 )),
//           ],
//         ),
//       ),
//     );
//   }
// }

