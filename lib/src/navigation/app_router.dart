import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../ui/ajustes/ajustes_screen.dart';
import '../ui/categorias/categorias_screen.dart';
import '../ui/compras/compra_detalle_screen.dart';
import '../ui/compras/compra_form_screen.dart';
import '../ui/compras/compras_screen.dart';
import '../ui/dashboard/dashboard_screen.dart';
import '../ui/productos/producto_detalle_screen.dart';
import '../ui/productos/producto_form_screen.dart';
import '../ui/productos/productos_screen.dart';
import '../ui/proveedores/proveedores_screen.dart';
import '../ui/reportes/reportes_screen.dart';
import '../ui/ventas/venta_detalle_screen.dart';
import '../ui/ventas/venta_form_screen.dart';
import '../ui/ventas/ventas_screen.dart';
import 'app_shell.dart';
import 'routes.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter createRouter() {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.shellRoot,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.shellRoot,
                builder: (context, state) => const DashboardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.productos,
                builder: (context, state) => const ProductosScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.ventas,
                builder: (context, state) => const VentasScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.compras,
                builder: (context, state) => const ComprasScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.reportes,
                builder: (context, state) => const ReportesScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.ajustes,
        builder: (context, state) => const AjustesScreen(),
      ),
      GoRoute(
        path: '/productos/nuevo',
        builder: (context, state) => const ProductoFormScreen(),
      ),
      GoRoute(
        path: '/productos/:id/editar',
        builder: (context, state) => ProductoFormScreen(
          productoId: int.tryParse(state.pathParameters['id'] ?? '0'),
        ),
      ),
      GoRoute(
        path: '/ventas/nueva',
        builder: (context, state) => const VentaFormScreen(),
      ),
      GoRoute(
        path: '/compras/nueva',
        builder: (context, state) => const CompraFormScreen(),
      ),
      GoRoute(
        path: AppRoutes.categorias,
        builder: (context, state) => const CategoriasScreen(),
      ),
      GoRoute(
        path: AppRoutes.proveedores,
        builder: (context, state) => const ProveedoresScreen(),
      ),
      GoRoute(
        path: '/productos/:id',
        builder: (context, state) => ProductoDetalleScreen(
          productoId: int.tryParse(state.pathParameters['id'] ?? '0') ?? 0,
        ),
      ),
      GoRoute(
        path: '/ventas/:id',
        builder: (context, state) => VentaDetalleScreen(
          ventaId: int.tryParse(state.pathParameters['id'] ?? '0') ?? 0,
        ),
      ),
      GoRoute(
        path: '/compras/:id',
        builder: (context, state) => CompraDetalleScreen(
          compraId: int.tryParse(state.pathParameters['id'] ?? '0') ?? 0,
        ),
      ),
    ],
  );
}

class AppDestinations {
  static const List<NavigationDestination> items = [
    NavigationDestination(
      icon: Icon(Icons.dashboard_outlined),
      selectedIcon: Icon(Icons.dashboard),
      label: 'Dashboard',
    ),
    NavigationDestination(
      icon: Icon(Icons.inventory_2_outlined),
      selectedIcon: Icon(Icons.inventory_2),
      label: 'Productos',
    ),
    NavigationDestination(
      icon: Icon(Icons.point_of_sale_outlined),
      selectedIcon: Icon(Icons.point_of_sale),
      label: 'Ventas',
    ),
    NavigationDestination(
      icon: Icon(Icons.shopping_cart_outlined),
      selectedIcon: Icon(Icons.shopping_cart),
      label: 'Compras',
    ),
    NavigationDestination(
      icon: Icon(Icons.bar_chart_outlined),
      selectedIcon: Icon(Icons.bar_chart),
      label: 'Reportes',
    ),
  ];
}
