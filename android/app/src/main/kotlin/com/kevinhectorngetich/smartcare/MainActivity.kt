package com.kevinhectorngetich.smartcare

import android.app.usage.UsageStatsManager
import android.app.usage.UsageEvents
import android.content.Context
import android.os.Build
import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.text.SimpleDateFormat
import java.util.*
import android.app.AppOpsManager
import android.content.Intent
import android.os.Process
import android.provider.Settings


class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.kevinhectorngetich.smartcare/usage_stats"
    private val TAG = "MainActivity"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        requestUsageStatsPermission()
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            if (call.method == "getUsageStatsForWeek") {
                val usageStatsMap = getUsageStatsForWeek()
                result.success(usageStatsMap)
            }
              else if (call.method == "getUnlockCount") {
                 val count = getUnlockCount()
                result.success(count)
             }
              else if (call.method == "getUsageStatsForPreviousWeek") {
                 val averageUsagePreviousWeek = getUnlockCount()
                result.success(averageUsagePreviousWeek)
             }
            else {
                result.notImplemented()
            }
        }
    }
private fun requestUsageStatsPermission() {
    val appOpsManager = getSystemService(Context.APP_OPS_SERVICE) as AppOpsManager
    val mode = appOpsManager.checkOpNoThrow(
        AppOpsManager.OPSTR_GET_USAGE_STATS,
        Process.myUid(),
        packageName
    )
    if (mode != AppOpsManager.MODE_ALLOWED) {
        startActivity(Intent(Settings.ACTION_USAGE_ACCESS_SETTINGS))
    }
}


//? TRYING only the apps the user has opened
 private fun getUsageStatsForWeek(): Map<String, Long> {
        val usageStatsManager = getSystemService(Context.USAGE_STATS_SERVICE) as UsageStatsManager
        val calendar = Calendar.getInstance()
        calendar.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY)
        calendar.set(Calendar.HOUR_OF_DAY, 0)
        calendar.set(Calendar.MINUTE, 0)
        calendar.set(Calendar.SECOND, 0)
        val usageStatsMap = mutableMapOf<String, Long>()
        val dateFormat = SimpleDateFormat("EEE, MMM d, yyyy")
        for (i in 0..6) {
            val startDate = calendar.timeInMillis
            calendar.add(Calendar.DATE, 1)
            val endDate = calendar.timeInMillis
            val usageStats = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
                usageStatsManager.queryUsageStats(
                    UsageStatsManager.INTERVAL_BEST,
                    startDate,
                    endDate
                )
            } else {
                usageStatsManager.queryUsageStats(
                    UsageStatsManager.INTERVAL_DAILY,
                    startDate,
                    endDate
                )
            }
            var usageTime = 0L
            for (stat in usageStats) {
                if (stat.lastTimeUsed >= startDate && stat.lastTimeUsed <= endDate) {
                    usageTime += stat.totalTimeInForeground
                }
            }
            val dayOfWeek = when (i) {
                0 -> "Sunday"
                1 -> "Monday"
                2 -> "Tuesday"
                3 -> "Wednesday"
                4 -> "Thursday"
                5 -> "Friday"
                else -> "Saturday"
            }

            usageStatsMap[dayOfWeek] = usageTime / (1000 * 60 * 60)

        }
        Log.d(TAG, "Usage stats for the week: $usageStatsMap")
        return usageStatsMap
    }

    private fun getUsageStatsForPreviousWeek(): Double {
    val usageStatsManager = getSystemService(Context.USAGE_STATS_SERVICE) as UsageStatsManager
    val calendar = Calendar.getInstance()
    calendar.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY)
    calendar.set(Calendar.HOUR_OF_DAY, 0)
    calendar.set(Calendar.MINUTE, 0)
    calendar.set(Calendar.SECOND, 0)
    var totalUsageTime = 0L
    for (i in 0..6) {
        val startDate = calendar.timeInMillis
        calendar.add(Calendar.DATE, 1)
        val endDate = calendar.timeInMillis
        val usageStats = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
            usageStatsManager.queryUsageStats(
                UsageStatsManager.INTERVAL_BEST,
                startDate,
                endDate
            )
        } else {
            usageStatsManager.queryUsageStats(
                UsageStatsManager.INTERVAL_DAILY,
                startDate,
                endDate
            )
        }
        var usageTime = 0L
        for (stat in usageStats) {
            if (stat.lastTimeUsed >= startDate && stat.lastTimeUsed <= endDate) {
                usageTime += stat.totalTimeInForeground
            }
        }
        totalUsageTime += usageTime
    }
    val avgUsageTime = totalUsageTime / (1000 * 60 * 60 * 7).toDouble()
    Log.d(TAG, "Usage stats for the previous week: $avgUsageTime hours")
    return avgUsageTime
}


private fun getUnlockCount(): Int {
    var count = 0
    val usageStatsManager = getSystemService(Context.USAGE_STATS_SERVICE) as UsageStatsManager
    val calendar = Calendar.getInstance()
    calendar.set(Calendar.HOUR_OF_DAY, 0)
    calendar.set(Calendar.MINUTE, 0)
    calendar.set(Calendar.SECOND, 0)
    val startTime = calendar.timeInMillis
    val endTime = System.currentTimeMillis()
    val usageEvents = usageStatsManager.queryEvents(startTime, endTime)
    val event = UsageEvents.Event()
    while (usageEvents.hasNextEvent()) {
        usageEvents.getNextEvent(event)
        if (event.eventType == UsageEvents.Event.KEYGUARD_HIDDEN) {
            count++
        }
    }
    Log.d(TAG, "Unlock count for today: $count")
    return count
}


}
