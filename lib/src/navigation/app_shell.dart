import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_router.dart';

class AppShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const AppShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _onDestinationSelected,
        destinations: AppDestinations.items,
      ),
      floatingActionButton: _buildFab(context),
    );
  }

  void _onDestinationSelected(int index) {
    navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex);
  }

  Widget? _buildFab(BuildContext context) {
    return switch (navigationShell.currentIndex) {
      1 => FloatingActionButton(
          heroTag: 'fab_productos',
          onPressed: () => context.push('/productos/nuevo'),
          child: const Icon(Icons.add),
        ),
      2 => FloatingActionButton(
          heroTag: 'fab_ventas',
          onPressed: () => context.push('/ventas/nueva'),
          child: const Icon(Icons.add),
        ),
      3 => FloatingActionButton(
          heroTag: 'fab_compras',
          onPressed: () => context.push('/compras/nueva'),
          child: const Icon(Icons.add),
        ),
      _ => null,
    };
  }
}
