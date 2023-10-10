import 'package:flutter/material.dart';
import 'package:flutter_diabetes/model/usuario.dart';
import 'package:flutter_diabetes/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class AddAlarmPage extends StatefulWidget {
  final bool status;
  final Usuario usuario;
  const AddAlarmPage({super.key, required this.status, required this.usuario});

  @override
  State<AddAlarmPage> createState() => _AddAlarmPageState();
}

class _AddAlarmPageState extends State<AddAlarmPage> {
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
                        Text(widget.status ? "Novo Alarme" : "Editar alarme",
                            style: GoogleFonts.ubuntu(
                                fontSize:
                                    MediaQuery.sizeOf(context).height * 0.035)),
                        SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.035),
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