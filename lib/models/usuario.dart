// To parse this JSON data, do
//
//     final usuario = usuarioFromMap(jsonString);

import 'dart:convert';

class Usuario {
  String name;
  String email;
  String address;
  String phone;
  String? photo;
  String? id;

  Usuario({
    required this.name,
    required this.email,
    required this.address,
    required this.phone,
    this.photo,
    this.id,
  });

  factory Usuario.fromJson(String str) => Usuario.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Usuario.fromMap(Map<String, dynamic> json) => Usuario(
        name: json["name"],
        email: json["email"],
        address: json["address"],
        phone: json["phone"],
        photo: json["photo"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "email": email,
        "address": address,
        "phone": phone,
        "photo": photo,
      };
  // Devuelve una copia del objeto Product.
  Usuario copy() => Usuario(
      name: this.name,
      email: this.email,
      address: this.address,
      phone: this.phone,
      photo: this.photo,
      id: this.id);
}
