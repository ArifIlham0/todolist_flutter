import 'package:intl/intl.dart';

String formatDateTime(String dateTime) {
  return DateFormat('d MMMM, y - kk:mm').format(DateTime.parse(dateTime));
}
