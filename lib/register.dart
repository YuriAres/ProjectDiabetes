import 'package:flutter/material.dart';
import 'package:flutter_diabetes/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  List<String> sexo = ["Masculino", "Feminino"];
  List<String> diabetestype = [
    "Pré-Diabetes",
    "Diabetes Tipo I",
    "Diabetes Tipo II"
  ];
  String? selectedsex;
  String? selecteddiabetes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SafeArea(
              child: Column(
            children: [
              CustomWidgets().header(context),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Expanded(
                  child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.elliptical(25, 28)),
                  color: Color(0xFF8851F6),
                ),
                child: Column(
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Criar nova conta",
                        style: GoogleFonts.ubuntu(
                            fontSize: MediaQuery.of(context).size.height * 0.03,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    CustomWidgets()
                        .customTextfield(context, "Nome", "Insira seu nome"),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    CustomWidgets()
                        .customTextfield(context, "Idade", "Insira sua idade"),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: CustomWidgets().customDropDownButton(
                          "Sexo",
                          context,
                          selectedsex,
                          sexo,
                          (selection) =>
                              {selectedsex = selection, print(selectedsex)}),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    CustomWidgets()
                        .customTextfield(context, "Email", "Insira seu email"),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    CustomWidgets()
                        .customTextfield(context, "Senha", "Insira sua senha"),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: CustomWidgets().customDropDownButton(
                          "Tipo da diabetes",
                          context,
                          selecteddiabetes,
                          diabetestype,
                          (selection) => {
                                selecteddiabetes = selection,
                                print(selecteddiabetes)
                              }),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff6318F2),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: Text(
                          "Registrar",
                          style: GoogleFonts.ubuntu(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.03,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    TextButton(
                      child: Text(
                        "Já possui conta? Clique aqui!",
                        style: GoogleFonts.ubuntu(
                            color: Colors.white,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.02),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ))
            ],
          )),
        ),
      ),
    );
  }
}
