// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_diabetes/alarmpage.dart';
import 'package:flutter_diabetes/firebase_api.dart';
import 'package:flutter_diabetes/model/anotacoes.dart';
import 'package:flutter_diabetes/model/usuario.dart';
import 'package:flutter_diabetes/notification_service.dart';
import 'package:flutter_diabetes/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddAlarmPage extends StatefulWidget {
  final bool status;
  final Usuario usuario;
  final List<Anotacao> anotacoes;
  String? nomeAlarm;
  int? horaAlarm;
  int? minutosAlarm;
  String? data;
  AddAlarmPage(
      {super.key,
      required this.status,
      required this.usuario,
      required this.anotacoes,
      this.nomeAlarm,
      this.horaAlarm,
      this.minutosAlarm,
      this.data});

  @override
  State<AddAlarmPage> createState() => _AddAlarmPageState();
}

class _AddAlarmPageState extends State<AddAlarmPage> {
  @override
  void initState() {
    if (widget.status == false) {
      alarmHora.text = widget.horaAlarm.toString();
      alarmMinutos.text = widget.minutosAlarm.toString();
      alarmName.text = widget.nomeAlarm.toString();
      showNotification();
    }
    super.initState();
  }

  TextEditingController alarmName = TextEditingController();
  TextEditingController alarmHora = TextEditingController();
  TextEditingController alarmMinutos = TextEditingController();
  bool valor = false;

  createALarm() async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: ((context) {
          return AlertDialog(
            title: Text("Sucesso!",
                style: GoogleFonts.ubuntu(
                    fontSize: MediaQuery.sizeOf(context).height * 0.030)),
            content: Text("Seu alarme foi criado com sucesso!",
                style: GoogleFonts.ubuntu(
                    fontSize: MediaQuery.sizeOf(context).height * 0.023)),
            actions: [
              TextButton(
                onPressed: () {
                  alarmName.clear();
                  alarmHora.clear();
                  alarmMinutos.clear();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Alarmpage(
                              usuario: widget.usuario,
                              anotacoes: widget.anotacoes)));
                },
                child: Text("Concluir",
                    style: GoogleFonts.ubuntu(
                        fontSize: MediaQuery.sizeOf(context).height * 0.023)),
              )
            ],
          );
        }));
    FirebaseAPI().createAlarm(
        nome: alarmName.text,
        horas: int.parse(alarmHora.text),
        id: FirebaseAuth.instance.currentUser!.uid,
        data: DateTime.now(),
        minutos: int.parse(alarmMinutos.text));
  }

  showNotification() {
    setState(() {
      valor = !valor;

      if (valor) {
        print(valor);
        Provider.of<NotificationService>(context, listen: false)
            .showNotification(CustomNotification(
                id: 1, title: widget.nomeAlarm, body: "", payload: "/"));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      Positioned(
                        top: 15,
                        left: 0,
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
                              widget.status
                                  ? Icons.help_outline
                                  : Icons.delete_outline,
                              color: Colors.white,
                              size: MediaQuery.of(context).size.height * 0.035,
                            ),
                            onPressed: widget.status
                                ? () {}
                                : () {
                                    showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: ((context) {
                                          return AlertDialog(
                                            title: Text("Atenção!",
                                                style: GoogleFonts.ubuntu(
                                                    fontSize: MediaQuery.sizeOf(
                                                                context)
                                                            .height *
                                                        0.030)),
                                            content: Text(
                                                "Tem certeza que deseja remover seu alarme?",
                                                style: GoogleFonts.ubuntu(
                                                    fontSize: MediaQuery.sizeOf(
                                                                context)
                                                            .height *
                                                        0.023)),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  FirebaseAPI().deleteAlarm(
                                                      name: widget.nomeAlarm!,
                                                      id: FirebaseAuth.instance
                                                          .currentUser!.uid,
                                                      data: widget.data!
                                                          .toString());
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Alarmpage(
                                                                  usuario: widget
                                                                      .usuario,
                                                                  anotacoes: widget
                                                                      .anotacoes)));
                                                },
                                                child: Text("Sim",
                                                    style: GoogleFonts.ubuntu(
                                                        fontSize:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .height *
                                                                0.023)),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Não",
                                                    style: GoogleFonts.ubuntu(
                                                        fontSize:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .height *
                                                                0.023)),
                                              )
                                            ],
                                          );
                                        }));
                                  }),
                      )
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
                        Text(widget.status ? "Novo Alarme" : "Editar alarme",
                            style: GoogleFonts.ubuntu(
                                fontSize:
                                    MediaQuery.sizeOf(context).height * 0.035)),
                        SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.035),
                        Container(
                            height: MediaQuery.sizeOf(context).height * 0.25,
                            width: MediaQuery.sizeOf(context).width * 0.9,
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 129, 70, 247),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 100,
                                      width: 110,
                                      child: TextField(
                                        enabled: widget.status,
                                        controller: alarmHora,
                                        keyboardType: TextInputType.number,
                                        maxLength: 2,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.ubuntu(
                                            color: Colors.white,
                                            fontSize: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.065),
                                        decoration: InputDecoration(
                                            counterText: "",
                                            fillColor: const Color(0xff9A68FD),
                                            filled: true,
                                            border: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    width: 0,
                                                    style: BorderStyle.none),
                                                borderRadius:
                                                    BorderRadius.circular(15))),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.sizeOf(context).height *
                                          0.01,
                                    ),
                                    Text(":",
                                        style: GoogleFonts.ubuntu(
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.065,
                                            color: Colors.white)),
                                    SizedBox(
                                      width: MediaQuery.sizeOf(context).height *
                                          0.01,
                                    ),
                                    SizedBox(
                                      height: 100,
                                      width: 110,
                                      child: TextField(
                                        enabled: widget.status,
                                        controller: alarmMinutos,
                                        keyboardType: TextInputType.number,
                                        maxLength: 2,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.ubuntu(
                                            color: Colors.white,
                                            fontSize: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.065),
                                        decoration: InputDecoration(
                                          counterText: "",
                                          fillColor: const Color(0xff9A68FD),
                                          filled: true,
                                          border: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  width: 0,
                                                  style: BorderStyle.none),
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.19,
                                    ),
                                    Text(
                                      "Horas",
                                      style: GoogleFonts.ubuntu(
                                          fontSize: MediaQuery.sizeOf(context)
                                                  .height *
                                              0.025,
                                          color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.18,
                                    ),
                                    Text("Minutos",
                                        style: GoogleFonts.ubuntu(
                                            fontSize: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.025,
                                            color: Colors.white))
                                  ],
                                )
                              ],
                            )),
                        SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.025),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.sizeOf(context).width * 0.03,
                              vertical:
                                  MediaQuery.sizeOf(context).height * 0.02),
                          height: MediaQuery.sizeOf(context).height * 0.32,
                          width: MediaQuery.sizeOf(context).height * 0.8,
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 129, 70, 247),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            children: [
                              Text("Descrição",
                                  style: GoogleFonts.ubuntu(
                                      fontSize:
                                          MediaQuery.sizeOf(context).height *
                                              0.03,
                                      color: Colors.white)),
                              SizedBox(
                                  height: MediaQuery.sizeOf(context).height *
                                      0.025),
                              CustomWidgets().customTextfield(
                                  context,
                                  "Nome do alarme",
                                  "Descreva o nome do alarme",
                                  alarmName,
                                  Colors.white,
                                  1,
                                  false,
                                  null,
                                  TextInputType.name,
                                  false,
                                  widget.status),
                              SizedBox(
                                  height: MediaQuery.sizeOf(context).height *
                                      0.025),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Frequência",
                                    style: GoogleFonts.ubuntu(
                                        fontSize:
                                            MediaQuery.sizeOf(context).height *
                                                0.023,
                                        color: Colors.white)),
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.01),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  customContainer("D", context),
                                  customContainer("S", context),
                                  customContainer("T", context),
                                  customContainer("Q", context),
                                  customContainer("Q", context),
                                  customContainer("S", context),
                                  customContainer("S", context),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.025),
                        CustomWidgets().customElevatedButton(
                            context,
                            widget.status
                                ? createALarm
                                : () {
                                    print("Não criado!");
                                  },
                            widget.status ? "Criar" : "Editar")
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

Future<List<Anotacao>> pesquisarDocs(Usuario usuario) async {
  var querySnapshot = await FirebaseFirestore.instance
      .collection('usuarios')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('anotacoes')
      .get();

  List<Anotacao> anotacao;
  anotacao =
      List.from(querySnapshot.docs.map((doc) => Anotacao.fromMap(doc.data())));
  return anotacao;
}

Widget hours(int horas, BuildContext context) {
  return Text(horas < 10 ? "0$horas" : horas.toString(),
      style: GoogleFonts.ubuntu(
          fontSize: MediaQuery.sizeOf(context).height * 0.06));
}

Widget customContainer(String weekday, BuildContext context) {
  return GestureDetector(
    child: Container(
        height: MediaQuery.sizeOf(context).height * 0.07,
        width: MediaQuery.sizeOf(context).width * 0.1,
        decoration: const BoxDecoration(
            color: Color(0xff9A68FD),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Center(
          child: Text(
            weekday,
            style: GoogleFonts.ubuntu(
                fontSize: MediaQuery.sizeOf(context).height * 0.025,
                color: Colors.white),
          ),
        )),
  );
}
