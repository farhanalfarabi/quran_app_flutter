import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:quran_app/detail_doa.dart';
import 'package:quran_app/models/doa_model.dart';
import 'package:quran_app/theme/theme.dart';

class DoaTab extends StatelessWidget {
  List<DoaModel> allUser = [];
  Future getAllDoa() async {
    try {
      var response = await http
          .get(Uri.parse("https://doa-doa-api-ahmadramadhan.fly.dev/api"));
      List data = json.decode(response.body) as List;
      data.forEach((element) {
        allUser.add(DoaModel.fromJson(element));
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
        future: getAllDoa(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text("Loading...."),
            );
          } else {
            if (allUser.length == 0) {
              return Center(
                child: Text("Tidak ada data.."),
              );
            }

            return ListView.separated(
                itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailDoa(noId: allUser[index].id),
                          ),
                        );
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 24),
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
                                      "${allUser[index].id}",
                                      style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Row(
                              children: [
                                Text(
                                  "${allUser[index].doa}",
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                separatorBuilder: (context, index) => Container(),
                itemCount: allUser.length);
          }
        },
      ),
    );
  }
}
