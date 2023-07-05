import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String buttonText; // Added buttonText parameter

  const MyButton({
    Key? key,
    required this.onTap,
    required this.buttonText,
  }) : super(key: key); // Updated constructor

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(25),
          margin: const EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 110, 0, 130),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(buttonText,
                style: GoogleFonts.lexendDeca(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
