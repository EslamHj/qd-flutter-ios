import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_delivery/coponents/darkMode.dart';

class myButton extends StatelessWidget {

  final String label ;
  final Color color ;
  final Function()? onTap ;
  const myButton({Key? key , required this.label  , required this.color ,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap,
      child: Container (
         alignment: Alignment.topCenter,
         padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: color,
        ),
        child: Text(
          label,
          style: GoogleFonts.cairo( textStyle:  TextStyle(
            color: Colors.white, 
            fontWeight: FontWeight.bold
            )),
          ),
      ),
    );
  }
}