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
import '../shared/widgets/stock_badge.dart';
import 'widgets/kpi_card_compound.dart';
import 'widgets/kpi_card_metric.dart';
import 'widgets/kpi_card_premium.dart';
import 'widgets/section_header.dart';
import '../shared/widgets/shimmer_loading.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.watch(dashboardRepositoryProvider);
    final notifier = ref.read(dashboardNotifierProvider.notifier);

    ref.listen(dashboardAyerStreamProvider, (_, data) {
      data.whenData((entries) {
        notifier.updateKpisAyer({for (final e in entries) e.kpi: e.valor});
      });
    });

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
            _KpiCardsSliver(repo: repo, notifier: notifier),
            const _EvolucionSection(),
            const _TopVendidosSection(),
            const _MetodoPagoSection(),
            _StockAlertasSection(repo: repo),
            const SliverPadding(padding: EdgeInsets.only(bottom: 80)),
          ],
        ),
      ),
    );
  }
}

class _KpiCardsSliver extends ConsumerWidget {
  final DashboardRepository repo;
  final DashboardNotifier notifier;

  const _KpiCardsSliver({required this.repo, required this.notifier});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dashboardNotifierProvider);
    final kpiDiarioAsync = ref.watch(kpiDiarioStreamProvider);

    return StreamBuilder<List<DashboardEntry>>(
      stream: repo.watchDashboard(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final kpis = {for (final e in snapshot.data!) e.kpi: e.valor};
          WidgetsBinding.instance.addPostFrameCallback((_) => notifier.updateKpis(kpis));
        }

        final isEmpty = state.kpis.isEmpty;
        if (isEmpty) {
          return SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: AppSpacing.sm),
                ShimmerGrid(count: 2, height: 140),
                const SizedBox(height: AppSpacing.sm),
                ShimmerGrid(count: 2, height: 80),
                const SizedBox(height: AppSpacing.sm),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  child: ShimmerCard(height: 100),
                ),
                const SizedBox(height: AppSpacing.sm),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  child: ShimmerCard(height: 100),
                ),
              ],
            ),
          );
        }

        final ingresosHoy = _kpiDouble(state.kpis, AppConstants.kpiIngresosHoy);
        final gananciaHoy = _kpiDouble(state.kpis, AppConstants.kpiGananciaHoy);
        final ventasHoy = _kpiDouble(state.kpis, AppConstants.kpiVentasHoy);
        final reponer = _kpiDouble(state.kpis, AppConstants.kpiReponer);
        final ingresosMes = _kpiDouble(state.kpis, AppConstants.kpiIngresosMes);
        final gananciaMes = _kpiDouble(state.kpis, AppConstants.kpiGananciaMes);
        final valorCosto = _kpiDouble(state.kpis, AppConstants.kpiValorCosto);
        final valorVenta = _kpiDouble(state.kpis, AppConstants.kpiValorVenta);

        final ingresosAyer = _kpiDouble(state.kpisAyer, 'Ingresos ayer');
        final gananciaAyer = _kpiDouble(state.kpisAyer, 'Ganancia ayer');
        final ventasAyer = _kpiDouble(state.kpisAyer, 'Ventas ayer');
        final ingresosMesAnt = _kpiDouble(state.kpisAyer, 'Ingresos mes ant');
        final gananciaMesAnt = _kpiDouble(state.kpisAyer, 'Ganancia mes ant');

        final sparkIngresos = _sparklineData(kpiDiarioAsync, (d) => d.ingresos);
        final sparkGanancia = _sparklineData(kpiDiarioAsync, (d) => d.gananciaBruta);

        return SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(title: 'Hoy', icon: Icons.today),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Row(
                  children: [
                    Expanded(
                      child: PremiumKpiCard(
                        label: 'Ingresos',
                        value: ingresosHoy,
                        icon: Icons.attach_money,
                        gradientStart: const Color(0xFF3B82F6),
                        gradientEnd: const Color(0xFF1D4ED8),
                        sparklineData: sparkIngresos,
                        cambioPct: _calcCambio(ingresosHoy, ingresosAyer),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: PremiumKpiCard(
                        label: 'Ganancia bruta',
                        value: gananciaHoy,
                        icon: Icons.trending_up,
                        gradientStart: const Color(0xFF10B981),
                        gradientEnd: const Color(0xFF047857),
                        sparklineData: sparkGanancia,
                        cambioPct: _calcCambio(gananciaHoy, gananciaAyer),
                      ),
                    ),
                  ],
                ),
              ),
              const SectionHeader(title: 'Rápidas', icon: Icons.speed),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Row(
                  children: [
                    Expanded(
                      child: MetricKpiCard(
                        label: 'Ventas hoy',
                        value: ventasHoy,
                        icon: Icons.receipt_long,
                        accentColor: const Color(0xFFF59E0B),
                        trendLabel: _trendStr(ventasHoy, ventasAyer),
                        trendUp: ventasHoy >= ventasAyer,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: MetricKpiCard(
                        label: 'A reponer',
                        value: reponer,
                        icon: Icons.warning_amber,
                        accentColor: const Color(0xFFEF4444),
                      ),
                    ),
                  ],
                ),
              ),
              const SectionHeader(title: 'Este mes', icon: Icons.calendar_month),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: CompoundKpiCard(
                  title: 'Resumen del mes',
                  icon: Icons.calendar_month,
                  accentColor: const Color(0xFF8B5CF6),
                  primary: CompoundKpiItem(
                    label: 'Ingresos',
                    value: ingresosMes,
                    subtitle: ingresosMesAnt > 0
                        ? 'vs mes ant: ${_calcCambioStr(ingresosMes, ingresosMesAnt)}'
                        : null,
                    destacado: true,
                  ),
                  secondary: CompoundKpiItem(
                    label: 'Ganancia',
                    value: gananciaMes,
                    subtitle: gananciaMesAnt > 0
                        ? 'vs mes ant: ${_calcCambioStr(gananciaMes, gananciaMesAnt)}'
                        : null,
                    destacado: true,
                  ),
                  progressValue: ingresosMes > 0 && gananciaMes > 0
                      ? (gananciaMes / ingresosMes * 100).clamp(0, 100)
                      : null,
                ),
              ),
              const SectionHeader(title: 'Inventario', icon: Icons.inventory),
              Padding(
                padding: const EdgeInsets.only(left: AppSpacing.lg, right: AppSpacing.lg, bottom: AppSpacing.md),
                child: CompoundKpiCard(
                  title: 'Valor inventario',
                  icon: Icons.inventory,
                  accentColor: const Color(0xFFF59E0B),
                  primary: CompoundKpiItem(
                    label: 'A costo',
                    value: valorCosto,
                  ),
                  secondary: CompoundKpiItem(
                    label: 'A venta',
                    value: valorVenta,
                    destacado: true,
                    subtitle: valorCosto > 0
                        ? '+${((valorVenta - valorCosto) / valorCosto * 100).toStringAsFixed(0)}% potencial'
                        : null,
                  ),
                  progressValue: valorCosto > 0
                      ? ((valorVenta - valorCosto) / valorVenta * 100).clamp(0, 100)
                      : null,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

double _kpiDouble(Map<String, String> kpis, String key) {
  return double.tryParse(kpis[key] ?? '0') ?? 0;
}

double? _calcCambio(double actual, double anterior) {
  if (anterior <= 0) return null;
  return ((actual - anterior) / anterior * 100);
}

String _trendStr(double actual, double anterior) {
  if (anterior <= 0) return '';
  final pct = ((actual - anterior) / anterior * 100);
  final sign = pct >= 0 ? '+' : '';
  return '$sign${pct.toStringAsFixed(1)}%';
}

String _calcCambioStr(double actual, double anterior) {
  if (anterior <= 0) return 'N/A';
  final pct = ((actual - anterior) / anterior * 100);
  final sign = pct >= 0 ? '+' : '';
  return '$sign${pct.toStringAsFixed(1)}%';
}

List<double> _sparklineData(
  AsyncValue<List<KpiDiario>> asyncData,
  double Function(KpiDiario) extract,
) {
  return asyncData.maybeWhen(
    data: (data) => data.reversed.take(7).map(extract).toList(),
    orElse: () => <double>[],
  );
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
                SizedBox(height: 260, child: _MetodoPagoPieChart(metodos: data)),
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
                ...alertas.map((a) => Card(
                  margin: const EdgeInsets.only(bottom: AppSpacing.xs),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: Theme.of(context).colorScheme.errorContainer,
                            child: Icon(Icons.warning, color: Theme.of(context).colorScheme.onErrorContainer, size: 20),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(a.producto, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600), maxLines: 1, overflow: TextOverflow.ellipsis),
                                const SizedBox(height: 2),
                                Text(a.categoria, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant), maxLines: 1, overflow: TextOverflow.ellipsis),
                              ],
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const StockBadge('REPONER'),
                              Text('Stock: ${a.stockActual} / Mín: ${a.stockMinimo}', style: Theme.of(context).textTheme.labelSmall),
                              Text('Faltante: ${a.faltante.toStringAsFixed(0)}', style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Theme.of(context).colorScheme.error)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
              ],
            ),
          ),
        );
      },
      loading: () => SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(children: List.generate(3, (_) => const Padding(
            padding: EdgeInsets.only(bottom: AppSpacing.sm),
            child: ShimmerCard(height: 72),
          ))),
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
          LineChartBarData(spots: ingresosSpots, isCurved: true, color: theme.colorScheme.primary, barWidth: 2, dotData: const FlDotData(show: false), belowBarData: BarAreaData(show: true, color: theme.colorScheme.primary.withValues(alpha: 0.1))),
          LineChartBarData(spots: costosSpots, isCurved: true, color: theme.colorScheme.error, barWidth: 2, dotData: const FlDotData(show: false)),
          LineChartBarData(spots: gananciaSpots, isCurved: true, color: theme.colorScheme.tertiary, barWidth: 2, dotData: const FlDotData(show: false), belowBarData: BarAreaData(show: true, color: theme.colorScheme.tertiary.withValues(alpha: 0.1))),
        ],
        lineTouchData: LineTouchData(touchTooltipData: LineTouchTooltipData(getTooltipItems: (touchedSpots) {
          return touchedSpots.map((spot) {
            final label = switch (spot.barIndex) { 0 => 'Ingresos', 1 => 'Costos', _ => 'Ganancia' };
            return LineTooltipItem('$label\n\$ ${spot.y.toStringAsFixed(2)}', TextStyle(color: spot.barIndex == 0 ? theme.colorScheme.primary : spot.barIndex == 1 ? theme.colorScheme.error : theme.colorScheme.tertiary));
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
    final theme = Theme.of(context);
    final colors = [theme.colorScheme.primary, theme.colorScheme.tertiary, theme.colorScheme.secondary];
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
