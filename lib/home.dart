import 'package:flutter/material.dart';
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "DIA",
                      style: GoogleFonts.ubuntu(
                        fontSize: (MediaQuery.of(context).size.height * 0.08),
                      ),
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
                            fontSize:
                                (MediaQuery.of(context).size.height * 0.03),
                          ),
                        ),
                        Text(
                          "betes",
                          style: GoogleFonts.ubuntu(
                            fontSize:
                                (MediaQuery.of(context).size.height * 0.03),
                          ),
                        )
                      ],
                    )
                  ],
                ),
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
                  padding: EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.elliptical(25, 28)),
                    color: Color(0xFF8851F6),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        height: MediaQuery.of(context).size.height * 0.06,
                      ),
                      TextField(
                        style: GoogleFonts.ubuntu(
                            color: Colors.white,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.02),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(
                              MediaQuery.of(context).size.height * 0.02),
                          label: const Text("Email"),
                          labelStyle: GoogleFonts.ubuntu(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.02),
                          hintText: "Insira seu email",
                          hintStyle: GoogleFonts.ubuntu(
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.02),
                          filled: true,
                          fillColor: const Color(0xff9A68FD),
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              borderSide: BorderSide(
                                  width: 0, style: BorderStyle.none)),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      TextField(
                        style: GoogleFonts.ubuntu(
                            color: Colors.white,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.02),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(
                              MediaQuery.of(context).size.height * 0.02),
                          label: const Text("Email"),
                          labelStyle: GoogleFonts.ubuntu(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.02),
                          hintText: "Insira seu email",
                          hintStyle: GoogleFonts.ubuntu(
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.02),
                          filled: true,
                          fillColor: const Color(0xff9A68FD),
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              borderSide: BorderSide(
                                  width: 0, style: BorderStyle.none)),
                        ),
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
