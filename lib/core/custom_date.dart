import 'package:intl/intl.dart';

const idMonths = [
  "Januari",
  "Februari",
  "Maret",
  "April",
  "Mei",
  "Juni",
  "Juli",
  "Agustus",
  "September",
  "Oktober",
  "November",
  "Desember"
];

class DateCustom {
  /// DateFormat now in string
  ///
  /// Output : 2022-05-06 12:30:19
  static String timestamp() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd kk:mm:ss').format(now);
    return formattedDate;
  }

  /// DateFormat now in string
  ///
  /// Output : 2022-05-06
  static String commonDate() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    return formattedDate;
  }

  /// Params string date : yyyy-mm-dd
  ///
  /// Ex. 2022-01-01
  static String id(String date) {
    List<String> listDates = date.split("-");
    // ignore: prefer_interpolation_to_compose_strings
    return "${listDates[2]} ${idMonths[int.parse(listDates[1]) - 1]} ${listDates[0]}";
  }
}
