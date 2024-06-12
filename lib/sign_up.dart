import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app/homepage.dart';
import 'package:quran_app/sign_in.dart';
import 'package:quran_app/sign_up.dart';
import 'package:quran_app/theme/theme.dart';

class Daftar extends StatelessWidget {
  const Daftar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background2,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Quran Qu",
              style: GoogleFonts.poppins(
                  color: purple2, fontSize: 24, fontWeight: FontWeight.w700),
              textAlign: TextAlign.end,
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              "AssalamuAlaikum !!!",
              style: GoogleFonts.poppins(
                  color: purple3, fontSize: 14, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 53,
            ),
            Text(
              "Sign Up ",
              style: GoogleFonts.poppins(
                  color: purple3, fontSize: 14, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 22,
            ),
            TextFormField(
              decoration: const InputDecoration(
                filled: true,
                fillColor: Color(0xFFE5B6F2),
                hintText: "email",
                hintStyle: TextStyle(
                  color: Color(0xCC300759),
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 22,
            ),
            TextFormField(
              decoration: const InputDecoration(
                filled: true,
                fillColor: Color(0xFFE5B6F2),
                hintText: "password",
                hintStyle: TextStyle(
                  color: Color(0xCC300759),
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 22,
            ),
            TextFormField(
              decoration: const InputDecoration(
                filled: true,
                fillColor: Color(0xFFE5B6F2),
                hintText: "Confirmed password",
                hintStyle: TextStyle(
                  color: Color(0xCC300759),
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 44,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ));
              },
              child: Container(
                width: 65,
                height: 40,
                padding: EdgeInsets.all(10),
                decoration: ShapeDecoration(
                  color: Color(0xFFE5B6F2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Sign Up',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF300759),
                    fontSize: 13,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            RichText(
              text: TextSpan(
                  style: TextStyle(
                    color: Color(0xFF300759),
                    fontSize: 11,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                  children: [
                    TextSpan(
                      text: ("have an account ? "),
                    ),
                    TextSpan(
                        text: ("Login here"),
                        style: TextStyle(
                          color: Color(0xFF0E18F6),
                          fontSize: 11,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Login(),
                                ));
                          }),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
