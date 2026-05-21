class AppConstants {
  AppConstants._();

  static const paymentMethods = ['efectivo', 'tarjeta', 'transferencia'];

  static const paymentMethodLabels = {
    'efectivo': 'Efectivo',
    'tarjeta': 'Tarjeta',
    'transferencia': 'Transferencia',
  };

  static const paymentMethodIcons = {
    'efectivo': 'payments',
    'tarjeta': 'credit_card',
    'transferencia': 'account_balance',
  };

  static const adjustmentTypes = ['entrada', 'salida'];

  static const adjustmentTypeLabels = {
    'entrada': 'Entrada',
    'salida': 'Salida',
  };

  static const adjustmentMotivos = [
    'conteo físico',
    'merma',
    'robo',
    'daño',
    'vencimiento',
    'devolución',
    'ajuste manual',
  ];

  static const stockStatusOk = 'OK';
  static const stockStatusReponer = 'REPONER';

  static const loteAgotado = 'AGOTADO';
  static const loteEnCurso = 'EN CURSO';
  static const loteLento = 'LENTO';

  static const kpiVentasHoy = 'Ventas hoy';
  static const kpiIngresosHoy = 'Ingresos hoy';
  static const kpiGananciaHoy = 'Ganancia bruta hoy';
  static const kpiIngresosMes = 'Ingresos este mes';
  static const kpiGananciaMes = 'Ganancia bruta este mes';
  static const kpiReponer = 'Productos a reponer';
  static const kpiValorCosto = 'Valor inventario (costo)';
  static const kpiValorVenta = 'Valor inventario (venta)';
}
