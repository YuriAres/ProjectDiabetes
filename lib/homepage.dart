import 'package:flutter/material.dart';
import 'package:flutter_diabetes/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Color(0xff6318F2),
        child: Icon(Icons.add),
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
              icon: Icon(Icons.person, color: Colors.white),
              label: "Perfil",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart, color: Colors.white),
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
                            onPressed: () {},
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: CustomWidgets().header(context, Colors.white),
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.015,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "1 de setembro de 2023",
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
                        "Bem vindo, Yuri! Confira suas ultimas anotações.",
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
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(22),
                          topRight: Radius.circular(22))),
                  child: ListView(
                      // Seu conteúdo rolável aqui
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
