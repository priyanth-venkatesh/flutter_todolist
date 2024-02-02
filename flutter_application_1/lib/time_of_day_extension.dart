import 'package:flutter/material.dart';

extension TimeOfDayExtension on TimeOfDay {
  String format(BuildContext context) {
    final now = DateTime.now();
    final dateTime = DateTime(now.year, now.month, now.day, this.hour, this.minute);
    final format = MaterialLocalizations.of(context).formatTimeOfDay(TimeOfDay.fromDateTime(dateTime), alwaysUse24HourFormat: false);
    return format;
  }
}
// TODO Implement this library.