import 'package:flutter/material.dart';
import 'package:flutter_diabetes/homepage.dart';
import 'package:flutter_diabetes/model/usuario.dart';
import 'package:flutter_diabetes/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

TextEditingController indiceGlicemico = TextEditingController();
TextEditingController anotacoes = TextEditingController();
ScrollController scrollController = ScrollController();

class AddPage extends StatelessWidget {
  final Usuario usuario;
  const AddPage({super.key, required this.usuario});

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
                        Text("Nova anotação",
                            style: GoogleFonts.ubuntu(
                                fontSize:
                                    MediaQuery.sizeOf(context).height * 0.035)),
                        SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.045),
                        CustomWidgets().customTextfield(
                          context,
                          "Índice Glicêmico",
                          "Insira o indice obtido",
                          indiceGlicemico,
                          Colors.black,
                        ),
                        SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.035),
                        Scrollbar(
                          controller: scrollController,
                          thumbVisibility: true,
                          child: CustomWidgets().customTextfield(
                              context,
                              "Anotações",
                              "Insira sua anotação aqui...",
                              anotacoes,
                              Colors.black,
                              20,
                              true,
                              scrollController),
                        ),
                        SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.035),
                        CustomWidgets().customElevatedButton(context, () async {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: ((context) {
                                return AlertDialog(
                                  title: Text("Sucesso!",
                                      style: GoogleFonts.ubuntu(
                                          fontSize: MediaQuery.sizeOf(context)
                                                  .height *
                                              0.030)),
                                  content: Text(
                                      "Sua anotação foi criada com sucesso!",
                                      style: GoogleFonts.ubuntu(
                                          fontSize: MediaQuery.sizeOf(context)
                                                  .height *
                                              0.023)),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        indiceGlicemico.clear();
                                        anotacoes.clear();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Homepage(
                                                    usuario: usuario)));
                                      },
                                      child: Text("Concluir",
                                          style: GoogleFonts.ubuntu(
                                              fontSize:
                                                  MediaQuery.sizeOf(context)
                                                          .height *
                                                      0.023)),
                                    )
                                  ],
                                );
                              }));
                        }, "Adicionar")
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
