package hearsilent.wiflutter

import android.content.Context
import hearsilent.wiflutter.libs.WiFiHelper
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** WiFlutterPlugin */
class WiFlutterPlugin : FlutterPlugin, MethodCallHandler {

    private lateinit var context: Context

    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "wiflutter")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "connect" -> {
                val ssid = call.argument<String>("ssid")
                    ?: return result.error("404", null, null)
                val bssid = call.argument<String>("bssid")
                val password = call.argument<String>("password")
                val joinOnce = call.argument<Boolean>("joinOnce") ?: true
                val withInternet = call.argument<Boolean>("withInternet") ?: false
                val timeoutInSeconds = call.argument<Int>("timeoutInSeconds") ?: 30

                if (!::context.isInitialized) {
                    return result.error("500", "Context is not initialized", null)
                }

                result.success(
                    WiFiHelper.requestNetwork(
                        context,
                        ssid,
                        bssid,
                        password,
                        joinOnce,
                        withInternet,
                        timeoutInSeconds
                    )
                )
            }

            "disconnect" -> {
                if (!::context.isInitialized) {
                    return result.error("500", "Context is not initialized", null)
                }

                WiFiHelper.resetDefaultNetwork(context)
                result.success(true)
            }

            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
