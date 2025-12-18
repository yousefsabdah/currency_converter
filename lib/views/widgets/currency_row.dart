import 'package:flutter/material.dart';

/// Reusable row with a label and a dropdown for selecting a currency.
class CurrencyRow extends StatelessWidget {
  final String label;
  final String value;
  final List<String> currencies;
  final ValueChanged<String> onChanged;

  const CurrencyRow({
    super.key,
    required this.label,
    required this.value,
    required this.currencies,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(label)),
        const SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: DropdownButtonFormField<String>(
            value: value,
            items: currencies
                .map(
                  (c) => DropdownMenuItem(
                    value: c,
                    child: Text(c),
                  ),
                )
                .toList(),
            onChanged: (v) => v != null ? onChanged(v) : null,
            decoration: const InputDecoration(
              isDense: true,
              border: OutlineInputBorder(),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
          ),
        ),
      ],
    );
  }
}



