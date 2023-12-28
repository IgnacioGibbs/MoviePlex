import 'package:intl/intl.dart';

class HumanFormats {
  static String number(double number) {
    final formattedNumber = NumberFormat.compactCurrency(
      decimalDigits: 1,
      symbol: '',
      locale: 'en_US', //Con esto manejo el idioma
    ).format(number);

    return formattedNumber;
  }
}
