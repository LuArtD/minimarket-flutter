import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/database_provider.dart';
import '../../theme/formatters.dart';
import '../../theme/spacing.dart';
import '../shared/widgets/empty_state.dart';
import '../shared/widgets/error_banner.dart';
import '../shared/widgets/shimmer_loading.dart';

class ReportesScreen extends ConsumerStatefulWidget {
  const ReportesScreen({super.key});

  @override
  ConsumerState<ReportesScreen> createState() => _ReportesScreenState();
}

class _ReportesScreenState extends ConsumerState<ReportesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reportes'),
        bottom: TabBar(controller: _tabController, tabs: const [
          Tab(text: 'Diario', icon: Icon(Icons.today)),
          Tab(text: 'Semanal', icon: Icon(Icons.date_range)),
          Tab(text: 'Mensual', icon: Icon(Icons.calendar_month)),
          Tab(text: 'Análisis', icon: Icon(Icons.analytics)),
        ]),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _DiarioTabStream(),
          _SemanalTabStream(),
          _MensualTabStream(),
          _AnalisisTabStream(),
        ],
      ),
    );
  }
}

class _DiarioTabStream extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(kpiDiarioStreamProvider);
    return asyncData.when(
      data: (data) => _DiarioTab(data: data),
      loading: () => const ShimmerCard(height: 300),
      error: (e, _) => ErrorBanner(message: 'Error: $e', onRetry: () => ref.invalidate(kpiDiarioStreamProvider)),
    );
  }
}

class _SemanalTabStream extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(kpiSemanalStreamProvider);
    return asyncData.when(
      data: (data) => _SemanalTab(data: data),
      loading: () => const ShimmerCard(height: 300),
      error: (e, _) => ErrorBanner(message: 'Error: $e', onRetry: () => ref.invalidate(kpiSemanalStreamProvider)),
    );
  }
}

class _MensualTabStream extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(kpiMensualStreamProvider);
    return asyncData.when(
      data: (data) => _MensualTab(data: data),
      loading: () => const ShimmerCard(height: 300),
      error: (e, _) => ErrorBanner(message: 'Error: $e', onRetry: () => ref.invalidate(kpiMensualStreamProvider)),
    );
  }
}

class _AnalisisTabStream extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        _DiaSemanaSection(),
        const SizedBox(height: AppSpacing.xl),
        _HoraPicoSection(),
        const SizedBox(height: AppSpacing.xl),
        _CategoriaSection(),
        const SizedBox(height: AppSpacing.xl),
        _MargenSection(),
      ],
    );
  }
}

class _DiaSemanaSection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(kpiDiaSemanaStreamProvider);
    return asyncData.when(
      data: (data) {
        if (data.isEmpty) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Mejor día de la semana', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: AppSpacing.sm),
            SizedBox(height: 200, child: _DiaSemanaChart(data: data)),
          ],
        );
      },
      loading: () => const SizedBox(height: 200, child: ShimmerCard(height: 200)),
      error: (e, _) => SizedBox(height: 200, child: ErrorBanner(message: 'Error: $e', onRetry: () => ref.invalidate(kpiDiaSemanaStreamProvider))),
    );
  }
}

class _HoraPicoSection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(kpiHoraPicoStreamProvider);
    return asyncData.when(
      data: (data) {
        if (data.isEmpty) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hora pico', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: AppSpacing.sm),
            SizedBox(height: 200, child: _HoraPicoChart(data: data)),
          ],
        );
      },
      loading: () => const SizedBox(height: 200, child: ShimmerCard(height: 200)),
      error: (e, _) => SizedBox(height: 200, child: ErrorBanner(message: 'Error: $e', onRetry: () => ref.invalidate(kpiHoraPicoStreamProvider))),
    );
  }
}

class _CategoriaSection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(kpiPorCategoriaStreamProvider);
    return asyncData.when(
      data: (data) {
        if (data.isEmpty) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ventas por categoría', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: AppSpacing.sm),
            SizedBox(height: 200, child: _CategoriaPieChart(data: data)),
          ],
        );
      },
      loading: () => const SizedBox(height: 200, child: ShimmerCard(height: 200)),
      error: (e, _) => SizedBox(height: 200, child: ErrorBanner(message: 'Error: $e', onRetry: () => ref.invalidate(kpiPorCategoriaStreamProvider))),
    );
  }
}

class _MargenSection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(kpiMargenProductoStreamProvider);
    return asyncData.when(
      data: (data) {
        if (data.isEmpty) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Margen por producto (top 10)', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: AppSpacing.sm),
            ...data.take(10).map((p) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
                  child: Row(
                    children: [
                      Expanded(flex: 3, child: Text(p.producto)),
                      Expanded(flex: 2, child: LinearProgressIndicator(value: (p.margenPct / 100).clamp(0.0, 1.0), minHeight: 8, borderRadius: BorderRadius.circular(4))),
                      const SizedBox(width: 8),
                      Text('${p.margenPct.toStringAsFixed(1)}%', style: Theme.of(context).textTheme.labelSmall),
                    ],
                  ),
                )),
          ],
        );
      },
      loading: () => const ShimmerCard(height: 200),
      error: (e, _) => ErrorBanner(message: 'Error: $e', onRetry: () => ref.invalidate(kpiMargenProductoStreamProvider)),
    );
  }
}

class _DiarioTab extends StatelessWidget {
  final List<dynamic> data;
  const _DiarioTab({required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return const EmptyState(icon: Icons.bar_chart, title: 'Sin datos diarios');
    final theme = Theme.of(context);
    final spots = data.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value.gananciaBruta)).toList();

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Ganancia bruta diaria', style: theme.textTheme.titleMedium),
          const SizedBox(height: AppSpacing.lg),
          Expanded(
            child: LineChart(LineChartData(
              gridData: FlGridData(show: true, drawVerticalLine: false),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 50, getTitlesWidget: (v, _) => Text('\$ ${v.toInt()}', style: theme.textTheme.labelSmall?.copyWith(fontSize: 9)))),
                bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (v, _) {
                  final idx = v.toInt();
                  if (idx >= 0 && idx < data.length) {
                    final parts = data[idx].dia.toString().split('-');
                    if (parts.length >= 3) return Text('${parts[2]}/${parts[1]}', style: theme.textTheme.labelSmall?.copyWith(fontSize: 9));
                  }
                  return const SizedBox.shrink();
                })),
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              borderData: FlBorderData(show: false),
              lineBarsData: [LineChartBarData(spots: spots, isCurved: true, color: theme.colorScheme.primary, barWidth: 3, dotData: const FlDotData(show: true), belowBarData: BarAreaData(show: true, color: theme.colorScheme.primary.withValues(alpha: 0.1)))],
            )),
          ),
        ],
      ),
    );
  }
}

class _SemanalTab extends StatelessWidget {
  final List<dynamic> data;
  const _SemanalTab({required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return const EmptyState(icon: Icons.bar_chart, title: 'Sin datos semanales');
    final theme = Theme.of(context);
    final groups = List<BarChartGroupData>.generate(data.length, (i) => BarChartGroupData(x: i, barRods: [BarChartRodData(toY: data[i].gananciaBruta, color: theme.colorScheme.primary, width: 20, borderRadius: const BorderRadius.vertical(top: Radius.circular(4)))]));

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        children: [
          Text('Ganancia semanal', style: theme.textTheme.titleMedium),
          const SizedBox(height: AppSpacing.lg),
          Expanded(
            child: BarChart(BarChartData(
              alignment: BarChartAlignment.spaceAround,
              gridData: const FlGridData(show: true, drawVerticalLine: false),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 50, getTitlesWidget: (v, _) => Text('\$ ${v.toInt()}', style: theme.textTheme.labelSmall?.copyWith(fontSize: 9)))),
                bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (v, _) {
                  final idx = v.toInt();
                  if (idx >= 0 && idx < data.length) return Text(data[idx].semana.toString().substring(2), style: theme.textTheme.labelSmall?.copyWith(fontSize: 8));
                  return const SizedBox.shrink();
                })),
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              borderData: FlBorderData(show: false),
              barGroups: groups,
            )),
          ),
        ],
      ),
    );
  }
}

class _MensualTab extends StatelessWidget {
  final List<dynamic> data;
  const _MensualTab({required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return const EmptyState(icon: Icons.calendar_month, title: 'Sin datos mensuales');
    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.lg),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final mes = data[index];
        return Card(
          margin: const EdgeInsets.only(bottom: AppSpacing.sm),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(AppFormatters.formatMonth(mes.mes), style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: AppSpacing.sm),
              _DataRow(label: 'Ventas', value: mes.numVentas.toString()),
              _DataRow(label: 'Ingresos', value: AppFormatters.formatCurrency(mes.ingresos)),
              _DataRow(label: 'Costos', value: AppFormatters.formatCurrency(mes.costos)),
              _DataRow(label: 'Ganancia', value: AppFormatters.formatCurrency(mes.gananciaBruta), bold: true),
              const Divider(),
              Text('Por método de pago:', style: Theme.of(context).textTheme.labelMedium),
              const SizedBox(height: AppSpacing.xs),
              _DataRow(label: 'Efectivo', value: AppFormatters.formatCurrency(mes.totalEfectivo)),
              _DataRow(label: 'Tarjeta', value: AppFormatters.formatCurrency(mes.totalTarjeta)),
              _DataRow(label: 'Transferencia', value: AppFormatters.formatCurrency(mes.totalTransferencia)),
            ]),
          ),
        );
      },
    );
  }
}

class _DiaSemanaChart extends StatelessWidget {
  final List<dynamic> data;
  const _DiaSemanaChart({required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final groups = List<BarChartGroupData>.generate(data.length, (i) => BarChartGroupData(x: i, barRods: [BarChartRodData(toY: data[i].ingresosTotal, color: theme.colorScheme.primary, width: 16, borderRadius: const BorderRadius.vertical(top: Radius.circular(4)))]));

    return BarChart(BarChartData(
      alignment: BarChartAlignment.spaceAround,
      gridData: FlGridData(show: true, drawVerticalLine: false, getDrawingHorizontalLine: (_) => FlLine(color: theme.colorScheme.outlineVariant, strokeWidth: 1)),
      titlesData: FlTitlesData(
        bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (v, _) {
          final idx = v.toInt();
          if (idx >= 0 && idx < data.length) return Text(data[idx].diaSemana.toString().substring(0, 3), style: theme.textTheme.labelSmall?.copyWith(fontSize: 9));
          return const SizedBox.shrink();
        })),
        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 40, getTitlesWidget: (v, _) => Text('\$${v.toInt()}', style: theme.textTheme.labelSmall?.copyWith(fontSize: 9)))),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      borderData: FlBorderData(show: false),
      barGroups: groups,
    ));
  }
}

class _HoraPicoChart extends StatelessWidget {
  final List<dynamic> data;
  const _HoraPicoChart({required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BarChart(BarChartData(
      alignment: BarChartAlignment.spaceAround,
      gridData: FlGridData(show: true, drawVerticalLine: false, getDrawingHorizontalLine: (_) => FlLine(color: theme.colorScheme.outlineVariant, strokeWidth: 1)),
      titlesData: FlTitlesData(
        bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (v, _) => Text('${v.toInt()}h', style: theme.textTheme.labelSmall?.copyWith(fontSize: 9)))),
        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 30, getTitlesWidget: (v, _) => Text('${v.toInt()}', style: theme.textTheme.labelSmall?.copyWith(fontSize: 9)))),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      borderData: FlBorderData(show: false),
      barGroups: data.take(12).map((d) => BarChartGroupData(x: int.parse(d.hora), barRods: [BarChartRodData(toY: d.numVentas.toDouble(), color: theme.colorScheme.tertiary, width: 12, borderRadius: const BorderRadius.vertical(top: Radius.circular(4)))])).toList(),
    ));
  }
}

class _CategoriaPieChart extends StatelessWidget {
  final List<dynamic> data;
  const _CategoriaPieChart({required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = [theme.colorScheme.primary, theme.colorScheme.tertiary, theme.colorScheme.secondary, theme.colorScheme.primaryContainer, theme.colorScheme.tertiaryContainer, theme.colorScheme.secondaryContainer];
    final sections = data.asMap().entries.map((e) => PieChartSectionData(
      value: e.value.ingresos,
      title: e.value.categoria.toString().length > 10 ? '${e.value.categoria.toString().substring(0, 10)}...' : e.value.categoria.toString(),
      color: colors[e.key % colors.length],
      radius: 70,
      titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
    )).toList();

    return PieChart(PieChartData(sections: sections, centerSpaceRadius: 30, sectionsSpace: 2));
  }
}

class _DataRow extends StatelessWidget {
  final String label;
  final String value;
  final bool bold;
  const _DataRow({required this.label, required this.value, this.bold = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
        Text(value, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: bold ? FontWeight.w700 : null, color: bold ? Theme.of(context).colorScheme.primary : null)),
      ]),
    );
  }
}
