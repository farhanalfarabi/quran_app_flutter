import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quran_app/homepage.dart';
import 'package:quran_app/sign_in.dart';
import 'package:quran_app/sign_up.dart';
import 'package:quran_app/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  await GetStorage.init();

  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

  runApp(MyApp(isFirstTime: isFirstTime));
}

class MyApp extends StatelessWidget {
  final bool isFirstTime;

  MyApp({
    super.key,
    required bool this.isFirstTime,
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: isFirstTime
            ? SplashScreen()
            : HomePage(), // Ganti HomePage dengan halaman utama Anda
        getPages: [
          GetPage(
            name: "/login",
            page: () => Login(),
          ),
          GetPage(
            name: "/homepage",
            page: () => HomePage(),
          ),
          GetPage(
            name: "/daftar",
            page: () => Daftar(),
          ),
        ]);
  }
}
