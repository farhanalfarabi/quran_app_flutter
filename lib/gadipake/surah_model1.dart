// // To parse this JSON data, do
// //
// //     final surahModel = surahModelFromJson(jsonString);

// import 'dart:convert';

// SurahModel surahModelFromJson(String str) =>
//     SurahModel.fromJson(json.decode(str));

// String surahModelToJson(SurahModel data) => json.encode(data.toJson());

// class SurahModel {
//   int? code;
//   String? message;
//   Data? data;

//   SurahModel({
//     this.code,
//     this.message,
//     this.data,
//   });

//   factory SurahModel.fromJson(Map<String, dynamic> json) => SurahModel(
//         code: json["code"],
//         message: json["message"],
//         data: json["data"] == null ? null : Data.fromJson(json["data"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "code": code,
//         "message": message,
//         "data": data?.toJson(),
//       };
// }

// class Data {
//   int? nomor;
//   String? nama;
//   String? namaLatin;
//   int? jumlahAyat;
//   String? tempatTurun;
//   String? arti;
//   String? deskripsi;
//   Map<String, String>? audioFull;
//   List<Ayat>? ayat;
//   SuratSenya? suratSelanjutnya;
//   SuratSenya? suratSebelumnya;

//   Data({
//     this.nomor,
//     this.nama,
//     this.namaLatin,
//     this.jumlahAyat,
//     this.tempatTurun,
//     this.arti,
//     this.deskripsi,
//     this.audioFull,
//     this.ayat,
//     this.suratSelanjutnya,
//     this.suratSebelumnya,
//   });

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         nomor: json["nomor"],
//         nama: json["nama"],
//         namaLatin: json["namaLatin"],
//         jumlahAyat: json["jumlahAyat"],
//         tempatTurun: json["tempatTurun"],
//         arti: json["arti"],
//         deskripsi: json["deskripsi"],
//         audioFull: Map.from(json["audioFull"]!)
//             .map((k, v) => MapEntry<String, String>(k, v)),
//         ayat: json["ayat"] == null
//             ? []
//             : List<Ayat>.from(json["ayat"]!.map((x) => Ayat.fromJson(x))),
//         suratSelanjutnya: json["suratSelanjutnya"] == false
//             ? null
//             : SuratSenya.fromJson(json["suratSelanjutnya"]),
//         suratSebelumnya: json["suratSebelumnya"] == false
//             ? null
//             : SuratSenya.fromJson(json["suratSebelumnya"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "nomor": nomor,
//         "nama": nama,
//         "namaLatin": namaLatin,
//         "jumlahAyat": jumlahAyat,
//         "tempatTurun": tempatTurun,
//         "arti": arti,
//         "deskripsi": deskripsi,
//         "audioFull":
//             Map.from(audioFull!).map((k, v) => MapEntry<String, dynamic>(k, v)),
//         "ayat": ayat == null
//             ? []
//             : List<dynamic>.from(ayat!.map((x) => x.toJson())),
//         "suratSelanjutnya": suratSelanjutnya?.toJson(),
//         "suratSebelumnya": suratSebelumnya?.toJson(),
//       };
// }

// class Ayat {
//   int? nomorAyat;
//   String? teksArab;
//   String? teksLatin;
//   String? teksIndonesia;
//   Map<String, String>? audio;

//   Ayat({
//     this.nomorAyat,
//     this.teksArab,
//     this.teksLatin,
//     this.teksIndonesia,
//     this.audio,
//   });

//   factory Ayat.fromJson(Map<String, dynamic> json) => Ayat(
//         nomorAyat: json["nomorAyat"],
//         teksArab: json["teksArab"],
//         teksLatin: json["teksLatin"],
//         teksIndonesia: json["teksIndonesia"],
//         audio: Map.from(json["audio"]!)
//             .map((k, v) => MapEntry<String, String>(k, v)),
//       );

//   Map<String, dynamic> toJson() => {
//         "nomorAyat": nomorAyat,
//         "teksArab": teksArab,
//         "teksLatin": teksLatin,
//         "teksIndonesia": teksIndonesia,
//         "audio":
//             Map.from(audio!).map((k, v) => MapEntry<String, dynamic>(k, v)),
//       };
// }

// class SuratSenya {
//   int? nomor;
//   String? nama;
//   String? namaLatin;
//   int? jumlahAyat;

//   SuratSenya({
//     this.nomor,
//     this.nama,
//     this.namaLatin,
//     this.jumlahAyat,
//   });

//   factory SuratSenya.fromJson(Map<String, dynamic> json) => SuratSenya(
//         nomor: json["nomor"],
//         nama: json["nama"],
//         namaLatin: json["namaLatin"],
//         jumlahAyat: json["jumlahAyat"],
//       );

//   Map<String, dynamic> toJson() => {
//         "nomor": nomor,
//         "nama": nama,
//         "namaLatin": namaLatin,
//         "jumlahAyat": jumlahAyat,
//       };
// }
