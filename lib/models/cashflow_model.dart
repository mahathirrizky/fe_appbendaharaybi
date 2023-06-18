// To parse this JSON data, do
//
//     final cashflowModel = cashflowModelFromJson(jsonString);

import 'dart:convert';

CashflowModel cashflowModelFromJson(String str) =>
    CashflowModel.fromJson(json.decode(str));

String cashflowModelToJson(CashflowModel data) => json.encode(data.toJson());

class CashflowModel {
  int id;
  int jumlah;
  String keterangan;
  String jenis;
  String? imageurl;
  DateTime createdAt;

  CashflowModel({
    required this.id,
    required this.jumlah,
    required this.keterangan,
    required this.jenis,
    this.imageurl,
    required this.createdAt,
  });

  factory CashflowModel.fromJson(Map<String, dynamic> json) => CashflowModel(
        id: json["id"],
        jumlah: json["jumlah"],
        keterangan: json["keterangan"],
        jenis: json["jenis"],
        imageurl: json["image_url"],
        createdAt: DateTime.parse(json["createdAt"] as String),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "jumlah": jumlah,
        "keterangan": keterangan,
        "jenis": jenis,
        "image_url": imageurl,
        "createdAt": createdAt.toIso8601String(),
      };
}
