/// Simple domain model representing a currency (e.g. USD, EUR).
class CurrencyModel {
  final String code;
  final String name;

  const CurrencyModel({
    required this.code,
    required this.name,
  });
}
