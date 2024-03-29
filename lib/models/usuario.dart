// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

import 'package:app_movil_oficial/global/environment.dart';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

final base_url = Environment.apiUrl;

class Usuario {
  Usuario({
    this.online,
    this.nombre,
    this.email,
    this.img,
    this.uid,
    this.role = "OFICIAL_ROLE",
  });

  bool online;
  String nombre;
  String email;
  String img;
  String uid;
  String role;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        online: json["online"],
        nombre: json["nombre"],
        email: json["email"],
        img: json["img"],
        uid: json["uid"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "online": online,
        "nombre": nombre,
        "email": email,
        "img": img,
        "uid": uid,
        "role": role,
      };

  String get imagenUrl {
    return '$base_url/uploads/usuarios/no-image';
  }
}
