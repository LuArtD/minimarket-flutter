import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../dao/views_dao.dart';
import '../../navigation/routes.dart';
import '../../notifiers/dashboard_notifier.dart';
import '../../providers/database_provider.dart';
import '../../repositories/dashboard_repository.dart';
import '../../theme/constants.dart';
import '../../theme/spacing.dart';
import '../shared/widgets/kpi_card.dart';
import '../shared/widgets/stock_badge.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dashboardNotifierProvider);
    final notifier = ref.read(dashboardNotifierProvider.notifier);
    final repo = ref.watch(dashboardRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push(AppRoutes.ajustes),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(dashboardNotifierProvider),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(dashboardNotifierProvider),
        child: CustomScrollView(
          slivers: [
            StreamBuilder<List<DashboardEntry>>(
              stream: repo.watchDashboard(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final kpis = {for (final e in snapshot.data!) e.kpi: e.valor};
                  WidgetsBinding.instance.addPostFrameCallback((_) => notifier.updateKpis(kpis));
                }
                return SliverPadding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  sliver: SliverGrid.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: AppSpacing.sm,
                      crossAxisSpacing: AppSpacing.sm,
                    ),
                    itemCount: 8,
                    itemBuilder: (context, index) => _buildKpiCard(context, state.kpis, index),
                  ),
                );
              },
            ),
            _EvolucionSection(),
            _MetodoPagoSection(),
            _TopVendidosSection(),
            _StockAlertasSection(repo: repo),
            const SliverPadding(padding: EdgeInsets.only(bottom: 80)),
          ],
        ),
      ),
    );
  }

  Widget _buildKpiCard(BuildContext context, Map<String, String> kpis, int index) {
    final entries = [
      (AppConstants.kpiVentasHoy, Icons.receipt_long, null),
      (AppConstants.kpiIngresosHoy, Icons.attach_money, Colors.green),
      (AppConstants.kpiGananciaHoy, Icons.trending_up, Colors.blue),
      (AppConstants.kpiIngresosMes, Icons.calendar_month, null),
      (AppConstants.kpiGananciaMes, Icons.savings, Colors.blue),
      (AppConstants.kpiReponer, Icons.warning_amber, Colors.orange),
      (AppConstants.kpiValorCosto, Icons.inventory, null),
      (AppConstants.kpiValorVenta, Icons.store, null),
    ];

    if (index >= entries.length) return const SizedBox.shrink();

    final (label, icon, color) = entries[index];
    final value = kpis[label] ?? '0';

    return KpiCard(label: label, value: value, icon: icon, iconColor: color);
  }
}

class _EvolucionSection extends ConsumerWidget {
  const _EvolucionSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(kpiDiarioStreamProvider);
    return asyncData.when(
      data: (data) {
        final filtered = data.take(7).toList();
        if (filtered.isEmpty) return const SliverToBoxAdapter(child: SizedBox.shrink());
        return SliverPadding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Evolución (7 días)', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: AppSpacing.md),
                SizedBox(height: 220, child: _EvolucionChart(kpiDiario: filtered)),
              ],
            ),
          ),
        );
      },
      loading: () => const SliverToBoxAdapter(child: SizedBox.shrink()),
      error: (_, _) => const SliverToBoxAdapter(child: SizedBox.shrink()),
    );
  }
}

class _MetodoPagoSection extends ConsumerWidget {
  const _MetodoPagoSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(kpiMetodoPagoStreamProvider);
    return asyncData.when(
      data: (data) {
        if (data.isEmpty) return const SliverToBoxAdapter(child: SizedBox.shrink());
        return SliverPadding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ventas por método de pago', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: AppSpacing.md),
                SizedBox(height: 200, child: _MetodoPagoPieChart(metodos: data)),
              ],
            ),
          ),
        );
      },
      loading: () => const SliverToBoxAdapter(child: SizedBox.shrink()),
      error: (_, _) => const SliverToBoxAdapter(child: SizedBox.shrink()),
    );
  }
}

class _TopVendidosSection extends ConsumerWidget {
  const _TopVendidosSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(topMasVendidosStreamProvider);
    return asyncData.when(
      data: (data) {
        final filtered = data.take(5).toList();
        if (filtered.isEmpty) return const SliverToBoxAdapter(child: SizedBox.shrink());
        return SliverPadding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Top 5 más vendidos', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: AppSpacing.md),
                SizedBox(height: 200, child: _TopVendidosBarChart(topVendidos: filtered)),
              ],
            ),
          ),
        );
      },
      loading: () => const SliverToBoxAdapter(child: SizedBox.shrink()),
      error: (_, _) => const SliverToBoxAdapter(child: SizedBox.shrink()),
    );
  }
}

class _StockAlertasSection extends ConsumerWidget {
  final DashboardRepository repo;

  const _StockAlertasSection({required this.repo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncAlertas = ref.watch(reposicionStreamProvider);
    return asyncAlertas.when(
      data: (alertas) {
        if (alertas.isEmpty) {
          return const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.lg),
              child: Center(child: Text('Todo el stock está OK')),
            ),
          );
        }
        return SliverPadding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Productos a reponer (${alertas.length})', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: AppSpacing.sm),
                ...alertas.map((a) => ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.errorContainer,
                    child: Icon(Icons.warning, color: Theme.of(context).colorScheme.onErrorContainer, size: 20),
                  ),
                  title: Text(a.producto),
                  subtitle: Text(a.categoria),
                  trailing: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const StockBadge('REPONER'),
                      Text('Stock: ${a.stockActual} / Mín: ${a.stockMinimo}', style: Theme.of(context).textTheme.labelSmall),
                      Text('Faltante: ${a.faltante.toStringAsFixed(0)}', style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Theme.of(context).colorScheme.error)),
                    ],
                  ),
                )),
              ],
            ),
          ),
        );
      },
      loading: () => const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.lg),
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
      error: (_, _) => const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.lg),
          child: Center(child: Text('Error al cargar')),
        ),
      ),
    );
  }
}

class _EvolucionChart extends StatelessWidget {
  final List<KpiDiario> kpiDiario;

  const _EvolucionChart({required this.kpiDiario});

  @override
  Widget build(BuildContext context) {
    final reversed = kpiDiario.reversed.toList();
    final theme = Theme.of(context);
    if (reversed.isEmpty) return const SizedBox.shrink();

    final ingresosSpots = <FlSpot>[];
    final costosSpots = <FlSpot>[];
    final gananciaSpots = <FlSpot>[];

    for (var i = 0; i < reversed.length; i++) {
      final kpi = reversed[i];
      ingresosSpots.add(FlSpot(i.toDouble(), kpi.ingresos));
      costosSpots.add(FlSpot(i.toDouble(), kpi.costos));
      gananciaSpots.add(FlSpot(i.toDouble(), kpi.gananciaBruta));
    }

    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true, drawVerticalLine: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 50, getTitlesWidget: (v, _) => Text('\$ ${v.toInt()}', style: theme.textTheme.labelSmall?.copyWith(fontSize: 9)))),
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (v, _) {
            final idx = v.toInt();
            if (idx >= 0 && idx < reversed.length) {
              final parts = reversed[idx].dia.split('-');
              if (parts.length >= 3) return Text('${parts[2]}/${parts[1]}', style: theme.textTheme.labelSmall?.copyWith(fontSize: 9));
            }
            return const SizedBox.shrink();
          })),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(spots: ingresosSpots, isCurved: true, color: Colors.green, barWidth: 2, dotData: const FlDotData(show: false), belowBarData: BarAreaData(show: true, color: Colors.green.withValues(alpha: 0.1))),
          LineChartBarData(spots: costosSpots, isCurved: true, color: Colors.red, barWidth: 2, dotData: const FlDotData(show: false)),
          LineChartBarData(spots: gananciaSpots, isCurved: true, color: Colors.blue, barWidth: 2, dotData: const FlDotData(show: false), belowBarData: BarAreaData(show: true, color: Colors.blue.withValues(alpha: 0.1))),
        ],
        lineTouchData: LineTouchData(touchTooltipData: LineTouchTooltipData(getTooltipItems: (touchedSpots) {
          return touchedSpots.map((spot) {
            final label = switch (spot.barIndex) { 0 => 'Ingresos', 1 => 'Costos', _ => 'Ganancia' };
            return LineTooltipItem('$label\n\$ ${spot.y.toStringAsFixed(2)}', TextStyle(color: spot.barIndex == 0 ? Colors.green : spot.barIndex == 1 ? Colors.red : Colors.blue));
          }).toList();
        })),
      ),
    );
  }
}

class _MetodoPagoPieChart extends StatelessWidget {
  final List<KpiMetodoPago> metodos;

  const _MetodoPagoPieChart({required this.metodos});

  @override
  Widget build(BuildContext context) {
    final colors = [Colors.green, Colors.blue, Colors.orange];
    final sections = metodos.asMap().entries.map((e) {
      return PieChartSectionData(
        value: e.value.totalCobrado,
        title: AppConstants.paymentMethodLabels[e.value.metodoPago] ?? e.value.metodoPago,
        color: colors[e.key % colors.length],
        radius: 80,
        titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      );
    }).toList();

    return PieChart(PieChartData(sections: sections, centerSpaceRadius: 40, sectionsSpace: 2));
  }
}

class _TopVendidosBarChart extends StatelessWidget {
  final List<TopVendido> topVendidos;

  const _TopVendidosBarChart({required this.topVendidos});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final reversed = topVendidos.reversed.toList();
    final maxVal = reversed.map((e) => e.unidadesVendidas).reduce((a, b) => a > b ? a : b) * 1.2;

    final barGroups = List<BarChartGroupData>.generate(reversed.length, (i) {
      final item = reversed[i];
      return BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(toY: item.unidadesVendidas, color: theme.colorScheme.primary, width: 20, borderRadius: const BorderRadius.vertical(top: Radius.circular(4)), backDrawRodData: BackgroundBarChartRodData(show: true, toY: maxVal, color: theme.colorScheme.surfaceContainerHighest)),
        ],
      );
    });

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        gridData: const FlGridData(show: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 30, getTitlesWidget: (v, _) => Text(v.toInt().toString(), style: theme.textTheme.labelSmall?.copyWith(fontSize: 9)))),
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (v, _) {
            final idx = v.toInt();
            if (idx >= 0 && idx < reversed.length) {
              final name = reversed[idx].producto;
              final short = name.length > 10 ? '${name.substring(0, 10)}...' : name;
              return Text(short, style: theme.textTheme.labelSmall?.copyWith(fontSize: 8));
            }
            return const SizedBox.shrink();
          })),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        barGroups: barGroups,
      ),
    );
  }
}
