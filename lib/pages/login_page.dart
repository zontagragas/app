import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:log/pages/register_page.dart';

import '../controller/home_page_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool passwordVisible = false;
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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

                        Text(
                          'Tekrardan Hoşgeldiniz!',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 19,
                          ),
                        ),

                        const SizedBox(height: 55),

                        SizedBox(
                          width: 350,
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  // errorText: loginfail ? 'password not match' : null,
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
                                  hintText: 'Mail Adresiniz',
                                  hintStyle: GoogleFonts.lexendDeca(
                                      textStyle:
                                          TextStyle(color: Colors.grey[500]))),
                              controller: _.emailController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Mail Adresinizi Giriniz!';
                                }
                                if (!value.contains('@')) {
                                  return 'Mail Adresiniz Hatalı';
                                }
                                if (value.length < 8) {
                                  return 'Mail Adresiniz Çok Kısa';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: 350,
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: TextFormField(
                              obscureText: true,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(15),
                              ],
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
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_.formKey!.currentState!.validate()) {
                              print('Gönderildi');
                              _.signUserIn();
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
                          child: Text("Giriş Yap",
                              style: GoogleFonts.lexendDeca(
                                textStyle: const TextStyle(
                                    color: Colors.white, fontSize: 18),
                              )),
                        ),

                        const SizedBox(height: 50),

                        // üye
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Henüz üye değilmisiniz?',
                                style: GoogleFonts.lexendDeca(
                                  textStyle: TextStyle(color: Colors.grey[700]),
                                )),
                            TextButton(
                              onPressed: () {
                                Get.to(() => RegisterPage());
                              },
                              child: Text('Kayıt olun',
                                  style: GoogleFonts.lexendDeca(
                                    textStyle: const TextStyle(
                                      color: Color.fromARGB(255, 110, 0, 130),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                            )
                          ],
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
