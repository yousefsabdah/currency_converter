import 'package:currency_converter/services/currency_api_service.dart';
import 'package:flutter/material.dart';


class ExchangeRateController extends ChangeNotifier {
  final ExchangeRateService _service = ExchangeRateService();

  Map<String, dynamic> _rates = {};
  bool isLoading = false;
  String? error;

  String fromCurrency = 'USD';
  String toCurrency = 'EUR';

  final TextEditingController amountController =
      TextEditingController(text: '1');

  double result = 0.0;
  double currentRate = 0.0;

  bool swapped = false; // 🎞 animation trigger

  List<String> get currencies => _rates.keys.toList();

  bool get hasRates => _rates.isNotEmpty;

  ExchangeRateController() {
    // Trigger an initial load so views can remain stateless.
    Future.microtask(loadRates);
  }

  String getSymbol(String currency) {
    const symbols = {
      'USD': '\$',
      'EUR': '€',
      'INR': '₹',
      'GBP': '£',
      'JPY': '¥',
      'SYR':'SP'
    };
    return symbols[currency] ?? currency;
  }

  Future<void> loadRates() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      _rates = await _service.getRates(fromCurrency);
      currentRate = _rates[toCurrency] ?? 0;
      // Keep the last entered amount in sync with the latest rate.
      convert();
    } catch (e) {
      error = e.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void convert() {
    final amount = double.tryParse(amountController.text) ?? 0;
    if (amount <= 0 || currentRate <= 0) {
      result = 0;
    } else {
      result = amount * currentRate;
    }
    notifyListeners();
  }

  void changeFrom(String value) {
    fromCurrency = value;
    loadRates();
  }

  void changeTo(String value) {
    toCurrency = value;
    currentRate = _rates[toCurrency] ?? 0;
    notifyListeners();
  }

  void swap() {
    swapped = !swapped;
    final temp = fromCurrency;
    fromCurrency = toCurrency;
    toCurrency = temp;
    loadRates();
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }
}
