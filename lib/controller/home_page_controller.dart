import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:log/model/user_model.dart';
import 'package:log/pages/home.page.dart';

class UserController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  GlobalKey<FormState>? formKey;

  @override
  void onInit() {
    formKey = GlobalKey<FormState>();
    super.onInit();
  }

  void signUserIn() async {
    showDialog(
      context: Get.context!,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    // print(emailController.text);
    // print(passwordController.text);

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      )
          .then((value) {
        final User? user = FirebaseAuth.instance.currentUser;
        final uuid = user!.uid;
        FirebaseFirestore.instance
            .collection('users')
            .doc(uuid)
            .snapshots()
            .map((event) {
          return UserModel.fromJson(event.data()!);
        });
        value.user?.uid;
      });
      Navigator.pop(Get.context!);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  void signUserUp() async {
    showDialog(
      context: Get.context!,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    try {
      if (passwordController.text == confirmpasswordController.text) {
        if (passwordController.text.length < 6) {
          Navigator.pop(Get.context!);
          showErrorMessage("Şifre en az 6 karakter olmalıdır.");
        }
        if (emailController.toString().contains('@')) {
        } else {
          Navigator.pop(Get.context!);
          showErrorMessage("Mail adresiniz hatalı.");
        }
        if (emailController.text.isEmpty) {
          Navigator.pop(Get.context!);
          showErrorMessage("Mail adresinizi giriniz.");
        }
        if (ageController.text.trim().isEmpty) {
          Navigator.pop(Get.context!);
          showErrorMessage("Yaşınızı yazınız.");
        }
        if (lastNameController.text.isEmpty) {
          Navigator.pop(Get.context!);
          showErrorMessage("Soyadınızı yazınız.");
        }
        if (firstNameController.text.isEmpty) {
          Navigator.pop(Get.context!);
          showErrorMessage("Adınızı yazınız.");
        } else {
          Navigator.pop(Get.context!);
          await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: emailController.text,
                  password: passwordController.text)
              .then((value) async {
            await FirebaseFirestore.instance
                .collection('users')
                .doc(value.user!.uid)
                .set({
              'First Name': firstNameController.text,
              'last Name': lastNameController.text,
              'email': emailController.text,
              'age': int.parse(ageController.text),
              "uID": value.user!.uid,
            });
            Get.to(() => Homecall());
          });
        }
      }
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  void showErrorMessage(String message) {
    showDialog(
        context: Get.context!,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.deepPurple,
            title: Center(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        });
  }
}
