import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_diabetes/firebase_api.dart';
import 'package:flutter_diabetes/homepage.dart';
import 'package:flutter_diabetes/model/usuario.dart';
import 'package:flutter_diabetes/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

TextEditingController indiceGlicemico = TextEditingController();
TextEditingController anotacoes = TextEditingController();
TextEditingController medicamentos = TextEditingController();
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
                      Positioned(
                        top: 15,
                        right: 0,
                        child: IconButton(
                          icon: Icon(
                            Icons.help_outline,
                            color: Colors.white,
                            size: MediaQuery.of(context).size.height * 0.035,
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                    title: Text("Ajuda",
                                        style: GoogleFonts.ubuntu(
                                            fontSize: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.023,
                                            fontWeight: FontWeight.bold)),
                                    content: Text(
                                        "O indice glicêmico deve ser preenchido de acordo com a ultima medição realizada pelo aparelho Glicosimetro."
                                        " Caso não possua indice apenas não preencha.\n\nJá para os medicamentos também deve se atentar a preencher nesse padrão 'Remédio 100 MG','Remédio 50 MG'."
                                        " Também não se deve preencher nada caso não tenha tomado!",
                                        style: GoogleFonts.ubuntu(
                                            fontSize: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.021),
                                        textAlign: TextAlign.justify)));
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
                            1,
                            true,
                            null,
                            TextInputType.number),
                        SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.035),
                        CustomWidgets().customTextfield(
                          context,
                          "Medicamentos",
                          "Insira os medicamos utilizados",
                          medicamentos,
                          Colors.black,
                          1,
                          true,
                          null,
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
                              13,
                              true,
                              scrollController,
                              TextInputType.multiline),
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
                                        medicamentos.clear();
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
                          FirebaseAPI().createAnotacao(
                              indice: num.parse(indiceGlicemico.text),
                              newAnotacao: anotacoes.text,
                              id: FirebaseAuth.instance.currentUser!.uid,
                              data: DateTime.now(),
                              medicacao: medicamentos.text);
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
