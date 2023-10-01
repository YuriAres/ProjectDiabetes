import 'package:flutter/material.dart';
import 'package:flutter_diabetes/addpage.dart';
import 'package:flutter_diabetes/helppage.dart';
import 'package:flutter_diabetes/model/usuario.dart';
import 'package:flutter_diabetes/notepage.dart';
import 'package:flutter_diabetes/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatefulWidget {
  Usuario? usuario;
  Homepage({super.key, this.usuario});
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const AddPage();
          }));
        },
        backgroundColor: Color(0xff6318F2),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFF8851F6),
          selectedFontSize: 16,
          unselectedFontSize: 14,
          iconSize: 25,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey[400],
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: const Color(0xFF8851F6),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Positioned(
                          top: 15,
                          left: -15,
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
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const Helppage();
                              }));
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.015,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        CustomWidgets().data(),
                        style: GoogleFonts.ubuntu(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.height * 0.019,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.013,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Bem vindo, ${widget.usuario!.nome}! Confira suas ultimas anotações.",
                        style: GoogleFonts.ubuntu(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.height * 0.025,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.sizeOf(context).width * 0.05,
                      vertical: MediaQuery.sizeOf(context).height * 0.03),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(22),
                          topRight: Radius.circular(22))),
                  child: ListView(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const Notepage();
                          }));
                        },
                        child: Container(
                          padding: EdgeInsets.all(
                              MediaQuery.sizeOf(context).height * 0.012),
                          height: MediaQuery.sizeOf(context).height * 0.13,
                          decoration: BoxDecoration(
                              color: const Color(0xff9A68FD),
                              borderRadius: BorderRadius.all(Radius.circular(
                                  MediaQuery.sizeOf(context).height * 0.01))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "01/09/23 as 08:30 PM",
                                style: GoogleFonts.ubuntu(color: Colors.white),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.sizeOf(context).height * 0.012,
                              ),
                              Text(
                                "Indice Glicêmico: 132 MG",
                                style: GoogleFonts.ubuntu(
                                    color: Colors.white,
                                    fontSize:
                                        MediaQuery.sizeOf(context).height *
                                            0.022),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.sizeOf(context).height * 0.008,
                              ),
                              Text(
                                "Anotações: Clique e confira suas anota..",
                                style: GoogleFonts.ubuntu(
                                    color: Colors.white,
                                    fontSize:
                                        MediaQuery.sizeOf(context).height *
                                            0.022),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
