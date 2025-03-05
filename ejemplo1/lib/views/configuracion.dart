import 'package:flutter/material.dart';
import 'package:ejemplo1/helpers/mixins/validate_mixin.dart';
import 'package:ejemplo1/helpers/app_colors.dart';
import 'package:ejemplo1/helpers/persistent_data.dart';
import 'package:ejemplo1/helpers/widgets/dialog.dart';
import 'package:ejemplo1/helpers/widgets/easytext.dart';
import 'package:ejemplo1/helpers/widgets/particles.dart';

class ConfiguracionPage extends StatefulWidget {

  const ConfiguracionPage({
    super.key,
  });

  @override
  State<ConfiguracionPage> createState() => _ConfiguracionPageState();
}

class _ConfiguracionPageState extends State<ConfiguracionPage> with ValidateMixin {
  bool? _sonido;
  int? _color;
  final _colores = [Colors.red, Colors.blue, Colors.yellow, Colors.green];

  void _actualizarColor(int index) {
    setState(() {
      _color = _colores[index].value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Easytext(text: "Configuración", size: 40),
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
                Form(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Easytext(text: "Sonido", size: 20),
                      Switch.adaptive(
                        value: _sonido ?? true, 
                        onChanged: (value) {
                          setState(() {
                            _sonido = value;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      const Easytext(text: "Background", size: 20),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          GestureDetector(
                            onTap: () => _actualizarColor(0),
                            child: Container(
                              color: _colores[0],
                              width: 50,
                              height: 50,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _actualizarColor(1),
                            child: Container(
                              color: _colores[1],
                              width: 50,
                              height: 50,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _actualizarColor(2),
                            child: Container(
                              color: _colores[2],
                              width: 50,
                              height: 50,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _actualizarColor(3),
                            child: Container(
                              color: _colores[3],
                              width: 50,
                              height: 50,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),                      
                      ElevatedButton(
                        onPressed: () async {
                          Dialogo.showLoadingDialog(context);
                          await PersistentData.preferences?.setStringList("puntuaciones", []);

                          if(context.mounted) {
                            //dismiss loading
                            Navigator.of(context).pop();
                            //show confetti
                            Particles(
                              context: context,
                            ).showTriangle();
                            Dialogo.info(
                              context,
                              message: "Puntajes borrados",
                            );
                          }

                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade800,
                        ),
                        child: const Easytext(
                          text: "Borrar puntajes",
                          size: 15,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          Dialogo.showLoadingDialog(context);
                          await PersistentData.preferences?.setBool("sonido", _sonido ?? false);
                          await PersistentData.preferences?.setInt("color", _color ?? 0);

                          if(context.mounted) {
                            //dismiss loading
                            Navigator.of(context).pop();
                            //show confetti
                            Particles(
                              context: context,
                            ).showCircle();

                            Dialogo.info(
                              context,
                              message: "Guardado",
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade800,
                        ),
                        child: const Easytext(
                          text: "Guardar",
                          size: 15,
                        ),
                      ),
                    ],
                  ),
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