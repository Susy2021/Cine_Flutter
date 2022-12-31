import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:peliculas/providers/db_providers.dart';

class PersonalListProvider extends ChangeNotifier {
  List<PersonalModel> personal = [];
  List<HorariosModel> horarios = [];
  List<ContactosModel> contactos = [];

  //String tipoSeleccionado = 'http' ; 
  nuevoPersonal(String id) async {
    final nuevoPersonal = new PersonalModel(
      id: 1,
      apellido: '',
      dni: '',
      edad: '',
      fechaNacimiento: '',
      nombre: '',
      username: '',
      sueldoMensual: '',
    );
    final id = await DBProvider.db.nuevoPersonal(nuevoPersonal);
    nuevoPersonal.id = id!;
    this.personal.add(nuevoPersonal);
    notifyListeners();
  }

  nuevoHorarios(String id) async {
    final nuevoHorarios = new HorariosModel(
      id: 1,
      fecha: '',
      horaEntrada: '',
      horaSalida: '',
      usuarioId: '',
    );
    final id = await DBProvider.db.nuevoHorarios(nuevoHorarios);
    nuevoHorarios.id = id;
    this.horarios.add(nuevoHorarios);
    notifyListeners();
  }

  nuevoContactos(String id) async {
    final nuevoContactos = new ContactosModel(
      id: 1,
      nombre: '',
      apellido: '',
      telefono: 1,
      usuarioId: '',
      relacion: '',
    );
    final id = await DBProvider.db.nuevoContactos(nuevoContactos);
    nuevoContactos.id = id;
    this.contactos.add(nuevoContactos);
    notifyListeners();
  }

  cargarPersonal() async {
    final personal = await DBProvider.db.getTodoPersonal();
    this.personal = [...?personal];
    notifyListeners();
  }

  cargarHorarios() async {
    final horarios = await DBProvider.db.getTodoHorarios();
    this.horarios = [...?horarios];
    notifyListeners();
  }

  cargarContactos() async {
    final contactos = await DBProvider.db.getTodoContactos();
    this.contactos = [...?contactos];
    notifyListeners();
  }

  cargarPersonalPorFiltros(String , String s, String string )async {
    final personal = await DBProvider.db.getPersonalPorFiltros('', '', '', 1);
    this.personal = [...?personal];
    //this.tipoSeleccionado = tipo;
    notifyListeners();
  }

  cargarHorariosPorFiltros(String s, String string, String ) async {
    final horarios = await DBProvider.db.getHorariosPorFiltros(
      '',
      '',
      '',
    );
    this.horarios = [...?horarios];
    //this.tipoSeleccionado = tipo;
    notifyListeners();
  }

  cargarContactosPorFiltros(String s, String string, String ) async {
    final contactos = await DBProvider.db.getContactosPorFiltros(
      '',
      '',
      '',
    );
    this.contactos = [...?contactos];
    //this.tipoSeleccionado = tipo;
    notifyListeners();
  }

  borrarTodosPersonal() async {
    await DBProvider.db.deleteAllPersonal();
    this.personal = [];
    notifyListeners();
  }

  borrarTodosHorarios() async {
    await DBProvider.db.deleteAllHorarios();
    this.horarios = [];
    notifyListeners();
  }

  borrarTodosContactos() async {
    await DBProvider.db.deleteAllContactos();
    this.contactos = [];
    notifyListeners();
  }

  borrarPersonalPorId(int id) async {
    await DBProvider.db.deletePersonal(id);
    this.cargarPersonalPorFiltros(
      '',
      '',
      '',);
  }
  borrarHorariosPorId(int id) async {
    await DBProvider.db.deleteHorarios(id);
    this.cargarHorariosPorFiltros(
      '',
      '',
      '',);
  }
  borrarContactosPorId(int id) async {
    await DBProvider.db.deleteContactos(id);
    this.cargarContactosPorFiltros(
      '',
      '',
      '',);
  }

}
