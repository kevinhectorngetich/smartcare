 package com.kevinhectorngetich.smartcare

 // import io.flutter.embedding.android.FlutterActivity

 // class MainActivity: FlutterActivity() {
 // }
 import android.app.usage.UsageStats
 import android.app.usage.UsageStatsManager
 import android.content.Context
 import android.os.Build
 import java.text.SimpleDateFormat
 import android.os.Bundle
 import android.util.Log
 import androidx.annotation.NonNull
 import io.flutter.embedding.android.FlutterActivity
 import io.flutter.embedding.engine.FlutterEngine
 import io.flutter.plugin.common.MethodCall
 import io.flutter.plugin.common.MethodChannel
 import java.util.*

 class MainActivity : FlutterActivity() {
     private val CHANNEL = "com.kevinhectorngetich.smartcare/usage_stats"
     private val TAG = "MainActivity"

     override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
         super.configureFlutterEngine(flutterEngine)
         MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
             call, result ->
             if (call.method == "getUsageStatsForWeek") {
                 val usageStatsMap = getUsageStatsForWeek()
                 result.success(usageStatsMap)
             } else if (call.method == "getWhatsAppUsage") {
                 val usage = getWhatsAppUsage()
                result.success(usage)
             }
              else {
                 result.notImplemented()
             }
         }
     }

     private fun getWhatsAppUsage(): Long {
        val usageStatsManager = getSystemService(Context.USAGE_STATS_SERVICE) as UsageStatsManager
        val startTime = getStartTimeForToday()
        val endTime = System.currentTimeMillis()
        val usageStats = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            usageStatsManager.queryUsageStats(UsageStatsManager.INTERVAL_DAILY, startTime, endTime)
        } else {
            usageStatsManager.queryUsageStats(UsageStatsManager.INTERVAL_BEST, startTime, endTime)
        }

        val whatsappPackageName = "com.whatsapp"
        var whatsappUsageTime = 0L

        for (usage in usageStats) {
            if (usage.packageName == whatsappPackageName) {
                whatsappUsageTime += usage.totalTimeInForeground
            }
        }
        return whatsappUsageTime
     }

    private fun getStartTimeForToday(): Long {
        val calendar = Calendar.getInstance()
        calendar.set(Calendar.HOUR_OF_DAY, 0)
        calendar.set(Calendar.MINUTE, 0)
        calendar.set(Calendar.SECOND, 0)
        return calendar.timeInMillis
    }



  private fun getUsageStatsForWeek(): Map<String, Long> {
      val usageStatsManager = getSystemService(Context.USAGE_STATS_SERVICE) as UsageStatsManager
      val calendar = Calendar.getInstance()
      calendar.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY)
      calendar.set(Calendar.HOUR_OF_DAY, 0)
      calendar.set(Calendar.MINUTE, 0)
      calendar.set(Calendar.SECOND, 0)
      val usageStatsMap = mutableMapOf<String, Long>()
      for (i in 0..6) {
          val startDate = calendar.timeInMillis
          calendar.add(Calendar.DATE, 1)
          val endDate = calendar.timeInMillis
          val usageStats = usageStatsManager.queryUsageStats(UsageStatsManager.INTERVAL_DAILY, startDate, endDate)
          var usageTime = 0L
          for (stat in usageStats) {
              usageTime += stat.totalTimeInForeground
          }
          for (stat in usageStats) {
             Log.d(TAG, "Package name: ${stat.packageName}, Usage time: ${stat.totalTimeInForeground}")
            //  usageTime += stat.totalTimeInForeground
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



 }
