package hearsilent.wiflutter.libs

import android.annotation.TargetApi
import android.content.Context
import android.net.ConnectivityManager
import android.net.ConnectivityManager.NetworkCallback
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

    private var mCallback: NetworkCallback? = null
    private var mConnectivityManager: ConnectivityManager? = null

    /**
     * **This method was deprecated in API level 31.**
     *
     * Starting with [*Build.VERSION_CODES#S*](https://developer.android.com/reference/android/os/Build.VERSION_CODES#S), WifiInfo retrieval is moved to [***ConnectivityManager***](https://developer.android.com/reference/android/net/ConnectivityManager) API surface. WifiInfo is attached in [***NetworkCapabilities#getTransportInfo()***](https://developer.android.com/reference/android/net/NetworkCapabilities#getTransportInfo()) which is available via callback in [***NetworkCallback#onCapabilitiesChanged(Network, NetworkCapabilities)***](https://developer.android.com/reference/android/net/ConnectivityManager.NetworkCallback#onCapabilitiesChanged(android.net.Network,%20android.net.NetworkCapabilities)) or on-demand from [***ConnectivityManager#getNetworkCapabilities(Network).***](https://developer.android.com/reference/android/net/ConnectivityManager#getNetworkCapabilities(android.net.Network))
     *
     * For more information about ***connectionInfo***, see [getConnectionInfo](https://developer.android.com/reference/android/net/wifi/WifiManager#getConnectionInfo()).
     */
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
    @TargetApi(Build.VERSION_CODES.LOLLIPOP)
    fun requestNetwork(
        context: Context,
        ssid: String,
        bssid: String? = null,
        password: String? = null,
        withInternet: Boolean = false,
        timeoutInSeconds: Int = 30
    ): Boolean {
        if (!postVersion(Build.VERSION_CODES.LOLLIPOP)) return false

        if (BuildConfig.DEBUG) {
            Log.d(
                TAG,
                "requestNetwork: ssid=$ssid, bssid=$bssid, password=$password, withInternet=$withInternet, timeoutInSeconds=$timeoutInSeconds"
            )
        }

        setUpConnectivityManager(context)
        mConnectivityManager?.apply {
            val builder = NetworkRequest.Builder()
            if (withInternet) {
                builder.addCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET)
            } else {
                builder.removeCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET)
            }
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

            unregisterNetworkCallback(this, mCallback)

            mCallback = object : NetworkCallback() {

                override fun onAvailable(network: Network) {
                    if (BuildConfig.DEBUG) {
                        Log.i(TAG, "onAvailable: $network")
                    }

                    WiFiHelper.bindProcessToNetwork(network)
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

    /**
     * Unregister network callback to prevent *race condition* issue.
     */
    @JvmStatic
    fun unregisterNetworkCallback(
        connectivityManager: ConnectivityManager,
        callback: NetworkCallback?
    ) {
        try {
            if (BuildConfig.DEBUG) {
                Log.i(TAG, "Clean up pre-callback: $callback")
            }
            callback?.apply {
                connectivityManager.unregisterNetworkCallback(this)
            }
        } catch (e: IllegalArgumentException) {
            if (BuildConfig.DEBUG) {
                Log.wtf(TAG, "Clean up pre-callback error: $e")
            }
        }
    }

    @JvmStatic
    fun resetDefaultNetwork(context: Context) {
        if (!postVersion(Build.VERSION_CODES.LOLLIPOP)) return

        if (BuildConfig.DEBUG) {
            Log.d(TAG, "resetDefaultNetwork")
        }

        setUpConnectivityManager(context)
        bindProcessToNetwork(null)

        mCallback?.apply {
            try {
                mConnectivityManager?.unregisterNetworkCallback(this)
            } catch (e: IllegalArgumentException) {
                e.printStackTrace()
            }
        }
        mCallback = null
    }

    /**
     * Binds the current process to ***network***. All Sockets created in the future (and not explicitly bound via a bound SocketFactory from [Network.getSocketFactory()](https://developer.android.com/reference/android/net/Network#getSocketFactory())) will be bound to ***network***. All host name resolutions will be limited to ***network*** as well. Note that if ***network*** ever disconnects, all Sockets created in this way will cease to work and all host name resolutions will fail. This is by design so an application doesn't accidentally use Sockets it thinks are still bound to a particular [Network](https://developer.android.com/reference/android/net/Network). To clear binding pass ***null*** for ***network***. Using individually bound Sockets created by Network.getSocketFactory().createSocket() and performing network-specific host name resolutions via [Network.getAllByName](https://developer.android.com/reference/android/net/Network#getAllByName(java.lang.String)) is preferred to calling ***bindProcessToNetwork***.
     *
     * For more information about ***bindProcessToNetwork***, see [bindProcessToNetwork](https://developer.android.com/reference/android/net/ConnectivityManager#bindProcessToNetwork(android.net.Network))
     */
    @JvmStatic
    private fun bindProcessToNetwork(network: Network?) {
        if (postVersion(Build.VERSION_CODES.M)) {
            mConnectivityManager?.boundNetworkForProcess?.apply {
                mConnectivityManager?.bindProcessToNetwork(network)
            }
        } else {
            ConnectivityManager.getProcessDefaultNetwork()?.apply {
                ConnectivityManager.setProcessDefaultNetwork(network)
            }
        }
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