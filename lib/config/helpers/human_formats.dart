import 'package:intl/intl.dart';

class HumanFormats {
  static String number(double number, {int decimalDigits = 0}) {
    final formattedNumber = NumberFormat.compactCurrency(
      decimalDigits: decimalDigits,
      symbol: '',
      locale: 'en_US', //Con esto manejo el idioma
    ).format(number);

    return formattedNumber;
  }
}
