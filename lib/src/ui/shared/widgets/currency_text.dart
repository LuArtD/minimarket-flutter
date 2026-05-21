import 'package:flutter/material.dart';

import '../../../theme/formatters.dart';

class CurrencyText extends StatelessWidget {
  final double amount;
  final TextStyle? style;
  final TextOverflow? overflow;

  const CurrencyText(
    this.amount, {
    super.key,
    this.style,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      AppFormatters.formatCurrency(amount),
      style: style,
      overflow: overflow,
    );
  }
}

class CurrencyLabel extends StatelessWidget {
  final String label;
  final double amount;
  final TextStyle? labelStyle;
  final TextStyle? amountStyle;

  const CurrencyLabel({
    super.key,
    required this.label,
    required this.amount,
    this.labelStyle,
    this.amountStyle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: labelStyle ?? theme.textTheme.labelSmall,
        ),
        const SizedBox(width: 4),
        CurrencyText(amount, style: amountStyle),
      ],
    );
  }
}
