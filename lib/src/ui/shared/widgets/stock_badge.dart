import 'package:flutter/material.dart';

import '../../../theme/constants.dart';
import '../../../theme/spacing.dart';

class StockBadge extends StatelessWidget {
  final String status;

  const StockBadge(this.status, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isOk = status == AppConstants.stockStatusOk;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xxs),
      decoration: BoxDecoration(
        color: isOk
            ? theme.colorScheme.primaryContainer.withOpacity(0.5)
            : theme.colorScheme.errorContainer.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isOk ? Icons.check_circle : Icons.warning,
            size: 12,
            color: isOk ? theme.colorScheme.primary : theme.colorScheme.error,
          ),
          const SizedBox(width: 4),
          Text(
            status,
            style: theme.textTheme.labelSmall?.copyWith(
              color: isOk ? theme.colorScheme.primary : theme.colorScheme.error,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class LoteStatusBadge extends StatelessWidget {
  final String status;

  const LoteStatusBadge(this.status, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = switch (status) {
      AppConstants.loteAgotado => theme.colorScheme.error,
      AppConstants.loteEnCurso => theme.colorScheme.primary,
      _ => theme.colorScheme.tertiary,
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xxs),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: theme.textTheme.labelSmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
