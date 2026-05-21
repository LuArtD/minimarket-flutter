import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'app_database.g.dart';

String _nowLocal() {
  final n = DateTime.now();
  return '${n.year}-${n.month.toString().padLeft(2, '0')}-${n.day.toString().padLeft(2, '0')} ${n.hour.toString().padLeft(2, '0')}:${n.minute.toString().padLeft(2, '0')}:${n.second.toString().padLeft(2, '0')}';
}

class Categorias extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text().withLength(min: 1, max: 100).unique()();
  TextColumn get descripcion => text().nullable()();
  IntColumn get activa => integer().withDefault(const Constant(1))();
  TextColumn get creadoEn => text().clientDefault(() => _nowLocal())();
}

class Proveedores extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text().withLength(min: 1, max: 100).unique()();
  TextColumn get contacto => text().nullable()();
  TextColumn get telefono => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get direccion => text().nullable()();
  IntColumn get activo => integer().withDefault(const Constant(1))();
  TextColumn get creadoEn => text().clientDefault(() => _nowLocal())();
}

class Productos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text().withLength(min: 1, max: 100).unique()();
  TextColumn get descripcion => text().nullable()();
  IntColumn get categoriaId => integer().references(Categorias, #id)();
  RealColumn get precioVenta => real().withDefault(const Constant(0.0))();
  RealColumn get margenGananciaPct => real().withDefault(const Constant(0.0))();
  RealColumn get stockMinimo => real().withDefault(const Constant(0.0))();
  RealColumn get stockActual => real().withDefault(const Constant(0.0))();
  IntColumn get activo => integer().withDefault(const Constant(1))();
  TextColumn get creadoEn => text().clientDefault(() => _nowLocal())();
  TextColumn get actualizadoEn => text().clientDefault(() => _nowLocal())();
}

class Compras extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get proveedorId => integer().references(Proveedores, #id)();
  TextColumn get fecha => text().clientDefault(() => _nowLocal())();
  TextColumn get nroFactura => text().nullable()();
  TextColumn get observaciones => text().nullable()();
  RealColumn get total => real().withDefault(const Constant(0.0))();
  TextColumn get creadoEn => text().clientDefault(() => _nowLocal())();
}

class CompraDetalles extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get compraId => integer().references(Compras, #id)();
  IntColumn get productoId => integer().references(Productos, #id)();
  RealColumn get cantidad => real()();
  RealColumn get cantidadRestante => real()();
  RealColumn get precioCosto => real()();
  RealColumn get precioVentaLote => real().withDefault(const Constant(0.0))();
  TextColumn get creadoEn => text().clientDefault(() => _nowLocal())();
}

class Ventas extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get fecha => text().clientDefault(() => _nowLocal())();
  TextColumn get metodoPago => text().withDefault(const Constant('efectivo'))();
  RealColumn get total => real().withDefault(const Constant(0.0))();
  RealColumn get costoTotal => real().withDefault(const Constant(0.0))();
  TextColumn get observaciones => text().nullable()();
  TextColumn get creadoEn => text().clientDefault(() => _nowLocal())();
}

class VentaDetalles extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get ventaId => integer().references(Ventas, #id)();
  IntColumn get productoId => integer().references(Productos, #id)();
  IntColumn get loteId => integer().references(CompraDetalles, #id)();
  RealColumn get cantidad => real()();
  RealColumn get precioVenta => real()();
  RealColumn get precioCosto => real()();
  TextColumn get creadoEn => text().clientDefault(() => _nowLocal())();
}

class AjustesInventario extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productoId => integer().references(Productos, #id)();
  TextColumn get fecha => text().clientDefault(() => _nowLocal())();
  TextColumn get tipo => text()();
  RealColumn get cantidad => real()();
  TextColumn get motivo => text()();
  RealColumn get stockAntes => real()();
  RealColumn get stockDespues => real()();
  TextColumn get creadoEn => text().clientDefault(() => _nowLocal())();
}

class HistorialMargenes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productoId => integer().references(Productos, #id)();
  RealColumn get margenAnterior => real()();
  RealColumn get margenNuevo => real()();
  RealColumn get precioVentaAnterior => real()();
  RealColumn get precioVentaNuevo => real()();
  TextColumn get motivo => text().nullable()();
  TextColumn get fecha => text().clientDefault(() => _nowLocal())();
}

@DriftDatabase(tables: [
  Categorias,
  Proveedores,
  Productos,
  Compras,
  CompraDetalles,
  Ventas,
  VentaDetalles,
  AjustesInventario,
  HistorialMargenes,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');

        if (details.wasCreated) {
          await _runSeedScript();
        } else {
          await _runMigrations();
        }
      },
    );
  }

  Future<void> _runMigrations() async {
    await customStatement("UPDATE ventas SET fecha = REPLACE(REPLACE(SUBSTR(fecha, 1, 19), 'T', ' '), 'Z', '') WHERE fecha LIKE '%T%'");
    await customStatement("UPDATE compras SET fecha = REPLACE(REPLACE(SUBSTR(fecha, 1, 19), 'T', ' '), 'Z', '') WHERE fecha LIKE '%T%'");
    await customStatement("UPDATE venta_detalles SET creado_en = REPLACE(REPLACE(SUBSTR(creado_en, 1, 19), 'T', ' '), 'Z', '') WHERE creado_en LIKE '%T%'");

    final nowLocal = _nowLocal();
    for (final entry in [
      'UPDATE categorias SET creado_en = \'$nowLocal\' WHERE creado_en = \'CURRENT_TIMESTAMP\'',
      'UPDATE proveedores SET creado_en = \'$nowLocal\' WHERE creado_en = \'CURRENT_TIMESTAMP\'',
      'UPDATE productos SET creado_en = \'$nowLocal\', actualizado_en = \'$nowLocal\' WHERE creado_en = \'CURRENT_TIMESTAMP\'',
      'UPDATE compras SET fecha = \'$nowLocal\', creado_en = \'$nowLocal\' WHERE fecha = \'CURRENT_TIMESTAMP\'',
      'UPDATE compra_detalles SET creado_en = \'$nowLocal\' WHERE creado_en = \'CURRENT_TIMESTAMP\'',
      'UPDATE ventas SET fecha = \'$nowLocal\', creado_en = \'$nowLocal\' WHERE fecha = \'CURRENT_TIMESTAMP\'',
      'UPDATE venta_detalles SET creado_en = \'$nowLocal\' WHERE creado_en = \'CURRENT_TIMESTAMP\'',
      'UPDATE ajustes_inventario SET fecha = \'$nowLocal\', creado_en = \'$nowLocal\' WHERE fecha = \'CURRENT_TIMESTAMP\'',
      'UPDATE historial_margenes SET fecha = \'$nowLocal\' WHERE fecha = \'CURRENT_TIMESTAMP\'',
    ]) {
      await customStatement(entry);
    }

    await customStatement('DROP TRIGGER IF EXISTS trg_margen_update');
    await customStatement('''
      CREATE TRIGGER IF NOT EXISTS trg_margen_update
      AFTER UPDATE OF margen_ganancia_pct ON productos
      WHEN NEW.margen_ganancia_pct != OLD.margen_ganancia_pct
      BEGIN
          INSERT INTO historial_margenes (
              producto_id, margen_anterior, margen_nuevo,
              precio_venta_anterior, precio_venta_nuevo,
              fecha
          )
          VALUES (
              NEW.id,
              OLD.margen_ganancia_pct,
              NEW.margen_ganancia_pct,
              OLD.precio_venta,
              COALESCE((
                  SELECT ROUND(MAX(cd.precio_costo * (1.0 + NEW.margen_ganancia_pct / 100.0)), 2)
                    FROM compra_detalles cd
                   WHERE cd.producto_id = NEW.id
                     AND cd.cantidad_restante > 0
              ), 0),
              datetime('now','localtime')
          );
          UPDATE compra_detalles
             SET precio_venta_lote = ROUND(precio_costo * (1.0 + NEW.margen_ganancia_pct / 100.0), 2)
           WHERE producto_id = NEW.id
             AND cantidad_restante > 0;
          UPDATE productos
             SET precio_venta   = COALESCE((
                     SELECT ROUND(MAX(cd.precio_costo * (1.0 + NEW.margen_ganancia_pct / 100.0)), 2)
                       FROM compra_detalles cd
                      WHERE cd.producto_id = NEW.id
                        AND cd.cantidad_restante > 0
                 ), 0),
                 actualizado_en = datetime('now','localtime')
           WHERE id = NEW.id;
      END
    ''');

    final sql = await rootBundle.loadString('docs/minimarket.sql');
    final statements = _parseSqlStatements(sql);

    final viewNames = <String>[];
    for (final statement in statements) {
      final trimmed = statement.trim();
      if (trimmed.toUpperCase().startsWith('CREATE VIEW')) {
        final viewName = RegExp(r'CREATE VIEW (?:IF NOT EXISTS )?(\w+)', caseSensitive: false).firstMatch(trimmed)?.group(1);
        if (viewName != null) {
          viewNames.add(viewName);
          try {
            await customStatement('DROP VIEW IF EXISTS $viewName');
          } catch (e) {
            print('Error dropping view $viewName: $e');
          }
        }
      }
    }

    var createdCount = 0;
    for (final statement in statements) {
      final trimmed = statement.trim();
      if (trimmed.toUpperCase().startsWith('CREATE VIEW')) {
        try {
          await customStatement(trimmed);
          createdCount++;
        } catch (e) {
          print('Error creating view: $e');
          print('Statement: $trimmed');
        }
      }
    }
    print('Migration: dropped ${viewNames.length} views, created $createdCount views');
  }

  Future<void> _runSeedScript() async {
    final sql = await rootBundle.loadString('docs/minimarket.sql');
    final statements = _parseSqlStatements(sql);

    for (final statement in statements) {
      final trimmed = statement.trim();
      if (trimmed.isEmpty) continue;
      if (trimmed.toUpperCase().startsWith('PRAGMA')) continue;
      try {
        await customStatement(trimmed);
      } catch (e) {
        // ignore: avoid_print
        print('Error executing SQL: $e\nStatement: $trimmed');
      }
    }
  }

  List<String> _parseSqlStatements(String sql) {
    // Remove single-line comments (-- ...)
    final withoutLineComments = sql.replaceAll(RegExp(r'--[^\n]*'), '');
    // Remove multi-line comments (/* ... */)
    final withoutComments = withoutLineComments.replaceAll(RegExp(r'/\*[\s\S]*?\*/'), '');

    final result = <String>[];
    final buffer = StringBuffer();
    var inTrigger = false;

    for (final line in withoutComments.split('\n')) {
      final trimmed = line.trim();
      if (trimmed.isEmpty) continue;

      if (trimmed.toUpperCase().startsWith('CREATE TRIGGER') ||
          trimmed.toUpperCase().startsWith('END;')) {
        if (inTrigger) {
          buffer.writeln(line);
          final stmt = buffer.toString().trim();
          if (stmt.isNotEmpty) result.add(stmt);
          buffer.clear();
          inTrigger = false;
        } else if (trimmed.toUpperCase().startsWith('CREATE TRIGGER')) {
          inTrigger = true;
          buffer.writeln(line);
        } else {
          // Standalone END; or other statement
          if (trimmed == 'END;') {
            // Should not happen if parsing is correct, but handle gracefully
            continue;
          }
          final stmt = '$buffer\n$line'.trim();
          if (stmt.isNotEmpty && stmt != ';') result.add(stmt);
          buffer.clear();
        }
      } else if (inTrigger) {
        buffer.writeln(line);
      } else {
        if (trimmed.endsWith(';')) {
          buffer.writeln(trimmed.substring(0, trimmed.length - 1));
          final stmt = buffer.toString().trim();
          if (stmt.isNotEmpty && stmt != ';') result.add(stmt);
          buffer.clear();
        } else {
          buffer.writeln(line);
        }
      }
    }

    // Handle any remaining content
    final remaining = buffer.toString().trim();
    if (remaining.isNotEmpty && remaining != ';') {
      result.add(remaining);
    }

    return result;
  }

  static Future<AppDatabase> construct() async {
    final dbPath = await getApplicationDocumentsDirectory();
    final dbFile = File(p.join(dbPath.path, 'minimarket.db'));

    await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();

    return AppDatabase(NativeDatabase.createInBackground(dbFile));
  }
}
