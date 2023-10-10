import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_diabetes/notepage.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomWidgets {
  Widget customTextfield(BuildContext context, String labeltext,
      String hinttext, TextEditingController controller,
      [Color selectedcolor = Colors.white, int maxlines = 1]) {
    return TextField(
      maxLines: maxlines,
      controller: controller,
      style: GoogleFonts.ubuntu(
          color: selectedcolor,
          fontSize: MediaQuery.of(context).size.height * 0.02),
      decoration: InputDecoration(
        alignLabelWithHint: true,
        contentPadding:
            EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
        label: Text(labeltext),
        labelStyle: GoogleFonts.ubuntu(
            fontWeight: FontWeight.bold,
            color: selectedcolor,
            fontSize: MediaQuery.of(context).size.height * 0.02),
        hintText: hinttext,
        hintStyle: GoogleFonts.ubuntu(
            color: selectedcolor,
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

  Widget customElevatedButton(
      BuildContext context, Function() action, String label) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.06,
      width: MediaQuery.of(context).size.width * 0.6,
      child: ElevatedButton(
        onPressed: action,
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff6318F2),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: Text(
          label,
          style: GoogleFonts.ubuntu(
              fontSize: MediaQuery.of(context).size.height * 0.03,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  String data() {
    String weekday;
    String month;

    switch (DateTime.now().weekday) {
      case 1:
        weekday = "Segunda";
        break;
      case 2:
        weekday = "Terça";
        break;
      case 3:
        weekday = "Quarta";
        break;
      case 4:
        weekday = "Quinta";
        break;
      case 5:
        weekday = "Sexta";
        break;
      case 6:
        weekday = "Sábado";
        break;
      case 7:
        weekday = "Domingo";
        break;
      default:
        weekday = "";
        break;
    }

    switch (DateTime.now().month) {
      case 1:
        month = "Janeiro";
        break;
      case 2:
        month = "Fevereiro";
        break;
      case 3:
        month = "Março";
        break;
      case 4:
        month = "Abril";
        break;
      case 5:
        month = "Maio";
        break;
      case 6:
        month = "Junho";
        break;
      case 7:
        month = "Julho";
        break;
      case 8:
        month = "Agosto";
        break;
      case 9:
        month = "Setembro";
        break;
      case 10:
        month = "Outubro";
        break;
      case 11:
        month = "Novembro";
        break;
      case 12:
        month = "Dezembro";
        break;
      default:
        month = "";
        break;
    }

    return "$weekday, ${DateTime.now().day} de $month de ${DateTime.now().year}";
  }

  Widget containerAnotacao(BuildContext context, num indice, String anotacao) {
    String smallAnotacao;

    print("Teste ${anotacao.length}");
    if (anotacao.length > 28) {
      smallAnotacao = anotacao.substring(0, 28);
      smallAnotacao += "..";
    } else {
      smallAnotacao = anotacao;
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Notepage(indice: indice, anotacao: anotacao);
        }));
      },
      child: Container(
        padding: EdgeInsets.all(MediaQuery.sizeOf(context).height * 0.012),
        margin: const EdgeInsets.symmetric(vertical: 5),
        height: MediaQuery.sizeOf(context).height * 0.13,
        decoration: BoxDecoration(
            color: const Color(0xff9A68FD),
            borderRadius: BorderRadius.all(
                Radius.circular(MediaQuery.sizeOf(context).height * 0.01))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "01/09/23 as 08:30 PM",
              style: GoogleFonts.ubuntu(color: Colors.white),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.012,
            ),
            Text(
              "Indice Glicêmico: $indice MG",
              style: GoogleFonts.ubuntu(
                  color: Colors.white,
                  fontSize: MediaQuery.sizeOf(context).height * 0.022),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.008,
            ),
            Text(
              "Anotações: $smallAnotacao",
              style: GoogleFonts.ubuntu(
                  color: Colors.white,
                  fontSize: MediaQuery.sizeOf(context).height * 0.022),
            ),
          ],
        ),
      ),
    );
  }
}
