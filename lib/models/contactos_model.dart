// To parse this JSON data, do
//
//     final contactosModel = contactosModelFromJson(jsonString);

import 'dart:convert';

ContactosModel contactosModelFromJson(String str) => ContactosModel.fromJson(json.decode(str));

String contactosModelToJson(ContactosModel data) => json.encode(data.toJson());

class ContactosModel {
    ContactosModel({
        required this.id,
        required this.nombre,
        this.apellido,
        required this.telefono,
        this.direccion,
        required this.relacion,
        required this.usuarioId,
    });

    int id;
    String nombre;
    String? apellido;
    int telefono;
    String? direccion;
    String relacion;
    String usuarioId;

    factory ContactosModel.fromJson(Map<String, dynamic> json) => ContactosModel(
        id: json["id"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        telefono: json["telefono"],
        direccion: json["direccion"],
        relacion: json["relacion"],
        usuarioId: json["usuario_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "apellido": apellido,
        "telefono": telefono,
        "direccion": direccion,
        "relacion": relacion,
        "usuario_id": usuarioId,
    };
}
