import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
class LoginController extends GetxController {
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
  RxBool isHidden = true.obs;
  RxBool rememberme = false.obs;

  void Login() async {
    final box = GetStorage();
    if (emailC.text == "farhan" && passC.text == "alfarabi") {
      if (box.read("dataRememberme") != null) {
        box.remove("dataRememberme");
      }
      if (rememberme.isTrue) {
        // simpan data ke dalam storage hp

        box.write(
          "dataRememberme",
          {
            "email": emailC.text,
            "pass": passC.text,
          },
        );
      }
      Get.offAllNamed("/homepage");
    } else {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "email atau password anda salahh",
      );
    }
  }

  void logout() {
    Get.offAllNamed("/login");
  }
}
