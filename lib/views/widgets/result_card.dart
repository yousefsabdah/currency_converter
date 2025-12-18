import 'package:flutter/material.dart';


class ResultCard extends StatelessWidget {
  final String currencySymbol;
  final double result;

  const ResultCard({
    super.key,
    required this.currencySymbol,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: theme.colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text('Converted Amount'),
            const SizedBox(height: 10),
            Text(
              '$currencySymbol ${result.toStringAsFixed(2)}',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



