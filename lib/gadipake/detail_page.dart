// import 'dart:convert';
// import 'dart:developer';

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:quran_app/gadipake/surah_model.dart';
// import 'package:quran_app/theme/theme.dart';
// import 'package:http/http.dart' as http;

// class DetailPage extends StatefulWidget {
//   final int noSurat;

//   DetailPage({super.key, required this.noSurat});

//   @override
//   State<DetailPage> createState() => _DetailPageState();
// }

// class _DetailPageState extends State<DetailPage> {
//   final dio = Dio();
//   SurahModel? _surahDetails;

//   @override
//   void initState() {
//     super.initState();
//     getDetailSurah(widget.noSurat);
//   }

//   Future<SurahModel?> getDetailSurah(int noSurat) async {
//     try {
//       final response = await dio.get("https://equran.id/api/v2/surat/$noSurat");
//       final data = SurahModel.fromJson(response.data);
//       setState(() {
//         _surahDetails = data;
//       });
//       return data;
//     } on DioException {
//       return null;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: background,
//       appBar: _appBar(context: context),
//       body: FutureBuilder(
//         future: getDetailSurah(widget.noSurat),
//         builder: (context, snapshot) {
//           final data = snapshot.data?.data;
//           if (snapshot.hasData) {
//             return SafeArea(
//                 child: Text(
//               data!.nama!,
//               style: TextStyle(color: Colors.white, fontSize: 30),
//             ));
//           } else if (snapshot.hasError) {
//             return Text("Terjadi Kesalahan");
//           }
//           return LinearProgressIndicator();
//         },
//       ),
//     );
//   }

//   AppBar _appBar({required BuildContext context}) {
//     return AppBar(
//       backgroundColor: background,
//       automaticallyImplyLeading: false,
//       title: Row(
//         children: [
//           IconButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               icon: SvgPicture.asset('assets/svg/back-icon.svg')),
//           SizedBox(
//             width: 24,
//           ),
//           Text(
//             _surahDetails?.data?.namaLatin ?? "loading",
//             style: GoogleFonts.poppins(
//                 color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
//           ),
//           Spacer(),
//           IconButton(
//               onPressed: () {},
//               icon: SvgPicture.asset('assets/svg/search-icon.svg')),
//         ],
//       ),
//     );
//   }
// }
