class MoneyUtril {
  static String format(dynamic money) {
    return double.parse("$money").toStringAsFixed(2);
  }
}
