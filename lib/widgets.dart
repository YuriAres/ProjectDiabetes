import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomWidgets {
  Widget customTextfield(BuildContext context, String labeltext,
      String hinttext, TextEditingController controller) {
    return TextField(
      controller: controller,
      style: GoogleFonts.ubuntu(
          color: Colors.white,
          fontSize: MediaQuery.of(context).size.height * 0.02),
      decoration: InputDecoration(
        contentPadding:
            EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
        label: Text(labeltext),
        labelStyle: GoogleFonts.ubuntu(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.height * 0.02),
        hintText: hinttext,
        hintStyle: GoogleFonts.ubuntu(
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.height * 0.02),
        filled: true,
        fillColor: const Color(0xff9A68FD),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            borderSide: BorderSide(width: 0, style: BorderStyle.none)),
      ),
    );
  }

  Widget header(BuildContext context, Color fontcolor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "DIA",
          style: GoogleFonts.ubuntu(
              fontSize: (MediaQuery.of(context).size.height * 0.08),
              color: fontcolor),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.01,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "rio",
              style: GoogleFonts.ubuntu(
                  fontSize: (MediaQuery.of(context).size.height * 0.03),
                  color: fontcolor),
            ),
            Text(
              "betes",
              style: GoogleFonts.ubuntu(
                  fontSize: (MediaQuery.of(context).size.height * 0.03),
                  color: fontcolor),
            )
          ],
        )
      ],
    );
  }

  Widget customDropDownButton(
      String hint,
      BuildContext context,
      String? selectedValue,
      List<String> moedas,
      Function(String? selection) func) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.32,
      child: DropdownButtonFormField(
          hint: Text(
            hint,
            style: GoogleFonts.ubuntu(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.height * 0.02),
          ),
          isExpanded: true,
          dropdownColor: const Color(0xff9A68FD),
          decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xff9A68FD),
              contentPadding:
                  EdgeInsets.all(MediaQuery.of(context).size.height * 0.0185),
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 0, style: BorderStyle.none),
                  borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 0, style: BorderStyle.none),
                  borderRadius: BorderRadius.circular(10))),
          icon: const Icon(
            Icons.expand_more,
            size: 30,
            color: Colors.white,
          ),
          value: selectedValue,
          items: moedas
              .map((opcoes) => DropdownMenuItem(
                  value: opcoes,
                  child: Center(
                      child: Text(opcoes,
                          style: GoogleFonts.ubuntu(
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.02)))))
              .toList(),
          onChanged: func),
    );
  }
}
