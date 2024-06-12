import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:quran_app/deskripsi_surah.dart';
import 'package:quran_app/models/ayat_model.dart';
import 'package:quran_app/models/surah_model.dart';
import 'package:quran_app/tabs/surah_tab.dart';
import 'package:quran_app/tafsir_page.dart';
import 'package:quran_app/theme/theme.dart';

class DetailSurah extends StatelessWidget {
  final int noSurat;

  DetailSurah({super.key, required this.noSurat});

  Future<Surah> getDetailSurah() async {
    try {
      var response =
          await http.get(Uri.parse("https://equran.id/api/v2/surat/$noSurat"));
      var data = json.decode(response.body)['data'];
      return Surah.fromJson(data);
    } catch (e) {
      throw Exception("Failed to load surah details");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Surah>(
      future: getDetailSurah(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: background,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            backgroundColor: background,
            body: Center(
              child: Text("Error: ${snapshot.error}"),
            ),
          );
        } else if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: background,
            body: Center(
              child: Text("No data available"),
            ),
          );
        }

        Surah detailSurah = snapshot.data!;
        return Scaffold(
          backgroundColor: background,
          appBar: _appBar(context: context, surah: detailSurah),
          body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverToBoxAdapter(
                      child: _Details(context: context, surah: detailSurah),
                    )
                  ],
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      var ayat = detailSurah.ayat![index];
                      return _ayatItem(ayat: ayat, context: context);
                    },
                    separatorBuilder: (context, index) => Container(),
                    itemCount: detailSurah.jumlahAyat),
              )),
        );
      },
    );
  }

  Widget _ayatItem({required Ayat ayat, required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: abu),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 27,
                  width: 27,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(27 / 2),
                      color: purple),
                  child: Center(
                    child: Text(
                      "${ayat.nomorAyat}",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                  ),
                ),
              ),
              Spacer(),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => TafsirPage(
              //             noSurat: noSurat,
              //           ),
              //         ));
              //   },
              //   child: Text("baca tafsir"),
              // ),
              Icon(
                Icons.share_outlined,
                size: 24,
                color: Colors.white,
              ),
              SizedBox(
                width: 16,
              ),
              Icon(
                Icons.play_arrow_outlined,
                size: 24,
                color: Colors.white,
              ),
              SizedBox(
                width: 16,
              ),
              Icon(
                Icons.bookmark_outline_outlined,
                size: 24,
                color: Colors.white,
              ),
              SizedBox(
                width: 16,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          "${ayat.teksArab}",
          style: GoogleFonts.amiri(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.right,
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          "${ayat.teksIndonesia}",
          style: GoogleFonts.poppins(
            color: text,
            fontSize: 16,
          ),
          textAlign: TextAlign.right,
        ),
      ]),
    );
  }

  Container _Details({required BuildContext context, required Surah surah}) =>
      Container(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Stack(
                    children: [
                      Container(
                        height: 257,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                stops: [
                                  0,
                                  1,
                                ],
                                colors: [
                                  Color(0xFFDF98FA),
                                  Color(0xFF9055FF)
                                ])),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Opacity(
                            opacity: .3,
                            child: SvgPicture.asset(
                              'assets/svg/quran.svg',
                              height: 138,
                            ),
                          )),
                      Container(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                surah.namaLatin,
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 26,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                surah.arti,
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              Divider(
                                height: 32,
                                color: Colors.white.withOpacity(.35),
                                thickness: 2,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 4),
                                  Text(
                                    surah.tempatTurun,
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Container(
                                    height: 4,
                                    width: 4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "${surah.jumlahAyat.toString()} ayat ",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 32,
                              ),
                              SvgPicture.asset("assets/svg/bismillah.svg"),
                              Container(
                                width: double.infinity,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DescriptionPage(
                                                noSurat: surah.nomor,
                                                namaSurat: surah.namaLatin,
                                              )),
                                    );
                                  },
                                  child: Text(
                                    "baca selengkapnya",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      );

  AppBar _appBar({required BuildContext context, required Surah surah}) {
    return AppBar(
      backgroundColor: background,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset('assets/svg/back-icon.svg'),
          ),
          SizedBox(width: 24),
          Text(
            surah.namaLatin,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          Spacer(),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset('assets/svg/search-icon.svg'),
          ),
        ],
      ),
    );
  }
}
