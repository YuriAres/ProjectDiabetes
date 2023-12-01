import 'package:flutter/material.dart';
import 'package:flutter_diabetes/firebase_api.dart';
import 'package:flutter_diabetes/login.dart';
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

  TextEditingController nomeController = TextEditingController();
  TextEditingController idadeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  cadastrar() {
    if (nomeController.text.isEmpty ||
        idadeController.text.isEmpty ||
        emailController.text.isEmpty ||
        senhaController.text.isEmpty ||
        selectedsex == null ||
        selecteddiabetes == null) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text("Alerta!"),
                content: const Text(
                    "Por favor preencha todos os campos antes de prosseguir!"),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Ok"))
                ],
              ));
    } else if (senhaController.text.length < 6) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text("Alerta!"),
                content: const Text("A senha deve possuir mais que 6 digitos!"),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Ok"))
                ],
              ));
    } else {
      FirebaseAPI().createUser(
          email: emailController.text,
          nome: nomeController.text,
          idade: int.parse(idadeController.text),
          sexo: selectedsex!,
          senha: senhaController.text,
          tipo: selecteddiabetes!);

      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text("Sucesso!"),
                content: const Text("Usuário criado com sucesso!"),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage())),
                      child: const Text("Ok"))
                ],
              ));
    }
  }

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
              CustomWidgets().header(context, Colors.black),
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
                    CustomWidgets().customTextfield(
                        context,
                        "Nome",
                        "Insira seu nome",
                        nomeController,
                        Colors.white,
                        1,
                        false),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    CustomWidgets().customTextfield(
                        context,
                        "Idade",
                        "Insira sua idade",
                        idadeController,
                        Colors.white,
                        1,
                        false),
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
                    CustomWidgets().customTextfield(
                        context,
                        "Email",
                        "Insira seu email",
                        emailController,
                        Colors.white,
                        1,
                        false),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    CustomWidgets().customTextfield(
                        context,
                        "Senha",
                        "Insira sua senha",
                        senhaController,
                        Colors.white,
                        1,
                        false),
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
                        onPressed: cadastrar,
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
