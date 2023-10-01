import 'package:flutter/material.dart';
import 'package:flutter_diabetes/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class Helppage extends StatelessWidget {
  const Helppage({super.key});

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
                        const Row(),
                        SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.035),
                        Text("Informações gerais",
                            style: GoogleFonts.ubuntu(
                                fontSize:
                                    MediaQuery.sizeOf(context).height * 0.035)),
                        SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.038),
                        Container(
                          padding: EdgeInsets.all(
                              MediaQuery.sizeOf(context).height * 0.012),
                          height: MediaQuery.sizeOf(context).height * 0.24,
                          width: MediaQuery.sizeOf(context).width * 0.9,
                          decoration: BoxDecoration(
                              color: const Color(0xff9A68FD),
                              borderRadius: BorderRadius.all(Radius.circular(
                                  MediaQuery.sizeOf(context).height * 0.01))),
                          child: Column(
                            children: [
                              Text(
                                "Objetivo",
                                style: GoogleFonts.ubuntu(
                                    fontSize:
                                        MediaQuery.sizeOf(context).height *
                                            0.028,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                  height: MediaQuery.sizeOf(context).height *
                                      0.0115),
                              Text(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed nec turpis metus. Class aptent taciti sociosqu ad litora torquent per conubia nostra.",
                                style: GoogleFonts.ubuntu(
                                    fontSize:
                                        MediaQuery.sizeOf(context).height *
                                            0.022,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.03),
                        Container(
                          padding: EdgeInsets.all(
                              MediaQuery.sizeOf(context).height * 0.012),
                          height: MediaQuery.sizeOf(context).height * 0.24,
                          width: MediaQuery.sizeOf(context).width * 0.9,
                          decoration: BoxDecoration(
                              color: const Color(0xff9A68FD),
                              borderRadius: BorderRadius.all(Radius.circular(
                                  MediaQuery.sizeOf(context).height * 0.01))),
                          child: Column(
                            children: [
                              Text(
                                "Diabetes",
                                style: GoogleFonts.ubuntu(
                                    fontSize:
                                        MediaQuery.sizeOf(context).height *
                                            0.028,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                  height: MediaQuery.sizeOf(context).height *
                                      0.0115),
                              Text(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed nec turpis metus. Class aptent taciti sociosqu ad litora torquent per conubia nostra,",
                                style: GoogleFonts.ubuntu(
                                    fontSize:
                                        MediaQuery.sizeOf(context).height *
                                            0.022,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.05),
                        CustomWidgets().customElevatedButton(
                            context, () => null, "Saber mais")
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
