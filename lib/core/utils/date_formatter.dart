import 'package:intl/intl.dart';

class DateFormatter {
  static String formatApiDate(String dateString) {
    try {
      DateTime dateTime = DateTime.parse(dateString).toLocal();
      return DateFormat('dd MMMM yyyy').format(dateTime);
    } catch (e) {
      return '-';
    }
  }
}
