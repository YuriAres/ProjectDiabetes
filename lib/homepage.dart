import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_diabetes/addpage.dart';
import 'package:flutter_diabetes/alarmpage.dart';
import 'package:flutter_diabetes/helppage.dart';
import 'package:flutter_diabetes/model/anotacoes.dart';
import 'package:flutter_diabetes/model/usuario.dart';
import 'package:flutter_diabetes/notepage.dart';
import 'package:flutter_diabetes/perfilpage.dart';
import 'package:flutter_diabetes/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class Homepage extends StatefulWidget {
  Usuario usuario;
  Homepage({super.key, required this.usuario});
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Anotacao> anotacoes = [];

  Future getAtividades() async {
    var data = await FirebaseFirestore.instance
        .collection('usuarios')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('anotacoes')
        .get();
    setState(() {
      anotacoes =
          List.from(data.docs.map((doc) => Anotacao.fromMap(doc.data())));
    });
  }

  @override
  void didChangeDependencies() {
    getAtividades();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddPage(usuario: widget.usuario);
          }));
        },
        backgroundColor: const Color(0xff6318F2),
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
          currentIndex: 0,
          onTap: (value) {
            if (value == 1) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Alarmpage(usuario: widget.usuario);
              }));
            }
            if (value == 3) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Perfilpage(usuario: widget.usuario);
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
                        "Bem vindo, ${widget.usuario.nome}! Confira suas ultimas anotações.",
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
                  child: ListView.builder(
                    itemCount: anotacoes.length,
                    itemBuilder: (context, index) {
                      return CustomWidgets().containerAnotacao(context,
                          anotacoes[index].indice, anotacoes[index].anotacao);
                    },
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
