import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app/controllers/login_controller.dart';
import 'package:quran_app/homepage.dart';
import 'package:quran_app/sign_up.dart';
import 'package:quran_app/theme/theme.dart';

class Login extends StatelessWidget {
  final box = GetStorage();
  final LoginController loginC = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    if (box.read("dataRememberme") != null) {
      loginC.rememberme.value = true;
      loginC.emailC.text = box.read("dataRememberme")["email"];
      loginC.passC.text = box.read("dataRememberme")["pass"];
    }
    return Scaffold(
      backgroundColor: background,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Qur'an Qu",
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w700),
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
            Container(
              width: double.infinity,
              child: Text(
                "Sign In ",
                style: GoogleFonts.poppins(
                    color: purple3, fontSize: 14, fontWeight: FontWeight.w700),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 22,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFDF98FA), Color(0xFF9055FF)],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                controller: loginC.emailC,
                decoration: InputDecoration(
                  hintText: "email",
                  prefixIcon: Icon(
                    Icons.person,
                  ),
                  hintStyle: TextStyle(
                    color: Color(0xCC300759),
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  filled: true,
                  fillColor: Colors.transparent, // Set fillColor to transparent
                ),
              ),
            ),
            SizedBox(
              height: 22,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFDF98FA), Color(0xFF9055FF)],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Obx(
                () => TextFormField(
                  controller: loginC.passC,
                  obscureText: loginC.isHidden.value,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () => loginC.isHidden.toggle(),
                      icon: Icon(Icons.remove_red_eye),
                    ),
                    hintText: "password",
                    prefixIcon: Icon(
                      Icons.lock,
                    ),
                    hintStyle: TextStyle(
                        color: Color(0xCC300759),
                        fontSize: 13,
                        fontWeight: FontWeight.w400),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    filled: true,
                    fillColor:
                        Colors.transparent, // Set fillColor to transparent
                  ),
                ),
              ),
            ),
            Obx(() => CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  value: loginC.rememberme.value,
                  title: Text(
                    "Remember me",
                    style: TextStyle(
                        fontSize: 14,
                        color: purple3,
                        fontWeight: FontWeight.w400),
                  ),
                  onChanged: (value) {
                    loginC.rememberme.toggle();
                  },
                )),
            SizedBox(
              height: 44,
            ),
            GestureDetector(
              onTap: () => loginC.Login(),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFDF98FA), Color(0xFF9055FF)],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            RichText(
              text: TextSpan(
                  style: TextStyle(
                    color: purple3,
                    fontSize: 11,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                  children: [
                    TextSpan(
                      text: ("Don’t have an account ? "),
                    ),
                    TextSpan(
                        text: ("Register here"),
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
                                  builder: (context) => Daftar(),
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
