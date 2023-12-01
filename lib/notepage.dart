import 'package:flutter/material.dart';
import 'package:flutter_diabetes/firebase_api.dart';
import 'package:flutter_diabetes/homepage.dart';
import 'package:flutter_diabetes/model/usuario.dart';
import 'package:flutter_diabetes/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class Notepage extends StatelessWidget {
  final num indice;
  final String anotacao;
  final DateTime data;
  final Usuario usuario;
  final String id;
  final String medicacoes;
  const Notepage(
      {super.key,
      required this.indice,
      required this.anotacao,
      required this.data,
      required this.usuario,
      required this.id,
      required this.medicacoes});

  @override
  Widget build(BuildContext context) {
    ScrollController medscrollController = ScrollController();
    ScrollController antscrollController = ScrollController();

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
                        right: -4,
                        child: IconButton(
                          icon: Icon(
                            Icons.delete_outline,
                            color: Colors.white,
                            size: MediaQuery.of(context).size.height * 0.035,
                          ),
                          onPressed: () {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: ((context) {
                                  return AlertDialog(
                                    title: Text("Atenção!",
                                        style: GoogleFonts.ubuntu(
                                            fontSize: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.030)),
                                    content: Text(
                                        "Tem certeza que deseja remover sua anotação?",
                                        style: GoogleFonts.ubuntu(
                                            fontSize: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.023)),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          FirebaseAPI().deleteAnotacao(
                                              name: data.toString(), id: id);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Homepage(
                                                          usuario: usuario)));
                                        },
                                        child: Text("Sim",
                                            style: GoogleFonts.ubuntu(
                                                fontSize:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.023)),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Não",
                                            style: GoogleFonts.ubuntu(
                                                fontSize:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.023)),
                                      )
                                    ],
                                  );
                                }));
                          },
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
                        Text("Anotação",
                            style: GoogleFonts.ubuntu(
                                fontSize:
                                    MediaQuery.sizeOf(context).height * 0.035)),
                        SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.015),
                        Text(
                            "Suas anotações do dia ${data.day}/${data.month}/${data.year}, foram:",
                            style: GoogleFonts.ubuntu(
                                fontSize:
                                    MediaQuery.sizeOf(context).height * 0.020)),
                        SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.028),
                        Container(
                          padding: EdgeInsets.all(
                              MediaQuery.sizeOf(context).height * 0.012),
                          height: MediaQuery.sizeOf(context).height * 0.13,
                          width: MediaQuery.sizeOf(context).width * 0.9,
                          decoration: BoxDecoration(
                              color: const Color(0xff9A68FD),
                              borderRadius: BorderRadius.all(Radius.circular(
                                  MediaQuery.sizeOf(context).height * 0.01))),
                          child: Column(
                            children: [
                              Text(
                                "Indice glicêmico",
                                style: GoogleFonts.ubuntu(
                                    fontSize:
                                        MediaQuery.sizeOf(context).height *
                                            0.021,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                  height: MediaQuery.sizeOf(context).height *
                                      0.018),
                              Text(
                                indice.toString(),
                                style: GoogleFonts.ubuntu(
                                    fontSize:
                                        MediaQuery.sizeOf(context).height *
                                            0.035,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.02),
                        Container(
                            padding: EdgeInsets.all(
                                MediaQuery.sizeOf(context).height * 0.012),
                            height: MediaQuery.sizeOf(context).height * 0.115,
                            width: MediaQuery.sizeOf(context).width * 0.9,
                            decoration: BoxDecoration(
                                color: const Color(0xff9A68FD),
                                borderRadius: BorderRadius.all(Radius.circular(
                                    MediaQuery.sizeOf(context).height * 0.01))),
                            child: Column(
                              children: [
                                Text(
                                  "Medicamentos",
                                  style: GoogleFonts.ubuntu(
                                      fontSize:
                                          MediaQuery.sizeOf(context).height *
                                              0.024,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                    height: MediaQuery.sizeOf(context).height *
                                        0.0115),
                                Scrollbar(
                                    thickness: 3,
                                    radius: const Radius.circular(6),
                                    thumbVisibility: true,
                                    controller: medscrollController,
                                    child: SingleChildScrollView(
                                        controller: medscrollController,
                                        scrollDirection: Axis.horizontal,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.015),
                                          child: Text(
                                            medicacoes,
                                            style: GoogleFonts.ubuntu(
                                                fontSize:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.024,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        )))
                              ],
                            )),
                        SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.02),
                        Container(
                          padding: EdgeInsets.all(
                              MediaQuery.sizeOf(context).height * 0.012),
                          height: MediaQuery.sizeOf(context).height * 0.4,
                          width: MediaQuery.sizeOf(context).width * 0.9,
                          decoration: BoxDecoration(
                              color: const Color(0xff9A68FD),
                              borderRadius: BorderRadius.all(Radius.circular(
                                  MediaQuery.sizeOf(context).height * 0.01))),
                          child: Scrollbar(
                            thumbVisibility: true,
                            controller: antscrollController,
                            child: SingleChildScrollView(
                              controller: antscrollController,
                              child: Column(
                                children: [
                                  Text(
                                    anotacao,
                                    style: GoogleFonts.ubuntu(
                                        fontSize:
                                            MediaQuery.sizeOf(context).height *
                                                0.024,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400),
                                    textAlign: TextAlign.justify,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
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
