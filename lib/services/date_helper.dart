import 'package:intl/intl.dart';

class DateHelper {
  // Function to get current date as a string in 'yyyy-MM-dd' format
  String getCurrentDateString() {
    return DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  // Function to check if a new day has started
  bool isNewDay(String lastDateString) {
    String currentDateString = getCurrentDateString();
    return currentDateString != lastDateString;
  }
}