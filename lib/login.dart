import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_diabetes/homepage.dart';
import 'package:flutter_diabetes/model/usuario.dart';
import 'package:flutter_diabetes/register.dart';
import 'package:flutter_diabetes/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  Future login() async {
    if (emailController.text == "" || senhaController.text == "") {
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
    } else {
      FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: senhaController.text);
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        late Usuario usuario;
        final docUser = await FirebaseFirestore.instance
            .collection('usuarios')
            .doc(user.uid)
            .get();
        usuario = Usuario.fromMap(docUser.data()!);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Homepage(
                      usuario: usuario,
                    )));
      }
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                CustomWidgets().header(context, Colors.black),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.26,
                    child: Image.asset("lib/images/icon_homepage.png"),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Text(
                  "Bem vindo de volta!",
                  style: GoogleFonts.ubuntu(
                    fontSize: (MediaQuery.of(context).size.height * 0.03),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
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
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Login",
                          style: GoogleFonts.ubuntu(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.05,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      CustomWidgets().customTextfield(
                          context,
                          "Email",
                          "Insira seu email",
                          emailController,
                          Colors.white,
                          1,
                          false),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      CustomWidgets().customTextfield(
                          context,
                          "Senha",
                          "Insira sua senha",
                          senhaController,
                          Colors.white,
                          1,
                          false),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          child: Text(
                            "Esqueceu sua senha?",
                            style: GoogleFonts.ubuntu(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.02),
                          ),
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: ElevatedButton(
                          onPressed: login,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff6318F2),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: Text(
                            "Log in",
                            style: GoogleFonts.ubuntu(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.03,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      TextButton(
                        child: Text(
                          "Não possui conta? Clique aqui!",
                          style: GoogleFonts.ubuntu(
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.02),
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const RegisterPage();
                          }));
                        },
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
