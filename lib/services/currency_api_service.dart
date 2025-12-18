import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

/// A small wrapper around the public exchange rate API.
///
/// This keeps all networking concerns in one place and throws
/// user‑friendly error messages that the UI can show directly.
class ExchangeRateService {
  static const String _apiKey = '29fff54d36c1ca0ca7826459';
  static const String _baseUrl = 'https://v6.exchangerate-api.com/v6';

  Future<Map<String, dynamic>> getRates(String baseCurrency) async {
    final url = Uri.parse('$_baseUrl/$_apiKey/latest/$baseCurrency');

    try {
      final response = await http
          .get(url)
          .timeout(const Duration(seconds: 10)); // basic timeout safeguard

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['result'] == 'success') {
          return Map<String, dynamic>.from(data['conversion_rates'] as Map);
        } else {
          throw Exception(
            data['error-type'] ?? 'Unknown error from exchange service',
          );
        }
      } else {
        // Try to surface a message from the body if present
        String message = 'Failed to load exchange rates (code ${response.statusCode})';
        try {
          final data = json.decode(response.body);
          if (data is Map && data['error-type'] is String) {
            message = data['error-type'] as String;
          }
        } catch (_) {
          // ignore JSON errors, keep generic message
        }
        throw Exception(message);
      }
    } on SocketException {
      throw Exception('No internet connection. Please check your network.');
    } on HttpException {
      throw Exception('Could not reach the exchange rate service.');
    } on FormatException {
      throw Exception('Received invalid data from the exchange rate service.');
    }
  }
}
