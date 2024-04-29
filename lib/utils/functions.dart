import 'package:intl/intl.dart';

String getFormattedDate(DateTime dateTime) {
  return DateFormat('EEEE, d MMMM yyyy').format(dateTime);
}
