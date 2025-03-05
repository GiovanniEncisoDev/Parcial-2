import 'package:flutter/material.dart';
import 'package:ejemplo1/helpers/app_colors.dart';
import 'package:ejemplo1/helpers/mixins/validate_mixin.dart';
import 'package:ejemplo1/helpers/widgets/easytext.dart';

class ScoreMenuPage extends StatelessWidget with ValidateMixin {
  final List<int> scores;
  ScoreMenuPage({
    super.key,
    this.scores = const [0,0,0,0,0,0,0,0,0,0],
  });

  //TODO - keep latest 10 scores
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Easytext(text: "Puntajes", size: 40),
        backgroundColor: Colors.blueGrey.shade800,
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: AppColors.navy,
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Container(
            width: double.infinity,
            height: calculatedHeight(context),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.grey.shade800,
                  Colors.grey.shade600.withOpacity(0.7),
                  Colors.blueGrey.shade800.withOpacity(0.7),
                  Colors.blueGrey.shade600.withOpacity(0.7)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    const TableRow(
                      children: [
                        Easytext(
                          text: "Jugador", 
                          size: 20,
                          bold: true,
                          textAlign: TextAlign.center,
                        ),
                        Easytext(
                          text: "Puntaje", 
                          size: 20,
                          bold: true,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const TableRow(
                      children: [
                        SizedBox(height: 20,),
                        SizedBox(height: 20,),
                      ],
                    ),
                    ...scores.map((score) => TableRow(
                      children: [
                        const Easytext(
                          text: "Invitado",
                          size: 15,
                          textAlign: TextAlign.center,
                        ),
                        Easytext(
                          text: score.toString(),
                          size: 15,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )),
                  ],
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }
}