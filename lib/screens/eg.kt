import android.app.usage.UsageStatsManager
import android.content.Context
import android.content.pm.PackageManager
import java.util.*

fun getScreenTimeUsageData(context: Context): Map<Int, Long> {
    val calendar =
        Calendar.getInstance() calendar . timeInMillis = System . currentTimeMillis () calendar . set (Calendar.DAY_OF_WEEK, Calendar.MONDAY) val startOfWeek = calendar.timeInMillis val usageStatsManager = context.getSystemService(Context.USAGE_STATS_SERVICE) as UsageStatsManager val appPackageName = "com.kevinhectorngetich.smartcare" if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
        val usageStats = usageStatsManager.queryUsageStats(
            UsageStatsManager.INTERVAL_WEEKLY,
            startOfWeek,
            System.currentTimeMillis()
        ) return usageStats.filter { it.packageName == appPackageName }
        .groupBy { calendar.get(Calendar.DAY_OF_WEEK) }
        .mapValues { it.value.sumByLong { stat -> stat.totalTimeInForeground } }
    } else {
        val appInfo =
            context.packageManager.getApplicationInfo(appPackageName, PackageManager.GET_META_DATA)
        val packageName = appInfo.packageName
        val uid = appInfo.uid
        val usageStats =
            usageStatsManager.queryAndAggregateUsageStats(startOfWeek, System.currentTimeMillis())
        val appUsageStats = usageStats[packageName]?.get(uid) return mapOf(
        Calendar.MONDAY to appUsageStats?.totalTimeInForeground ?: 0
    )
    }
}