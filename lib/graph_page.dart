import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_diabetes/alarmpage.dart';
import 'package:flutter_diabetes/homepage.dart';
import 'package:flutter_diabetes/model/usuario.dart';
import 'package:flutter_diabetes/perfilpage.dart';
import 'package:flutter_diabetes/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'model/anotacoes.dart';

class GraphPage extends StatefulWidget {
  final Usuario usuario;
  final List<Anotacao> anotacoes;
  const GraphPage({super.key, required this.usuario, required this.anotacoes});

  @override
  State<GraphPage> createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  List<double> numeros = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  num maior = 0;
  num menor = 0;
  num media = 0;
  double variacao = 0;
  late num penultimo;
  late bool status;
  @override
  void didChangeDependencies() {
    List<Anotacao> reverselist = widget.anotacoes.reversed.toList();
    if (widget.anotacoes.length <= 10) {
      for (int i = 0; i < widget.anotacoes.length; i++) {
        numeros.insert(i, reverselist[i].indice.toDouble());
      }
    } else {
      int j = 0;
      for (int i = reverselist.length - 10; i < reverselist.length; i++) {
        numeros.insert(j, reverselist[i].indice.toDouble());
        j++;
      }
    }
    for (int i = 0; i < numeros.length; i++) {
      if (numeros[i] > 0) {
        if (numeros[i] > maior) {
          maior = numeros[i];
        }
        if (numeros[i] < menor || i == 0) {
          menor = numeros[i];
        }
        media += numeros[i];
        if ((reverselist.length - (reverselist.length - 10)) - 2 == i) {
          penultimo = numeros[i];
          variacao = ((reverselist.last.indice - penultimo) / penultimo) * 100;
        }
      }
    }
    if (variacao > 0) {
      status = true;
    } else {
      status = false;
    }
    if (reverselist.length <= 10) {
      media = media / reverselist.length;
    } else {
      media = media / 10;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    BarData mybardata = BarData(
        oneAmount: numeros[0],
        twoAmount: numeros[1],
        threeAmount: numeros[2],
        fourAmount: numeros[3],
        fiveAmount: numeros[4],
        sixAmount: numeros[5],
        sevenAmount: numeros[6],
        eightAmount: numeros[7],
        nineAmount: numeros[8],
        tenAmount: numeros[9]);

    mybardata.initializeBarChart();

    return Scaffold(
      backgroundColor: const Color(0xFF8851F6),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFF8851F6),
          selectedFontSize: 16,
          unselectedFontSize: 14,
          iconSize: 25,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey[400],
          currentIndex: 2,
          onTap: (value) {
            if (value == 0) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Homepage(
                  usuario: widget.usuario,
                );
              }));
            }
            if (value == 1) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Alarmpage(
                  usuario: widget.usuario,
                  anotacoes: widget.anotacoes,
                );
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
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.015,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
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
                        Text("Estatisticas",
                            style: GoogleFonts.ubuntu(
                                fontSize:
                                    MediaQuery.sizeOf(context).height * 0.035)),
                        SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.025),
                        Container(
                          padding: EdgeInsets.all(
                              MediaQuery.sizeOf(context).height * 0.01),
                          height: MediaQuery.sizeOf(context).height * 0.35,
                          width: MediaQuery.sizeOf(context).width * 0.9,
                          decoration: BoxDecoration(
                              color: const Color(0xFF8851F6),
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.arrow_left,
                                      color: Colors.white,
                                      size: MediaQuery.sizeOf(context).height *
                                          0.04,
                                    )),
                                Text("Ultimas medições",
                                    style: GoogleFonts.ubuntu(
                                        fontSize:
                                            MediaQuery.sizeOf(context).height *
                                                0.025,
                                        color: Colors.white)),
                                IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {},
                                    icon: Icon(Icons.arrow_right,
                                        color: Colors.white,
                                        size:
                                            MediaQuery.sizeOf(context).height *
                                                0.04)),
                              ],
                            ),
                            const Divider(
                              color: Colors.white,
                              thickness: 0.7,
                            ),
                            Expanded(
                                child: BarChart(BarChartData(
                                    maxY: 200,
                                    minY: 0,
                                    gridData: const FlGridData(show: false),
                                    borderData: FlBorderData(show: false),
                                    titlesData: const FlTitlesData(
                                        rightTitles: AxisTitles(
                                            sideTitles:
                                                SideTitles(showTitles: false)),
                                        leftTitles: AxisTitles(
                                            sideTitles:
                                                SideTitles(showTitles: false)),
                                        topTitles: AxisTitles(
                                            sideTitles:
                                                SideTitles(showTitles: false)),
                                        bottomTitles: AxisTitles(
                                            sideTitles: SideTitles(
                                                showTitles: true,
                                                getTitlesWidget:
                                                    getBottomTitles))),
                                    barGroups: mybardata.bardata
                                        .map((data) => BarChartGroupData(
                                                x: data.x,
                                                barRods: [
                                                  BarChartRodData(
                                                      toY: data.y,
                                                      width: 15,
                                                      color: Colors.white)
                                                ]))
                                        .toList()))),
                          ]),
                        ),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.all(
                                  MediaQuery.sizeOf(context).height * 0.012),
                              height: MediaQuery.sizeOf(context).height * 0.13,
                              width: MediaQuery.sizeOf(context).width * 0.40,
                              decoration: BoxDecoration(
                                  color: const Color(0xff9A68FD),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          MediaQuery.sizeOf(context).height *
                                              0.01))),
                              child: Column(
                                children: [
                                  Text(
                                    "Variação",
                                    style: GoogleFonts.ubuntu(
                                        fontSize:
                                            MediaQuery.sizeOf(context).height *
                                                0.021,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.013),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        status
                                            ? Icons.arrow_drop_up
                                            : Icons.arrow_drop_down,
                                        color: Colors.white,
                                        size:
                                            MediaQuery.sizeOf(context).height *
                                                0.05,
                                      ),
                                      Text(
                                        "${variacao.toStringAsFixed(1)} %",
                                        style: GoogleFonts.ubuntu(
                                            fontSize: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.035,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(
                                  MediaQuery.sizeOf(context).height * 0.012),
                              height: MediaQuery.sizeOf(context).height * 0.13,
                              width: MediaQuery.sizeOf(context).width * 0.40,
                              decoration: BoxDecoration(
                                  color: const Color(0xff9A68FD),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          MediaQuery.sizeOf(context).height *
                                              0.01))),
                              child: Column(
                                children: [
                                  Text(
                                    "Média",
                                    style: GoogleFonts.ubuntu(
                                        fontSize:
                                            MediaQuery.sizeOf(context).height *
                                                0.021,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.013),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        media.toStringAsFixed(1),
                                        style: GoogleFonts.ubuntu(
                                            fontSize: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.035,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.all(
                                  MediaQuery.sizeOf(context).height * 0.012),
                              height: MediaQuery.sizeOf(context).height * 0.13,
                              width: MediaQuery.sizeOf(context).width * 0.40,
                              decoration: BoxDecoration(
                                  color: const Color(0xff9A68FD),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          MediaQuery.sizeOf(context).height *
                                              0.01))),
                              child: Column(
                                children: [
                                  Text(
                                    "Maior indice",
                                    style: GoogleFonts.ubuntu(
                                        fontSize:
                                            MediaQuery.sizeOf(context).height *
                                                0.021,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.013),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        maior.toString(),
                                        style: GoogleFonts.ubuntu(
                                            fontSize: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.035,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(
                                  MediaQuery.sizeOf(context).height * 0.012),
                              height: MediaQuery.sizeOf(context).height * 0.13,
                              width: MediaQuery.sizeOf(context).width * 0.40,
                              decoration: BoxDecoration(
                                  color: const Color(0xff9A68FD),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          MediaQuery.sizeOf(context).height *
                                              0.01))),
                              child: Column(
                                children: [
                                  Text(
                                    "Menor indice",
                                    style: GoogleFonts.ubuntu(
                                        fontSize:
                                            MediaQuery.sizeOf(context).height *
                                                0.021,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.013),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        menor.toString(),
                                        style: GoogleFonts.ubuntu(
                                            fontSize: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.035,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
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

class IndividualBar {
  final int x;
  final double y;

  IndividualBar({required this.x, required this.y});
}

class BarData {
  final double oneAmount;
  final double twoAmount;
  final double threeAmount;
  final double fourAmount;
  final double fiveAmount;
  final double sixAmount;
  final double sevenAmount;
  final double eightAmount;
  final double nineAmount;
  final double tenAmount;

  BarData(
      {required this.oneAmount,
      required this.twoAmount,
      required this.threeAmount,
      required this.fourAmount,
      required this.fiveAmount,
      required this.sixAmount,
      required this.sevenAmount,
      required this.eightAmount,
      required this.nineAmount,
      required this.tenAmount});

  List<IndividualBar> bardata = [];

  void initializeBarChart() {
    bardata = [
      IndividualBar(x: 0, y: oneAmount),
      IndividualBar(x: 1, y: twoAmount),
      IndividualBar(x: 2, y: threeAmount),
      IndividualBar(x: 3, y: fourAmount),
      IndividualBar(x: 4, y: fiveAmount),
      IndividualBar(x: 5, y: sixAmount),
      IndividualBar(x: 6, y: sevenAmount),
      IndividualBar(x: 7, y: eightAmount),
      IndividualBar(x: 8, y: nineAmount),
      IndividualBar(x: 9, y: tenAmount),
    ];
  }
}

Widget getBottomTitles(double value, TitleMeta meta) {
  TextStyle style = GoogleFonts.ubuntu(fontSize: 14, color: Colors.white);

  Text week;
  switch (value.toInt()) {
    case 0:
      week = Text("1º", style: style);
      break;
    case 1:
      week = Text("2º", style: style);
      break;
    case 2:
      week = Text("3º", style: style);
      break;
    case 3:
      week = Text("4º", style: style);
      break;
    case 4:
      week = Text("5º", style: style);
      break;
    case 5:
      week = Text("6º", style: style);
      break;
    case 6:
      week = Text("7º", style: style);
      break;
    case 7:
      week = Text("8º", style: style);
      break;
    case 8:
      week = Text("9º", style: style);
      break;
    case 9:
      week = Text("10º", style: style);
      break;
    default:
      week = Text(
        "NaN",
        style: style,
      );
  }
  return SideTitleWidget(axisSide: meta.axisSide, child: week);
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
