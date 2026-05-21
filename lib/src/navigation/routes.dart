class AppRoutes {
  AppRoutes._();

  static const home = '/';
  static const productos = '/productos';
  static const productoNuevo = '/productos/nuevo';
  static const productoEditar = '/productos/:id/editar';
  static const ventas = '/ventas';
  static const ventaNueva = '/ventas/nueva';
  static const compras = '/compras';
  static const compraNueva = '/compras/nueva';
  static const reportes = '/reportes';
  static const ajustes = '/ajustes';
  static const categorias = '/categorias';
  static const proveedores = '/proveedores';

  static String productoDetalle(int id) => '/productos/$id';
  static String productoEditarRoute(int id) => '/productos/$id/editar';
  static String ventaDetalle(int id) => '/ventas/$id';
  static String compraDetalle(int id) => '/compras/$id';

  static const shellRoot = '/dashboard';
  static const productosTab = 'productos';
  static const ventasTab = 'ventas';
  static const comprasTab = 'compras';
  static const reportesTab = 'reportes';
}
