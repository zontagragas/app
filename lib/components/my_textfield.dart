import 'package:flutter/material.dart';
import 'package:flutter/src/services/text_formatter.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final keyboardType;
  final String? Function(String?)? validator;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.keyboardType,
    required this.validator, 
    required List<FilteringTextInputFormatter> inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: TextFormField(
          validator: validator,
          keyboardType: keyboardType,
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent, width: 2),
                // borderRadius: BorderRadius.circular(20) yuvarak istiyosan
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
                // borderRadius: BorderRadius.circular(20) yuvarlak yapmak istiyosan
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2),
                // borderRadius: BorderRadius.circular(20)
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2),
                // borderRadius: BorderRadius.circular(20)
              ),
              fillColor: Colors.grey.shade200,
              filled: true,
              hintText: hintText,
              hintStyle: GoogleFonts.lexendDeca(
                  textStyle: TextStyle(color: Colors.grey[500]))),
        ),
      ),
    );
  }
}
