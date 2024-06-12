import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:quran_app/models/doa_model.dart';
import 'package:quran_app/theme/theme.dart';

class DetailDoa extends StatefulWidget {
  final String noId;
  DetailDoa({required this.noId});

  @override
  _DetailDoaState createState() => _DetailDoaState();
}

class _DetailDoaState extends State<DetailDoa> {
  late Future<DoaModel> doaDetail;
  String? doaName; // State untuk menyimpan nama doa

  Future<DoaModel> fetchDoaDetail() async {
    try {
      var response = await http
          .get(Uri.parse("https://doa-doa-api-ahmadramadhan.fly.dev/api"));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        List doaList = data as List;
        var doa = doaList.firstWhere((element) => element['id'] == widget.noId,
            orElse: () => null);
        if (doa != null) {
          setState(() {
            doaName = doa['doa']; // Perbarui nama doa
          });
          return DoaModel.fromJson(doa);
        } else {
          throw Exception('Doa tidak ditemukan');
        }
      } else {
        throw Exception('Failed to load doa');
      }
    } catch (e) {
      throw Exception('Failed to load doa');
    }
  }

  @override
  void initState() {
    super.initState();
    doaDetail = fetchDoaDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: _appBar(),
      body: FutureBuilder<DoaModel>(
        future: doaDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            var doa = snapshot.data!;
            return _doaItem(doa);
          } else {
            return Center(child: Text("Doa tidak ditemukan"));
          }
        },
      ),
    );
  }

  Padding _doaItem(DoaModel doa) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: purple,
                    width: 4,
                  )),
              child: Column(
                children: [
                  Text(
                    doa.doa,
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  // SizedBox(height: 20),
                  Container(
                    width: 100.0,
                    child: SvgPicture.asset(
                      "assets/svg/bismillah.svg",
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    doa.ayat,
                    style: GoogleFonts.amiri(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.end,
                  ),
                  SizedBox(height: 20),
                  Text(
                    doa.artinya,
                    style:
                        GoogleFonts.poppins(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _appBar() {
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
          Expanded(
            child: Text(
              doaName ?? "", // Tampilkan nama doa atau kosong jika belum dimuat
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
              overflow: TextOverflow
                  .ellipsis, // Tambahkan ellipsis jika teks terlalu panjang
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset('assets/svg/search-icon.svg'),
          ),
        ],
      ),
    );
  }
}
