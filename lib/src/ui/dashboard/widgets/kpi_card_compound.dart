import 'package:flutter/material.dart';

import '../../../theme/formatters.dart';
import '../../../theme/spacing.dart';
import 'progress_ring.dart';

class CompoundKpiCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final CompoundKpiItem primary;
  final CompoundKpiItem secondary;
  final double? progressValue;
  final Color accentColor;

  const CompoundKpiCard({
    super.key,
    required this.title,
    required this.icon,
    required this.primary,
    required this.secondary,
    this.progressValue,
    this.accentColor = const Color(0xFF3B82F6),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 18, color: accentColor),
                const SizedBox(width: AppSpacing.sm),
                Text(title, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
                const Spacer(),
                if (progressValue != null)
                  ProgressRing(
                    progress: progressValue! / 100,
                    color: accentColor,
                    size: 40,
                    strokeWidth: 3,
                    child: Text(
                      '${progressValue!.toStringAsFixed(0)}%',
                      style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: accentColor),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Expanded(child: _buildSubMetric(primary, accentColor, theme)),
                Container(width: 1, height: 40, color: theme.colorScheme.outlineVariant),
                const SizedBox(width: AppSpacing.md),
                Expanded(child: _buildSubMetric(secondary, accentColor, theme)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubMetric(CompoundKpiItem item, Color accent, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.label,
          style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Text(
          item.isCurrency ? AppFormatters.formatCurrency(item.value) : item.value.toStringAsFixed(0),
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: theme.colorScheme.onSurface,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (item.subtitle != null)
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(
              item.subtitle!,
              style: theme.textTheme.labelSmall?.copyWith(
                color: item.destacado == true ? accent : theme.colorScheme.onSurfaceVariant,
                fontWeight: item.destacado == true ? FontWeight.w600 : null,
              ),
            ),
          ),
      ],
    );
  }
}

class CompoundKpiItem {
  final String label;
  final double value;
  final bool isCurrency;
  final String? subtitle;
  final bool? destacado;

  const CompoundKpiItem({
    required this.label,
    required this.value,
    this.isCurrency = true,
    this.subtitle,
    this.destacado,
  });
}
