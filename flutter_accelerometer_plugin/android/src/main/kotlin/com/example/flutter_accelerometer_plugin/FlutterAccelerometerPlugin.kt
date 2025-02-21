package com.example.accelerometer_plugin

import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

class AccelerometerPlugin : MethodCallHandler, EventChannel.StreamHandler, SensorEventListener {
    private var sensorManager: SensorManager? = null
    private var eventSink: EventChannel.EventSink? = null

    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "accelerometer_plugin")
            val plugin = AccelerometerPlugin()
            channel.setMethodCallHandler(plugin)

            val eventChannel = EventChannel(registrar.messenger(), "accelerometer_events")
            eventChannel.setStreamHandler(plugin)

            plugin.sensorManager = registrar.context().getSystemService(Context.SENSOR_SERVICE) as SensorManager
        }
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "startListening" -> {
                sensorManager?.registerListener(
                    this,
                    sensorManager?.getDefaultSensor(Sensor.TYPE_ACCELEROMETER),
                    SensorManager.SENSOR_DELAY_NORMAL
                )
                result.success(null)
            }
            "stopListening" -> {
                sensorManager?.unregisterListener(this)
                result.success(null)
            }
            else -> result.notImplemented()
        }
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventSink = events
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null
    }

    override fun onSensorChanged(event: SensorEvent?) {
        event?.let {
            val data = mapOf(
                "x" to it.values[0],
                "y" to it.values[1],
                "z" to it.values[2]
            )
            eventSink?.success(data)
        }
    }

    override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {}
}