import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:qr_code/app/controllers/auth_controller.dart';
import 'package:qr_code/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);

  final TextEditingController emailC =
      TextEditingController(text: "admin@gmail.com");
  final TextEditingController passwordC =
      TextEditingController(text: "admin123");

  final AuthController authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextField(
              autocorrect: false,
              controller: emailC,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9))),
            ),
            const SizedBox(height: 20),
            Obx(() => TextField(
                  autocorrect: false,
                  controller: passwordC,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: controller.isHidden.value,
                  decoration: InputDecoration(
                      labelText: "Password",
                      suffixIcon: IconButton(
                        onPressed: () {
                          controller.isHidden.toggle();
                        },
                        icon: Icon(controller.isHidden.isFalse
                            ? Icons.remove_red_eye
                            : Icons.remove_red_eye_outlined),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9))),
                )),
            const SizedBox(height: 35),
            ElevatedButton(
                onPressed: () async {
                  if (controller.isLoading.isFalse) {
                    if (emailC.text.isNotEmpty && passwordC.text.isNotEmpty) {
                      //* proses login
                      controller.isLoading(true);
                      Map<String, dynamic> hasil =
                          await authC.login(emailC.text, passwordC.text);
                      controller.isLoading(false);

                      if (hasil["error"] == true) {
                        Get.snackbar("Error", hasil["message"]);
                      } else {
                        Get.offAllNamed(Routes.home);
                      }
                    } else {
                      Get.snackbar("Error", "Email & password harus diisi.");
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 20)),
                child: Obx(() =>
                    Text(controller.isLoading.isFalse ? "Login" : "Loading")))
          ],
        ));
  }
}
