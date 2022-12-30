import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

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
    Directory? documentsDirectory = await getExternalStorageDirectory();
    final path = join(documentsDirectory!.path,
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
            sueldo mensual INTEGER,
          )
        ''');
      await db.execute('''
          CREATE TABLE Horarios de Trabajo (
            id INTEGER PRIMARY KEY,
            fecha TEXT,
            hora entrada INTEGER,
            hora salida INTEGER,
            usuario_id TEXT,
            FOREIGN KEY(usuario_id) REFERENCES usuarios(_id)
          )
        ''');
      await db.execute('''
          CREATE TABLE contactos_asociados (
            id INTEGER PRIMARY KEY,
            nombre TEXT,
            apellido TEXT,
            telefonos TEXT,
            direccion TEXT,
            relacion TEXT,
            usuario_id TEXT,
            FOREIGN KEY(usuario_id) REFERENCES usuarios(_id)
          )
          ''');
    });
  }

  nuevoPersonalRaw () async{
    
  }

}



