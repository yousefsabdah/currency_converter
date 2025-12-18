import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/exchange_rate_controller.dart';
import 'widgets/amount_input_field.dart';
import 'widgets/currency_row.dart';
import 'widgets/error_view.dart';
import 'widgets/result_card.dart';

class ExchangeRatePage extends StatelessWidget {
  const ExchangeRatePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
        centerTitle: true,
      ),
      body: Consumer<ExchangeRateController>(
        builder: (_, controller, __) {
          if (controller.isLoading && !controller.hasRates) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.error != null && !controller.hasRates) {
            return ErrorView(
              message: controller.error!,
              onRetry: controller.loadRates,
            );
          }

          return RefreshIndicator(
            onRefresh: controller.loadRates,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    transitionBuilder: (child, animation) =>
                        ScaleTransition(scale: animation, child: child),
                    child: _converterCard(theme, controller),
                  ),
                  const SizedBox(height: 20),
                  _rateInfo(theme, controller),
                  const SizedBox(height: 20),
                  _resultCard(theme, controller),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _converterCard(
      ThemeData theme, ExchangeRateController exchangeRateController) {
    return Card(
      key: ValueKey(exchangeRateController.swapped),
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            AmountInputField(controller: exchangeRateController.amountController),
            const SizedBox(height: 20),

            CurrencyRow(
              label: 'From',
              value: exchangeRateController.fromCurrency,
              currencies: exchangeRateController.currencies,
              onChanged: exchangeRateController.changeFrom,
            ),
            IconButton(
              icon: const Icon(Icons.swap_vert_rounded),
              color: theme.colorScheme.primary,
              onPressed: exchangeRateController.swap,
            ),
            CurrencyRow(
              label: 'To',
              value: exchangeRateController.toCurrency,
              currencies: exchangeRateController.currencies,
              onChanged: exchangeRateController.changeTo,
            ),

            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: FilledButton(
                onPressed: exchangeRateController.convert,
                child: const Text('Convert'),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _rateInfo(ThemeData theme, ExchangeRateController c) {
    return Text(
      '1 ${c.fromCurrency} = ${c.currentRate.toStringAsFixed(2)} ${c.toCurrency}',
      style: TextStyle(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _resultCard(ThemeData theme, ExchangeRateController c) {
    return ResultCard(
      currencySymbol: c.getSymbol(c.toCurrency),
      result: c.result,
    );
  }
}
