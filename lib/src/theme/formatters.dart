import 'package:intl/intl.dart';

class AppFormatters {
  AppFormatters._();

  static final _number = NumberFormat('#,##0.00');

  static String formatCurrency(double amount) => '\$ ${_number.format(amount)}';

  static final date = DateFormat('dd/MM/yyyy');

  static final dateTime = DateFormat('dd/MM/yyyy HH:mm');

  static final time = DateFormat('HH:mm');

  static final month = DateFormat('MMM yyyy', 'es');

  static final dayMonth = DateFormat('dd MMM', 'es');

  static String formatDate(DateTime d) => date.format(d);

  static String formatDateTime(DateTime date) => dateTime.format(date);

  static String formatMonth(String monthStr) {
    try {
      final parts = monthStr.split('-');
      final date = DateTime(int.parse(parts[0]), int.parse(parts[1]));
      return month.format(date);
    } catch (_) {
      return monthStr;
    }
  }

  static String formatWeek(String weekStr) {
    try {
      final parts = weekStr.split('-W');
      return 'Sem ${parts[1]} - ${parts[0]}';
    } catch (_) {
      return weekStr;
    }
  }

  static String formatPercentage(double value) {
    return '${value.toStringAsFixed(1)}%';
  }

  static String formatDateShort(String dateStr) {
    if (dateStr.length < 10) return dateStr;
    final dt = DateTime.tryParse('${dateStr}Z');
    if (dt == null) return dateStr.substring(0, 10);
    return formatDate(dt.toLocal());
  }

  static String formatDateTimeShort(String dateStr) {
    if (dateStr.length < 16) return dateStr;
    return dateStr.substring(0, 16);
  }

  static String formatNumber(double value) {
    if (value == value.truncateToDouble()) {
      return value.toInt().toString();
    }
    return value.toStringAsFixed(2);
  }
}
