import 'package:flutter/material.dart';
import 'package:flutter_diabetes/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                CustomWidgets().header(context),
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
                          context, "Email", "Insira seu email"),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      CustomWidgets().customTextfield(
                          context, "Senha", "Insira sua senha"),
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
                          onPressed: () {},
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
                          "Não possui conta? Crie aqui!",
                          style: GoogleFonts.ubuntu(
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.02),
                        ),
                        onPressed: () {},
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
