// To parse this JSON data, do
//
//     final horariosModel = horariosModelFromJson(jsonString);

import 'dart:convert';

HorariosModel horariosModelFromJson(String str) => HorariosModel.fromJson(json.decode(str));

String horariosModelToJson(HorariosModel data) => json.encode(data.toJson());

class HorariosModel {
    HorariosModel({
        required this.id,
        required this.fecha,
        required this.horaEntrada,
        required this.horaSalida,
        required this.usuarioId,
    });

    int id;
    String fecha;
    String horaEntrada;
    String horaSalida;
    String usuarioId;

    factory HorariosModel.fromJson(Map<String, dynamic> json) => HorariosModel(
        id: json["id"],
        fecha: json["fecha"],
        horaEntrada: json["hora entrada"],
        horaSalida: json["hora salida"],
        usuarioId: json["usuario_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fecha": fecha,
        "hora entrada": horaEntrada,
        "hora salida": horaSalida,
        "usuario_id": usuarioId,
    };
}
