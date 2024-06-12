// To parse this JSON data, do
//
//     final doaModel = doaModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

DoaModel doaModelFromJson(String str) => DoaModel.fromJson(json.decode(str));

String doaModelToJson(DoaModel data) => json.encode(data.toJson());

class DoaModel {
    String id;
    String doa;
    String ayat;
    String latin;
    String artinya;

    DoaModel({
        required this.id,
        required this.doa,
        required this.ayat,
        required this.latin,
        required this.artinya,
    });

    factory DoaModel.fromJson(Map<String, dynamic> json) => DoaModel(
        id: json["id"],
        doa: json["doa"],
        ayat: json["ayat"],
        latin: json["latin"],
        artinya: json["artinya"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "doa": doa,
        "ayat": ayat,
        "latin": latin,
        "artinya": artinya,
    };
}
