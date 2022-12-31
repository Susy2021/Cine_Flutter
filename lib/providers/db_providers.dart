// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';
import 'package:path/path.dart';
import 'package:peliculas/models/models.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path_provider/path_provider.dart';

export 'package:peliculas/models/contactos_model.dart';
export 'package:peliculas/models/horarios_model.dart';
export 'package:peliculas/models/personal_model.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  Future<Database?> initDB() async {
    //Path de donde almacenaremos la base de datos
    Directory? documentsDirectory =
        await getExternalStorageDirectory(); //ApplicationDocumentsDirectory
    final path = join(
        documentsDirectory!.path, //sacar el ! de documentsDirectory
        'PersonalDB.db'); //TODO MI PERSONALDB ES LA SCANSDB DE FERNANDO
    print(path);

    //Crear base de datos
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE Personal (
            _id INTEGER PRIMARY KEY,
            username TEXT,
            nombre TEXT,
            apellido TEXT,
            dni INTEGER,
            fechaNacimiento TEXT,
            edad INTEGER,
            telefono TEXT,
            direccion TEXT,
            sueldoMensual INTEGER,
          )
        ''');
      await db.execute('''
          CREATE TABLE Horarios_de_Trabajo (
            id INTEGER PRIMARY KEY,
            fecha TEXT,
            hora entrada INTEGER,
            hora salida INTEGER,
            usuario_id TEXT,
            FOREIGN KEY(usuario_id) REFERENCES usuarios(_id)
          )
        ''');
      await db.execute('''
          CREATE TABLE Contactos_asociados (
            id INTEGER PRIMARY KEY,
            nombre TEXT,
            apellido TEXT,
            telefono TEXT,
            direccion TEXT,
            relacion TEXT,
            usuario_id TEXT,
            FOREIGN KEY(usuario_id) REFERENCES usuarios(_id)
          )
          ''');
    });
  }

  Future<int?> nuevoPersonalRaw(PersonalModel nuevoPersonal) async {
    final id = nuevoPersonal.id;
    final username = nuevoPersonal.username;
    final nombre = nuevoPersonal.nombre;
    final apellido = nuevoPersonal.apellido;
    final dni = nuevoPersonal.dni;
    final fechaNacimiento = nuevoPersonal.fechaNacimiento;
    final edad = nuevoPersonal.edad;
    final telefono = nuevoPersonal.telefono;
    final direccion = nuevoPersonal.direccion;
    final sueldoMensual = nuevoPersonal.sueldoMensual;

    final db = await database;
    final res = await db?.rawInsert('''
      INSERT INTO Personal(id, username, nombre, apellido, dni, fechaNacimiento, edad, telefono, direccion, sueldoMensual)
      VALUES ($id, '$username', '$nombre', '$apellido', $dni, '$fechaNacimiento', $edad, $telefono, '$direccion', $sueldoMensual)
    ''');
    return res; //Personal
  }

  Future<int?> nuevoHorariosRaw(HorariosModel nuevoHorarios) async {
    final id = nuevoHorarios.id;
    final fecha = nuevoHorarios.fecha;
    final horaEntrada = nuevoHorarios.horaEntrada;
    final horaSalida = nuevoHorarios.horaSalida;

    final db = await database;
    final horarios = await db?.rawInsert('''
      INSERT INTO Personal(id, fecha, horaEntrada, horaSalida)
      VALUES ($id, '$fecha', '$horaEntrada', '$horaSalida')
    ''');
    return horarios;
  }

  Future<int?> nuevoContactosRaw(ContactosModel nuevoContactos) async {
    final id = nuevoContactos.id;
    final nombre = nuevoContactos.nombre;
    final apellido = nuevoContactos.apellido;
    final telefono = nuevoContactos.telefono;
    final direccion = nuevoContactos.direccion;
    final relacion = nuevoContactos.relacion;
    final usuarioId = nuevoContactos.usuarioId;

    final db = await database;
    final contactos = await db?.rawInsert('''
      INSERT INTO Personal(id, fecha, horaEntrada, horaSalida)
      VALUES ($id, '$nombre', '$apellido', $telefono, '$direccion', '$relacion', '$usuarioId')
    ''');
    return contactos;
  }

  Future<int?> nuevoPersonal(PersonalModel nuevoPersonal) async {
    final db = await database;
    final res = await db?.insert('Personal', nuevoPersonal.toJson());
    return res; //Personal
  }
//Personal

  Future<int> nuevoHorarios(HorariosModel nuevoHorarios) async {
    var database;
    final db = await database;
    final horarios = await db.insert('Horarios', nuevoHorarios.toJson());
    return horarios;
  }

  Future<int> nuevoContactos(ContactosModel nuevoContactos) async {
    var database;
    final db = await database;
    final contactos = await db.insert('Contactos', nuevoContactos.toJson());
    return contactos;
  }

  Future<PersonalModel?> getPersonalById(int id) async {
    final db = await database;
    final res = await db!.query('Personal', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? PersonalModel.fromJson(res.first) : null;
  }

  Future<HorariosModel?> getHorariosById(int id) async {
    final db = await database;
    final horarios =
        await db!.query('Horarios', where: 'id = ?', whereArgs: [id]);
    return horarios.isNotEmpty ? HorariosModel.fromJson(horarios.first) : null;
  }

  Future<ContactosModel?> getContactosById(int id) async {
    final db = await database;
    final contactos =
        await db!.query('Contactos', where: 'id = ?', whereArgs: [id]);
    return contactos.isNotEmpty
        ? ContactosModel.fromJson(contactos.first)
        : null;
  }

  Future<List<PersonalModel>?> getTodoPersonal() async {
    final db = await database;
    final res = await db!.query('Personal');
    return res.isNotEmpty
        ? res.map((p) => PersonalModel.fromJson(p)).toList()
        : [];
  }

  Future<List<HorariosModel>?> getTodoHorarios() async {
    final db = await database;
    final horarios = await db!.query('Horarios');
    return horarios.isNotEmpty
        ? horarios.map((p) => HorariosModel.fromJson(p)).toList()
        : [];
  }

  Future<List<ContactosModel>?> getTodoContactos() async {
    final db = await database;
    final contactos = await db!.query('Contactos');
    return contactos.isNotEmpty
        ? contactos.map((p) => ContactosModel.fromJson(p)).toList()
        : [];
  }

  Future<List<PersonalModel>?> getPersonalPorFiltros(String nombre,
      String apellido, String username, int sueldoMensual) async {
    // PersonalPorNombre
    final db = await database;
    final res = await db!.rawQuery('''
      SELECT * FROM Personal WHERE nombre = 'nombre', apellido = 'apellido', username = 'username', sueldoMensual = 'sueldoMensual'
      ''');
    return res.isNotEmpty
        ? res.map((p) => PersonalModel.fromJson(p)).toList()
        : [];
  }

  Future<List<HorariosModel>?> getHorariosPorFiltros(
      String horaEntrada, String fecha, String horaSalida) async {
    final db = await database;
    final horarios = await db!.rawQuery('''
      SELECT * FROM Horarios WHERE fecha = 'fecha', horaEntrada = 'horaEntrada', horaSalida = 'horaSalida'
      ''');
    return horarios.isNotEmpty
        ? horarios.map((p) => HorariosModel.fromJson(p)).toList()
        : [];
  }

  Future<List<ContactosModel>?> getContactosPorFiltros(
      String nombre, String apellido, String relacion) async {
    final db = await database;
    final contactos = await db!.rawQuery('''
      SELECT * FROM Contactos WHERE nombre = 'nombre', apellido = 'apellido', relacion = 'relacion'
      ''');
    return contactos.isNotEmpty
        ? contactos.map((p) => ContactosModel.fromJson(p)).toList()
        : [];
  }

  Future<int?> updatePersonal(PersonalModel nuevoPersonal) async {
    final db = await database;
    final res = await db?.update('Personal', nuevoPersonal.toJson(),
        where: 'id = ?', whereArgs: [nuevoPersonal.id]);
    return res;
  }

  Future<int?> updateHorarios(HorariosModel nuevoHorarios) async {
    final db = await database;
    final horarios = await db?.update('Horarios', nuevoHorarios.toJson(),
        where: 'id = ?', whereArgs: [nuevoHorarios.id]);
    return horarios;
  }

  Future<int?> updateContactos(ContactosModel nuevoContactos) async {
    final db = await database;
    final contactos = await db?.update('Contactos', nuevoContactos.toJson(),
        where: 'id = ?', whereArgs: [nuevoContactos.id]);
    return contactos;
  }

  Future<int?> deletePersonal(int id) async {
    final db = await database;
    final res = await db?.delete('Personal', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int?> deleteHorarios(int id) async {
    final db = await database;
    final horarios =
        await db?.delete('Horarios', where: 'id = ?', whereArgs: [id]);
    return horarios;
  }

  Future<int?> deleteContactos(int id) async {
    final db = await database;
    final contactos =
        await db?.delete('Contactos', where: 'id = ?', whereArgs: [id]);
    return contactos;
  }

  Future<int?> deleteAllPersonal() async {
    final db = await database;
    final res = await db?.delete('Personal');
    return res;
  }

  Future<int?> deleteAllHorarios() async {
    final db = await database;
    final horarios = await db?.delete('Horarios');
    return horarios;
  }

  Future<int?> deleteAllContactos() async {
    final db = await database;
    final contactos = await db?.delete('Contactos');
    return contactos;
  }
}
