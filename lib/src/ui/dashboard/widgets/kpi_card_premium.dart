import 'package:flutter/material.dart';

import '../../../theme/formatters.dart';
import '../../../theme/spacing.dart';
import 'sparkline.dart';

class PremiumKpiCard extends StatelessWidget {
  final String label;
  final double value;
  final IconData icon;
  final Color gradientStart;
  final Color gradientEnd;
  final List<double>? sparklineData;
  final double? cambioPct;

  const PremiumKpiCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.gradientStart,
    required this.gradientEnd,
    this.sparklineData,
    this.cambioPct,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [gradientStart, gradientEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: gradientStart.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 18, color: Colors.white.withValues(alpha: 0.8)),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              AppFormatters.formatCurrency(value),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w700,
                height: 1.1,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: AppSpacing.sm),
            if (sparklineData != null)
              Sparkline(data: sparklineData!, color: Colors.white.withValues(alpha: 0.6)),
            if (cambioPct != null)
              Padding(
                padding: const EdgeInsets.only(top: AppSpacing.xs),
                child: _buildCambioBadge(cambioPct!),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCambioBadge(double cambio) {
    final isPositive = cambio >= 0;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: (isPositive ? Colors.green : Colors.red).withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isPositive ? Icons.trending_up : Icons.trending_down,
            size: 14,
            color: Colors.white,
          ),
          const SizedBox(width: 4),
          Text(
            '${isPositive ? '+' : ''}${cambio.toStringAsFixed(1)}% vs ayer',
            style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
