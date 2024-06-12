import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:quran_app/theme/theme.dart';

class DescriptionPage extends StatelessWidget {
  final int noSurat;
  final String namaSurat;

  DescriptionPage({super.key, required this.noSurat, required this.namaSurat});

  Future<String> getDescription() async {
    try {
      var response =
          await http.get(Uri.parse("https://equran.id/api/v2/surat/$noSurat"));
      var data = json.decode(response.body)['data'];
      return data['deskripsi'] ?? 'No description available';
    } catch (e) {
      throw Exception("Failed to load description");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getDescription(),
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
              child: Text("No description available"),
            ),
          );
        }

        String description = snapshot.data!;
        return Scaffold(
          backgroundColor: background,
          appBar: _appBar(context: context),
          body: Padding(
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
                    child: Text(
                      description,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  AppBar _appBar({required BuildContext context}) {
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
            "Deskripsi ${namaSurat}",
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
