import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_diabetes/model/anotacoes.dart';
import 'package:flutter_diabetes/model/usuario.dart';
import 'package:flutter_diabetes/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class AddAlarmPage extends StatefulWidget {
  final bool status;
  final Usuario usuario;
  const AddAlarmPage({super.key, required this.status, required this.usuario});

  @override
  State<AddAlarmPage> createState() => _AddAlarmPageState();
}

class _AddAlarmPageState extends State<AddAlarmPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8851F6),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 15,
                        left: 0,
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: MediaQuery.of(context).size.height * 0.035,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: CustomWidgets().header(context, Colors.white),
                      ),
                      Positioned(
                        top: 15,
                        right: -10,
                        child: IconButton(
                          icon: Icon(
                            Icons.help_outline,
                            color: Colors.white,
                            size: MediaQuery.of(context).size.height * 0.035,
                          ),
                          onPressed: () {},
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.015,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(22),
                        topRight: Radius.circular(22),
                      ),
                    ),
                    child: Column(
                      children: [
                        const Row(),
                        SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.035),
                        Text(widget.status ? "Novo Alarme" : "Editar alarme",
                            style: GoogleFonts.ubuntu(
                                fontSize:
                                    MediaQuery.sizeOf(context).height * 0.035)),
                        SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.035),
                        Container(
                            height: MediaQuery.sizeOf(context).height * 0.25,
                            width: MediaQuery.sizeOf(context).width * 0.9,
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 129, 70, 247),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 100,
                                      width: 110,
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.ubuntu(
                                            color: Colors.white,
                                            fontSize: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.065),
                                        decoration: InputDecoration(
                                            fillColor: const Color(0xff9A68FD),
                                            filled: true,
                                            border: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    width: 0,
                                                    style: BorderStyle.none),
                                                borderRadius:
                                                    BorderRadius.circular(15))),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.sizeOf(context).height *
                                          0.01,
                                    ),
                                    Text(":",
                                        style: GoogleFonts.ubuntu(
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.065,
                                            color: Colors.white)),
                                    SizedBox(
                                      width: MediaQuery.sizeOf(context).height *
                                          0.01,
                                    ),
                                    SizedBox(
                                      height: 100,
                                      width: 110,
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.ubuntu(
                                            color: Colors.white,
                                            fontSize: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.065),
                                        decoration: InputDecoration(
                                          fillColor: const Color(0xff9A68FD),
                                          filled: true,
                                          border: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  width: 0,
                                                  style: BorderStyle.none),
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.19,
                                    ),
                                    Text(
                                      "Horas",
                                      style: GoogleFonts.ubuntu(
                                          fontSize: MediaQuery.sizeOf(context)
                                                  .height *
                                              0.025,
                                          color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.18,
                                    ),
                                    Text("Minutos",
                                        style: GoogleFonts.ubuntu(
                                            fontSize: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.025,
                                            color: Colors.white))
                                  ],
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<List<Anotacao>> pesquisarDocs(Usuario usuario) async {
  var querySnapshot = await FirebaseFirestore.instance
      .collection('usuarios')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('anotacoes')
      .get();

  List<Anotacao> anotacao;
  anotacao =
      List.from(querySnapshot.docs.map((doc) => Anotacao.fromMap(doc.data())));
  return anotacao;
}

Widget hours(int horas, BuildContext context) {
  return Text(horas < 10 ? "0$horas" : horas.toString(),
      style: GoogleFonts.ubuntu(
          fontSize: MediaQuery.sizeOf(context).height * 0.06));
}
