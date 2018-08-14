package guru.hoteliers.uaretriever

import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.PluginRegistry.Registrar
import android.content.pm.PackageManager.NameNotFoundException

class UaRetrieverPlugin(registrar: Registrar): MethodCallHandler {
  private val mRegistrar: Registrar = registrar

  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar): Unit {
      val channel = MethodChannel(registrar.messenger(), "ua_retriever")
      channel.setMethodCallHandler(UaRetrieverPlugin(registrar))
    }
  }

  override fun onMethodCall(call: MethodCall, result: Result): Unit {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else if (call.method.equals("UAString")) {
      getUserAgent(result)
    } else {
      result.notImplemented()
    }
  }

  fun getUserAgent(result: Result) {
    try {
      val context = mRegistrar.context()
      val pm = context.getPackageManager()
      val pInfo = pm.getPackageInfo(context.getPackageName(), 0)
      val appName = pInfo.applicationInfo.loadLabel(pm).toString()
      val appVersion = pInfo.versionName
      val userAgent = System.getProperty("http.agent")

      result.success("$appName/$appVersion $userAgent")
    } catch (ex: NameNotFoundException) {
      result.error("Name not found", ex.message, null)
    }
  }
}
