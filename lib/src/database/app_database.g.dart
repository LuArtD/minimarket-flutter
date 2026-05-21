// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CategoriasTable extends Categorias
    with TableInfo<$CategoriasTable, Categoria> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _descripcionMeta = const VerificationMeta(
    'descripcion',
  );
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
    'descripcion',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _activaMeta = const VerificationMeta('activa');
  @override
  late final GeneratedColumn<int> activa = GeneratedColumn<int>(
    'activa',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _creadoEnMeta = const VerificationMeta(
    'creadoEn',
  );
  @override
  late final GeneratedColumn<String> creadoEn = GeneratedColumn<String>(
    'creado_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => _nowLocal(),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nombre,
    descripcion,
    activa,
    creadoEn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categorias';
  @override
  VerificationContext validateIntegrity(
    Insertable<Categoria> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('descripcion')) {
      context.handle(
        _descripcionMeta,
        descripcion.isAcceptableOrUnknown(
          data['descripcion']!,
          _descripcionMeta,
        ),
      );
    }
    if (data.containsKey('activa')) {
      context.handle(
        _activaMeta,
        activa.isAcceptableOrUnknown(data['activa']!, _activaMeta),
      );
    }
    if (data.containsKey('creado_en')) {
      context.handle(
        _creadoEnMeta,
        creadoEn.isAcceptableOrUnknown(data['creado_en']!, _creadoEnMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Categoria map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Categoria(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      descripcion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}descripcion'],
      ),
      activa: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}activa'],
      )!,
      creadoEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}creado_en'],
      )!,
    );
  }

  @override
  $CategoriasTable createAlias(String alias) {
    return $CategoriasTable(attachedDatabase, alias);
  }
}

class Categoria extends DataClass implements Insertable<Categoria> {
  final int id;
  final String nombre;
  final String? descripcion;
  final int activa;
  final String creadoEn;
  const Categoria({
    required this.id,
    required this.nombre,
    this.descripcion,
    required this.activa,
    required this.creadoEn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    if (!nullToAbsent || descripcion != null) {
      map['descripcion'] = Variable<String>(descripcion);
    }
    map['activa'] = Variable<int>(activa);
    map['creado_en'] = Variable<String>(creadoEn);
    return map;
  }

  CategoriasCompanion toCompanion(bool nullToAbsent) {
    return CategoriasCompanion(
      id: Value(id),
      nombre: Value(nombre),
      descripcion: descripcion == null && nullToAbsent
          ? const Value.absent()
          : Value(descripcion),
      activa: Value(activa),
      creadoEn: Value(creadoEn),
    );
  }

  factory Categoria.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Categoria(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      descripcion: serializer.fromJson<String?>(json['descripcion']),
      activa: serializer.fromJson<int>(json['activa']),
      creadoEn: serializer.fromJson<String>(json['creadoEn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'descripcion': serializer.toJson<String?>(descripcion),
      'activa': serializer.toJson<int>(activa),
      'creadoEn': serializer.toJson<String>(creadoEn),
    };
  }

  Categoria copyWith({
    int? id,
    String? nombre,
    Value<String?> descripcion = const Value.absent(),
    int? activa,
    String? creadoEn,
  }) => Categoria(
    id: id ?? this.id,
    nombre: nombre ?? this.nombre,
    descripcion: descripcion.present ? descripcion.value : this.descripcion,
    activa: activa ?? this.activa,
    creadoEn: creadoEn ?? this.creadoEn,
  );
  Categoria copyWithCompanion(CategoriasCompanion data) {
    return Categoria(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      descripcion: data.descripcion.present
          ? data.descripcion.value
          : this.descripcion,
      activa: data.activa.present ? data.activa.value : this.activa,
      creadoEn: data.creadoEn.present ? data.creadoEn.value : this.creadoEn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Categoria(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('descripcion: $descripcion, ')
          ..write('activa: $activa, ')
          ..write('creadoEn: $creadoEn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nombre, descripcion, activa, creadoEn);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Categoria &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.descripcion == this.descripcion &&
          other.activa == this.activa &&
          other.creadoEn == this.creadoEn);
}

class CategoriasCompanion extends UpdateCompanion<Categoria> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<String?> descripcion;
  final Value<int> activa;
  final Value<String> creadoEn;
  const CategoriasCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.activa = const Value.absent(),
    this.creadoEn = const Value.absent(),
  });
  CategoriasCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
    this.descripcion = const Value.absent(),
    this.activa = const Value.absent(),
    this.creadoEn = const Value.absent(),
  }) : nombre = Value(nombre);
  static Insertable<Categoria> custom({
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<String>? descripcion,
    Expression<int>? activa,
    Expression<String>? creadoEn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (descripcion != null) 'descripcion': descripcion,
      if (activa != null) 'activa': activa,
      if (creadoEn != null) 'creado_en': creadoEn,
    });
  }

  CategoriasCompanion copyWith({
    Value<int>? id,
    Value<String>? nombre,
    Value<String?>? descripcion,
    Value<int>? activa,
    Value<String>? creadoEn,
  }) {
    return CategoriasCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      descripcion: descripcion ?? this.descripcion,
      activa: activa ?? this.activa,
      creadoEn: creadoEn ?? this.creadoEn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (activa.present) {
      map['activa'] = Variable<int>(activa.value);
    }
    if (creadoEn.present) {
      map['creado_en'] = Variable<String>(creadoEn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriasCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('descripcion: $descripcion, ')
          ..write('activa: $activa, ')
          ..write('creadoEn: $creadoEn')
          ..write(')'))
        .toString();
  }
}

class $ProveedoresTable extends Proveedores
    with TableInfo<$ProveedoresTable, Proveedore> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProveedoresTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _contactoMeta = const VerificationMeta(
    'contacto',
  );
  @override
  late final GeneratedColumn<String> contacto = GeneratedColumn<String>(
    'contacto',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _telefonoMeta = const VerificationMeta(
    'telefono',
  );
  @override
  late final GeneratedColumn<String> telefono = GeneratedColumn<String>(
    'telefono',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _direccionMeta = const VerificationMeta(
    'direccion',
  );
  @override
  late final GeneratedColumn<String> direccion = GeneratedColumn<String>(
    'direccion',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _activoMeta = const VerificationMeta('activo');
  @override
  late final GeneratedColumn<int> activo = GeneratedColumn<int>(
    'activo',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _creadoEnMeta = const VerificationMeta(
    'creadoEn',
  );
  @override
  late final GeneratedColumn<String> creadoEn = GeneratedColumn<String>(
    'creado_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => _nowLocal(),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nombre,
    contacto,
    telefono,
    email,
    direccion,
    activo,
    creadoEn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'proveedores';
  @override
  VerificationContext validateIntegrity(
    Insertable<Proveedore> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('contacto')) {
      context.handle(
        _contactoMeta,
        contacto.isAcceptableOrUnknown(data['contacto']!, _contactoMeta),
      );
    }
    if (data.containsKey('telefono')) {
      context.handle(
        _telefonoMeta,
        telefono.isAcceptableOrUnknown(data['telefono']!, _telefonoMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('direccion')) {
      context.handle(
        _direccionMeta,
        direccion.isAcceptableOrUnknown(data['direccion']!, _direccionMeta),
      );
    }
    if (data.containsKey('activo')) {
      context.handle(
        _activoMeta,
        activo.isAcceptableOrUnknown(data['activo']!, _activoMeta),
      );
    }
    if (data.containsKey('creado_en')) {
      context.handle(
        _creadoEnMeta,
        creadoEn.isAcceptableOrUnknown(data['creado_en']!, _creadoEnMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Proveedore map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Proveedore(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      contacto: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contacto'],
      ),
      telefono: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}telefono'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      direccion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}direccion'],
      ),
      activo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}activo'],
      )!,
      creadoEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}creado_en'],
      )!,
    );
  }

  @override
  $ProveedoresTable createAlias(String alias) {
    return $ProveedoresTable(attachedDatabase, alias);
  }
}

class Proveedore extends DataClass implements Insertable<Proveedore> {
  final int id;
  final String nombre;
  final String? contacto;
  final String? telefono;
  final String? email;
  final String? direccion;
  final int activo;
  final String creadoEn;
  const Proveedore({
    required this.id,
    required this.nombre,
    this.contacto,
    this.telefono,
    this.email,
    this.direccion,
    required this.activo,
    required this.creadoEn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    if (!nullToAbsent || contacto != null) {
      map['contacto'] = Variable<String>(contacto);
    }
    if (!nullToAbsent || telefono != null) {
      map['telefono'] = Variable<String>(telefono);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || direccion != null) {
      map['direccion'] = Variable<String>(direccion);
    }
    map['activo'] = Variable<int>(activo);
    map['creado_en'] = Variable<String>(creadoEn);
    return map;
  }

  ProveedoresCompanion toCompanion(bool nullToAbsent) {
    return ProveedoresCompanion(
      id: Value(id),
      nombre: Value(nombre),
      contacto: contacto == null && nullToAbsent
          ? const Value.absent()
          : Value(contacto),
      telefono: telefono == null && nullToAbsent
          ? const Value.absent()
          : Value(telefono),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      direccion: direccion == null && nullToAbsent
          ? const Value.absent()
          : Value(direccion),
      activo: Value(activo),
      creadoEn: Value(creadoEn),
    );
  }

  factory Proveedore.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Proveedore(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      contacto: serializer.fromJson<String?>(json['contacto']),
      telefono: serializer.fromJson<String?>(json['telefono']),
      email: serializer.fromJson<String?>(json['email']),
      direccion: serializer.fromJson<String?>(json['direccion']),
      activo: serializer.fromJson<int>(json['activo']),
      creadoEn: serializer.fromJson<String>(json['creadoEn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'contacto': serializer.toJson<String?>(contacto),
      'telefono': serializer.toJson<String?>(telefono),
      'email': serializer.toJson<String?>(email),
      'direccion': serializer.toJson<String?>(direccion),
      'activo': serializer.toJson<int>(activo),
      'creadoEn': serializer.toJson<String>(creadoEn),
    };
  }

  Proveedore copyWith({
    int? id,
    String? nombre,
    Value<String?> contacto = const Value.absent(),
    Value<String?> telefono = const Value.absent(),
    Value<String?> email = const Value.absent(),
    Value<String?> direccion = const Value.absent(),
    int? activo,
    String? creadoEn,
  }) => Proveedore(
    id: id ?? this.id,
    nombre: nombre ?? this.nombre,
    contacto: contacto.present ? contacto.value : this.contacto,
    telefono: telefono.present ? telefono.value : this.telefono,
    email: email.present ? email.value : this.email,
    direccion: direccion.present ? direccion.value : this.direccion,
    activo: activo ?? this.activo,
    creadoEn: creadoEn ?? this.creadoEn,
  );
  Proveedore copyWithCompanion(ProveedoresCompanion data) {
    return Proveedore(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      contacto: data.contacto.present ? data.contacto.value : this.contacto,
      telefono: data.telefono.present ? data.telefono.value : this.telefono,
      email: data.email.present ? data.email.value : this.email,
      direccion: data.direccion.present ? data.direccion.value : this.direccion,
      activo: data.activo.present ? data.activo.value : this.activo,
      creadoEn: data.creadoEn.present ? data.creadoEn.value : this.creadoEn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Proveedore(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('contacto: $contacto, ')
          ..write('telefono: $telefono, ')
          ..write('email: $email, ')
          ..write('direccion: $direccion, ')
          ..write('activo: $activo, ')
          ..write('creadoEn: $creadoEn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    nombre,
    contacto,
    telefono,
    email,
    direccion,
    activo,
    creadoEn,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Proveedore &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.contacto == this.contacto &&
          other.telefono == this.telefono &&
          other.email == this.email &&
          other.direccion == this.direccion &&
          other.activo == this.activo &&
          other.creadoEn == this.creadoEn);
}

class ProveedoresCompanion extends UpdateCompanion<Proveedore> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<String?> contacto;
  final Value<String?> telefono;
  final Value<String?> email;
  final Value<String?> direccion;
  final Value<int> activo;
  final Value<String> creadoEn;
  const ProveedoresCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.contacto = const Value.absent(),
    this.telefono = const Value.absent(),
    this.email = const Value.absent(),
    this.direccion = const Value.absent(),
    this.activo = const Value.absent(),
    this.creadoEn = const Value.absent(),
  });
  ProveedoresCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
    this.contacto = const Value.absent(),
    this.telefono = const Value.absent(),
    this.email = const Value.absent(),
    this.direccion = const Value.absent(),
    this.activo = const Value.absent(),
    this.creadoEn = const Value.absent(),
  }) : nombre = Value(nombre);
  static Insertable<Proveedore> custom({
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<String>? contacto,
    Expression<String>? telefono,
    Expression<String>? email,
    Expression<String>? direccion,
    Expression<int>? activo,
    Expression<String>? creadoEn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (contacto != null) 'contacto': contacto,
      if (telefono != null) 'telefono': telefono,
      if (email != null) 'email': email,
      if (direccion != null) 'direccion': direccion,
      if (activo != null) 'activo': activo,
      if (creadoEn != null) 'creado_en': creadoEn,
    });
  }

  ProveedoresCompanion copyWith({
    Value<int>? id,
    Value<String>? nombre,
    Value<String?>? contacto,
    Value<String?>? telefono,
    Value<String?>? email,
    Value<String?>? direccion,
    Value<int>? activo,
    Value<String>? creadoEn,
  }) {
    return ProveedoresCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      contacto: contacto ?? this.contacto,
      telefono: telefono ?? this.telefono,
      email: email ?? this.email,
      direccion: direccion ?? this.direccion,
      activo: activo ?? this.activo,
      creadoEn: creadoEn ?? this.creadoEn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (contacto.present) {
      map['contacto'] = Variable<String>(contacto.value);
    }
    if (telefono.present) {
      map['telefono'] = Variable<String>(telefono.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (direccion.present) {
      map['direccion'] = Variable<String>(direccion.value);
    }
    if (activo.present) {
      map['activo'] = Variable<int>(activo.value);
    }
    if (creadoEn.present) {
      map['creado_en'] = Variable<String>(creadoEn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProveedoresCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('contacto: $contacto, ')
          ..write('telefono: $telefono, ')
          ..write('email: $email, ')
          ..write('direccion: $direccion, ')
          ..write('activo: $activo, ')
          ..write('creadoEn: $creadoEn')
          ..write(')'))
        .toString();
  }
}

class $ProductosTable extends Productos
    with TableInfo<$ProductosTable, Producto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _descripcionMeta = const VerificationMeta(
    'descripcion',
  );
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
    'descripcion',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoriaIdMeta = const VerificationMeta(
    'categoriaId',
  );
  @override
  late final GeneratedColumn<int> categoriaId = GeneratedColumn<int>(
    'categoria_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES categorias (id)',
    ),
  );
  static const VerificationMeta _precioVentaMeta = const VerificationMeta(
    'precioVenta',
  );
  @override
  late final GeneratedColumn<double> precioVenta = GeneratedColumn<double>(
    'precio_venta',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _margenGananciaPctMeta = const VerificationMeta(
    'margenGananciaPct',
  );
  @override
  late final GeneratedColumn<double> margenGananciaPct =
      GeneratedColumn<double>(
        'margen_ganancia_pct',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(0.0),
      );
  static const VerificationMeta _stockMinimoMeta = const VerificationMeta(
    'stockMinimo',
  );
  @override
  late final GeneratedColumn<double> stockMinimo = GeneratedColumn<double>(
    'stock_minimo',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _stockActualMeta = const VerificationMeta(
    'stockActual',
  );
  @override
  late final GeneratedColumn<double> stockActual = GeneratedColumn<double>(
    'stock_actual',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _activoMeta = const VerificationMeta('activo');
  @override
  late final GeneratedColumn<int> activo = GeneratedColumn<int>(
    'activo',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _creadoEnMeta = const VerificationMeta(
    'creadoEn',
  );
  @override
  late final GeneratedColumn<String> creadoEn = GeneratedColumn<String>(
    'creado_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => _nowLocal(),
  );
  static const VerificationMeta _actualizadoEnMeta = const VerificationMeta(
    'actualizadoEn',
  );
  @override
  late final GeneratedColumn<String> actualizadoEn = GeneratedColumn<String>(
    'actualizado_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => _nowLocal(),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nombre,
    descripcion,
    categoriaId,
    precioVenta,
    margenGananciaPct,
    stockMinimo,
    stockActual,
    activo,
    creadoEn,
    actualizadoEn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'productos';
  @override
  VerificationContext validateIntegrity(
    Insertable<Producto> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('descripcion')) {
      context.handle(
        _descripcionMeta,
        descripcion.isAcceptableOrUnknown(
          data['descripcion']!,
          _descripcionMeta,
        ),
      );
    }
    if (data.containsKey('categoria_id')) {
      context.handle(
        _categoriaIdMeta,
        categoriaId.isAcceptableOrUnknown(
          data['categoria_id']!,
          _categoriaIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_categoriaIdMeta);
    }
    if (data.containsKey('precio_venta')) {
      context.handle(
        _precioVentaMeta,
        precioVenta.isAcceptableOrUnknown(
          data['precio_venta']!,
          _precioVentaMeta,
        ),
      );
    }
    if (data.containsKey('margen_ganancia_pct')) {
      context.handle(
        _margenGananciaPctMeta,
        margenGananciaPct.isAcceptableOrUnknown(
          data['margen_ganancia_pct']!,
          _margenGananciaPctMeta,
        ),
      );
    }
    if (data.containsKey('stock_minimo')) {
      context.handle(
        _stockMinimoMeta,
        stockMinimo.isAcceptableOrUnknown(
          data['stock_minimo']!,
          _stockMinimoMeta,
        ),
      );
    }
    if (data.containsKey('stock_actual')) {
      context.handle(
        _stockActualMeta,
        stockActual.isAcceptableOrUnknown(
          data['stock_actual']!,
          _stockActualMeta,
        ),
      );
    }
    if (data.containsKey('activo')) {
      context.handle(
        _activoMeta,
        activo.isAcceptableOrUnknown(data['activo']!, _activoMeta),
      );
    }
    if (data.containsKey('creado_en')) {
      context.handle(
        _creadoEnMeta,
        creadoEn.isAcceptableOrUnknown(data['creado_en']!, _creadoEnMeta),
      );
    }
    if (data.containsKey('actualizado_en')) {
      context.handle(
        _actualizadoEnMeta,
        actualizadoEn.isAcceptableOrUnknown(
          data['actualizado_en']!,
          _actualizadoEnMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Producto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Producto(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      descripcion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}descripcion'],
      ),
      categoriaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}categoria_id'],
      )!,
      precioVenta: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}precio_venta'],
      )!,
      margenGananciaPct: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}margen_ganancia_pct'],
      )!,
      stockMinimo: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}stock_minimo'],
      )!,
      stockActual: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}stock_actual'],
      )!,
      activo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}activo'],
      )!,
      creadoEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}creado_en'],
      )!,
      actualizadoEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}actualizado_en'],
      )!,
    );
  }

  @override
  $ProductosTable createAlias(String alias) {
    return $ProductosTable(attachedDatabase, alias);
  }
}

class Producto extends DataClass implements Insertable<Producto> {
  final int id;
  final String nombre;
  final String? descripcion;
  final int categoriaId;
  final double precioVenta;
  final double margenGananciaPct;
  final double stockMinimo;
  final double stockActual;
  final int activo;
  final String creadoEn;
  final String actualizadoEn;
  const Producto({
    required this.id,
    required this.nombre,
    this.descripcion,
    required this.categoriaId,
    required this.precioVenta,
    required this.margenGananciaPct,
    required this.stockMinimo,
    required this.stockActual,
    required this.activo,
    required this.creadoEn,
    required this.actualizadoEn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    if (!nullToAbsent || descripcion != null) {
      map['descripcion'] = Variable<String>(descripcion);
    }
    map['categoria_id'] = Variable<int>(categoriaId);
    map['precio_venta'] = Variable<double>(precioVenta);
    map['margen_ganancia_pct'] = Variable<double>(margenGananciaPct);
    map['stock_minimo'] = Variable<double>(stockMinimo);
    map['stock_actual'] = Variable<double>(stockActual);
    map['activo'] = Variable<int>(activo);
    map['creado_en'] = Variable<String>(creadoEn);
    map['actualizado_en'] = Variable<String>(actualizadoEn);
    return map;
  }

  ProductosCompanion toCompanion(bool nullToAbsent) {
    return ProductosCompanion(
      id: Value(id),
      nombre: Value(nombre),
      descripcion: descripcion == null && nullToAbsent
          ? const Value.absent()
          : Value(descripcion),
      categoriaId: Value(categoriaId),
      precioVenta: Value(precioVenta),
      margenGananciaPct: Value(margenGananciaPct),
      stockMinimo: Value(stockMinimo),
      stockActual: Value(stockActual),
      activo: Value(activo),
      creadoEn: Value(creadoEn),
      actualizadoEn: Value(actualizadoEn),
    );
  }

  factory Producto.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Producto(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      descripcion: serializer.fromJson<String?>(json['descripcion']),
      categoriaId: serializer.fromJson<int>(json['categoriaId']),
      precioVenta: serializer.fromJson<double>(json['precioVenta']),
      margenGananciaPct: serializer.fromJson<double>(json['margenGananciaPct']),
      stockMinimo: serializer.fromJson<double>(json['stockMinimo']),
      stockActual: serializer.fromJson<double>(json['stockActual']),
      activo: serializer.fromJson<int>(json['activo']),
      creadoEn: serializer.fromJson<String>(json['creadoEn']),
      actualizadoEn: serializer.fromJson<String>(json['actualizadoEn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'descripcion': serializer.toJson<String?>(descripcion),
      'categoriaId': serializer.toJson<int>(categoriaId),
      'precioVenta': serializer.toJson<double>(precioVenta),
      'margenGananciaPct': serializer.toJson<double>(margenGananciaPct),
      'stockMinimo': serializer.toJson<double>(stockMinimo),
      'stockActual': serializer.toJson<double>(stockActual),
      'activo': serializer.toJson<int>(activo),
      'creadoEn': serializer.toJson<String>(creadoEn),
      'actualizadoEn': serializer.toJson<String>(actualizadoEn),
    };
  }

  Producto copyWith({
    int? id,
    String? nombre,
    Value<String?> descripcion = const Value.absent(),
    int? categoriaId,
    double? precioVenta,
    double? margenGananciaPct,
    double? stockMinimo,
    double? stockActual,
    int? activo,
    String? creadoEn,
    String? actualizadoEn,
  }) => Producto(
    id: id ?? this.id,
    nombre: nombre ?? this.nombre,
    descripcion: descripcion.present ? descripcion.value : this.descripcion,
    categoriaId: categoriaId ?? this.categoriaId,
    precioVenta: precioVenta ?? this.precioVenta,
    margenGananciaPct: margenGananciaPct ?? this.margenGananciaPct,
    stockMinimo: stockMinimo ?? this.stockMinimo,
    stockActual: stockActual ?? this.stockActual,
    activo: activo ?? this.activo,
    creadoEn: creadoEn ?? this.creadoEn,
    actualizadoEn: actualizadoEn ?? this.actualizadoEn,
  );
  Producto copyWithCompanion(ProductosCompanion data) {
    return Producto(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      descripcion: data.descripcion.present
          ? data.descripcion.value
          : this.descripcion,
      categoriaId: data.categoriaId.present
          ? data.categoriaId.value
          : this.categoriaId,
      precioVenta: data.precioVenta.present
          ? data.precioVenta.value
          : this.precioVenta,
      margenGananciaPct: data.margenGananciaPct.present
          ? data.margenGananciaPct.value
          : this.margenGananciaPct,
      stockMinimo: data.stockMinimo.present
          ? data.stockMinimo.value
          : this.stockMinimo,
      stockActual: data.stockActual.present
          ? data.stockActual.value
          : this.stockActual,
      activo: data.activo.present ? data.activo.value : this.activo,
      creadoEn: data.creadoEn.present ? data.creadoEn.value : this.creadoEn,
      actualizadoEn: data.actualizadoEn.present
          ? data.actualizadoEn.value
          : this.actualizadoEn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Producto(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('descripcion: $descripcion, ')
          ..write('categoriaId: $categoriaId, ')
          ..write('precioVenta: $precioVenta, ')
          ..write('margenGananciaPct: $margenGananciaPct, ')
          ..write('stockMinimo: $stockMinimo, ')
          ..write('stockActual: $stockActual, ')
          ..write('activo: $activo, ')
          ..write('creadoEn: $creadoEn, ')
          ..write('actualizadoEn: $actualizadoEn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    nombre,
    descripcion,
    categoriaId,
    precioVenta,
    margenGananciaPct,
    stockMinimo,
    stockActual,
    activo,
    creadoEn,
    actualizadoEn,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Producto &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.descripcion == this.descripcion &&
          other.categoriaId == this.categoriaId &&
          other.precioVenta == this.precioVenta &&
          other.margenGananciaPct == this.margenGananciaPct &&
          other.stockMinimo == this.stockMinimo &&
          other.stockActual == this.stockActual &&
          other.activo == this.activo &&
          other.creadoEn == this.creadoEn &&
          other.actualizadoEn == this.actualizadoEn);
}

class ProductosCompanion extends UpdateCompanion<Producto> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<String?> descripcion;
  final Value<int> categoriaId;
  final Value<double> precioVenta;
  final Value<double> margenGananciaPct;
  final Value<double> stockMinimo;
  final Value<double> stockActual;
  final Value<int> activo;
  final Value<String> creadoEn;
  final Value<String> actualizadoEn;
  const ProductosCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.categoriaId = const Value.absent(),
    this.precioVenta = const Value.absent(),
    this.margenGananciaPct = const Value.absent(),
    this.stockMinimo = const Value.absent(),
    this.stockActual = const Value.absent(),
    this.activo = const Value.absent(),
    this.creadoEn = const Value.absent(),
    this.actualizadoEn = const Value.absent(),
  });
  ProductosCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
    this.descripcion = const Value.absent(),
    required int categoriaId,
    this.precioVenta = const Value.absent(),
    this.margenGananciaPct = const Value.absent(),
    this.stockMinimo = const Value.absent(),
    this.stockActual = const Value.absent(),
    this.activo = const Value.absent(),
    this.creadoEn = const Value.absent(),
    this.actualizadoEn = const Value.absent(),
  }) : nombre = Value(nombre),
       categoriaId = Value(categoriaId);
  static Insertable<Producto> custom({
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<String>? descripcion,
    Expression<int>? categoriaId,
    Expression<double>? precioVenta,
    Expression<double>? margenGananciaPct,
    Expression<double>? stockMinimo,
    Expression<double>? stockActual,
    Expression<int>? activo,
    Expression<String>? creadoEn,
    Expression<String>? actualizadoEn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (descripcion != null) 'descripcion': descripcion,
      if (categoriaId != null) 'categoria_id': categoriaId,
      if (precioVenta != null) 'precio_venta': precioVenta,
      if (margenGananciaPct != null) 'margen_ganancia_pct': margenGananciaPct,
      if (stockMinimo != null) 'stock_minimo': stockMinimo,
      if (stockActual != null) 'stock_actual': stockActual,
      if (activo != null) 'activo': activo,
      if (creadoEn != null) 'creado_en': creadoEn,
      if (actualizadoEn != null) 'actualizado_en': actualizadoEn,
    });
  }

  ProductosCompanion copyWith({
    Value<int>? id,
    Value<String>? nombre,
    Value<String?>? descripcion,
    Value<int>? categoriaId,
    Value<double>? precioVenta,
    Value<double>? margenGananciaPct,
    Value<double>? stockMinimo,
    Value<double>? stockActual,
    Value<int>? activo,
    Value<String>? creadoEn,
    Value<String>? actualizadoEn,
  }) {
    return ProductosCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      descripcion: descripcion ?? this.descripcion,
      categoriaId: categoriaId ?? this.categoriaId,
      precioVenta: precioVenta ?? this.precioVenta,
      margenGananciaPct: margenGananciaPct ?? this.margenGananciaPct,
      stockMinimo: stockMinimo ?? this.stockMinimo,
      stockActual: stockActual ?? this.stockActual,
      activo: activo ?? this.activo,
      creadoEn: creadoEn ?? this.creadoEn,
      actualizadoEn: actualizadoEn ?? this.actualizadoEn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (categoriaId.present) {
      map['categoria_id'] = Variable<int>(categoriaId.value);
    }
    if (precioVenta.present) {
      map['precio_venta'] = Variable<double>(precioVenta.value);
    }
    if (margenGananciaPct.present) {
      map['margen_ganancia_pct'] = Variable<double>(margenGananciaPct.value);
    }
    if (stockMinimo.present) {
      map['stock_minimo'] = Variable<double>(stockMinimo.value);
    }
    if (stockActual.present) {
      map['stock_actual'] = Variable<double>(stockActual.value);
    }
    if (activo.present) {
      map['activo'] = Variable<int>(activo.value);
    }
    if (creadoEn.present) {
      map['creado_en'] = Variable<String>(creadoEn.value);
    }
    if (actualizadoEn.present) {
      map['actualizado_en'] = Variable<String>(actualizadoEn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductosCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('descripcion: $descripcion, ')
          ..write('categoriaId: $categoriaId, ')
          ..write('precioVenta: $precioVenta, ')
          ..write('margenGananciaPct: $margenGananciaPct, ')
          ..write('stockMinimo: $stockMinimo, ')
          ..write('stockActual: $stockActual, ')
          ..write('activo: $activo, ')
          ..write('creadoEn: $creadoEn, ')
          ..write('actualizadoEn: $actualizadoEn')
          ..write(')'))
        .toString();
  }
}

class $ComprasTable extends Compras with TableInfo<$ComprasTable, Compra> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ComprasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _proveedorIdMeta = const VerificationMeta(
    'proveedorId',
  );
  @override
  late final GeneratedColumn<int> proveedorId = GeneratedColumn<int>(
    'proveedor_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES proveedores (id)',
    ),
  );
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<String> fecha = GeneratedColumn<String>(
    'fecha',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => _nowLocal(),
  );
  static const VerificationMeta _nroFacturaMeta = const VerificationMeta(
    'nroFactura',
  );
  @override
  late final GeneratedColumn<String> nroFactura = GeneratedColumn<String>(
    'nro_factura',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _observacionesMeta = const VerificationMeta(
    'observaciones',
  );
  @override
  late final GeneratedColumn<String> observaciones = GeneratedColumn<String>(
    'observaciones',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<double> total = GeneratedColumn<double>(
    'total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _creadoEnMeta = const VerificationMeta(
    'creadoEn',
  );
  @override
  late final GeneratedColumn<String> creadoEn = GeneratedColumn<String>(
    'creado_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => _nowLocal(),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    proveedorId,
    fecha,
    nroFactura,
    observaciones,
    total,
    creadoEn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'compras';
  @override
  VerificationContext validateIntegrity(
    Insertable<Compra> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('proveedor_id')) {
      context.handle(
        _proveedorIdMeta,
        proveedorId.isAcceptableOrUnknown(
          data['proveedor_id']!,
          _proveedorIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_proveedorIdMeta);
    }
    if (data.containsKey('fecha')) {
      context.handle(
        _fechaMeta,
        fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta),
      );
    }
    if (data.containsKey('nro_factura')) {
      context.handle(
        _nroFacturaMeta,
        nroFactura.isAcceptableOrUnknown(data['nro_factura']!, _nroFacturaMeta),
      );
    }
    if (data.containsKey('observaciones')) {
      context.handle(
        _observacionesMeta,
        observaciones.isAcceptableOrUnknown(
          data['observaciones']!,
          _observacionesMeta,
        ),
      );
    }
    if (data.containsKey('total')) {
      context.handle(
        _totalMeta,
        total.isAcceptableOrUnknown(data['total']!, _totalMeta),
      );
    }
    if (data.containsKey('creado_en')) {
      context.handle(
        _creadoEnMeta,
        creadoEn.isAcceptableOrUnknown(data['creado_en']!, _creadoEnMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Compra map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Compra(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      proveedorId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}proveedor_id'],
      )!,
      fecha: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fecha'],
      )!,
      nroFactura: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nro_factura'],
      ),
      observaciones: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}observaciones'],
      ),
      total: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total'],
      )!,
      creadoEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}creado_en'],
      )!,
    );
  }

  @override
  $ComprasTable createAlias(String alias) {
    return $ComprasTable(attachedDatabase, alias);
  }
}

class Compra extends DataClass implements Insertable<Compra> {
  final int id;
  final int proveedorId;
  final String fecha;
  final String? nroFactura;
  final String? observaciones;
  final double total;
  final String creadoEn;
  const Compra({
    required this.id,
    required this.proveedorId,
    required this.fecha,
    this.nroFactura,
    this.observaciones,
    required this.total,
    required this.creadoEn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['proveedor_id'] = Variable<int>(proveedorId);
    map['fecha'] = Variable<String>(fecha);
    if (!nullToAbsent || nroFactura != null) {
      map['nro_factura'] = Variable<String>(nroFactura);
    }
    if (!nullToAbsent || observaciones != null) {
      map['observaciones'] = Variable<String>(observaciones);
    }
    map['total'] = Variable<double>(total);
    map['creado_en'] = Variable<String>(creadoEn);
    return map;
  }

  ComprasCompanion toCompanion(bool nullToAbsent) {
    return ComprasCompanion(
      id: Value(id),
      proveedorId: Value(proveedorId),
      fecha: Value(fecha),
      nroFactura: nroFactura == null && nullToAbsent
          ? const Value.absent()
          : Value(nroFactura),
      observaciones: observaciones == null && nullToAbsent
          ? const Value.absent()
          : Value(observaciones),
      total: Value(total),
      creadoEn: Value(creadoEn),
    );
  }

  factory Compra.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Compra(
      id: serializer.fromJson<int>(json['id']),
      proveedorId: serializer.fromJson<int>(json['proveedorId']),
      fecha: serializer.fromJson<String>(json['fecha']),
      nroFactura: serializer.fromJson<String?>(json['nroFactura']),
      observaciones: serializer.fromJson<String?>(json['observaciones']),
      total: serializer.fromJson<double>(json['total']),
      creadoEn: serializer.fromJson<String>(json['creadoEn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'proveedorId': serializer.toJson<int>(proveedorId),
      'fecha': serializer.toJson<String>(fecha),
      'nroFactura': serializer.toJson<String?>(nroFactura),
      'observaciones': serializer.toJson<String?>(observaciones),
      'total': serializer.toJson<double>(total),
      'creadoEn': serializer.toJson<String>(creadoEn),
    };
  }

  Compra copyWith({
    int? id,
    int? proveedorId,
    String? fecha,
    Value<String?> nroFactura = const Value.absent(),
    Value<String?> observaciones = const Value.absent(),
    double? total,
    String? creadoEn,
  }) => Compra(
    id: id ?? this.id,
    proveedorId: proveedorId ?? this.proveedorId,
    fecha: fecha ?? this.fecha,
    nroFactura: nroFactura.present ? nroFactura.value : this.nroFactura,
    observaciones: observaciones.present
        ? observaciones.value
        : this.observaciones,
    total: total ?? this.total,
    creadoEn: creadoEn ?? this.creadoEn,
  );
  Compra copyWithCompanion(ComprasCompanion data) {
    return Compra(
      id: data.id.present ? data.id.value : this.id,
      proveedorId: data.proveedorId.present
          ? data.proveedorId.value
          : this.proveedorId,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
      nroFactura: data.nroFactura.present
          ? data.nroFactura.value
          : this.nroFactura,
      observaciones: data.observaciones.present
          ? data.observaciones.value
          : this.observaciones,
      total: data.total.present ? data.total.value : this.total,
      creadoEn: data.creadoEn.present ? data.creadoEn.value : this.creadoEn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Compra(')
          ..write('id: $id, ')
          ..write('proveedorId: $proveedorId, ')
          ..write('fecha: $fecha, ')
          ..write('nroFactura: $nroFactura, ')
          ..write('observaciones: $observaciones, ')
          ..write('total: $total, ')
          ..write('creadoEn: $creadoEn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    proveedorId,
    fecha,
    nroFactura,
    observaciones,
    total,
    creadoEn,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Compra &&
          other.id == this.id &&
          other.proveedorId == this.proveedorId &&
          other.fecha == this.fecha &&
          other.nroFactura == this.nroFactura &&
          other.observaciones == this.observaciones &&
          other.total == this.total &&
          other.creadoEn == this.creadoEn);
}

class ComprasCompanion extends UpdateCompanion<Compra> {
  final Value<int> id;
  final Value<int> proveedorId;
  final Value<String> fecha;
  final Value<String?> nroFactura;
  final Value<String?> observaciones;
  final Value<double> total;
  final Value<String> creadoEn;
  const ComprasCompanion({
    this.id = const Value.absent(),
    this.proveedorId = const Value.absent(),
    this.fecha = const Value.absent(),
    this.nroFactura = const Value.absent(),
    this.observaciones = const Value.absent(),
    this.total = const Value.absent(),
    this.creadoEn = const Value.absent(),
  });
  ComprasCompanion.insert({
    this.id = const Value.absent(),
    required int proveedorId,
    this.fecha = const Value.absent(),
    this.nroFactura = const Value.absent(),
    this.observaciones = const Value.absent(),
    this.total = const Value.absent(),
    this.creadoEn = const Value.absent(),
  }) : proveedorId = Value(proveedorId);
  static Insertable<Compra> custom({
    Expression<int>? id,
    Expression<int>? proveedorId,
    Expression<String>? fecha,
    Expression<String>? nroFactura,
    Expression<String>? observaciones,
    Expression<double>? total,
    Expression<String>? creadoEn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (proveedorId != null) 'proveedor_id': proveedorId,
      if (fecha != null) 'fecha': fecha,
      if (nroFactura != null) 'nro_factura': nroFactura,
      if (observaciones != null) 'observaciones': observaciones,
      if (total != null) 'total': total,
      if (creadoEn != null) 'creado_en': creadoEn,
    });
  }

  ComprasCompanion copyWith({
    Value<int>? id,
    Value<int>? proveedorId,
    Value<String>? fecha,
    Value<String?>? nroFactura,
    Value<String?>? observaciones,
    Value<double>? total,
    Value<String>? creadoEn,
  }) {
    return ComprasCompanion(
      id: id ?? this.id,
      proveedorId: proveedorId ?? this.proveedorId,
      fecha: fecha ?? this.fecha,
      nroFactura: nroFactura ?? this.nroFactura,
      observaciones: observaciones ?? this.observaciones,
      total: total ?? this.total,
      creadoEn: creadoEn ?? this.creadoEn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (proveedorId.present) {
      map['proveedor_id'] = Variable<int>(proveedorId.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<String>(fecha.value);
    }
    if (nroFactura.present) {
      map['nro_factura'] = Variable<String>(nroFactura.value);
    }
    if (observaciones.present) {
      map['observaciones'] = Variable<String>(observaciones.value);
    }
    if (total.present) {
      map['total'] = Variable<double>(total.value);
    }
    if (creadoEn.present) {
      map['creado_en'] = Variable<String>(creadoEn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ComprasCompanion(')
          ..write('id: $id, ')
          ..write('proveedorId: $proveedorId, ')
          ..write('fecha: $fecha, ')
          ..write('nroFactura: $nroFactura, ')
          ..write('observaciones: $observaciones, ')
          ..write('total: $total, ')
          ..write('creadoEn: $creadoEn')
          ..write(')'))
        .toString();
  }
}

class $CompraDetallesTable extends CompraDetalles
    with TableInfo<$CompraDetallesTable, CompraDetalle> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CompraDetallesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _compraIdMeta = const VerificationMeta(
    'compraId',
  );
  @override
  late final GeneratedColumn<int> compraId = GeneratedColumn<int>(
    'compra_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES compras (id)',
    ),
  );
  static const VerificationMeta _productoIdMeta = const VerificationMeta(
    'productoId',
  );
  @override
  late final GeneratedColumn<int> productoId = GeneratedColumn<int>(
    'producto_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES productos (id)',
    ),
  );
  static const VerificationMeta _cantidadMeta = const VerificationMeta(
    'cantidad',
  );
  @override
  late final GeneratedColumn<double> cantidad = GeneratedColumn<double>(
    'cantidad',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cantidadRestanteMeta = const VerificationMeta(
    'cantidadRestante',
  );
  @override
  late final GeneratedColumn<double> cantidadRestante = GeneratedColumn<double>(
    'cantidad_restante',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _precioCostoMeta = const VerificationMeta(
    'precioCosto',
  );
  @override
  late final GeneratedColumn<double> precioCosto = GeneratedColumn<double>(
    'precio_costo',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _precioVentaLoteMeta = const VerificationMeta(
    'precioVentaLote',
  );
  @override
  late final GeneratedColumn<double> precioVentaLote = GeneratedColumn<double>(
    'precio_venta_lote',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _creadoEnMeta = const VerificationMeta(
    'creadoEn',
  );
  @override
  late final GeneratedColumn<String> creadoEn = GeneratedColumn<String>(
    'creado_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => _nowLocal(),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    compraId,
    productoId,
    cantidad,
    cantidadRestante,
    precioCosto,
    precioVentaLote,
    creadoEn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'compra_detalles';
  @override
  VerificationContext validateIntegrity(
    Insertable<CompraDetalle> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('compra_id')) {
      context.handle(
        _compraIdMeta,
        compraId.isAcceptableOrUnknown(data['compra_id']!, _compraIdMeta),
      );
    } else if (isInserting) {
      context.missing(_compraIdMeta);
    }
    if (data.containsKey('producto_id')) {
      context.handle(
        _productoIdMeta,
        productoId.isAcceptableOrUnknown(data['producto_id']!, _productoIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productoIdMeta);
    }
    if (data.containsKey('cantidad')) {
      context.handle(
        _cantidadMeta,
        cantidad.isAcceptableOrUnknown(data['cantidad']!, _cantidadMeta),
      );
    } else if (isInserting) {
      context.missing(_cantidadMeta);
    }
    if (data.containsKey('cantidad_restante')) {
      context.handle(
        _cantidadRestanteMeta,
        cantidadRestante.isAcceptableOrUnknown(
          data['cantidad_restante']!,
          _cantidadRestanteMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_cantidadRestanteMeta);
    }
    if (data.containsKey('precio_costo')) {
      context.handle(
        _precioCostoMeta,
        precioCosto.isAcceptableOrUnknown(
          data['precio_costo']!,
          _precioCostoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_precioCostoMeta);
    }
    if (data.containsKey('precio_venta_lote')) {
      context.handle(
        _precioVentaLoteMeta,
        precioVentaLote.isAcceptableOrUnknown(
          data['precio_venta_lote']!,
          _precioVentaLoteMeta,
        ),
      );
    }
    if (data.containsKey('creado_en')) {
      context.handle(
        _creadoEnMeta,
        creadoEn.isAcceptableOrUnknown(data['creado_en']!, _creadoEnMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CompraDetalle map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CompraDetalle(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      compraId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}compra_id'],
      )!,
      productoId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}producto_id'],
      )!,
      cantidad: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cantidad'],
      )!,
      cantidadRestante: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cantidad_restante'],
      )!,
      precioCosto: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}precio_costo'],
      )!,
      precioVentaLote: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}precio_venta_lote'],
      )!,
      creadoEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}creado_en'],
      )!,
    );
  }

  @override
  $CompraDetallesTable createAlias(String alias) {
    return $CompraDetallesTable(attachedDatabase, alias);
  }
}

class CompraDetalle extends DataClass implements Insertable<CompraDetalle> {
  final int id;
  final int compraId;
  final int productoId;
  final double cantidad;
  final double cantidadRestante;
  final double precioCosto;
  final double precioVentaLote;
  final String creadoEn;
  const CompraDetalle({
    required this.id,
    required this.compraId,
    required this.productoId,
    required this.cantidad,
    required this.cantidadRestante,
    required this.precioCosto,
    required this.precioVentaLote,
    required this.creadoEn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['compra_id'] = Variable<int>(compraId);
    map['producto_id'] = Variable<int>(productoId);
    map['cantidad'] = Variable<double>(cantidad);
    map['cantidad_restante'] = Variable<double>(cantidadRestante);
    map['precio_costo'] = Variable<double>(precioCosto);
    map['precio_venta_lote'] = Variable<double>(precioVentaLote);
    map['creado_en'] = Variable<String>(creadoEn);
    return map;
  }

  CompraDetallesCompanion toCompanion(bool nullToAbsent) {
    return CompraDetallesCompanion(
      id: Value(id),
      compraId: Value(compraId),
      productoId: Value(productoId),
      cantidad: Value(cantidad),
      cantidadRestante: Value(cantidadRestante),
      precioCosto: Value(precioCosto),
      precioVentaLote: Value(precioVentaLote),
      creadoEn: Value(creadoEn),
    );
  }

  factory CompraDetalle.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CompraDetalle(
      id: serializer.fromJson<int>(json['id']),
      compraId: serializer.fromJson<int>(json['compraId']),
      productoId: serializer.fromJson<int>(json['productoId']),
      cantidad: serializer.fromJson<double>(json['cantidad']),
      cantidadRestante: serializer.fromJson<double>(json['cantidadRestante']),
      precioCosto: serializer.fromJson<double>(json['precioCosto']),
      precioVentaLote: serializer.fromJson<double>(json['precioVentaLote']),
      creadoEn: serializer.fromJson<String>(json['creadoEn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'compraId': serializer.toJson<int>(compraId),
      'productoId': serializer.toJson<int>(productoId),
      'cantidad': serializer.toJson<double>(cantidad),
      'cantidadRestante': serializer.toJson<double>(cantidadRestante),
      'precioCosto': serializer.toJson<double>(precioCosto),
      'precioVentaLote': serializer.toJson<double>(precioVentaLote),
      'creadoEn': serializer.toJson<String>(creadoEn),
    };
  }

  CompraDetalle copyWith({
    int? id,
    int? compraId,
    int? productoId,
    double? cantidad,
    double? cantidadRestante,
    double? precioCosto,
    double? precioVentaLote,
    String? creadoEn,
  }) => CompraDetalle(
    id: id ?? this.id,
    compraId: compraId ?? this.compraId,
    productoId: productoId ?? this.productoId,
    cantidad: cantidad ?? this.cantidad,
    cantidadRestante: cantidadRestante ?? this.cantidadRestante,
    precioCosto: precioCosto ?? this.precioCosto,
    precioVentaLote: precioVentaLote ?? this.precioVentaLote,
    creadoEn: creadoEn ?? this.creadoEn,
  );
  CompraDetalle copyWithCompanion(CompraDetallesCompanion data) {
    return CompraDetalle(
      id: data.id.present ? data.id.value : this.id,
      compraId: data.compraId.present ? data.compraId.value : this.compraId,
      productoId: data.productoId.present
          ? data.productoId.value
          : this.productoId,
      cantidad: data.cantidad.present ? data.cantidad.value : this.cantidad,
      cantidadRestante: data.cantidadRestante.present
          ? data.cantidadRestante.value
          : this.cantidadRestante,
      precioCosto: data.precioCosto.present
          ? data.precioCosto.value
          : this.precioCosto,
      precioVentaLote: data.precioVentaLote.present
          ? data.precioVentaLote.value
          : this.precioVentaLote,
      creadoEn: data.creadoEn.present ? data.creadoEn.value : this.creadoEn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CompraDetalle(')
          ..write('id: $id, ')
          ..write('compraId: $compraId, ')
          ..write('productoId: $productoId, ')
          ..write('cantidad: $cantidad, ')
          ..write('cantidadRestante: $cantidadRestante, ')
          ..write('precioCosto: $precioCosto, ')
          ..write('precioVentaLote: $precioVentaLote, ')
          ..write('creadoEn: $creadoEn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    compraId,
    productoId,
    cantidad,
    cantidadRestante,
    precioCosto,
    precioVentaLote,
    creadoEn,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CompraDetalle &&
          other.id == this.id &&
          other.compraId == this.compraId &&
          other.productoId == this.productoId &&
          other.cantidad == this.cantidad &&
          other.cantidadRestante == this.cantidadRestante &&
          other.precioCosto == this.precioCosto &&
          other.precioVentaLote == this.precioVentaLote &&
          other.creadoEn == this.creadoEn);
}

class CompraDetallesCompanion extends UpdateCompanion<CompraDetalle> {
  final Value<int> id;
  final Value<int> compraId;
  final Value<int> productoId;
  final Value<double> cantidad;
  final Value<double> cantidadRestante;
  final Value<double> precioCosto;
  final Value<double> precioVentaLote;
  final Value<String> creadoEn;
  const CompraDetallesCompanion({
    this.id = const Value.absent(),
    this.compraId = const Value.absent(),
    this.productoId = const Value.absent(),
    this.cantidad = const Value.absent(),
    this.cantidadRestante = const Value.absent(),
    this.precioCosto = const Value.absent(),
    this.precioVentaLote = const Value.absent(),
    this.creadoEn = const Value.absent(),
  });
  CompraDetallesCompanion.insert({
    this.id = const Value.absent(),
    required int compraId,
    required int productoId,
    required double cantidad,
    required double cantidadRestante,
    required double precioCosto,
    this.precioVentaLote = const Value.absent(),
    this.creadoEn = const Value.absent(),
  }) : compraId = Value(compraId),
       productoId = Value(productoId),
       cantidad = Value(cantidad),
       cantidadRestante = Value(cantidadRestante),
       precioCosto = Value(precioCosto);
  static Insertable<CompraDetalle> custom({
    Expression<int>? id,
    Expression<int>? compraId,
    Expression<int>? productoId,
    Expression<double>? cantidad,
    Expression<double>? cantidadRestante,
    Expression<double>? precioCosto,
    Expression<double>? precioVentaLote,
    Expression<String>? creadoEn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (compraId != null) 'compra_id': compraId,
      if (productoId != null) 'producto_id': productoId,
      if (cantidad != null) 'cantidad': cantidad,
      if (cantidadRestante != null) 'cantidad_restante': cantidadRestante,
      if (precioCosto != null) 'precio_costo': precioCosto,
      if (precioVentaLote != null) 'precio_venta_lote': precioVentaLote,
      if (creadoEn != null) 'creado_en': creadoEn,
    });
  }

  CompraDetallesCompanion copyWith({
    Value<int>? id,
    Value<int>? compraId,
    Value<int>? productoId,
    Value<double>? cantidad,
    Value<double>? cantidadRestante,
    Value<double>? precioCosto,
    Value<double>? precioVentaLote,
    Value<String>? creadoEn,
  }) {
    return CompraDetallesCompanion(
      id: id ?? this.id,
      compraId: compraId ?? this.compraId,
      productoId: productoId ?? this.productoId,
      cantidad: cantidad ?? this.cantidad,
      cantidadRestante: cantidadRestante ?? this.cantidadRestante,
      precioCosto: precioCosto ?? this.precioCosto,
      precioVentaLote: precioVentaLote ?? this.precioVentaLote,
      creadoEn: creadoEn ?? this.creadoEn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (compraId.present) {
      map['compra_id'] = Variable<int>(compraId.value);
    }
    if (productoId.present) {
      map['producto_id'] = Variable<int>(productoId.value);
    }
    if (cantidad.present) {
      map['cantidad'] = Variable<double>(cantidad.value);
    }
    if (cantidadRestante.present) {
      map['cantidad_restante'] = Variable<double>(cantidadRestante.value);
    }
    if (precioCosto.present) {
      map['precio_costo'] = Variable<double>(precioCosto.value);
    }
    if (precioVentaLote.present) {
      map['precio_venta_lote'] = Variable<double>(precioVentaLote.value);
    }
    if (creadoEn.present) {
      map['creado_en'] = Variable<String>(creadoEn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CompraDetallesCompanion(')
          ..write('id: $id, ')
          ..write('compraId: $compraId, ')
          ..write('productoId: $productoId, ')
          ..write('cantidad: $cantidad, ')
          ..write('cantidadRestante: $cantidadRestante, ')
          ..write('precioCosto: $precioCosto, ')
          ..write('precioVentaLote: $precioVentaLote, ')
          ..write('creadoEn: $creadoEn')
          ..write(')'))
        .toString();
  }
}

class $VentasTable extends Ventas with TableInfo<$VentasTable, Venta> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VentasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<String> fecha = GeneratedColumn<String>(
    'fecha',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => _nowLocal(),
  );
  static const VerificationMeta _metodoPagoMeta = const VerificationMeta(
    'metodoPago',
  );
  @override
  late final GeneratedColumn<String> metodoPago = GeneratedColumn<String>(
    'metodo_pago',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('efectivo'),
  );
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<double> total = GeneratedColumn<double>(
    'total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _costoTotalMeta = const VerificationMeta(
    'costoTotal',
  );
  @override
  late final GeneratedColumn<double> costoTotal = GeneratedColumn<double>(
    'costo_total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _observacionesMeta = const VerificationMeta(
    'observaciones',
  );
  @override
  late final GeneratedColumn<String> observaciones = GeneratedColumn<String>(
    'observaciones',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _creadoEnMeta = const VerificationMeta(
    'creadoEn',
  );
  @override
  late final GeneratedColumn<String> creadoEn = GeneratedColumn<String>(
    'creado_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => _nowLocal(),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    fecha,
    metodoPago,
    total,
    costoTotal,
    observaciones,
    creadoEn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ventas';
  @override
  VerificationContext validateIntegrity(
    Insertable<Venta> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('fecha')) {
      context.handle(
        _fechaMeta,
        fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta),
      );
    }
    if (data.containsKey('metodo_pago')) {
      context.handle(
        _metodoPagoMeta,
        metodoPago.isAcceptableOrUnknown(data['metodo_pago']!, _metodoPagoMeta),
      );
    }
    if (data.containsKey('total')) {
      context.handle(
        _totalMeta,
        total.isAcceptableOrUnknown(data['total']!, _totalMeta),
      );
    }
    if (data.containsKey('costo_total')) {
      context.handle(
        _costoTotalMeta,
        costoTotal.isAcceptableOrUnknown(data['costo_total']!, _costoTotalMeta),
      );
    }
    if (data.containsKey('observaciones')) {
      context.handle(
        _observacionesMeta,
        observaciones.isAcceptableOrUnknown(
          data['observaciones']!,
          _observacionesMeta,
        ),
      );
    }
    if (data.containsKey('creado_en')) {
      context.handle(
        _creadoEnMeta,
        creadoEn.isAcceptableOrUnknown(data['creado_en']!, _creadoEnMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Venta map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Venta(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      fecha: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fecha'],
      )!,
      metodoPago: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metodo_pago'],
      )!,
      total: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total'],
      )!,
      costoTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}costo_total'],
      )!,
      observaciones: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}observaciones'],
      ),
      creadoEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}creado_en'],
      )!,
    );
  }

  @override
  $VentasTable createAlias(String alias) {
    return $VentasTable(attachedDatabase, alias);
  }
}

class Venta extends DataClass implements Insertable<Venta> {
  final int id;
  final String fecha;
  final String metodoPago;
  final double total;
  final double costoTotal;
  final String? observaciones;
  final String creadoEn;
  const Venta({
    required this.id,
    required this.fecha,
    required this.metodoPago,
    required this.total,
    required this.costoTotal,
    this.observaciones,
    required this.creadoEn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['fecha'] = Variable<String>(fecha);
    map['metodo_pago'] = Variable<String>(metodoPago);
    map['total'] = Variable<double>(total);
    map['costo_total'] = Variable<double>(costoTotal);
    if (!nullToAbsent || observaciones != null) {
      map['observaciones'] = Variable<String>(observaciones);
    }
    map['creado_en'] = Variable<String>(creadoEn);
    return map;
  }

  VentasCompanion toCompanion(bool nullToAbsent) {
    return VentasCompanion(
      id: Value(id),
      fecha: Value(fecha),
      metodoPago: Value(metodoPago),
      total: Value(total),
      costoTotal: Value(costoTotal),
      observaciones: observaciones == null && nullToAbsent
          ? const Value.absent()
          : Value(observaciones),
      creadoEn: Value(creadoEn),
    );
  }

  factory Venta.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Venta(
      id: serializer.fromJson<int>(json['id']),
      fecha: serializer.fromJson<String>(json['fecha']),
      metodoPago: serializer.fromJson<String>(json['metodoPago']),
      total: serializer.fromJson<double>(json['total']),
      costoTotal: serializer.fromJson<double>(json['costoTotal']),
      observaciones: serializer.fromJson<String?>(json['observaciones']),
      creadoEn: serializer.fromJson<String>(json['creadoEn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fecha': serializer.toJson<String>(fecha),
      'metodoPago': serializer.toJson<String>(metodoPago),
      'total': serializer.toJson<double>(total),
      'costoTotal': serializer.toJson<double>(costoTotal),
      'observaciones': serializer.toJson<String?>(observaciones),
      'creadoEn': serializer.toJson<String>(creadoEn),
    };
  }

  Venta copyWith({
    int? id,
    String? fecha,
    String? metodoPago,
    double? total,
    double? costoTotal,
    Value<String?> observaciones = const Value.absent(),
    String? creadoEn,
  }) => Venta(
    id: id ?? this.id,
    fecha: fecha ?? this.fecha,
    metodoPago: metodoPago ?? this.metodoPago,
    total: total ?? this.total,
    costoTotal: costoTotal ?? this.costoTotal,
    observaciones: observaciones.present
        ? observaciones.value
        : this.observaciones,
    creadoEn: creadoEn ?? this.creadoEn,
  );
  Venta copyWithCompanion(VentasCompanion data) {
    return Venta(
      id: data.id.present ? data.id.value : this.id,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
      metodoPago: data.metodoPago.present
          ? data.metodoPago.value
          : this.metodoPago,
      total: data.total.present ? data.total.value : this.total,
      costoTotal: data.costoTotal.present
          ? data.costoTotal.value
          : this.costoTotal,
      observaciones: data.observaciones.present
          ? data.observaciones.value
          : this.observaciones,
      creadoEn: data.creadoEn.present ? data.creadoEn.value : this.creadoEn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Venta(')
          ..write('id: $id, ')
          ..write('fecha: $fecha, ')
          ..write('metodoPago: $metodoPago, ')
          ..write('total: $total, ')
          ..write('costoTotal: $costoTotal, ')
          ..write('observaciones: $observaciones, ')
          ..write('creadoEn: $creadoEn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    fecha,
    metodoPago,
    total,
    costoTotal,
    observaciones,
    creadoEn,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Venta &&
          other.id == this.id &&
          other.fecha == this.fecha &&
          other.metodoPago == this.metodoPago &&
          other.total == this.total &&
          other.costoTotal == this.costoTotal &&
          other.observaciones == this.observaciones &&
          other.creadoEn == this.creadoEn);
}

class VentasCompanion extends UpdateCompanion<Venta> {
  final Value<int> id;
  final Value<String> fecha;
  final Value<String> metodoPago;
  final Value<double> total;
  final Value<double> costoTotal;
  final Value<String?> observaciones;
  final Value<String> creadoEn;
  const VentasCompanion({
    this.id = const Value.absent(),
    this.fecha = const Value.absent(),
    this.metodoPago = const Value.absent(),
    this.total = const Value.absent(),
    this.costoTotal = const Value.absent(),
    this.observaciones = const Value.absent(),
    this.creadoEn = const Value.absent(),
  });
  VentasCompanion.insert({
    this.id = const Value.absent(),
    this.fecha = const Value.absent(),
    this.metodoPago = const Value.absent(),
    this.total = const Value.absent(),
    this.costoTotal = const Value.absent(),
    this.observaciones = const Value.absent(),
    this.creadoEn = const Value.absent(),
  });
  static Insertable<Venta> custom({
    Expression<int>? id,
    Expression<String>? fecha,
    Expression<String>? metodoPago,
    Expression<double>? total,
    Expression<double>? costoTotal,
    Expression<String>? observaciones,
    Expression<String>? creadoEn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fecha != null) 'fecha': fecha,
      if (metodoPago != null) 'metodo_pago': metodoPago,
      if (total != null) 'total': total,
      if (costoTotal != null) 'costo_total': costoTotal,
      if (observaciones != null) 'observaciones': observaciones,
      if (creadoEn != null) 'creado_en': creadoEn,
    });
  }

  VentasCompanion copyWith({
    Value<int>? id,
    Value<String>? fecha,
    Value<String>? metodoPago,
    Value<double>? total,
    Value<double>? costoTotal,
    Value<String?>? observaciones,
    Value<String>? creadoEn,
  }) {
    return VentasCompanion(
      id: id ?? this.id,
      fecha: fecha ?? this.fecha,
      metodoPago: metodoPago ?? this.metodoPago,
      total: total ?? this.total,
      costoTotal: costoTotal ?? this.costoTotal,
      observaciones: observaciones ?? this.observaciones,
      creadoEn: creadoEn ?? this.creadoEn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<String>(fecha.value);
    }
    if (metodoPago.present) {
      map['metodo_pago'] = Variable<String>(metodoPago.value);
    }
    if (total.present) {
      map['total'] = Variable<double>(total.value);
    }
    if (costoTotal.present) {
      map['costo_total'] = Variable<double>(costoTotal.value);
    }
    if (observaciones.present) {
      map['observaciones'] = Variable<String>(observaciones.value);
    }
    if (creadoEn.present) {
      map['creado_en'] = Variable<String>(creadoEn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VentasCompanion(')
          ..write('id: $id, ')
          ..write('fecha: $fecha, ')
          ..write('metodoPago: $metodoPago, ')
          ..write('total: $total, ')
          ..write('costoTotal: $costoTotal, ')
          ..write('observaciones: $observaciones, ')
          ..write('creadoEn: $creadoEn')
          ..write(')'))
        .toString();
  }
}

class $VentaDetallesTable extends VentaDetalles
    with TableInfo<$VentaDetallesTable, VentaDetalle> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VentaDetallesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _ventaIdMeta = const VerificationMeta(
    'ventaId',
  );
  @override
  late final GeneratedColumn<int> ventaId = GeneratedColumn<int>(
    'venta_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES ventas (id)',
    ),
  );
  static const VerificationMeta _productoIdMeta = const VerificationMeta(
    'productoId',
  );
  @override
  late final GeneratedColumn<int> productoId = GeneratedColumn<int>(
    'producto_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES productos (id)',
    ),
  );
  static const VerificationMeta _loteIdMeta = const VerificationMeta('loteId');
  @override
  late final GeneratedColumn<int> loteId = GeneratedColumn<int>(
    'lote_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES compra_detalles (id)',
    ),
  );
  static const VerificationMeta _cantidadMeta = const VerificationMeta(
    'cantidad',
  );
  @override
  late final GeneratedColumn<double> cantidad = GeneratedColumn<double>(
    'cantidad',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _precioVentaMeta = const VerificationMeta(
    'precioVenta',
  );
  @override
  late final GeneratedColumn<double> precioVenta = GeneratedColumn<double>(
    'precio_venta',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _precioCostoMeta = const VerificationMeta(
    'precioCosto',
  );
  @override
  late final GeneratedColumn<double> precioCosto = GeneratedColumn<double>(
    'precio_costo',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _creadoEnMeta = const VerificationMeta(
    'creadoEn',
  );
  @override
  late final GeneratedColumn<String> creadoEn = GeneratedColumn<String>(
    'creado_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => _nowLocal(),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ventaId,
    productoId,
    loteId,
    cantidad,
    precioVenta,
    precioCosto,
    creadoEn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'venta_detalles';
  @override
  VerificationContext validateIntegrity(
    Insertable<VentaDetalle> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('venta_id')) {
      context.handle(
        _ventaIdMeta,
        ventaId.isAcceptableOrUnknown(data['venta_id']!, _ventaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ventaIdMeta);
    }
    if (data.containsKey('producto_id')) {
      context.handle(
        _productoIdMeta,
        productoId.isAcceptableOrUnknown(data['producto_id']!, _productoIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productoIdMeta);
    }
    if (data.containsKey('lote_id')) {
      context.handle(
        _loteIdMeta,
        loteId.isAcceptableOrUnknown(data['lote_id']!, _loteIdMeta),
      );
    } else if (isInserting) {
      context.missing(_loteIdMeta);
    }
    if (data.containsKey('cantidad')) {
      context.handle(
        _cantidadMeta,
        cantidad.isAcceptableOrUnknown(data['cantidad']!, _cantidadMeta),
      );
    } else if (isInserting) {
      context.missing(_cantidadMeta);
    }
    if (data.containsKey('precio_venta')) {
      context.handle(
        _precioVentaMeta,
        precioVenta.isAcceptableOrUnknown(
          data['precio_venta']!,
          _precioVentaMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_precioVentaMeta);
    }
    if (data.containsKey('precio_costo')) {
      context.handle(
        _precioCostoMeta,
        precioCosto.isAcceptableOrUnknown(
          data['precio_costo']!,
          _precioCostoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_precioCostoMeta);
    }
    if (data.containsKey('creado_en')) {
      context.handle(
        _creadoEnMeta,
        creadoEn.isAcceptableOrUnknown(data['creado_en']!, _creadoEnMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VentaDetalle map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VentaDetalle(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      ventaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}venta_id'],
      )!,
      productoId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}producto_id'],
      )!,
      loteId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}lote_id'],
      )!,
      cantidad: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cantidad'],
      )!,
      precioVenta: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}precio_venta'],
      )!,
      precioCosto: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}precio_costo'],
      )!,
      creadoEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}creado_en'],
      )!,
    );
  }

  @override
  $VentaDetallesTable createAlias(String alias) {
    return $VentaDetallesTable(attachedDatabase, alias);
  }
}

class VentaDetalle extends DataClass implements Insertable<VentaDetalle> {
  final int id;
  final int ventaId;
  final int productoId;
  final int loteId;
  final double cantidad;
  final double precioVenta;
  final double precioCosto;
  final String creadoEn;
  const VentaDetalle({
    required this.id,
    required this.ventaId,
    required this.productoId,
    required this.loteId,
    required this.cantidad,
    required this.precioVenta,
    required this.precioCosto,
    required this.creadoEn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['venta_id'] = Variable<int>(ventaId);
    map['producto_id'] = Variable<int>(productoId);
    map['lote_id'] = Variable<int>(loteId);
    map['cantidad'] = Variable<double>(cantidad);
    map['precio_venta'] = Variable<double>(precioVenta);
    map['precio_costo'] = Variable<double>(precioCosto);
    map['creado_en'] = Variable<String>(creadoEn);
    return map;
  }

  VentaDetallesCompanion toCompanion(bool nullToAbsent) {
    return VentaDetallesCompanion(
      id: Value(id),
      ventaId: Value(ventaId),
      productoId: Value(productoId),
      loteId: Value(loteId),
      cantidad: Value(cantidad),
      precioVenta: Value(precioVenta),
      precioCosto: Value(precioCosto),
      creadoEn: Value(creadoEn),
    );
  }

  factory VentaDetalle.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VentaDetalle(
      id: serializer.fromJson<int>(json['id']),
      ventaId: serializer.fromJson<int>(json['ventaId']),
      productoId: serializer.fromJson<int>(json['productoId']),
      loteId: serializer.fromJson<int>(json['loteId']),
      cantidad: serializer.fromJson<double>(json['cantidad']),
      precioVenta: serializer.fromJson<double>(json['precioVenta']),
      precioCosto: serializer.fromJson<double>(json['precioCosto']),
      creadoEn: serializer.fromJson<String>(json['creadoEn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ventaId': serializer.toJson<int>(ventaId),
      'productoId': serializer.toJson<int>(productoId),
      'loteId': serializer.toJson<int>(loteId),
      'cantidad': serializer.toJson<double>(cantidad),
      'precioVenta': serializer.toJson<double>(precioVenta),
      'precioCosto': serializer.toJson<double>(precioCosto),
      'creadoEn': serializer.toJson<String>(creadoEn),
    };
  }

  VentaDetalle copyWith({
    int? id,
    int? ventaId,
    int? productoId,
    int? loteId,
    double? cantidad,
    double? precioVenta,
    double? precioCosto,
    String? creadoEn,
  }) => VentaDetalle(
    id: id ?? this.id,
    ventaId: ventaId ?? this.ventaId,
    productoId: productoId ?? this.productoId,
    loteId: loteId ?? this.loteId,
    cantidad: cantidad ?? this.cantidad,
    precioVenta: precioVenta ?? this.precioVenta,
    precioCosto: precioCosto ?? this.precioCosto,
    creadoEn: creadoEn ?? this.creadoEn,
  );
  VentaDetalle copyWithCompanion(VentaDetallesCompanion data) {
    return VentaDetalle(
      id: data.id.present ? data.id.value : this.id,
      ventaId: data.ventaId.present ? data.ventaId.value : this.ventaId,
      productoId: data.productoId.present
          ? data.productoId.value
          : this.productoId,
      loteId: data.loteId.present ? data.loteId.value : this.loteId,
      cantidad: data.cantidad.present ? data.cantidad.value : this.cantidad,
      precioVenta: data.precioVenta.present
          ? data.precioVenta.value
          : this.precioVenta,
      precioCosto: data.precioCosto.present
          ? data.precioCosto.value
          : this.precioCosto,
      creadoEn: data.creadoEn.present ? data.creadoEn.value : this.creadoEn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VentaDetalle(')
          ..write('id: $id, ')
          ..write('ventaId: $ventaId, ')
          ..write('productoId: $productoId, ')
          ..write('loteId: $loteId, ')
          ..write('cantidad: $cantidad, ')
          ..write('precioVenta: $precioVenta, ')
          ..write('precioCosto: $precioCosto, ')
          ..write('creadoEn: $creadoEn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    ventaId,
    productoId,
    loteId,
    cantidad,
    precioVenta,
    precioCosto,
    creadoEn,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VentaDetalle &&
          other.id == this.id &&
          other.ventaId == this.ventaId &&
          other.productoId == this.productoId &&
          other.loteId == this.loteId &&
          other.cantidad == this.cantidad &&
          other.precioVenta == this.precioVenta &&
          other.precioCosto == this.precioCosto &&
          other.creadoEn == this.creadoEn);
}

class VentaDetallesCompanion extends UpdateCompanion<VentaDetalle> {
  final Value<int> id;
  final Value<int> ventaId;
  final Value<int> productoId;
  final Value<int> loteId;
  final Value<double> cantidad;
  final Value<double> precioVenta;
  final Value<double> precioCosto;
  final Value<String> creadoEn;
  const VentaDetallesCompanion({
    this.id = const Value.absent(),
    this.ventaId = const Value.absent(),
    this.productoId = const Value.absent(),
    this.loteId = const Value.absent(),
    this.cantidad = const Value.absent(),
    this.precioVenta = const Value.absent(),
    this.precioCosto = const Value.absent(),
    this.creadoEn = const Value.absent(),
  });
  VentaDetallesCompanion.insert({
    this.id = const Value.absent(),
    required int ventaId,
    required int productoId,
    required int loteId,
    required double cantidad,
    required double precioVenta,
    required double precioCosto,
    this.creadoEn = const Value.absent(),
  }) : ventaId = Value(ventaId),
       productoId = Value(productoId),
       loteId = Value(loteId),
       cantidad = Value(cantidad),
       precioVenta = Value(precioVenta),
       precioCosto = Value(precioCosto);
  static Insertable<VentaDetalle> custom({
    Expression<int>? id,
    Expression<int>? ventaId,
    Expression<int>? productoId,
    Expression<int>? loteId,
    Expression<double>? cantidad,
    Expression<double>? precioVenta,
    Expression<double>? precioCosto,
    Expression<String>? creadoEn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ventaId != null) 'venta_id': ventaId,
      if (productoId != null) 'producto_id': productoId,
      if (loteId != null) 'lote_id': loteId,
      if (cantidad != null) 'cantidad': cantidad,
      if (precioVenta != null) 'precio_venta': precioVenta,
      if (precioCosto != null) 'precio_costo': precioCosto,
      if (creadoEn != null) 'creado_en': creadoEn,
    });
  }

  VentaDetallesCompanion copyWith({
    Value<int>? id,
    Value<int>? ventaId,
    Value<int>? productoId,
    Value<int>? loteId,
    Value<double>? cantidad,
    Value<double>? precioVenta,
    Value<double>? precioCosto,
    Value<String>? creadoEn,
  }) {
    return VentaDetallesCompanion(
      id: id ?? this.id,
      ventaId: ventaId ?? this.ventaId,
      productoId: productoId ?? this.productoId,
      loteId: loteId ?? this.loteId,
      cantidad: cantidad ?? this.cantidad,
      precioVenta: precioVenta ?? this.precioVenta,
      precioCosto: precioCosto ?? this.precioCosto,
      creadoEn: creadoEn ?? this.creadoEn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ventaId.present) {
      map['venta_id'] = Variable<int>(ventaId.value);
    }
    if (productoId.present) {
      map['producto_id'] = Variable<int>(productoId.value);
    }
    if (loteId.present) {
      map['lote_id'] = Variable<int>(loteId.value);
    }
    if (cantidad.present) {
      map['cantidad'] = Variable<double>(cantidad.value);
    }
    if (precioVenta.present) {
      map['precio_venta'] = Variable<double>(precioVenta.value);
    }
    if (precioCosto.present) {
      map['precio_costo'] = Variable<double>(precioCosto.value);
    }
    if (creadoEn.present) {
      map['creado_en'] = Variable<String>(creadoEn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VentaDetallesCompanion(')
          ..write('id: $id, ')
          ..write('ventaId: $ventaId, ')
          ..write('productoId: $productoId, ')
          ..write('loteId: $loteId, ')
          ..write('cantidad: $cantidad, ')
          ..write('precioVenta: $precioVenta, ')
          ..write('precioCosto: $precioCosto, ')
          ..write('creadoEn: $creadoEn')
          ..write(')'))
        .toString();
  }
}

class $AjustesInventarioTable extends AjustesInventario
    with TableInfo<$AjustesInventarioTable, AjustesInventarioData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AjustesInventarioTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _productoIdMeta = const VerificationMeta(
    'productoId',
  );
  @override
  late final GeneratedColumn<int> productoId = GeneratedColumn<int>(
    'producto_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES productos (id)',
    ),
  );
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<String> fecha = GeneratedColumn<String>(
    'fecha',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => _nowLocal(),
  );
  static const VerificationMeta _tipoMeta = const VerificationMeta('tipo');
  @override
  late final GeneratedColumn<String> tipo = GeneratedColumn<String>(
    'tipo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cantidadMeta = const VerificationMeta(
    'cantidad',
  );
  @override
  late final GeneratedColumn<double> cantidad = GeneratedColumn<double>(
    'cantidad',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _motivoMeta = const VerificationMeta('motivo');
  @override
  late final GeneratedColumn<String> motivo = GeneratedColumn<String>(
    'motivo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stockAntesMeta = const VerificationMeta(
    'stockAntes',
  );
  @override
  late final GeneratedColumn<double> stockAntes = GeneratedColumn<double>(
    'stock_antes',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stockDespuesMeta = const VerificationMeta(
    'stockDespues',
  );
  @override
  late final GeneratedColumn<double> stockDespues = GeneratedColumn<double>(
    'stock_despues',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _creadoEnMeta = const VerificationMeta(
    'creadoEn',
  );
  @override
  late final GeneratedColumn<String> creadoEn = GeneratedColumn<String>(
    'creado_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => _nowLocal(),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    productoId,
    fecha,
    tipo,
    cantidad,
    motivo,
    stockAntes,
    stockDespues,
    creadoEn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ajustes_inventario';
  @override
  VerificationContext validateIntegrity(
    Insertable<AjustesInventarioData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('producto_id')) {
      context.handle(
        _productoIdMeta,
        productoId.isAcceptableOrUnknown(data['producto_id']!, _productoIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productoIdMeta);
    }
    if (data.containsKey('fecha')) {
      context.handle(
        _fechaMeta,
        fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta),
      );
    }
    if (data.containsKey('tipo')) {
      context.handle(
        _tipoMeta,
        tipo.isAcceptableOrUnknown(data['tipo']!, _tipoMeta),
      );
    } else if (isInserting) {
      context.missing(_tipoMeta);
    }
    if (data.containsKey('cantidad')) {
      context.handle(
        _cantidadMeta,
        cantidad.isAcceptableOrUnknown(data['cantidad']!, _cantidadMeta),
      );
    } else if (isInserting) {
      context.missing(_cantidadMeta);
    }
    if (data.containsKey('motivo')) {
      context.handle(
        _motivoMeta,
        motivo.isAcceptableOrUnknown(data['motivo']!, _motivoMeta),
      );
    } else if (isInserting) {
      context.missing(_motivoMeta);
    }
    if (data.containsKey('stock_antes')) {
      context.handle(
        _stockAntesMeta,
        stockAntes.isAcceptableOrUnknown(data['stock_antes']!, _stockAntesMeta),
      );
    } else if (isInserting) {
      context.missing(_stockAntesMeta);
    }
    if (data.containsKey('stock_despues')) {
      context.handle(
        _stockDespuesMeta,
        stockDespues.isAcceptableOrUnknown(
          data['stock_despues']!,
          _stockDespuesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_stockDespuesMeta);
    }
    if (data.containsKey('creado_en')) {
      context.handle(
        _creadoEnMeta,
        creadoEn.isAcceptableOrUnknown(data['creado_en']!, _creadoEnMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AjustesInventarioData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AjustesInventarioData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      productoId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}producto_id'],
      )!,
      fecha: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fecha'],
      )!,
      tipo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tipo'],
      )!,
      cantidad: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cantidad'],
      )!,
      motivo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}motivo'],
      )!,
      stockAntes: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}stock_antes'],
      )!,
      stockDespues: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}stock_despues'],
      )!,
      creadoEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}creado_en'],
      )!,
    );
  }

  @override
  $AjustesInventarioTable createAlias(String alias) {
    return $AjustesInventarioTable(attachedDatabase, alias);
  }
}

class AjustesInventarioData extends DataClass
    implements Insertable<AjustesInventarioData> {
  final int id;
  final int productoId;
  final String fecha;
  final String tipo;
  final double cantidad;
  final String motivo;
  final double stockAntes;
  final double stockDespues;
  final String creadoEn;
  const AjustesInventarioData({
    required this.id,
    required this.productoId,
    required this.fecha,
    required this.tipo,
    required this.cantidad,
    required this.motivo,
    required this.stockAntes,
    required this.stockDespues,
    required this.creadoEn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['producto_id'] = Variable<int>(productoId);
    map['fecha'] = Variable<String>(fecha);
    map['tipo'] = Variable<String>(tipo);
    map['cantidad'] = Variable<double>(cantidad);
    map['motivo'] = Variable<String>(motivo);
    map['stock_antes'] = Variable<double>(stockAntes);
    map['stock_despues'] = Variable<double>(stockDespues);
    map['creado_en'] = Variable<String>(creadoEn);
    return map;
  }

  AjustesInventarioCompanion toCompanion(bool nullToAbsent) {
    return AjustesInventarioCompanion(
      id: Value(id),
      productoId: Value(productoId),
      fecha: Value(fecha),
      tipo: Value(tipo),
      cantidad: Value(cantidad),
      motivo: Value(motivo),
      stockAntes: Value(stockAntes),
      stockDespues: Value(stockDespues),
      creadoEn: Value(creadoEn),
    );
  }

  factory AjustesInventarioData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AjustesInventarioData(
      id: serializer.fromJson<int>(json['id']),
      productoId: serializer.fromJson<int>(json['productoId']),
      fecha: serializer.fromJson<String>(json['fecha']),
      tipo: serializer.fromJson<String>(json['tipo']),
      cantidad: serializer.fromJson<double>(json['cantidad']),
      motivo: serializer.fromJson<String>(json['motivo']),
      stockAntes: serializer.fromJson<double>(json['stockAntes']),
      stockDespues: serializer.fromJson<double>(json['stockDespues']),
      creadoEn: serializer.fromJson<String>(json['creadoEn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productoId': serializer.toJson<int>(productoId),
      'fecha': serializer.toJson<String>(fecha),
      'tipo': serializer.toJson<String>(tipo),
      'cantidad': serializer.toJson<double>(cantidad),
      'motivo': serializer.toJson<String>(motivo),
      'stockAntes': serializer.toJson<double>(stockAntes),
      'stockDespues': serializer.toJson<double>(stockDespues),
      'creadoEn': serializer.toJson<String>(creadoEn),
    };
  }

  AjustesInventarioData copyWith({
    int? id,
    int? productoId,
    String? fecha,
    String? tipo,
    double? cantidad,
    String? motivo,
    double? stockAntes,
    double? stockDespues,
    String? creadoEn,
  }) => AjustesInventarioData(
    id: id ?? this.id,
    productoId: productoId ?? this.productoId,
    fecha: fecha ?? this.fecha,
    tipo: tipo ?? this.tipo,
    cantidad: cantidad ?? this.cantidad,
    motivo: motivo ?? this.motivo,
    stockAntes: stockAntes ?? this.stockAntes,
    stockDespues: stockDespues ?? this.stockDespues,
    creadoEn: creadoEn ?? this.creadoEn,
  );
  AjustesInventarioData copyWithCompanion(AjustesInventarioCompanion data) {
    return AjustesInventarioData(
      id: data.id.present ? data.id.value : this.id,
      productoId: data.productoId.present
          ? data.productoId.value
          : this.productoId,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
      tipo: data.tipo.present ? data.tipo.value : this.tipo,
      cantidad: data.cantidad.present ? data.cantidad.value : this.cantidad,
      motivo: data.motivo.present ? data.motivo.value : this.motivo,
      stockAntes: data.stockAntes.present
          ? data.stockAntes.value
          : this.stockAntes,
      stockDespues: data.stockDespues.present
          ? data.stockDespues.value
          : this.stockDespues,
      creadoEn: data.creadoEn.present ? data.creadoEn.value : this.creadoEn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AjustesInventarioData(')
          ..write('id: $id, ')
          ..write('productoId: $productoId, ')
          ..write('fecha: $fecha, ')
          ..write('tipo: $tipo, ')
          ..write('cantidad: $cantidad, ')
          ..write('motivo: $motivo, ')
          ..write('stockAntes: $stockAntes, ')
          ..write('stockDespues: $stockDespues, ')
          ..write('creadoEn: $creadoEn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    productoId,
    fecha,
    tipo,
    cantidad,
    motivo,
    stockAntes,
    stockDespues,
    creadoEn,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AjustesInventarioData &&
          other.id == this.id &&
          other.productoId == this.productoId &&
          other.fecha == this.fecha &&
          other.tipo == this.tipo &&
          other.cantidad == this.cantidad &&
          other.motivo == this.motivo &&
          other.stockAntes == this.stockAntes &&
          other.stockDespues == this.stockDespues &&
          other.creadoEn == this.creadoEn);
}

class AjustesInventarioCompanion
    extends UpdateCompanion<AjustesInventarioData> {
  final Value<int> id;
  final Value<int> productoId;
  final Value<String> fecha;
  final Value<String> tipo;
  final Value<double> cantidad;
  final Value<String> motivo;
  final Value<double> stockAntes;
  final Value<double> stockDespues;
  final Value<String> creadoEn;
  const AjustesInventarioCompanion({
    this.id = const Value.absent(),
    this.productoId = const Value.absent(),
    this.fecha = const Value.absent(),
    this.tipo = const Value.absent(),
    this.cantidad = const Value.absent(),
    this.motivo = const Value.absent(),
    this.stockAntes = const Value.absent(),
    this.stockDespues = const Value.absent(),
    this.creadoEn = const Value.absent(),
  });
  AjustesInventarioCompanion.insert({
    this.id = const Value.absent(),
    required int productoId,
    this.fecha = const Value.absent(),
    required String tipo,
    required double cantidad,
    required String motivo,
    required double stockAntes,
    required double stockDespues,
    this.creadoEn = const Value.absent(),
  }) : productoId = Value(productoId),
       tipo = Value(tipo),
       cantidad = Value(cantidad),
       motivo = Value(motivo),
       stockAntes = Value(stockAntes),
       stockDespues = Value(stockDespues);
  static Insertable<AjustesInventarioData> custom({
    Expression<int>? id,
    Expression<int>? productoId,
    Expression<String>? fecha,
    Expression<String>? tipo,
    Expression<double>? cantidad,
    Expression<String>? motivo,
    Expression<double>? stockAntes,
    Expression<double>? stockDespues,
    Expression<String>? creadoEn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productoId != null) 'producto_id': productoId,
      if (fecha != null) 'fecha': fecha,
      if (tipo != null) 'tipo': tipo,
      if (cantidad != null) 'cantidad': cantidad,
      if (motivo != null) 'motivo': motivo,
      if (stockAntes != null) 'stock_antes': stockAntes,
      if (stockDespues != null) 'stock_despues': stockDespues,
      if (creadoEn != null) 'creado_en': creadoEn,
    });
  }

  AjustesInventarioCompanion copyWith({
    Value<int>? id,
    Value<int>? productoId,
    Value<String>? fecha,
    Value<String>? tipo,
    Value<double>? cantidad,
    Value<String>? motivo,
    Value<double>? stockAntes,
    Value<double>? stockDespues,
    Value<String>? creadoEn,
  }) {
    return AjustesInventarioCompanion(
      id: id ?? this.id,
      productoId: productoId ?? this.productoId,
      fecha: fecha ?? this.fecha,
      tipo: tipo ?? this.tipo,
      cantidad: cantidad ?? this.cantidad,
      motivo: motivo ?? this.motivo,
      stockAntes: stockAntes ?? this.stockAntes,
      stockDespues: stockDespues ?? this.stockDespues,
      creadoEn: creadoEn ?? this.creadoEn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productoId.present) {
      map['producto_id'] = Variable<int>(productoId.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<String>(fecha.value);
    }
    if (tipo.present) {
      map['tipo'] = Variable<String>(tipo.value);
    }
    if (cantidad.present) {
      map['cantidad'] = Variable<double>(cantidad.value);
    }
    if (motivo.present) {
      map['motivo'] = Variable<String>(motivo.value);
    }
    if (stockAntes.present) {
      map['stock_antes'] = Variable<double>(stockAntes.value);
    }
    if (stockDespues.present) {
      map['stock_despues'] = Variable<double>(stockDespues.value);
    }
    if (creadoEn.present) {
      map['creado_en'] = Variable<String>(creadoEn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AjustesInventarioCompanion(')
          ..write('id: $id, ')
          ..write('productoId: $productoId, ')
          ..write('fecha: $fecha, ')
          ..write('tipo: $tipo, ')
          ..write('cantidad: $cantidad, ')
          ..write('motivo: $motivo, ')
          ..write('stockAntes: $stockAntes, ')
          ..write('stockDespues: $stockDespues, ')
          ..write('creadoEn: $creadoEn')
          ..write(')'))
        .toString();
  }
}

class $HistorialMargenesTable extends HistorialMargenes
    with TableInfo<$HistorialMargenesTable, HistorialMargene> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HistorialMargenesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _productoIdMeta = const VerificationMeta(
    'productoId',
  );
  @override
  late final GeneratedColumn<int> productoId = GeneratedColumn<int>(
    'producto_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES productos (id)',
    ),
  );
  static const VerificationMeta _margenAnteriorMeta = const VerificationMeta(
    'margenAnterior',
  );
  @override
  late final GeneratedColumn<double> margenAnterior = GeneratedColumn<double>(
    'margen_anterior',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _margenNuevoMeta = const VerificationMeta(
    'margenNuevo',
  );
  @override
  late final GeneratedColumn<double> margenNuevo = GeneratedColumn<double>(
    'margen_nuevo',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _precioVentaAnteriorMeta =
      const VerificationMeta('precioVentaAnterior');
  @override
  late final GeneratedColumn<double> precioVentaAnterior =
      GeneratedColumn<double>(
        'precio_venta_anterior',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _precioVentaNuevoMeta = const VerificationMeta(
    'precioVentaNuevo',
  );
  @override
  late final GeneratedColumn<double> precioVentaNuevo = GeneratedColumn<double>(
    'precio_venta_nuevo',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _motivoMeta = const VerificationMeta('motivo');
  @override
  late final GeneratedColumn<String> motivo = GeneratedColumn<String>(
    'motivo',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<String> fecha = GeneratedColumn<String>(
    'fecha',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => _nowLocal(),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    productoId,
    margenAnterior,
    margenNuevo,
    precioVentaAnterior,
    precioVentaNuevo,
    motivo,
    fecha,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'historial_margenes';
  @override
  VerificationContext validateIntegrity(
    Insertable<HistorialMargene> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('producto_id')) {
      context.handle(
        _productoIdMeta,
        productoId.isAcceptableOrUnknown(data['producto_id']!, _productoIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productoIdMeta);
    }
    if (data.containsKey('margen_anterior')) {
      context.handle(
        _margenAnteriorMeta,
        margenAnterior.isAcceptableOrUnknown(
          data['margen_anterior']!,
          _margenAnteriorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_margenAnteriorMeta);
    }
    if (data.containsKey('margen_nuevo')) {
      context.handle(
        _margenNuevoMeta,
        margenNuevo.isAcceptableOrUnknown(
          data['margen_nuevo']!,
          _margenNuevoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_margenNuevoMeta);
    }
    if (data.containsKey('precio_venta_anterior')) {
      context.handle(
        _precioVentaAnteriorMeta,
        precioVentaAnterior.isAcceptableOrUnknown(
          data['precio_venta_anterior']!,
          _precioVentaAnteriorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_precioVentaAnteriorMeta);
    }
    if (data.containsKey('precio_venta_nuevo')) {
      context.handle(
        _precioVentaNuevoMeta,
        precioVentaNuevo.isAcceptableOrUnknown(
          data['precio_venta_nuevo']!,
          _precioVentaNuevoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_precioVentaNuevoMeta);
    }
    if (data.containsKey('motivo')) {
      context.handle(
        _motivoMeta,
        motivo.isAcceptableOrUnknown(data['motivo']!, _motivoMeta),
      );
    }
    if (data.containsKey('fecha')) {
      context.handle(
        _fechaMeta,
        fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HistorialMargene map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HistorialMargene(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      productoId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}producto_id'],
      )!,
      margenAnterior: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}margen_anterior'],
      )!,
      margenNuevo: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}margen_nuevo'],
      )!,
      precioVentaAnterior: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}precio_venta_anterior'],
      )!,
      precioVentaNuevo: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}precio_venta_nuevo'],
      )!,
      motivo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}motivo'],
      ),
      fecha: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fecha'],
      )!,
    );
  }

  @override
  $HistorialMargenesTable createAlias(String alias) {
    return $HistorialMargenesTable(attachedDatabase, alias);
  }
}

class HistorialMargene extends DataClass
    implements Insertable<HistorialMargene> {
  final int id;
  final int productoId;
  final double margenAnterior;
  final double margenNuevo;
  final double precioVentaAnterior;
  final double precioVentaNuevo;
  final String? motivo;
  final String fecha;
  const HistorialMargene({
    required this.id,
    required this.productoId,
    required this.margenAnterior,
    required this.margenNuevo,
    required this.precioVentaAnterior,
    required this.precioVentaNuevo,
    this.motivo,
    required this.fecha,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['producto_id'] = Variable<int>(productoId);
    map['margen_anterior'] = Variable<double>(margenAnterior);
    map['margen_nuevo'] = Variable<double>(margenNuevo);
    map['precio_venta_anterior'] = Variable<double>(precioVentaAnterior);
    map['precio_venta_nuevo'] = Variable<double>(precioVentaNuevo);
    if (!nullToAbsent || motivo != null) {
      map['motivo'] = Variable<String>(motivo);
    }
    map['fecha'] = Variable<String>(fecha);
    return map;
  }

  HistorialMargenesCompanion toCompanion(bool nullToAbsent) {
    return HistorialMargenesCompanion(
      id: Value(id),
      productoId: Value(productoId),
      margenAnterior: Value(margenAnterior),
      margenNuevo: Value(margenNuevo),
      precioVentaAnterior: Value(precioVentaAnterior),
      precioVentaNuevo: Value(precioVentaNuevo),
      motivo: motivo == null && nullToAbsent
          ? const Value.absent()
          : Value(motivo),
      fecha: Value(fecha),
    );
  }

  factory HistorialMargene.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HistorialMargene(
      id: serializer.fromJson<int>(json['id']),
      productoId: serializer.fromJson<int>(json['productoId']),
      margenAnterior: serializer.fromJson<double>(json['margenAnterior']),
      margenNuevo: serializer.fromJson<double>(json['margenNuevo']),
      precioVentaAnterior: serializer.fromJson<double>(
        json['precioVentaAnterior'],
      ),
      precioVentaNuevo: serializer.fromJson<double>(json['precioVentaNuevo']),
      motivo: serializer.fromJson<String?>(json['motivo']),
      fecha: serializer.fromJson<String>(json['fecha']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productoId': serializer.toJson<int>(productoId),
      'margenAnterior': serializer.toJson<double>(margenAnterior),
      'margenNuevo': serializer.toJson<double>(margenNuevo),
      'precioVentaAnterior': serializer.toJson<double>(precioVentaAnterior),
      'precioVentaNuevo': serializer.toJson<double>(precioVentaNuevo),
      'motivo': serializer.toJson<String?>(motivo),
      'fecha': serializer.toJson<String>(fecha),
    };
  }

  HistorialMargene copyWith({
    int? id,
    int? productoId,
    double? margenAnterior,
    double? margenNuevo,
    double? precioVentaAnterior,
    double? precioVentaNuevo,
    Value<String?> motivo = const Value.absent(),
    String? fecha,
  }) => HistorialMargene(
    id: id ?? this.id,
    productoId: productoId ?? this.productoId,
    margenAnterior: margenAnterior ?? this.margenAnterior,
    margenNuevo: margenNuevo ?? this.margenNuevo,
    precioVentaAnterior: precioVentaAnterior ?? this.precioVentaAnterior,
    precioVentaNuevo: precioVentaNuevo ?? this.precioVentaNuevo,
    motivo: motivo.present ? motivo.value : this.motivo,
    fecha: fecha ?? this.fecha,
  );
  HistorialMargene copyWithCompanion(HistorialMargenesCompanion data) {
    return HistorialMargene(
      id: data.id.present ? data.id.value : this.id,
      productoId: data.productoId.present
          ? data.productoId.value
          : this.productoId,
      margenAnterior: data.margenAnterior.present
          ? data.margenAnterior.value
          : this.margenAnterior,
      margenNuevo: data.margenNuevo.present
          ? data.margenNuevo.value
          : this.margenNuevo,
      precioVentaAnterior: data.precioVentaAnterior.present
          ? data.precioVentaAnterior.value
          : this.precioVentaAnterior,
      precioVentaNuevo: data.precioVentaNuevo.present
          ? data.precioVentaNuevo.value
          : this.precioVentaNuevo,
      motivo: data.motivo.present ? data.motivo.value : this.motivo,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HistorialMargene(')
          ..write('id: $id, ')
          ..write('productoId: $productoId, ')
          ..write('margenAnterior: $margenAnterior, ')
          ..write('margenNuevo: $margenNuevo, ')
          ..write('precioVentaAnterior: $precioVentaAnterior, ')
          ..write('precioVentaNuevo: $precioVentaNuevo, ')
          ..write('motivo: $motivo, ')
          ..write('fecha: $fecha')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    productoId,
    margenAnterior,
    margenNuevo,
    precioVentaAnterior,
    precioVentaNuevo,
    motivo,
    fecha,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HistorialMargene &&
          other.id == this.id &&
          other.productoId == this.productoId &&
          other.margenAnterior == this.margenAnterior &&
          other.margenNuevo == this.margenNuevo &&
          other.precioVentaAnterior == this.precioVentaAnterior &&
          other.precioVentaNuevo == this.precioVentaNuevo &&
          other.motivo == this.motivo &&
          other.fecha == this.fecha);
}

class HistorialMargenesCompanion extends UpdateCompanion<HistorialMargene> {
  final Value<int> id;
  final Value<int> productoId;
  final Value<double> margenAnterior;
  final Value<double> margenNuevo;
  final Value<double> precioVentaAnterior;
  final Value<double> precioVentaNuevo;
  final Value<String?> motivo;
  final Value<String> fecha;
  const HistorialMargenesCompanion({
    this.id = const Value.absent(),
    this.productoId = const Value.absent(),
    this.margenAnterior = const Value.absent(),
    this.margenNuevo = const Value.absent(),
    this.precioVentaAnterior = const Value.absent(),
    this.precioVentaNuevo = const Value.absent(),
    this.motivo = const Value.absent(),
    this.fecha = const Value.absent(),
  });
  HistorialMargenesCompanion.insert({
    this.id = const Value.absent(),
    required int productoId,
    required double margenAnterior,
    required double margenNuevo,
    required double precioVentaAnterior,
    required double precioVentaNuevo,
    this.motivo = const Value.absent(),
    this.fecha = const Value.absent(),
  }) : productoId = Value(productoId),
       margenAnterior = Value(margenAnterior),
       margenNuevo = Value(margenNuevo),
       precioVentaAnterior = Value(precioVentaAnterior),
       precioVentaNuevo = Value(precioVentaNuevo);
  static Insertable<HistorialMargene> custom({
    Expression<int>? id,
    Expression<int>? productoId,
    Expression<double>? margenAnterior,
    Expression<double>? margenNuevo,
    Expression<double>? precioVentaAnterior,
    Expression<double>? precioVentaNuevo,
    Expression<String>? motivo,
    Expression<String>? fecha,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productoId != null) 'producto_id': productoId,
      if (margenAnterior != null) 'margen_anterior': margenAnterior,
      if (margenNuevo != null) 'margen_nuevo': margenNuevo,
      if (precioVentaAnterior != null)
        'precio_venta_anterior': precioVentaAnterior,
      if (precioVentaNuevo != null) 'precio_venta_nuevo': precioVentaNuevo,
      if (motivo != null) 'motivo': motivo,
      if (fecha != null) 'fecha': fecha,
    });
  }

  HistorialMargenesCompanion copyWith({
    Value<int>? id,
    Value<int>? productoId,
    Value<double>? margenAnterior,
    Value<double>? margenNuevo,
    Value<double>? precioVentaAnterior,
    Value<double>? precioVentaNuevo,
    Value<String?>? motivo,
    Value<String>? fecha,
  }) {
    return HistorialMargenesCompanion(
      id: id ?? this.id,
      productoId: productoId ?? this.productoId,
      margenAnterior: margenAnterior ?? this.margenAnterior,
      margenNuevo: margenNuevo ?? this.margenNuevo,
      precioVentaAnterior: precioVentaAnterior ?? this.precioVentaAnterior,
      precioVentaNuevo: precioVentaNuevo ?? this.precioVentaNuevo,
      motivo: motivo ?? this.motivo,
      fecha: fecha ?? this.fecha,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productoId.present) {
      map['producto_id'] = Variable<int>(productoId.value);
    }
    if (margenAnterior.present) {
      map['margen_anterior'] = Variable<double>(margenAnterior.value);
    }
    if (margenNuevo.present) {
      map['margen_nuevo'] = Variable<double>(margenNuevo.value);
    }
    if (precioVentaAnterior.present) {
      map['precio_venta_anterior'] = Variable<double>(
        precioVentaAnterior.value,
      );
    }
    if (precioVentaNuevo.present) {
      map['precio_venta_nuevo'] = Variable<double>(precioVentaNuevo.value);
    }
    if (motivo.present) {
      map['motivo'] = Variable<String>(motivo.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<String>(fecha.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HistorialMargenesCompanion(')
          ..write('id: $id, ')
          ..write('productoId: $productoId, ')
          ..write('margenAnterior: $margenAnterior, ')
          ..write('margenNuevo: $margenNuevo, ')
          ..write('precioVentaAnterior: $precioVentaAnterior, ')
          ..write('precioVentaNuevo: $precioVentaNuevo, ')
          ..write('motivo: $motivo, ')
          ..write('fecha: $fecha')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CategoriasTable categorias = $CategoriasTable(this);
  late final $ProveedoresTable proveedores = $ProveedoresTable(this);
  late final $ProductosTable productos = $ProductosTable(this);
  late final $ComprasTable compras = $ComprasTable(this);
  late final $CompraDetallesTable compraDetalles = $CompraDetallesTable(this);
  late final $VentasTable ventas = $VentasTable(this);
  late final $VentaDetallesTable ventaDetalles = $VentaDetallesTable(this);
  late final $AjustesInventarioTable ajustesInventario =
      $AjustesInventarioTable(this);
  late final $HistorialMargenesTable historialMargenes =
      $HistorialMargenesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    categorias,
    proveedores,
    productos,
    compras,
    compraDetalles,
    ventas,
    ventaDetalles,
    ajustesInventario,
    historialMargenes,
  ];
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}

typedef $$CategoriasTableCreateCompanionBuilder =
    CategoriasCompanion Function({
      Value<int> id,
      required String nombre,
      Value<String?> descripcion,
      Value<int> activa,
      Value<String> creadoEn,
    });
typedef $$CategoriasTableUpdateCompanionBuilder =
    CategoriasCompanion Function({
      Value<int> id,
      Value<String> nombre,
      Value<String?> descripcion,
      Value<int> activa,
      Value<String> creadoEn,
    });

final class $$CategoriasTableReferences
    extends BaseReferences<_$AppDatabase, $CategoriasTable, Categoria> {
  $$CategoriasTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ProductosTable, List<Producto>>
  _productosRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.productos,
    aliasName: $_aliasNameGenerator(db.categorias.id, db.productos.categoriaId),
  );

  $$ProductosTableProcessedTableManager get productosRefs {
    final manager = $$ProductosTableTableManager(
      $_db,
      $_db.productos,
    ).filter((f) => f.categoriaId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_productosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CategoriasTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriasTable> {
  $$CategoriasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get activa => $composableBuilder(
    column: $table.activa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> productosRefs(
    Expression<bool> Function($$ProductosTableFilterComposer f) f,
  ) {
    final $$ProductosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.productos,
      getReferencedColumn: (t) => t.categoriaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductosTableFilterComposer(
            $db: $db,
            $table: $db.productos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriasTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriasTable> {
  $$CategoriasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get activa => $composableBuilder(
    column: $table.activa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoriasTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriasTable> {
  $$CategoriasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => column,
  );

  GeneratedColumn<int> get activa =>
      $composableBuilder(column: $table.activa, builder: (column) => column);

  GeneratedColumn<String> get creadoEn =>
      $composableBuilder(column: $table.creadoEn, builder: (column) => column);

  Expression<T> productosRefs<T extends Object>(
    Expression<T> Function($$ProductosTableAnnotationComposer a) f,
  ) {
    final $$ProductosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.productos,
      getReferencedColumn: (t) => t.categoriaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductosTableAnnotationComposer(
            $db: $db,
            $table: $db.productos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoriasTable,
          Categoria,
          $$CategoriasTableFilterComposer,
          $$CategoriasTableOrderingComposer,
          $$CategoriasTableAnnotationComposer,
          $$CategoriasTableCreateCompanionBuilder,
          $$CategoriasTableUpdateCompanionBuilder,
          (Categoria, $$CategoriasTableReferences),
          Categoria,
          PrefetchHooks Function({bool productosRefs})
        > {
  $$CategoriasTableTableManager(_$AppDatabase db, $CategoriasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<String?> descripcion = const Value.absent(),
                Value<int> activa = const Value.absent(),
                Value<String> creadoEn = const Value.absent(),
              }) => CategoriasCompanion(
                id: id,
                nombre: nombre,
                descripcion: descripcion,
                activa: activa,
                creadoEn: creadoEn,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nombre,
                Value<String?> descripcion = const Value.absent(),
                Value<int> activa = const Value.absent(),
                Value<String> creadoEn = const Value.absent(),
              }) => CategoriasCompanion.insert(
                id: id,
                nombre: nombre,
                descripcion: descripcion,
                activa: activa,
                creadoEn: creadoEn,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CategoriasTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({productosRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (productosRefs) db.productos],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (productosRefs)
                    await $_getPrefetchedData<
                      Categoria,
                      $CategoriasTable,
                      Producto
                    >(
                      currentTable: table,
                      referencedTable: $$CategoriasTableReferences
                          ._productosRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CategoriasTableReferences(
                            db,
                            table,
                            p0,
                          ).productosRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.categoriaId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CategoriasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoriasTable,
      Categoria,
      $$CategoriasTableFilterComposer,
      $$CategoriasTableOrderingComposer,
      $$CategoriasTableAnnotationComposer,
      $$CategoriasTableCreateCompanionBuilder,
      $$CategoriasTableUpdateCompanionBuilder,
      (Categoria, $$CategoriasTableReferences),
      Categoria,
      PrefetchHooks Function({bool productosRefs})
    >;
typedef $$ProveedoresTableCreateCompanionBuilder =
    ProveedoresCompanion Function({
      Value<int> id,
      required String nombre,
      Value<String?> contacto,
      Value<String?> telefono,
      Value<String?> email,
      Value<String?> direccion,
      Value<int> activo,
      Value<String> creadoEn,
    });
typedef $$ProveedoresTableUpdateCompanionBuilder =
    ProveedoresCompanion Function({
      Value<int> id,
      Value<String> nombre,
      Value<String?> contacto,
      Value<String?> telefono,
      Value<String?> email,
      Value<String?> direccion,
      Value<int> activo,
      Value<String> creadoEn,
    });

final class $$ProveedoresTableReferences
    extends BaseReferences<_$AppDatabase, $ProveedoresTable, Proveedore> {
  $$ProveedoresTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ComprasTable, List<Compra>> _comprasRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.compras,
    aliasName: $_aliasNameGenerator(db.proveedores.id, db.compras.proveedorId),
  );

  $$ComprasTableProcessedTableManager get comprasRefs {
    final manager = $$ComprasTableTableManager(
      $_db,
      $_db.compras,
    ).filter((f) => f.proveedorId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_comprasRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProveedoresTableFilterComposer
    extends Composer<_$AppDatabase, $ProveedoresTable> {
  $$ProveedoresTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contacto => $composableBuilder(
    column: $table.contacto,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get telefono => $composableBuilder(
    column: $table.telefono,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get direccion => $composableBuilder(
    column: $table.direccion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get activo => $composableBuilder(
    column: $table.activo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> comprasRefs(
    Expression<bool> Function($$ComprasTableFilterComposer f) f,
  ) {
    final $$ComprasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.compras,
      getReferencedColumn: (t) => t.proveedorId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ComprasTableFilterComposer(
            $db: $db,
            $table: $db.compras,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProveedoresTableOrderingComposer
    extends Composer<_$AppDatabase, $ProveedoresTable> {
  $$ProveedoresTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contacto => $composableBuilder(
    column: $table.contacto,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get telefono => $composableBuilder(
    column: $table.telefono,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get direccion => $composableBuilder(
    column: $table.direccion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get activo => $composableBuilder(
    column: $table.activo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProveedoresTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProveedoresTable> {
  $$ProveedoresTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get contacto =>
      $composableBuilder(column: $table.contacto, builder: (column) => column);

  GeneratedColumn<String> get telefono =>
      $composableBuilder(column: $table.telefono, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get direccion =>
      $composableBuilder(column: $table.direccion, builder: (column) => column);

  GeneratedColumn<int> get activo =>
      $composableBuilder(column: $table.activo, builder: (column) => column);

  GeneratedColumn<String> get creadoEn =>
      $composableBuilder(column: $table.creadoEn, builder: (column) => column);

  Expression<T> comprasRefs<T extends Object>(
    Expression<T> Function($$ComprasTableAnnotationComposer a) f,
  ) {
    final $$ComprasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.compras,
      getReferencedColumn: (t) => t.proveedorId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ComprasTableAnnotationComposer(
            $db: $db,
            $table: $db.compras,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProveedoresTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProveedoresTable,
          Proveedore,
          $$ProveedoresTableFilterComposer,
          $$ProveedoresTableOrderingComposer,
          $$ProveedoresTableAnnotationComposer,
          $$ProveedoresTableCreateCompanionBuilder,
          $$ProveedoresTableUpdateCompanionBuilder,
          (Proveedore, $$ProveedoresTableReferences),
          Proveedore,
          PrefetchHooks Function({bool comprasRefs})
        > {
  $$ProveedoresTableTableManager(_$AppDatabase db, $ProveedoresTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProveedoresTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProveedoresTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProveedoresTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<String?> contacto = const Value.absent(),
                Value<String?> telefono = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> direccion = const Value.absent(),
                Value<int> activo = const Value.absent(),
                Value<String> creadoEn = const Value.absent(),
              }) => ProveedoresCompanion(
                id: id,
                nombre: nombre,
                contacto: contacto,
                telefono: telefono,
                email: email,
                direccion: direccion,
                activo: activo,
                creadoEn: creadoEn,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nombre,
                Value<String?> contacto = const Value.absent(),
                Value<String?> telefono = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> direccion = const Value.absent(),
                Value<int> activo = const Value.absent(),
                Value<String> creadoEn = const Value.absent(),
              }) => ProveedoresCompanion.insert(
                id: id,
                nombre: nombre,
                contacto: contacto,
                telefono: telefono,
                email: email,
                direccion: direccion,
                activo: activo,
                creadoEn: creadoEn,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProveedoresTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({comprasRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (comprasRefs) db.compras],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (comprasRefs)
                    await $_getPrefetchedData<
                      Proveedore,
                      $ProveedoresTable,
                      Compra
                    >(
                      currentTable: table,
                      referencedTable: $$ProveedoresTableReferences
                          ._comprasRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ProveedoresTableReferences(
                            db,
                            table,
                            p0,
                          ).comprasRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.proveedorId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ProveedoresTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProveedoresTable,
      Proveedore,
      $$ProveedoresTableFilterComposer,
      $$ProveedoresTableOrderingComposer,
      $$ProveedoresTableAnnotationComposer,
      $$ProveedoresTableCreateCompanionBuilder,
      $$ProveedoresTableUpdateCompanionBuilder,
      (Proveedore, $$ProveedoresTableReferences),
      Proveedore,
      PrefetchHooks Function({bool comprasRefs})
    >;
typedef $$ProductosTableCreateCompanionBuilder =
    ProductosCompanion Function({
      Value<int> id,
      required String nombre,
      Value<String?> descripcion,
      required int categoriaId,
      Value<double> precioVenta,
      Value<double> margenGananciaPct,
      Value<double> stockMinimo,
      Value<double> stockActual,
      Value<int> activo,
      Value<String> creadoEn,
      Value<String> actualizadoEn,
    });
typedef $$ProductosTableUpdateCompanionBuilder =
    ProductosCompanion Function({
      Value<int> id,
      Value<String> nombre,
      Value<String?> descripcion,
      Value<int> categoriaId,
      Value<double> precioVenta,
      Value<double> margenGananciaPct,
      Value<double> stockMinimo,
      Value<double> stockActual,
      Value<int> activo,
      Value<String> creadoEn,
      Value<String> actualizadoEn,
    });

final class $$ProductosTableReferences
    extends BaseReferences<_$AppDatabase, $ProductosTable, Producto> {
  $$ProductosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CategoriasTable _categoriaIdTable(_$AppDatabase db) =>
      db.categorias.createAlias(
        $_aliasNameGenerator(db.productos.categoriaId, db.categorias.id),
      );

  $$CategoriasTableProcessedTableManager get categoriaId {
    final $_column = $_itemColumn<int>('categoria_id')!;

    final manager = $$CategoriasTableTableManager(
      $_db,
      $_db.categorias,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoriaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$CompraDetallesTable, List<CompraDetalle>>
  _compraDetallesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.compraDetalles,
    aliasName: $_aliasNameGenerator(
      db.productos.id,
      db.compraDetalles.productoId,
    ),
  );

  $$CompraDetallesTableProcessedTableManager get compraDetallesRefs {
    final manager = $$CompraDetallesTableTableManager(
      $_db,
      $_db.compraDetalles,
    ).filter((f) => f.productoId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_compraDetallesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$VentaDetallesTable, List<VentaDetalle>>
  _ventaDetallesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.ventaDetalles,
    aliasName: $_aliasNameGenerator(
      db.productos.id,
      db.ventaDetalles.productoId,
    ),
  );

  $$VentaDetallesTableProcessedTableManager get ventaDetallesRefs {
    final manager = $$VentaDetallesTableTableManager(
      $_db,
      $_db.ventaDetalles,
    ).filter((f) => f.productoId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_ventaDetallesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $AjustesInventarioTable,
    List<AjustesInventarioData>
  >
  _ajustesInventarioRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.ajustesInventario,
        aliasName: $_aliasNameGenerator(
          db.productos.id,
          db.ajustesInventario.productoId,
        ),
      );

  $$AjustesInventarioTableProcessedTableManager get ajustesInventarioRefs {
    final manager = $$AjustesInventarioTableTableManager(
      $_db,
      $_db.ajustesInventario,
    ).filter((f) => f.productoId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _ajustesInventarioRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$HistorialMargenesTable, List<HistorialMargene>>
  _historialMargenesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.historialMargenes,
        aliasName: $_aliasNameGenerator(
          db.productos.id,
          db.historialMargenes.productoId,
        ),
      );

  $$HistorialMargenesTableProcessedTableManager get historialMargenesRefs {
    final manager = $$HistorialMargenesTableTableManager(
      $_db,
      $_db.historialMargenes,
    ).filter((f) => f.productoId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _historialMargenesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProductosTableFilterComposer
    extends Composer<_$AppDatabase, $ProductosTable> {
  $$ProductosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get precioVenta => $composableBuilder(
    column: $table.precioVenta,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get margenGananciaPct => $composableBuilder(
    column: $table.margenGananciaPct,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get stockMinimo => $composableBuilder(
    column: $table.stockMinimo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get stockActual => $composableBuilder(
    column: $table.stockActual,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get activo => $composableBuilder(
    column: $table.activo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get actualizadoEn => $composableBuilder(
    column: $table.actualizadoEn,
    builder: (column) => ColumnFilters(column),
  );

  $$CategoriasTableFilterComposer get categoriaId {
    final $$CategoriasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoriaId,
      referencedTable: $db.categorias,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriasTableFilterComposer(
            $db: $db,
            $table: $db.categorias,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> compraDetallesRefs(
    Expression<bool> Function($$CompraDetallesTableFilterComposer f) f,
  ) {
    final $$CompraDetallesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.compraDetalles,
      getReferencedColumn: (t) => t.productoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CompraDetallesTableFilterComposer(
            $db: $db,
            $table: $db.compraDetalles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> ventaDetallesRefs(
    Expression<bool> Function($$VentaDetallesTableFilterComposer f) f,
  ) {
    final $$VentaDetallesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ventaDetalles,
      getReferencedColumn: (t) => t.productoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VentaDetallesTableFilterComposer(
            $db: $db,
            $table: $db.ventaDetalles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> ajustesInventarioRefs(
    Expression<bool> Function($$AjustesInventarioTableFilterComposer f) f,
  ) {
    final $$AjustesInventarioTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ajustesInventario,
      getReferencedColumn: (t) => t.productoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AjustesInventarioTableFilterComposer(
            $db: $db,
            $table: $db.ajustesInventario,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> historialMargenesRefs(
    Expression<bool> Function($$HistorialMargenesTableFilterComposer f) f,
  ) {
    final $$HistorialMargenesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.historialMargenes,
      getReferencedColumn: (t) => t.productoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HistorialMargenesTableFilterComposer(
            $db: $db,
            $table: $db.historialMargenes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductosTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductosTable> {
  $$ProductosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get precioVenta => $composableBuilder(
    column: $table.precioVenta,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get margenGananciaPct => $composableBuilder(
    column: $table.margenGananciaPct,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get stockMinimo => $composableBuilder(
    column: $table.stockMinimo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get stockActual => $composableBuilder(
    column: $table.stockActual,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get activo => $composableBuilder(
    column: $table.activo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get actualizadoEn => $composableBuilder(
    column: $table.actualizadoEn,
    builder: (column) => ColumnOrderings(column),
  );

  $$CategoriasTableOrderingComposer get categoriaId {
    final $$CategoriasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoriaId,
      referencedTable: $db.categorias,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriasTableOrderingComposer(
            $db: $db,
            $table: $db.categorias,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductosTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductosTable> {
  $$ProductosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => column,
  );

  GeneratedColumn<double> get precioVenta => $composableBuilder(
    column: $table.precioVenta,
    builder: (column) => column,
  );

  GeneratedColumn<double> get margenGananciaPct => $composableBuilder(
    column: $table.margenGananciaPct,
    builder: (column) => column,
  );

  GeneratedColumn<double> get stockMinimo => $composableBuilder(
    column: $table.stockMinimo,
    builder: (column) => column,
  );

  GeneratedColumn<double> get stockActual => $composableBuilder(
    column: $table.stockActual,
    builder: (column) => column,
  );

  GeneratedColumn<int> get activo =>
      $composableBuilder(column: $table.activo, builder: (column) => column);

  GeneratedColumn<String> get creadoEn =>
      $composableBuilder(column: $table.creadoEn, builder: (column) => column);

  GeneratedColumn<String> get actualizadoEn => $composableBuilder(
    column: $table.actualizadoEn,
    builder: (column) => column,
  );

  $$CategoriasTableAnnotationComposer get categoriaId {
    final $$CategoriasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoriaId,
      referencedTable: $db.categorias,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriasTableAnnotationComposer(
            $db: $db,
            $table: $db.categorias,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> compraDetallesRefs<T extends Object>(
    Expression<T> Function($$CompraDetallesTableAnnotationComposer a) f,
  ) {
    final $$CompraDetallesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.compraDetalles,
      getReferencedColumn: (t) => t.productoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CompraDetallesTableAnnotationComposer(
            $db: $db,
            $table: $db.compraDetalles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> ventaDetallesRefs<T extends Object>(
    Expression<T> Function($$VentaDetallesTableAnnotationComposer a) f,
  ) {
    final $$VentaDetallesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ventaDetalles,
      getReferencedColumn: (t) => t.productoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VentaDetallesTableAnnotationComposer(
            $db: $db,
            $table: $db.ventaDetalles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> ajustesInventarioRefs<T extends Object>(
    Expression<T> Function($$AjustesInventarioTableAnnotationComposer a) f,
  ) {
    final $$AjustesInventarioTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.ajustesInventario,
          getReferencedColumn: (t) => t.productoId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$AjustesInventarioTableAnnotationComposer(
                $db: $db,
                $table: $db.ajustesInventario,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> historialMargenesRefs<T extends Object>(
    Expression<T> Function($$HistorialMargenesTableAnnotationComposer a) f,
  ) {
    final $$HistorialMargenesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.historialMargenes,
          getReferencedColumn: (t) => t.productoId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$HistorialMargenesTableAnnotationComposer(
                $db: $db,
                $table: $db.historialMargenes,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ProductosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductosTable,
          Producto,
          $$ProductosTableFilterComposer,
          $$ProductosTableOrderingComposer,
          $$ProductosTableAnnotationComposer,
          $$ProductosTableCreateCompanionBuilder,
          $$ProductosTableUpdateCompanionBuilder,
          (Producto, $$ProductosTableReferences),
          Producto,
          PrefetchHooks Function({
            bool categoriaId,
            bool compraDetallesRefs,
            bool ventaDetallesRefs,
            bool ajustesInventarioRefs,
            bool historialMargenesRefs,
          })
        > {
  $$ProductosTableTableManager(_$AppDatabase db, $ProductosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<String?> descripcion = const Value.absent(),
                Value<int> categoriaId = const Value.absent(),
                Value<double> precioVenta = const Value.absent(),
                Value<double> margenGananciaPct = const Value.absent(),
                Value<double> stockMinimo = const Value.absent(),
                Value<double> stockActual = const Value.absent(),
                Value<int> activo = const Value.absent(),
                Value<String> creadoEn = const Value.absent(),
                Value<String> actualizadoEn = const Value.absent(),
              }) => ProductosCompanion(
                id: id,
                nombre: nombre,
                descripcion: descripcion,
                categoriaId: categoriaId,
                precioVenta: precioVenta,
                margenGananciaPct: margenGananciaPct,
                stockMinimo: stockMinimo,
                stockActual: stockActual,
                activo: activo,
                creadoEn: creadoEn,
                actualizadoEn: actualizadoEn,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nombre,
                Value<String?> descripcion = const Value.absent(),
                required int categoriaId,
                Value<double> precioVenta = const Value.absent(),
                Value<double> margenGananciaPct = const Value.absent(),
                Value<double> stockMinimo = const Value.absent(),
                Value<double> stockActual = const Value.absent(),
                Value<int> activo = const Value.absent(),
                Value<String> creadoEn = const Value.absent(),
                Value<String> actualizadoEn = const Value.absent(),
              }) => ProductosCompanion.insert(
                id: id,
                nombre: nombre,
                descripcion: descripcion,
                categoriaId: categoriaId,
                precioVenta: precioVenta,
                margenGananciaPct: margenGananciaPct,
                stockMinimo: stockMinimo,
                stockActual: stockActual,
                activo: activo,
                creadoEn: creadoEn,
                actualizadoEn: actualizadoEn,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProductosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                categoriaId = false,
                compraDetallesRefs = false,
                ventaDetallesRefs = false,
                ajustesInventarioRefs = false,
                historialMargenesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (compraDetallesRefs) db.compraDetalles,
                    if (ventaDetallesRefs) db.ventaDetalles,
                    if (ajustesInventarioRefs) db.ajustesInventario,
                    if (historialMargenesRefs) db.historialMargenes,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (categoriaId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.categoriaId,
                                    referencedTable: $$ProductosTableReferences
                                        ._categoriaIdTable(db),
                                    referencedColumn: $$ProductosTableReferences
                                        ._categoriaIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (compraDetallesRefs)
                        await $_getPrefetchedData<
                          Producto,
                          $ProductosTable,
                          CompraDetalle
                        >(
                          currentTable: table,
                          referencedTable: $$ProductosTableReferences
                              ._compraDetallesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductosTableReferences(
                                db,
                                table,
                                p0,
                              ).compraDetallesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productoId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (ventaDetallesRefs)
                        await $_getPrefetchedData<
                          Producto,
                          $ProductosTable,
                          VentaDetalle
                        >(
                          currentTable: table,
                          referencedTable: $$ProductosTableReferences
                              ._ventaDetallesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductosTableReferences(
                                db,
                                table,
                                p0,
                              ).ventaDetallesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productoId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (ajustesInventarioRefs)
                        await $_getPrefetchedData<
                          Producto,
                          $ProductosTable,
                          AjustesInventarioData
                        >(
                          currentTable: table,
                          referencedTable: $$ProductosTableReferences
                              ._ajustesInventarioRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductosTableReferences(
                                db,
                                table,
                                p0,
                              ).ajustesInventarioRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productoId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (historialMargenesRefs)
                        await $_getPrefetchedData<
                          Producto,
                          $ProductosTable,
                          HistorialMargene
                        >(
                          currentTable: table,
                          referencedTable: $$ProductosTableReferences
                              ._historialMargenesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductosTableReferences(
                                db,
                                table,
                                p0,
                              ).historialMargenesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productoId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ProductosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductosTable,
      Producto,
      $$ProductosTableFilterComposer,
      $$ProductosTableOrderingComposer,
      $$ProductosTableAnnotationComposer,
      $$ProductosTableCreateCompanionBuilder,
      $$ProductosTableUpdateCompanionBuilder,
      (Producto, $$ProductosTableReferences),
      Producto,
      PrefetchHooks Function({
        bool categoriaId,
        bool compraDetallesRefs,
        bool ventaDetallesRefs,
        bool ajustesInventarioRefs,
        bool historialMargenesRefs,
      })
    >;
typedef $$ComprasTableCreateCompanionBuilder =
    ComprasCompanion Function({
      Value<int> id,
      required int proveedorId,
      Value<String> fecha,
      Value<String?> nroFactura,
      Value<String?> observaciones,
      Value<double> total,
      Value<String> creadoEn,
    });
typedef $$ComprasTableUpdateCompanionBuilder =
    ComprasCompanion Function({
      Value<int> id,
      Value<int> proveedorId,
      Value<String> fecha,
      Value<String?> nroFactura,
      Value<String?> observaciones,
      Value<double> total,
      Value<String> creadoEn,
    });

final class $$ComprasTableReferences
    extends BaseReferences<_$AppDatabase, $ComprasTable, Compra> {
  $$ComprasTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProveedoresTable _proveedorIdTable(_$AppDatabase db) =>
      db.proveedores.createAlias(
        $_aliasNameGenerator(db.compras.proveedorId, db.proveedores.id),
      );

  $$ProveedoresTableProcessedTableManager get proveedorId {
    final $_column = $_itemColumn<int>('proveedor_id')!;

    final manager = $$ProveedoresTableTableManager(
      $_db,
      $_db.proveedores,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_proveedorIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$CompraDetallesTable, List<CompraDetalle>>
  _compraDetallesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.compraDetalles,
    aliasName: $_aliasNameGenerator(db.compras.id, db.compraDetalles.compraId),
  );

  $$CompraDetallesTableProcessedTableManager get compraDetallesRefs {
    final manager = $$CompraDetallesTableTableManager(
      $_db,
      $_db.compraDetalles,
    ).filter((f) => f.compraId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_compraDetallesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ComprasTableFilterComposer
    extends Composer<_$AppDatabase, $ComprasTable> {
  $$ComprasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nroFactura => $composableBuilder(
    column: $table.nroFactura,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get observaciones => $composableBuilder(
    column: $table.observaciones,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnFilters(column),
  );

  $$ProveedoresTableFilterComposer get proveedorId {
    final $$ProveedoresTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.proveedorId,
      referencedTable: $db.proveedores,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProveedoresTableFilterComposer(
            $db: $db,
            $table: $db.proveedores,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> compraDetallesRefs(
    Expression<bool> Function($$CompraDetallesTableFilterComposer f) f,
  ) {
    final $$CompraDetallesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.compraDetalles,
      getReferencedColumn: (t) => t.compraId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CompraDetallesTableFilterComposer(
            $db: $db,
            $table: $db.compraDetalles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ComprasTableOrderingComposer
    extends Composer<_$AppDatabase, $ComprasTable> {
  $$ComprasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nroFactura => $composableBuilder(
    column: $table.nroFactura,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get observaciones => $composableBuilder(
    column: $table.observaciones,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProveedoresTableOrderingComposer get proveedorId {
    final $$ProveedoresTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.proveedorId,
      referencedTable: $db.proveedores,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProveedoresTableOrderingComposer(
            $db: $db,
            $table: $db.proveedores,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ComprasTableAnnotationComposer
    extends Composer<_$AppDatabase, $ComprasTable> {
  $$ComprasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fecha =>
      $composableBuilder(column: $table.fecha, builder: (column) => column);

  GeneratedColumn<String> get nroFactura => $composableBuilder(
    column: $table.nroFactura,
    builder: (column) => column,
  );

  GeneratedColumn<String> get observaciones => $composableBuilder(
    column: $table.observaciones,
    builder: (column) => column,
  );

  GeneratedColumn<double> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);

  GeneratedColumn<String> get creadoEn =>
      $composableBuilder(column: $table.creadoEn, builder: (column) => column);

  $$ProveedoresTableAnnotationComposer get proveedorId {
    final $$ProveedoresTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.proveedorId,
      referencedTable: $db.proveedores,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProveedoresTableAnnotationComposer(
            $db: $db,
            $table: $db.proveedores,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> compraDetallesRefs<T extends Object>(
    Expression<T> Function($$CompraDetallesTableAnnotationComposer a) f,
  ) {
    final $$CompraDetallesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.compraDetalles,
      getReferencedColumn: (t) => t.compraId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CompraDetallesTableAnnotationComposer(
            $db: $db,
            $table: $db.compraDetalles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ComprasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ComprasTable,
          Compra,
          $$ComprasTableFilterComposer,
          $$ComprasTableOrderingComposer,
          $$ComprasTableAnnotationComposer,
          $$ComprasTableCreateCompanionBuilder,
          $$ComprasTableUpdateCompanionBuilder,
          (Compra, $$ComprasTableReferences),
          Compra,
          PrefetchHooks Function({bool proveedorId, bool compraDetallesRefs})
        > {
  $$ComprasTableTableManager(_$AppDatabase db, $ComprasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ComprasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ComprasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ComprasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> proveedorId = const Value.absent(),
                Value<String> fecha = const Value.absent(),
                Value<String?> nroFactura = const Value.absent(),
                Value<String?> observaciones = const Value.absent(),
                Value<double> total = const Value.absent(),
                Value<String> creadoEn = const Value.absent(),
              }) => ComprasCompanion(
                id: id,
                proveedorId: proveedorId,
                fecha: fecha,
                nroFactura: nroFactura,
                observaciones: observaciones,
                total: total,
                creadoEn: creadoEn,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int proveedorId,
                Value<String> fecha = const Value.absent(),
                Value<String?> nroFactura = const Value.absent(),
                Value<String?> observaciones = const Value.absent(),
                Value<double> total = const Value.absent(),
                Value<String> creadoEn = const Value.absent(),
              }) => ComprasCompanion.insert(
                id: id,
                proveedorId: proveedorId,
                fecha: fecha,
                nroFactura: nroFactura,
                observaciones: observaciones,
                total: total,
                creadoEn: creadoEn,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ComprasTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({proveedorId = false, compraDetallesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (compraDetallesRefs) db.compraDetalles,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (proveedorId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.proveedorId,
                                    referencedTable: $$ComprasTableReferences
                                        ._proveedorIdTable(db),
                                    referencedColumn: $$ComprasTableReferences
                                        ._proveedorIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (compraDetallesRefs)
                        await $_getPrefetchedData<
                          Compra,
                          $ComprasTable,
                          CompraDetalle
                        >(
                          currentTable: table,
                          referencedTable: $$ComprasTableReferences
                              ._compraDetallesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ComprasTableReferences(
                                db,
                                table,
                                p0,
                              ).compraDetallesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.compraId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ComprasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ComprasTable,
      Compra,
      $$ComprasTableFilterComposer,
      $$ComprasTableOrderingComposer,
      $$ComprasTableAnnotationComposer,
      $$ComprasTableCreateCompanionBuilder,
      $$ComprasTableUpdateCompanionBuilder,
      (Compra, $$ComprasTableReferences),
      Compra,
      PrefetchHooks Function({bool proveedorId, bool compraDetallesRefs})
    >;
typedef $$CompraDetallesTableCreateCompanionBuilder =
    CompraDetallesCompanion Function({
      Value<int> id,
      required int compraId,
      required int productoId,
      required double cantidad,
      required double cantidadRestante,
      required double precioCosto,
      Value<double> precioVentaLote,
      Value<String> creadoEn,
    });
typedef $$CompraDetallesTableUpdateCompanionBuilder =
    CompraDetallesCompanion Function({
      Value<int> id,
      Value<int> compraId,
      Value<int> productoId,
      Value<double> cantidad,
      Value<double> cantidadRestante,
      Value<double> precioCosto,
      Value<double> precioVentaLote,
      Value<String> creadoEn,
    });

final class $$CompraDetallesTableReferences
    extends BaseReferences<_$AppDatabase, $CompraDetallesTable, CompraDetalle> {
  $$CompraDetallesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ComprasTable _compraIdTable(_$AppDatabase db) =>
      db.compras.createAlias(
        $_aliasNameGenerator(db.compraDetalles.compraId, db.compras.id),
      );

  $$ComprasTableProcessedTableManager get compraId {
    final $_column = $_itemColumn<int>('compra_id')!;

    final manager = $$ComprasTableTableManager(
      $_db,
      $_db.compras,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_compraIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ProductosTable _productoIdTable(_$AppDatabase db) =>
      db.productos.createAlias(
        $_aliasNameGenerator(db.compraDetalles.productoId, db.productos.id),
      );

  $$ProductosTableProcessedTableManager get productoId {
    final $_column = $_itemColumn<int>('producto_id')!;

    final manager = $$ProductosTableTableManager(
      $_db,
      $_db.productos,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$VentaDetallesTable, List<VentaDetalle>>
  _ventaDetallesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.ventaDetalles,
    aliasName: $_aliasNameGenerator(
      db.compraDetalles.id,
      db.ventaDetalles.loteId,
    ),
  );

  $$VentaDetallesTableProcessedTableManager get ventaDetallesRefs {
    final manager = $$VentaDetallesTableTableManager(
      $_db,
      $_db.ventaDetalles,
    ).filter((f) => f.loteId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_ventaDetallesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CompraDetallesTableFilterComposer
    extends Composer<_$AppDatabase, $CompraDetallesTable> {
  $$CompraDetallesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cantidad => $composableBuilder(
    column: $table.cantidad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cantidadRestante => $composableBuilder(
    column: $table.cantidadRestante,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get precioCosto => $composableBuilder(
    column: $table.precioCosto,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get precioVentaLote => $composableBuilder(
    column: $table.precioVentaLote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnFilters(column),
  );

  $$ComprasTableFilterComposer get compraId {
    final $$ComprasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.compraId,
      referencedTable: $db.compras,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ComprasTableFilterComposer(
            $db: $db,
            $table: $db.compras,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductosTableFilterComposer get productoId {
    final $$ProductosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productoId,
      referencedTable: $db.productos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductosTableFilterComposer(
            $db: $db,
            $table: $db.productos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> ventaDetallesRefs(
    Expression<bool> Function($$VentaDetallesTableFilterComposer f) f,
  ) {
    final $$VentaDetallesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ventaDetalles,
      getReferencedColumn: (t) => t.loteId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VentaDetallesTableFilterComposer(
            $db: $db,
            $table: $db.ventaDetalles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CompraDetallesTableOrderingComposer
    extends Composer<_$AppDatabase, $CompraDetallesTable> {
  $$CompraDetallesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cantidad => $composableBuilder(
    column: $table.cantidad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cantidadRestante => $composableBuilder(
    column: $table.cantidadRestante,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get precioCosto => $composableBuilder(
    column: $table.precioCosto,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get precioVentaLote => $composableBuilder(
    column: $table.precioVentaLote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnOrderings(column),
  );

  $$ComprasTableOrderingComposer get compraId {
    final $$ComprasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.compraId,
      referencedTable: $db.compras,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ComprasTableOrderingComposer(
            $db: $db,
            $table: $db.compras,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductosTableOrderingComposer get productoId {
    final $$ProductosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productoId,
      referencedTable: $db.productos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductosTableOrderingComposer(
            $db: $db,
            $table: $db.productos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CompraDetallesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CompraDetallesTable> {
  $$CompraDetallesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get cantidad =>
      $composableBuilder(column: $table.cantidad, builder: (column) => column);

  GeneratedColumn<double> get cantidadRestante => $composableBuilder(
    column: $table.cantidadRestante,
    builder: (column) => column,
  );

  GeneratedColumn<double> get precioCosto => $composableBuilder(
    column: $table.precioCosto,
    builder: (column) => column,
  );

  GeneratedColumn<double> get precioVentaLote => $composableBuilder(
    column: $table.precioVentaLote,
    builder: (column) => column,
  );

  GeneratedColumn<String> get creadoEn =>
      $composableBuilder(column: $table.creadoEn, builder: (column) => column);

  $$ComprasTableAnnotationComposer get compraId {
    final $$ComprasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.compraId,
      referencedTable: $db.compras,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ComprasTableAnnotationComposer(
            $db: $db,
            $table: $db.compras,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductosTableAnnotationComposer get productoId {
    final $$ProductosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productoId,
      referencedTable: $db.productos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductosTableAnnotationComposer(
            $db: $db,
            $table: $db.productos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> ventaDetallesRefs<T extends Object>(
    Expression<T> Function($$VentaDetallesTableAnnotationComposer a) f,
  ) {
    final $$VentaDetallesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ventaDetalles,
      getReferencedColumn: (t) => t.loteId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VentaDetallesTableAnnotationComposer(
            $db: $db,
            $table: $db.ventaDetalles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CompraDetallesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CompraDetallesTable,
          CompraDetalle,
          $$CompraDetallesTableFilterComposer,
          $$CompraDetallesTableOrderingComposer,
          $$CompraDetallesTableAnnotationComposer,
          $$CompraDetallesTableCreateCompanionBuilder,
          $$CompraDetallesTableUpdateCompanionBuilder,
          (CompraDetalle, $$CompraDetallesTableReferences),
          CompraDetalle,
          PrefetchHooks Function({
            bool compraId,
            bool productoId,
            bool ventaDetallesRefs,
          })
        > {
  $$CompraDetallesTableTableManager(
    _$AppDatabase db,
    $CompraDetallesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CompraDetallesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CompraDetallesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CompraDetallesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> compraId = const Value.absent(),
                Value<int> productoId = const Value.absent(),
                Value<double> cantidad = const Value.absent(),
                Value<double> cantidadRestante = const Value.absent(),
                Value<double> precioCosto = const Value.absent(),
                Value<double> precioVentaLote = const Value.absent(),
                Value<String> creadoEn = const Value.absent(),
              }) => CompraDetallesCompanion(
                id: id,
                compraId: compraId,
                productoId: productoId,
                cantidad: cantidad,
                cantidadRestante: cantidadRestante,
                precioCosto: precioCosto,
                precioVentaLote: precioVentaLote,
                creadoEn: creadoEn,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int compraId,
                required int productoId,
                required double cantidad,
                required double cantidadRestante,
                required double precioCosto,
                Value<double> precioVentaLote = const Value.absent(),
                Value<String> creadoEn = const Value.absent(),
              }) => CompraDetallesCompanion.insert(
                id: id,
                compraId: compraId,
                productoId: productoId,
                cantidad: cantidad,
                cantidadRestante: cantidadRestante,
                precioCosto: precioCosto,
                precioVentaLote: precioVentaLote,
                creadoEn: creadoEn,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CompraDetallesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                compraId = false,
                productoId = false,
                ventaDetallesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (ventaDetallesRefs) db.ventaDetalles,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (compraId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.compraId,
                                    referencedTable:
                                        $$CompraDetallesTableReferences
                                            ._compraIdTable(db),
                                    referencedColumn:
                                        $$CompraDetallesTableReferences
                                            ._compraIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (productoId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.productoId,
                                    referencedTable:
                                        $$CompraDetallesTableReferences
                                            ._productoIdTable(db),
                                    referencedColumn:
                                        $$CompraDetallesTableReferences
                                            ._productoIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (ventaDetallesRefs)
                        await $_getPrefetchedData<
                          CompraDetalle,
                          $CompraDetallesTable,
                          VentaDetalle
                        >(
                          currentTable: table,
                          referencedTable: $$CompraDetallesTableReferences
                              ._ventaDetallesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CompraDetallesTableReferences(
                                db,
                                table,
                                p0,
                              ).ventaDetallesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.loteId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$CompraDetallesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CompraDetallesTable,
      CompraDetalle,
      $$CompraDetallesTableFilterComposer,
      $$CompraDetallesTableOrderingComposer,
      $$CompraDetallesTableAnnotationComposer,
      $$CompraDetallesTableCreateCompanionBuilder,
      $$CompraDetallesTableUpdateCompanionBuilder,
      (CompraDetalle, $$CompraDetallesTableReferences),
      CompraDetalle,
      PrefetchHooks Function({
        bool compraId,
        bool productoId,
        bool ventaDetallesRefs,
      })
    >;
typedef $$VentasTableCreateCompanionBuilder =
    VentasCompanion Function({
      Value<int> id,
      Value<String> fecha,
      Value<String> metodoPago,
      Value<double> total,
      Value<double> costoTotal,
      Value<String?> observaciones,
      Value<String> creadoEn,
    });
typedef $$VentasTableUpdateCompanionBuilder =
    VentasCompanion Function({
      Value<int> id,
      Value<String> fecha,
      Value<String> metodoPago,
      Value<double> total,
      Value<double> costoTotal,
      Value<String?> observaciones,
      Value<String> creadoEn,
    });

final class $$VentasTableReferences
    extends BaseReferences<_$AppDatabase, $VentasTable, Venta> {
  $$VentasTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$VentaDetallesTable, List<VentaDetalle>>
  _ventaDetallesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.ventaDetalles,
    aliasName: $_aliasNameGenerator(db.ventas.id, db.ventaDetalles.ventaId),
  );

  $$VentaDetallesTableProcessedTableManager get ventaDetallesRefs {
    final manager = $$VentaDetallesTableTableManager(
      $_db,
      $_db.ventaDetalles,
    ).filter((f) => f.ventaId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_ventaDetallesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$VentasTableFilterComposer
    extends Composer<_$AppDatabase, $VentasTable> {
  $$VentasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metodoPago => $composableBuilder(
    column: $table.metodoPago,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get costoTotal => $composableBuilder(
    column: $table.costoTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get observaciones => $composableBuilder(
    column: $table.observaciones,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> ventaDetallesRefs(
    Expression<bool> Function($$VentaDetallesTableFilterComposer f) f,
  ) {
    final $$VentaDetallesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ventaDetalles,
      getReferencedColumn: (t) => t.ventaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VentaDetallesTableFilterComposer(
            $db: $db,
            $table: $db.ventaDetalles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VentasTableOrderingComposer
    extends Composer<_$AppDatabase, $VentasTable> {
  $$VentasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metodoPago => $composableBuilder(
    column: $table.metodoPago,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get costoTotal => $composableBuilder(
    column: $table.costoTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get observaciones => $composableBuilder(
    column: $table.observaciones,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VentasTableAnnotationComposer
    extends Composer<_$AppDatabase, $VentasTable> {
  $$VentasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fecha =>
      $composableBuilder(column: $table.fecha, builder: (column) => column);

  GeneratedColumn<String> get metodoPago => $composableBuilder(
    column: $table.metodoPago,
    builder: (column) => column,
  );

  GeneratedColumn<double> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);

  GeneratedColumn<double> get costoTotal => $composableBuilder(
    column: $table.costoTotal,
    builder: (column) => column,
  );

  GeneratedColumn<String> get observaciones => $composableBuilder(
    column: $table.observaciones,
    builder: (column) => column,
  );

  GeneratedColumn<String> get creadoEn =>
      $composableBuilder(column: $table.creadoEn, builder: (column) => column);

  Expression<T> ventaDetallesRefs<T extends Object>(
    Expression<T> Function($$VentaDetallesTableAnnotationComposer a) f,
  ) {
    final $$VentaDetallesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ventaDetalles,
      getReferencedColumn: (t) => t.ventaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VentaDetallesTableAnnotationComposer(
            $db: $db,
            $table: $db.ventaDetalles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VentasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VentasTable,
          Venta,
          $$VentasTableFilterComposer,
          $$VentasTableOrderingComposer,
          $$VentasTableAnnotationComposer,
          $$VentasTableCreateCompanionBuilder,
          $$VentasTableUpdateCompanionBuilder,
          (Venta, $$VentasTableReferences),
          Venta,
          PrefetchHooks Function({bool ventaDetallesRefs})
        > {
  $$VentasTableTableManager(_$AppDatabase db, $VentasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VentasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VentasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VentasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> fecha = const Value.absent(),
                Value<String> metodoPago = const Value.absent(),
                Value<double> total = const Value.absent(),
                Value<double> costoTotal = const Value.absent(),
                Value<String?> observaciones = const Value.absent(),
                Value<String> creadoEn = const Value.absent(),
              }) => VentasCompanion(
                id: id,
                fecha: fecha,
                metodoPago: metodoPago,
                total: total,
                costoTotal: costoTotal,
                observaciones: observaciones,
                creadoEn: creadoEn,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> fecha = const Value.absent(),
                Value<String> metodoPago = const Value.absent(),
                Value<double> total = const Value.absent(),
                Value<double> costoTotal = const Value.absent(),
                Value<String?> observaciones = const Value.absent(),
                Value<String> creadoEn = const Value.absent(),
              }) => VentasCompanion.insert(
                id: id,
                fecha: fecha,
                metodoPago: metodoPago,
                total: total,
                costoTotal: costoTotal,
                observaciones: observaciones,
                creadoEn: creadoEn,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$VentasTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({ventaDetallesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (ventaDetallesRefs) db.ventaDetalles,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (ventaDetallesRefs)
                    await $_getPrefetchedData<
                      Venta,
                      $VentasTable,
                      VentaDetalle
                    >(
                      currentTable: table,
                      referencedTable: $$VentasTableReferences
                          ._ventaDetallesRefsTable(db),
                      managerFromTypedResult: (p0) => $$VentasTableReferences(
                        db,
                        table,
                        p0,
                      ).ventaDetallesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.ventaId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$VentasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VentasTable,
      Venta,
      $$VentasTableFilterComposer,
      $$VentasTableOrderingComposer,
      $$VentasTableAnnotationComposer,
      $$VentasTableCreateCompanionBuilder,
      $$VentasTableUpdateCompanionBuilder,
      (Venta, $$VentasTableReferences),
      Venta,
      PrefetchHooks Function({bool ventaDetallesRefs})
    >;
typedef $$VentaDetallesTableCreateCompanionBuilder =
    VentaDetallesCompanion Function({
      Value<int> id,
      required int ventaId,
      required int productoId,
      required int loteId,
      required double cantidad,
      required double precioVenta,
      required double precioCosto,
      Value<String> creadoEn,
    });
typedef $$VentaDetallesTableUpdateCompanionBuilder =
    VentaDetallesCompanion Function({
      Value<int> id,
      Value<int> ventaId,
      Value<int> productoId,
      Value<int> loteId,
      Value<double> cantidad,
      Value<double> precioVenta,
      Value<double> precioCosto,
      Value<String> creadoEn,
    });

final class $$VentaDetallesTableReferences
    extends BaseReferences<_$AppDatabase, $VentaDetallesTable, VentaDetalle> {
  $$VentaDetallesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $VentasTable _ventaIdTable(_$AppDatabase db) => db.ventas.createAlias(
    $_aliasNameGenerator(db.ventaDetalles.ventaId, db.ventas.id),
  );

  $$VentasTableProcessedTableManager get ventaId {
    final $_column = $_itemColumn<int>('venta_id')!;

    final manager = $$VentasTableTableManager(
      $_db,
      $_db.ventas,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ventaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ProductosTable _productoIdTable(_$AppDatabase db) =>
      db.productos.createAlias(
        $_aliasNameGenerator(db.ventaDetalles.productoId, db.productos.id),
      );

  $$ProductosTableProcessedTableManager get productoId {
    final $_column = $_itemColumn<int>('producto_id')!;

    final manager = $$ProductosTableTableManager(
      $_db,
      $_db.productos,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CompraDetallesTable _loteIdTable(_$AppDatabase db) =>
      db.compraDetalles.createAlias(
        $_aliasNameGenerator(db.ventaDetalles.loteId, db.compraDetalles.id),
      );

  $$CompraDetallesTableProcessedTableManager get loteId {
    final $_column = $_itemColumn<int>('lote_id')!;

    final manager = $$CompraDetallesTableTableManager(
      $_db,
      $_db.compraDetalles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_loteIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$VentaDetallesTableFilterComposer
    extends Composer<_$AppDatabase, $VentaDetallesTable> {
  $$VentaDetallesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cantidad => $composableBuilder(
    column: $table.cantidad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get precioVenta => $composableBuilder(
    column: $table.precioVenta,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get precioCosto => $composableBuilder(
    column: $table.precioCosto,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnFilters(column),
  );

  $$VentasTableFilterComposer get ventaId {
    final $$VentasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ventaId,
      referencedTable: $db.ventas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VentasTableFilterComposer(
            $db: $db,
            $table: $db.ventas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductosTableFilterComposer get productoId {
    final $$ProductosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productoId,
      referencedTable: $db.productos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductosTableFilterComposer(
            $db: $db,
            $table: $db.productos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CompraDetallesTableFilterComposer get loteId {
    final $$CompraDetallesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.loteId,
      referencedTable: $db.compraDetalles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CompraDetallesTableFilterComposer(
            $db: $db,
            $table: $db.compraDetalles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VentaDetallesTableOrderingComposer
    extends Composer<_$AppDatabase, $VentaDetallesTable> {
  $$VentaDetallesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cantidad => $composableBuilder(
    column: $table.cantidad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get precioVenta => $composableBuilder(
    column: $table.precioVenta,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get precioCosto => $composableBuilder(
    column: $table.precioCosto,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnOrderings(column),
  );

  $$VentasTableOrderingComposer get ventaId {
    final $$VentasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ventaId,
      referencedTable: $db.ventas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VentasTableOrderingComposer(
            $db: $db,
            $table: $db.ventas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductosTableOrderingComposer get productoId {
    final $$ProductosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productoId,
      referencedTable: $db.productos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductosTableOrderingComposer(
            $db: $db,
            $table: $db.productos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CompraDetallesTableOrderingComposer get loteId {
    final $$CompraDetallesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.loteId,
      referencedTable: $db.compraDetalles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CompraDetallesTableOrderingComposer(
            $db: $db,
            $table: $db.compraDetalles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VentaDetallesTableAnnotationComposer
    extends Composer<_$AppDatabase, $VentaDetallesTable> {
  $$VentaDetallesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get cantidad =>
      $composableBuilder(column: $table.cantidad, builder: (column) => column);

  GeneratedColumn<double> get precioVenta => $composableBuilder(
    column: $table.precioVenta,
    builder: (column) => column,
  );

  GeneratedColumn<double> get precioCosto => $composableBuilder(
    column: $table.precioCosto,
    builder: (column) => column,
  );

  GeneratedColumn<String> get creadoEn =>
      $composableBuilder(column: $table.creadoEn, builder: (column) => column);

  $$VentasTableAnnotationComposer get ventaId {
    final $$VentasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ventaId,
      referencedTable: $db.ventas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VentasTableAnnotationComposer(
            $db: $db,
            $table: $db.ventas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductosTableAnnotationComposer get productoId {
    final $$ProductosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productoId,
      referencedTable: $db.productos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductosTableAnnotationComposer(
            $db: $db,
            $table: $db.productos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CompraDetallesTableAnnotationComposer get loteId {
    final $$CompraDetallesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.loteId,
      referencedTable: $db.compraDetalles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CompraDetallesTableAnnotationComposer(
            $db: $db,
            $table: $db.compraDetalles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VentaDetallesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VentaDetallesTable,
          VentaDetalle,
          $$VentaDetallesTableFilterComposer,
          $$VentaDetallesTableOrderingComposer,
          $$VentaDetallesTableAnnotationComposer,
          $$VentaDetallesTableCreateCompanionBuilder,
          $$VentaDetallesTableUpdateCompanionBuilder,
          (VentaDetalle, $$VentaDetallesTableReferences),
          VentaDetalle,
          PrefetchHooks Function({bool ventaId, bool productoId, bool loteId})
        > {
  $$VentaDetallesTableTableManager(_$AppDatabase db, $VentaDetallesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VentaDetallesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VentaDetallesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VentaDetallesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> ventaId = const Value.absent(),
                Value<int> productoId = const Value.absent(),
                Value<int> loteId = const Value.absent(),
                Value<double> cantidad = const Value.absent(),
                Value<double> precioVenta = const Value.absent(),
                Value<double> precioCosto = const Value.absent(),
                Value<String> creadoEn = const Value.absent(),
              }) => VentaDetallesCompanion(
                id: id,
                ventaId: ventaId,
                productoId: productoId,
                loteId: loteId,
                cantidad: cantidad,
                precioVenta: precioVenta,
                precioCosto: precioCosto,
                creadoEn: creadoEn,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int ventaId,
                required int productoId,
                required int loteId,
                required double cantidad,
                required double precioVenta,
                required double precioCosto,
                Value<String> creadoEn = const Value.absent(),
              }) => VentaDetallesCompanion.insert(
                id: id,
                ventaId: ventaId,
                productoId: productoId,
                loteId: loteId,
                cantidad: cantidad,
                precioVenta: precioVenta,
                precioCosto: precioCosto,
                creadoEn: creadoEn,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$VentaDetallesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({ventaId = false, productoId = false, loteId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (ventaId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.ventaId,
                                    referencedTable:
                                        $$VentaDetallesTableReferences
                                            ._ventaIdTable(db),
                                    referencedColumn:
                                        $$VentaDetallesTableReferences
                                            ._ventaIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (productoId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.productoId,
                                    referencedTable:
                                        $$VentaDetallesTableReferences
                                            ._productoIdTable(db),
                                    referencedColumn:
                                        $$VentaDetallesTableReferences
                                            ._productoIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (loteId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.loteId,
                                    referencedTable:
                                        $$VentaDetallesTableReferences
                                            ._loteIdTable(db),
                                    referencedColumn:
                                        $$VentaDetallesTableReferences
                                            ._loteIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$VentaDetallesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VentaDetallesTable,
      VentaDetalle,
      $$VentaDetallesTableFilterComposer,
      $$VentaDetallesTableOrderingComposer,
      $$VentaDetallesTableAnnotationComposer,
      $$VentaDetallesTableCreateCompanionBuilder,
      $$VentaDetallesTableUpdateCompanionBuilder,
      (VentaDetalle, $$VentaDetallesTableReferences),
      VentaDetalle,
      PrefetchHooks Function({bool ventaId, bool productoId, bool loteId})
    >;
typedef $$AjustesInventarioTableCreateCompanionBuilder =
    AjustesInventarioCompanion Function({
      Value<int> id,
      required int productoId,
      Value<String> fecha,
      required String tipo,
      required double cantidad,
      required String motivo,
      required double stockAntes,
      required double stockDespues,
      Value<String> creadoEn,
    });
typedef $$AjustesInventarioTableUpdateCompanionBuilder =
    AjustesInventarioCompanion Function({
      Value<int> id,
      Value<int> productoId,
      Value<String> fecha,
      Value<String> tipo,
      Value<double> cantidad,
      Value<String> motivo,
      Value<double> stockAntes,
      Value<double> stockDespues,
      Value<String> creadoEn,
    });

final class $$AjustesInventarioTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $AjustesInventarioTable,
          AjustesInventarioData
        > {
  $$AjustesInventarioTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProductosTable _productoIdTable(_$AppDatabase db) =>
      db.productos.createAlias(
        $_aliasNameGenerator(db.ajustesInventario.productoId, db.productos.id),
      );

  $$ProductosTableProcessedTableManager get productoId {
    final $_column = $_itemColumn<int>('producto_id')!;

    final manager = $$ProductosTableTableManager(
      $_db,
      $_db.productos,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AjustesInventarioTableFilterComposer
    extends Composer<_$AppDatabase, $AjustesInventarioTable> {
  $$AjustesInventarioTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cantidad => $composableBuilder(
    column: $table.cantidad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get motivo => $composableBuilder(
    column: $table.motivo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get stockAntes => $composableBuilder(
    column: $table.stockAntes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get stockDespues => $composableBuilder(
    column: $table.stockDespues,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnFilters(column),
  );

  $$ProductosTableFilterComposer get productoId {
    final $$ProductosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productoId,
      referencedTable: $db.productos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductosTableFilterComposer(
            $db: $db,
            $table: $db.productos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AjustesInventarioTableOrderingComposer
    extends Composer<_$AppDatabase, $AjustesInventarioTable> {
  $$AjustesInventarioTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cantidad => $composableBuilder(
    column: $table.cantidad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get motivo => $composableBuilder(
    column: $table.motivo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get stockAntes => $composableBuilder(
    column: $table.stockAntes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get stockDespues => $composableBuilder(
    column: $table.stockDespues,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProductosTableOrderingComposer get productoId {
    final $$ProductosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productoId,
      referencedTable: $db.productos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductosTableOrderingComposer(
            $db: $db,
            $table: $db.productos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AjustesInventarioTableAnnotationComposer
    extends Composer<_$AppDatabase, $AjustesInventarioTable> {
  $$AjustesInventarioTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fecha =>
      $composableBuilder(column: $table.fecha, builder: (column) => column);

  GeneratedColumn<String> get tipo =>
      $composableBuilder(column: $table.tipo, builder: (column) => column);

  GeneratedColumn<double> get cantidad =>
      $composableBuilder(column: $table.cantidad, builder: (column) => column);

  GeneratedColumn<String> get motivo =>
      $composableBuilder(column: $table.motivo, builder: (column) => column);

  GeneratedColumn<double> get stockAntes => $composableBuilder(
    column: $table.stockAntes,
    builder: (column) => column,
  );

  GeneratedColumn<double> get stockDespues => $composableBuilder(
    column: $table.stockDespues,
    builder: (column) => column,
  );

  GeneratedColumn<String> get creadoEn =>
      $composableBuilder(column: $table.creadoEn, builder: (column) => column);

  $$ProductosTableAnnotationComposer get productoId {
    final $$ProductosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productoId,
      referencedTable: $db.productos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductosTableAnnotationComposer(
            $db: $db,
            $table: $db.productos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AjustesInventarioTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AjustesInventarioTable,
          AjustesInventarioData,
          $$AjustesInventarioTableFilterComposer,
          $$AjustesInventarioTableOrderingComposer,
          $$AjustesInventarioTableAnnotationComposer,
          $$AjustesInventarioTableCreateCompanionBuilder,
          $$AjustesInventarioTableUpdateCompanionBuilder,
          (AjustesInventarioData, $$AjustesInventarioTableReferences),
          AjustesInventarioData,
          PrefetchHooks Function({bool productoId})
        > {
  $$AjustesInventarioTableTableManager(
    _$AppDatabase db,
    $AjustesInventarioTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AjustesInventarioTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AjustesInventarioTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AjustesInventarioTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> productoId = const Value.absent(),
                Value<String> fecha = const Value.absent(),
                Value<String> tipo = const Value.absent(),
                Value<double> cantidad = const Value.absent(),
                Value<String> motivo = const Value.absent(),
                Value<double> stockAntes = const Value.absent(),
                Value<double> stockDespues = const Value.absent(),
                Value<String> creadoEn = const Value.absent(),
              }) => AjustesInventarioCompanion(
                id: id,
                productoId: productoId,
                fecha: fecha,
                tipo: tipo,
                cantidad: cantidad,
                motivo: motivo,
                stockAntes: stockAntes,
                stockDespues: stockDespues,
                creadoEn: creadoEn,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int productoId,
                Value<String> fecha = const Value.absent(),
                required String tipo,
                required double cantidad,
                required String motivo,
                required double stockAntes,
                required double stockDespues,
                Value<String> creadoEn = const Value.absent(),
              }) => AjustesInventarioCompanion.insert(
                id: id,
                productoId: productoId,
                fecha: fecha,
                tipo: tipo,
                cantidad: cantidad,
                motivo: motivo,
                stockAntes: stockAntes,
                stockDespues: stockDespues,
                creadoEn: creadoEn,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AjustesInventarioTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({productoId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (productoId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.productoId,
                                referencedTable:
                                    $$AjustesInventarioTableReferences
                                        ._productoIdTable(db),
                                referencedColumn:
                                    $$AjustesInventarioTableReferences
                                        ._productoIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$AjustesInventarioTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AjustesInventarioTable,
      AjustesInventarioData,
      $$AjustesInventarioTableFilterComposer,
      $$AjustesInventarioTableOrderingComposer,
      $$AjustesInventarioTableAnnotationComposer,
      $$AjustesInventarioTableCreateCompanionBuilder,
      $$AjustesInventarioTableUpdateCompanionBuilder,
      (AjustesInventarioData, $$AjustesInventarioTableReferences),
      AjustesInventarioData,
      PrefetchHooks Function({bool productoId})
    >;
typedef $$HistorialMargenesTableCreateCompanionBuilder =
    HistorialMargenesCompanion Function({
      Value<int> id,
      required int productoId,
      required double margenAnterior,
      required double margenNuevo,
      required double precioVentaAnterior,
      required double precioVentaNuevo,
      Value<String?> motivo,
      Value<String> fecha,
    });
typedef $$HistorialMargenesTableUpdateCompanionBuilder =
    HistorialMargenesCompanion Function({
      Value<int> id,
      Value<int> productoId,
      Value<double> margenAnterior,
      Value<double> margenNuevo,
      Value<double> precioVentaAnterior,
      Value<double> precioVentaNuevo,
      Value<String?> motivo,
      Value<String> fecha,
    });

final class $$HistorialMargenesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $HistorialMargenesTable,
          HistorialMargene
        > {
  $$HistorialMargenesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProductosTable _productoIdTable(_$AppDatabase db) =>
      db.productos.createAlias(
        $_aliasNameGenerator(db.historialMargenes.productoId, db.productos.id),
      );

  $$ProductosTableProcessedTableManager get productoId {
    final $_column = $_itemColumn<int>('producto_id')!;

    final manager = $$ProductosTableTableManager(
      $_db,
      $_db.productos,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$HistorialMargenesTableFilterComposer
    extends Composer<_$AppDatabase, $HistorialMargenesTable> {
  $$HistorialMargenesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get margenAnterior => $composableBuilder(
    column: $table.margenAnterior,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get margenNuevo => $composableBuilder(
    column: $table.margenNuevo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get precioVentaAnterior => $composableBuilder(
    column: $table.precioVentaAnterior,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get precioVentaNuevo => $composableBuilder(
    column: $table.precioVentaNuevo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get motivo => $composableBuilder(
    column: $table.motivo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnFilters(column),
  );

  $$ProductosTableFilterComposer get productoId {
    final $$ProductosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productoId,
      referencedTable: $db.productos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductosTableFilterComposer(
            $db: $db,
            $table: $db.productos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HistorialMargenesTableOrderingComposer
    extends Composer<_$AppDatabase, $HistorialMargenesTable> {
  $$HistorialMargenesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get margenAnterior => $composableBuilder(
    column: $table.margenAnterior,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get margenNuevo => $composableBuilder(
    column: $table.margenNuevo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get precioVentaAnterior => $composableBuilder(
    column: $table.precioVentaAnterior,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get precioVentaNuevo => $composableBuilder(
    column: $table.precioVentaNuevo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get motivo => $composableBuilder(
    column: $table.motivo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProductosTableOrderingComposer get productoId {
    final $$ProductosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productoId,
      referencedTable: $db.productos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductosTableOrderingComposer(
            $db: $db,
            $table: $db.productos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HistorialMargenesTableAnnotationComposer
    extends Composer<_$AppDatabase, $HistorialMargenesTable> {
  $$HistorialMargenesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get margenAnterior => $composableBuilder(
    column: $table.margenAnterior,
    builder: (column) => column,
  );

  GeneratedColumn<double> get margenNuevo => $composableBuilder(
    column: $table.margenNuevo,
    builder: (column) => column,
  );

  GeneratedColumn<double> get precioVentaAnterior => $composableBuilder(
    column: $table.precioVentaAnterior,
    builder: (column) => column,
  );

  GeneratedColumn<double> get precioVentaNuevo => $composableBuilder(
    column: $table.precioVentaNuevo,
    builder: (column) => column,
  );

  GeneratedColumn<String> get motivo =>
      $composableBuilder(column: $table.motivo, builder: (column) => column);

  GeneratedColumn<String> get fecha =>
      $composableBuilder(column: $table.fecha, builder: (column) => column);

  $$ProductosTableAnnotationComposer get productoId {
    final $$ProductosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productoId,
      referencedTable: $db.productos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductosTableAnnotationComposer(
            $db: $db,
            $table: $db.productos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HistorialMargenesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HistorialMargenesTable,
          HistorialMargene,
          $$HistorialMargenesTableFilterComposer,
          $$HistorialMargenesTableOrderingComposer,
          $$HistorialMargenesTableAnnotationComposer,
          $$HistorialMargenesTableCreateCompanionBuilder,
          $$HistorialMargenesTableUpdateCompanionBuilder,
          (HistorialMargene, $$HistorialMargenesTableReferences),
          HistorialMargene,
          PrefetchHooks Function({bool productoId})
        > {
  $$HistorialMargenesTableTableManager(
    _$AppDatabase db,
    $HistorialMargenesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HistorialMargenesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HistorialMargenesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HistorialMargenesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> productoId = const Value.absent(),
                Value<double> margenAnterior = const Value.absent(),
                Value<double> margenNuevo = const Value.absent(),
                Value<double> precioVentaAnterior = const Value.absent(),
                Value<double> precioVentaNuevo = const Value.absent(),
                Value<String?> motivo = const Value.absent(),
                Value<String> fecha = const Value.absent(),
              }) => HistorialMargenesCompanion(
                id: id,
                productoId: productoId,
                margenAnterior: margenAnterior,
                margenNuevo: margenNuevo,
                precioVentaAnterior: precioVentaAnterior,
                precioVentaNuevo: precioVentaNuevo,
                motivo: motivo,
                fecha: fecha,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int productoId,
                required double margenAnterior,
                required double margenNuevo,
                required double precioVentaAnterior,
                required double precioVentaNuevo,
                Value<String?> motivo = const Value.absent(),
                Value<String> fecha = const Value.absent(),
              }) => HistorialMargenesCompanion.insert(
                id: id,
                productoId: productoId,
                margenAnterior: margenAnterior,
                margenNuevo: margenNuevo,
                precioVentaAnterior: precioVentaAnterior,
                precioVentaNuevo: precioVentaNuevo,
                motivo: motivo,
                fecha: fecha,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$HistorialMargenesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({productoId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (productoId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.productoId,
                                referencedTable:
                                    $$HistorialMargenesTableReferences
                                        ._productoIdTable(db),
                                referencedColumn:
                                    $$HistorialMargenesTableReferences
                                        ._productoIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$HistorialMargenesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HistorialMargenesTable,
      HistorialMargene,
      $$HistorialMargenesTableFilterComposer,
      $$HistorialMargenesTableOrderingComposer,
      $$HistorialMargenesTableAnnotationComposer,
      $$HistorialMargenesTableCreateCompanionBuilder,
      $$HistorialMargenesTableUpdateCompanionBuilder,
      (HistorialMargene, $$HistorialMargenesTableReferences),
      HistorialMargene,
      PrefetchHooks Function({bool productoId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CategoriasTableTableManager get categorias =>
      $$CategoriasTableTableManager(_db, _db.categorias);
  $$ProveedoresTableTableManager get proveedores =>
      $$ProveedoresTableTableManager(_db, _db.proveedores);
  $$ProductosTableTableManager get productos =>
      $$ProductosTableTableManager(_db, _db.productos);
  $$ComprasTableTableManager get compras =>
      $$ComprasTableTableManager(_db, _db.compras);
  $$CompraDetallesTableTableManager get compraDetalles =>
      $$CompraDetallesTableTableManager(_db, _db.compraDetalles);
  $$VentasTableTableManager get ventas =>
      $$VentasTableTableManager(_db, _db.ventas);
  $$VentaDetallesTableTableManager get ventaDetalles =>
      $$VentaDetallesTableTableManager(_db, _db.ventaDetalles);
  $$AjustesInventarioTableTableManager get ajustesInventario =>
      $$AjustesInventarioTableTableManager(_db, _db.ajustesInventario);
  $$HistorialMargenesTableTableManager get historialMargenes =>
      $$HistorialMargenesTableTableManager(_db, _db.historialMargenes);
}
