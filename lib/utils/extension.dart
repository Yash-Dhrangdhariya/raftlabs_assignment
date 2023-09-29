import 'package:intl/intl.dart';

extension DateExtension on String {
  String toPublishedDate() {
    return DateFormat.yMMMMd('en_US').format(
      trim() == '' ? DateTime.now() : DateTime.parse(this),
    );
  }
}
