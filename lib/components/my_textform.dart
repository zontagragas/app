// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class MyForm extends StatelessWidget {
//   final controller;
//   final String hintText;
//   final bool obscureText;
//   final keyboardType;

//   MyForm({
//     super.key,
//     required this.controller,
//     required this.hintText,
//     required this.obscureText,
//     required this.keyboardType,
//   });

//   final _formKey = GlobalKey<FormState>();

//   final _emailController = TextEditingController();

//   final _passwordController = TextEditingController();

//   Future<void> _signInWithEmailAndPassword() async {
//     try {
//       await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: _emailController.text,
//         password: _passwordController.text,
//       );
//       // Navigate to another screen or show a success message
//     } catch (e) {
//       // Handle error
//       print(e);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     String controller;
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: [
//           TextFormField(controller: _emailController),
//           TextFormField(
//             inputFormatters: [
//               LengthLimitingTextInputFormatter(15),
//             ],
//             decoration: InputDecoration(
//                 enabledBorder: const OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.white),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.grey.shade400),
//                 ),
//                 fillColor: Colors.grey.shade200,
//                 filled: true,
//                 hintText: hintText,
//                 hintStyle: TextStyle(color: Colors.grey[500])
//                 // The rest of your InputDecoration
//                 ),
//             controller: _emailController,
//             validator: (value) {
              
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
