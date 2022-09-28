abstract class DateUtil {
  static String toDateString(final DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  static String millisToDateString(final num milliseconds) {
    final startTime = milliseconds.toInt();
    final dateTime = DateTime.fromMillisecondsSinceEpoch(startTime);
    return DateUtil.toDateString(dateTime);
  }
}
