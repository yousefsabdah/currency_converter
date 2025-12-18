import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class AmountInputField extends StatelessWidget {
  final TextEditingController controller;

  const AmountInputField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          RegExp(r'^\d*\.?\d{0,4}'),
        ),
      ],
      decoration: const InputDecoration(
        labelText: 'Amount',
        prefixIcon: Icon(Icons.attach_money),
        border: OutlineInputBorder(),
        helperText: 'Enter the amount you want to convert',
      ),
    );
  }
}



