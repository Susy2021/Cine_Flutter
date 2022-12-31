// To parse this JSON data, do
//
//     final personalModel = personalModelFromJson(jsonString);

import 'dart:convert';
import 'package:meta/meta.dart';

PersonalModel personalModelFromJson(String str) =>
    PersonalModel.fromJson(json.decode(str));

String personalModelToJson(PersonalModel data) => json.encode(data.toJson());

class PersonalModel {
  PersonalModel({
    required this.id,
    required this.username,
    required this.nombre,
    required this.apellido,
    required this.dni,
    required this.fechaNacimiento,
    required this.edad,
    this.telefono,
    this.direccion,
    required this.sueldoMensual,
  });

  int id;
  String username;
  String nombre;
  String apellido;
  String dni;
  String fechaNacimiento;
  String edad;
  String? telefono;
  String? direccion;
  String sueldoMensual;

  factory PersonalModel.fromJson(Map<String, dynamic> json) => PersonalModel(
        id: json["id"],
        username: json["username"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        dni: json["dni"],
        fechaNacimiento: json["fechaNacimiento"],
        edad: json["edad"],
        telefono: json["telefono"],
        direccion: json["direccion"],
        sueldoMensual: json["sueldo mensual"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "nombre": nombre,
        "apellido": apellido,
        "dni": dni,
        "fechaNacimiento": fechaNacimiento,
        "edad": edad,
        "telefono": telefono,
        "direccion": direccion,
        "sueldo mensual": sueldoMensual,
      };
}
