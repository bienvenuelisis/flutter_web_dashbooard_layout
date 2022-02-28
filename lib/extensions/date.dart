import 'package:intl/intl.dart';

extension DateTimeUtils on DateTime {
  String get dateString {
    return "$day/$month/$year";
  }

  String get timeString {
    return "${hour}h$minute";
  }

  String get dateTimeString {
    return "$day/$month/$year à ${hour}h$minute";
  }

  String get str {
    return DateFormat.yMMMEd("fr_FR").format(this);
  }
}
