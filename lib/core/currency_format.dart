import 'package:intl/intl.dart';

class CurrencyFormat {
  static String toNumber(String number) {
    // Replace semua char setelah comma "."
    String noComma = (number).split('.')[0];
    noComma = noComma != '' ? noComma : '0';

    // Replace point ","
    String noPoint = noComma.split(',').join("");
    return noPoint;
  }

  static String toNumberComma(String number) {
    // Replace point ","
    String noPoint = number.split(',').join("");
    return noPoint;
  }
}

/// Digunakan untuk merubah format angka ke dalam rupiah
/// Ex. 1000000 menjadi Rp. 1,000,000
final currencyId =
    NumberFormat.currency(locale: 'EN', symbol: '', decimalDigits: 0);
