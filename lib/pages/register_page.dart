import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:log/components/my_textfield.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/home_page_controller.dart';
import 'package:get/get.dart';

import 'login_page.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool passwordVisible = false;

    Future addUserDetails(
        String firstName, String lastName, String email, String age) async {
      await FirebaseFirestore.instance.collection('users').add({
        'First Name': firstName,
        'last Name': lastName,
        'email': lastName,
        'age': age
      });
    }

    void showErrorMessage(String message) {
      showDialog(
          context: context,
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

    return GetBuilder<UserController>(
        init: UserController(),
        builder: (_) {
          return Scaffold(
            backgroundColor: Colors.grey[300],
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: _.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 50),

                        const SizedBox(height: 50),

                        Text('Hoşgeldiniz',
                            style: GoogleFonts.lexendDeca(
                                textStyle: TextStyle(color: Colors.grey[500]))),
                        const SizedBox(height: 10),

                        // İsim textfield
                        MyTextField(
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'Boş Bırakılamaz';
                            } else {}
                          },
                          keyboardType: TextInputType.emailAddress,
                          controller: _.firstNameController,
                          hintText: 'İsminiz',
                          obscureText: false,
                          inputFormatters: [],
                        ),
                        const SizedBox(height: 10),

                        // Soyisim textfield
                        MyTextField(
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'Boş Bırakılamaz!';
                            } else {}
                          },
                          keyboardType: TextInputType.text,
                          controller: _.lastNameController,
                          hintText: 'Soyadınız',
                          obscureText: false,
                          inputFormatters: [],
                        ),
                        const SizedBox(height: 10),
                        //yaş
                        MyTextField(
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'Boş Bırakılamaz!';
                            }
                            if (v.contains(RegExp(r'[a-z,A-Z]'))) {
                              return 'Sadece Sayı!';
                            } else {}
                          },
                          keyboardType: TextInputType.number,
                          controller: _.ageController,
                          hintText: 'Yaşınız',
                          obscureText: false,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                          ],
                        ),

                        const SizedBox(height: 10),

                        // mail
                        MyTextField(
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'Boş Bırakılamaz!';
                            } else {}
                          },
                          keyboardType: TextInputType.emailAddress,
                          controller: _.emailController,
                          hintText: 'Mail Adresiniz',
                          obscureText: false,
                          inputFormatters: [],
                        ),

                        const SizedBox(height: 10),

                        SizedBox(
                          width: 350,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                            child: TextFormField(
                              obscureText: !passwordVisible,
                              decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.transparent, width: 2),
                                    // borderRadius: BorderRadius.circular(20) yuvarak istiyosan
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade400),
                                    // borderRadius: BorderRadius.circular(20) yuvarlak yapmak istiyosan
                                  ),
                                  errorBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.red, width: 2),
                                    // borderRadius: BorderRadius.circular(20)
                                  ),
                                  focusedErrorBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.red, width: 2),
                                    // borderRadius: BorderRadius.circular(20)
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    color: Color.fromARGB(255, 110, 0, 130),
                                    onPressed: () {
                                      passwordVisible = !passwordVisible;
                                    },
                                  ),
                                  fillColor: Colors.grey.shade200,
                                  filled: true,
                                  hintText: 'Şifrenizi Giriniz',
                                  hintStyle: GoogleFonts.lexendDeca(
                                      textStyle:
                                          TextStyle(color: Colors.grey[500]))),
                              controller: _.passwordController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Şifrenizi Giriniz!';
                                } else if (value.length < 6) {
                                  return 'Şifreniz Eksik';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),
                        SizedBox(
                          width: 350,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                            child: TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.transparent, width: 2),
                                    // borderRadius: BorderRadius.circular(20) yuvarak istiyosan
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade400),
                                    // borderRadius: BorderRadius.circular(20) yuvarlak yapmak istiyosan
                                  ),
                                  errorBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.red, width: 2),
                                    // borderRadius: BorderRadius.circular(20)
                                  ),
                                  focusedErrorBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.red, width: 2),
                                    // borderRadius: BorderRadius.circular(20)
                                  ),
                                  fillColor: Colors.grey.shade200,
                                  filled: true,
                                  hintText: 'Şifrenizi Giriniz (Yeniden)',
                                  hintStyle: GoogleFonts.lexendDeca(
                                      textStyle:
                                          TextStyle(color: Colors.grey[500]))),
                              controller: _.confirmpasswordController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Şifrenizi Giriniz!';
                                } else if (value.length < 6) {
                                  return 'Şifreniz Eksik';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_.formKey!.currentState!.validate()) {
                              print('Gönderildi');
                              _.signUserUp();
                            } else {
                              print('boş bıraklıdlı');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 140.0, vertical: 20.0),
                              // shape: RoundedRectangleBorder(
                              //     borderRadius: BorderRadius.circular(25.0)), yuvarlak
                              primary: const Color.fromARGB(238, 124, 1, 155)),
                          child: Text("Üye Ol",
                              style: GoogleFonts.lexendDeca(
                                textStyle: const TextStyle(
                                    color: Colors.white, fontSize: 18),
                              )),
                        ),

                        const SizedBox(height: 50),

                        // google giris
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // // google button
                            // SquareTile(imagePath: 'lib/images/google.png'),
                          ],
                        ),

                        // hesapvarmı
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Hesabınız var mı',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            const SizedBox(width: 4),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => LoginPage());
                              },
                              child: const Text(
                                'Giriş yapın',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 110, 0, 130),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
