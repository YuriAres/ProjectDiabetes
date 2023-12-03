import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_diabetes/add_alarm_page.dart';
import 'package:flutter_diabetes/addpage.dart';
import 'package:flutter_diabetes/graph_page.dart';
import 'package:flutter_diabetes/homepage.dart';
import 'package:flutter_diabetes/model/usuario.dart';
import 'package:flutter_diabetes/perfilpage.dart';
import 'package:flutter_diabetes/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import 'model/alarm.dart';
import 'model/anotacoes.dart';

class Alarmpage extends StatefulWidget {
  final Usuario usuario;
  final List<Anotacao> anotacoes;
  const Alarmpage({super.key, required this.usuario, required this.anotacoes});

  @override
  State<Alarmpage> createState() => _AlarmpageState();
}

class _AlarmpageState extends State<Alarmpage> {
  bool switchstatus = false;

  List<Alarm> alarmes = [];

  Future getAtividades() async {
    var data = await FirebaseFirestore.instance
        .collection('usuarios')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('alarmes')
        .get();
    setState(() {
      alarmes = List.from(data.docs.map((doc) => Alarm.fromMap(doc.data())));
      alarmes = alarmes.reversed.toList();
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
            return AddAlarmPage(
              status: true,
              usuario: widget.usuario,
              anotacoes: widget.anotacoes,
            );
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
          currentIndex: 1,
          onTap: (value) {
            if (value == 0) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Homepage(
                  usuario: widget.usuario,
                );
              }));
            }
            if (value == 2) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return GraphPage(
                    usuario: widget.usuario, anotacoes: widget.anotacoes);
              }));
            }
            if (value == 3) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Perfilpage(
                    usuario: widget.usuario, anotacoes: widget.anotacoes);
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
                        Row(),
                        SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.035),
                        Text("Notificações",
                            style: GoogleFonts.ubuntu(
                                fontSize:
                                    MediaQuery.sizeOf(context).height * 0.035)),
                        SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.035),
                        Expanded(
                            child: ListView.builder(
                          itemCount: alarmes.length,
                          itemBuilder: (BuildContext context, int index) {
                            return CustomWidgets().widgetContainerAlarm(
                                context,
                                widget.usuario,
                                widget.anotacoes,
                                switchstatus, (value) {
                              setState(() {
                                switchstatus = value;
                                print(switchstatus);
                              });
                            }, alarmes[index].nome, alarmes[index].hora,
                                alarmes[index].minutos, alarmes[index].data);
                          },
                        ))
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
