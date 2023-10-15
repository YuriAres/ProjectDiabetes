import 'package:flutter/material.dart';
import 'package:flutter_diabetes/alarmpage.dart';
import 'package:flutter_diabetes/homepage.dart';
import 'package:flutter_diabetes/model/usuario.dart';
import 'package:flutter_diabetes/perfilpage.dart';
import 'package:flutter_diabetes/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';

class GraphPage extends StatefulWidget {
  final Usuario usuario;
  const GraphPage({super.key, required this.usuario});

  @override
  State<GraphPage> createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  List<double> numeros = [10, 20, 30, 40, 50, 60, 70];
  @override
  Widget build(BuildContext context) {
    BarData mybardata = BarData(
        domAmount: numeros[0],
        segAmount: numeros[1],
        terAmount: numeros[2],
        quaAmount: numeros[3],
        quiAmount: numeros[4],
        sexAmount: numeros[5],
        sabAmount: numeros[6]);

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
                );
              }));
            }
            if (value == 3) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Perfilpage(
                  usuario: widget.usuario,
                );
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
                    padding: const EdgeInsets.symmetric(horizontal: 5),
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
                            height: MediaQuery.sizeOf(context).height * 0.035),
                        SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.35,
                            width: MediaQuery.sizeOf(context).width,
                            child: BarChart(BarChartData(
                                maxY: 200,
                                minY: 0,
                                barGroups: mybardata.bardata
                                    .map((data) => BarChartGroupData(
                                            x: data.x,
                                            barRods: [
                                              BarChartRodData(
                                                  toY: data.y, width: 10)
                                            ]))
                                    .toList())))
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
  final double domAmount;
  final double segAmount;
  final double terAmount;
  final double quaAmount;
  final double quiAmount;
  final double sexAmount;
  final double sabAmount;

  BarData(
      {required this.domAmount,
      required this.segAmount,
      required this.terAmount,
      required this.quaAmount,
      required this.quiAmount,
      required this.sexAmount,
      required this.sabAmount});

  List<IndividualBar> bardata = [];

  void initializeBarChart() {
    bardata = [
      IndividualBar(x: 0, y: domAmount),
      IndividualBar(x: 1, y: segAmount),
      IndividualBar(x: 2, y: terAmount),
      IndividualBar(x: 3, y: quaAmount),
      IndividualBar(x: 4, y: quiAmount),
      IndividualBar(x: 5, y: sexAmount),
      IndividualBar(x: 6, y: sabAmount),
    ];
  }
}
