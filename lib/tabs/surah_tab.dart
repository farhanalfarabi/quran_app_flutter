import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:quran_app/detail_surah.dart';
import 'package:quran_app/models/surah_model.dart';
import 'package:quran_app/theme/theme.dart';

class SurahTab extends StatelessWidget {
  List<Surah> allSurah = [];

  Future<void> getAllSurah() async {
    try {
      var response = await http.get(Uri.parse("https://equran.id/api/v2/surat"));
      List data = (json.decode(response.body) as Map<String, dynamic>)['data'];
      data.forEach((element) {
        allSurah.add(Surah.fromJson(element));
      });
    } catch (e) {
      print("Terjadi kesalahan");
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: FutureBuilder(
        future: getAllSurah(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Terjadi kesalahan: ${snapshot.error}"),
            );
          } else if (allSurah.isEmpty) {
            return Center(
              child: Text("Tidak ada data.."),
            );
          } else {
            return ListView.separated(
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailSurah(noSurat: allSurah[index].nomor,),
                    ),
                  );
                },
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          SvgPicture.asset('assets/svg/nomor-icon.svg'),
                          SizedBox(
                            height: 36,
                            width: 36,
                            child: Center(
                              child: Text(
                                "${allSurah[index].nomor}",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${allSurah[index].namaLatin}",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Row(
                              children: [
                                SizedBox(height: 4),
                                Text(
                                  "${allSurah[index].tempatTurun}",
                                  style: GoogleFonts.poppins(
                                    color: text,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Container(
                                  height: 4,
                                  width: 4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    color: text,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "${allSurah[index].jumlahAyat}",
                                  style: GoogleFonts.poppins(
                                    color: text,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "${allSurah[index].nama}",
                        style: GoogleFonts.amiri(
                          color: textPrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              separatorBuilder: (context, index) => Divider(
                color: Color(0xFF7B80AD59).withOpacity(.35),
              ),
              itemCount: allSurah.length,
            );
          }
        },
      ),
    );
  }
}
