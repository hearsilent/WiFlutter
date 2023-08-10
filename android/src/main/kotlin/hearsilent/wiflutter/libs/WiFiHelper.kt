package hearsilent.wiflutter.libs

import android.annotation.TargetApi
import android.content.Context
import android.net.ConnectivityManager
import android.net.MacAddress
import android.net.Network
import android.net.NetworkCapabilities
import android.net.NetworkRequest
import android.net.wifi.WifiManager
import android.net.wifi.WifiNetworkSpecifier
import android.os.Build
import androidx.annotation.ChecksSdkIntAtLeast
import io.flutter.BuildConfig
import io.flutter.Log

object WiFiHelper {

    private const val TAG = "WiFiHelper"

    private var mCallback: ConnectivityManager.NetworkCallback? = null
    private var mConnectivityManager: ConnectivityManager? = null

    @JvmStatic
    fun getCurrentSSID(context: Context): String? {
        val wifiManager =
            context.applicationContext.getSystemService(Context.WIFI_SERVICE) as? WifiManager
                ?: return null

        val wifiInfo = wifiManager.connectionInfo
        if (!wifiInfo?.ssid.isNullOrEmpty()) {
            val ssid = wifiInfo.ssid
            return when {
                postVersion(Build.VERSION_CODES.JELLY_BEAN_MR1) ->
                    if (ssid.startsWith("\"") && ssid.endsWith("\""))
                        ssid.substring(1, ssid.length - 1)
                    else null

                else -> ssid
            }
        }
        return null
    }

    @JvmStatic
    @Suppress("deprecation")
    @TargetApi(Build.VERSION_CODES.LOLLIPOP)
    fun requestNetwork(
        context: Context,
        ssid: String,
        bssid: String? = null,
        password: String? = null,
        joinOnce: Boolean? = true,
        withInternet: Boolean? = false,
        timeoutInSeconds: Int = 30
    ): Boolean {
        if (!postVersion(Build.VERSION_CODES.LOLLIPOP)) return false

        if (BuildConfig.DEBUG) {
            Log.d(
                TAG,
                "requestNetwork: ssid=$ssid, bssid=$bssid, password=$password, joinOnce=$joinOnce, withInternet=$withInternet, timeoutInSeconds=$timeoutInSeconds"
            )
        }

        setUpConnectivityManager(context)
        mConnectivityManager?.apply {
            val builder = NetworkRequest.Builder()
            builder.addCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET)
            builder.addTransportType(NetworkCapabilities.TRANSPORT_WIFI)

            if (postVersion(Build.VERSION_CODES.Q)) {
                // Make new network specifier
                val specifierBuilder = WifiNetworkSpecifier.Builder()
                specifierBuilder.setSsid(ssid)
                bssid?.apply {
                    if (this.isEmpty()) {
                        if (BuildConfig.DEBUG) {
                            Log.wtf(TAG, "bssid should not be empty.")
                        }
                    } else {
                        specifierBuilder.setBssid(MacAddress.fromString(this))
                    }
                }
                password?.apply {
                    if (this.isEmpty()) {
                        if (BuildConfig.DEBUG) {
                            Log.wtf(TAG, "password should not be empty.")
                        }
                    } else {
                        if (BuildConfig.DEBUG) {
                            Log.wtf(
                                TAG,
                                "Should pass password through Wi-Fi security type (WiFi Protected Access)"
                            )
                        }
                        specifierBuilder.setWpa2Passphrase(password)
                    }
                }

                builder.setNetworkSpecifier(specifierBuilder.build())
            } else {
                if (BuildConfig.DEBUG) {
                    Log.wtf(TAG, "Doesn't handle legacy code for pre-Q device yet.")
                }
                return false
            }

            try {
                if (mCallback != null) {
                    if (BuildConfig.DEBUG) {
                        Log.i(TAG, "Clean up pre-callback: $mCallback")
                    }

                    this.unregisterNetworkCallback(mCallback!!)
                }
            } catch (e: IllegalArgumentException) {
                if (BuildConfig.DEBUG) {
                    Log.wtf(TAG, "Clean up pre-callback error: $e")
                }
            }

            mCallback = object : ConnectivityManager.NetworkCallback() {

                override fun onAvailable(network: Network) {
                    if (BuildConfig.DEBUG) {
                        Log.i(TAG, "onAvailable: $network")
                    }

                    if (postVersion(Build.VERSION_CODES.M)) {
                        mConnectivityManager!!.bindProcessToNetwork(network)
                    } else {
                        ConnectivityManager.setProcessDefaultNetwork(network)
                    }
                }

                override fun onLost(network: Network) {
                    super.onLost(network)
                    if (BuildConfig.DEBUG) {
                        Log.i(TAG, "onLost: $network")
                    }

                    resetDefaultNetwork(context)
                }
            }


            mCallback?.apply {
                if (postVersion(Build.VERSION_CODES.O)) {
                    mConnectivityManager!!.requestNetwork(
                        builder.build(),
                        this,
                        timeoutInSeconds * 1000
                    )
                } else {
                    if (BuildConfig.DEBUG) {
                        Log.wtf(
                            TAG,
                            "timeoutInSeconds (${timeoutInSeconds}s) is not working for post-O devices"
                        )
                    }
                    mConnectivityManager!!.requestNetwork(builder.build(), this)
                }
                return true
            }
        }

        return false
    }

    @JvmStatic
    @Suppress("deprecation")
    @TargetApi(Build.VERSION_CODES.LOLLIPOP)
    fun resetDefaultNetwork(context: Context) {
        if (!postVersion(Build.VERSION_CODES.LOLLIPOP)) return

        if (BuildConfig.DEBUG) {
            Log.d(TAG, "resetDefaultNetwork")
        }

        setUpConnectivityManager(context)
        if (postVersion(Build.VERSION_CODES.M)) {
            mConnectivityManager?.boundNetworkForProcess?.apply {
                mConnectivityManager?.bindProcessToNetwork(null)
            }
        } else {
            ConnectivityManager.getProcessDefaultNetwork()?.apply {
                ConnectivityManager.setProcessDefaultNetwork(null)
            }
        }

        mCallback?.apply {
            try {
                mConnectivityManager?.unregisterNetworkCallback(this)
            } catch (e: IllegalArgumentException) {
                e.printStackTrace()
            }
        }
        mCallback = null
    }

    @JvmStatic
    private fun setUpConnectivityManager(context: Context) {
        mConnectivityManager = mConnectivityManager
            ?: context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
    }

    @JvmStatic
    @ChecksSdkIntAtLeast(parameter = Build.VERSION_CODES.LOLLIPOP)
    fun postVersion(sdkInt: Int): Boolean {
        return Build.VERSION.SDK_INT >= sdkInt
    }
}