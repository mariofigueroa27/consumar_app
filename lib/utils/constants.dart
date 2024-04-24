import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;

Color kColorNaranja = const Color.fromRGBO(255, 127, 17, 1);
Color kColorAzul = Color.fromARGB(255, 67, 139, 255);
Color kColorCeleste = const Color.fromRGBO(0, 255, 208, 1);
Color kColorCeleste2 = Color.fromARGB(255, 67, 139, 255);
Color kColorAzul2 = Color.fromARGB(255, 22, 22, 22);

Color kColorBlanco = const Color.fromARGB(255, 255, 255, 255);

/* pw.TextStyle? kTextoCuerpoPdfAutoreport = const pw.TextStyle(fontSize: 12);
pw.TextStyle? kTextoTituloPdfAutoreport =
    pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold); */

pw.TextStyle? textoCuerpoTicketDR = const pw.TextStyle(fontSize: 8);
pw.TextStyle? tituloCuerpoTicketDR =
    pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold);

pw.TextStyle? kTextoTituloPdfAutoreport(pw.Font? font) {
  return pw.TextStyle(fontSize: 14, font: font, fontWeight: pw.FontWeight.bold);
}

pw.TextStyle? kTextoCuerpoPdfAutoreport(pw.Font? font) {
  return pw.TextStyle(fontSize: 8, font: font);
}

TextStyle? tituloCardDamage = TextStyle(
  fontSize: 18.0,
  fontWeight: FontWeight.bold,
  color: kColorAzul,
);
TextStyle? etiquetasCardDamage = TextStyle(
  fontWeight: FontWeight.bold,
  color: kColorAzul,
);
