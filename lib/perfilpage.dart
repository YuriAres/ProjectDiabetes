import 'package:flutter/material.dart';
import 'package:flutter_diabetes/alarmpage.dart';
import 'package:flutter_diabetes/graph_page.dart';
import 'package:flutter_diabetes/homepage.dart';
import 'package:flutter_diabetes/model/usuario.dart';
import 'package:flutter_diabetes/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'model/anotacoes.dart';

// ignore: must_be_immutable
class Perfilpage extends StatelessWidget {
  final Usuario usuario;
  final List<Anotacao> anotacoes;
  Perfilpage({super.key, required this.usuario, required this.anotacoes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFF8851F6),
          selectedFontSize: 16,
          unselectedFontSize: 14,
          iconSize: 25,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey[400],
          currentIndex: 3,
          onTap: (value) {
            if (value == 0) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Homepage(
                  usuario: usuario,
                );
              }));
            }
            if (value == 1) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Alarmpage(usuario: usuario, anotacoes: anotacoes);
              }));
            }
            if (value == 2) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return GraphPage(usuario: usuario, anotacoes: anotacoes);
              }));
            }
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications, color: Colors.white),
                label: "Notificações"),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart, color: Colors.white),
              label: "Estatisticas",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.white),
              label: "Perfil",
            )
          ]),
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
                        Text("Perfil",
                            style: GoogleFonts.ubuntu(
                                fontSize:
                                    MediaQuery.sizeOf(context).height * 0.035)),
                        SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.035),
                        Stack(
                          children: [
                            Container(
                              height: MediaQuery.sizeOf(context).height * 0.24,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xff9A68FD)),
                              child: Center(
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size:
                                      MediaQuery.sizeOf(context).height * 0.15,
                                ),
                              ),
                            ),
                            Positioned(
                                left: MediaQuery.sizeOf(context).width * 0.52,
                                bottom: -(MediaQuery.sizeOf(context).height *
                                    0.001),
                                child: Container(
                                  padding: EdgeInsets.all(
                                      MediaQuery.sizeOf(context).height *
                                          0.015),
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xff6318F2)),
                                  child: Center(
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                      size: MediaQuery.sizeOf(context).height *
                                          0.04,
                                    ),
                                  ),
                                ))
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.025),
                        Text(usuario.nome,
                            style: GoogleFonts.ubuntu(
                                fontSize:
                                    MediaQuery.sizeOf(context).height * 0.035)),
                        SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.025),
                        Container(
                          padding: EdgeInsets.all(
                              MediaQuery.sizeOf(context).height * 0.012),
                          height: MediaQuery.sizeOf(context).height * 0.26,
                          width: MediaQuery.sizeOf(context).width * 0.9,
                          decoration: BoxDecoration(
                              color: const Color(0xff9A68FD),
                              borderRadius: BorderRadius.all(Radius.circular(
                                  MediaQuery.sizeOf(context).height * 0.01))),
                          child: Column(
                            children: [
                              Text(
                                "Informações",
                                style: GoogleFonts.ubuntu(
                                    fontSize:
                                        MediaQuery.sizeOf(context).height *
                                            0.03,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(
                                  height: MediaQuery.sizeOf(context).height *
                                      0.025),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Email: ${usuario.email}",
                                  style: GoogleFonts.ubuntu(
                                      fontSize:
                                          MediaQuery.sizeOf(context).height *
                                              0.025,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              SizedBox(
                                  height: MediaQuery.sizeOf(context).height *
                                      0.015),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Idade: ${usuario.idade} anos",
                                  style: GoogleFonts.ubuntu(
                                      fontSize:
                                          MediaQuery.sizeOf(context).height *
                                              0.025,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              SizedBox(
                                  height: MediaQuery.sizeOf(context).height *
                                      0.015),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Sexo: ${usuario.sexo}",
                                  style: GoogleFonts.ubuntu(
                                      fontSize:
                                          MediaQuery.sizeOf(context).height *
                                              0.025,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              SizedBox(
                                  height: MediaQuery.sizeOf(context).height *
                                      0.015),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Tipo: ${usuario.tipo}",
                                    style: GoogleFonts.ubuntu(
                                        fontSize:
                                            MediaQuery.sizeOf(context).height *
                                                0.025,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                                    textAlign: TextAlign.left,
                                  )),
                            ],
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
