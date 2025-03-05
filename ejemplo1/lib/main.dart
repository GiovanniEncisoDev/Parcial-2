import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:ejemplo1/helpers/constants.dart';
import 'package:ejemplo1/helpers/persistent_data.dart';
import 'package:ejemplo1/views/configuracion.dart';
import 'package:ejemplo1/juego/tec_game.dart';
import 'package:ejemplo1/helpers/mixins/validate_mixin.dart';
import 'package:ejemplo1/views/menu_inicio.dart';
import 'package:ejemplo1/views/puntajes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PersistentData.init();
  puntuaciones = PersistentData.preferences?.getStringList("puntajes") ?? puntuaciones;
  sonido = PersistentData.preferences?.getBool("sonido") ?? sonido;
  color = PersistentData.preferences?.getInt("color") ?? color;

  print("obteniendo datos de memoria interna");
  print("puntuaciones: $puntuaciones");
  print("sonido: $sonido");
  print("color: $color");

  //Hides status bar to give immersion in-game
  Flame.device.fullScreen();
  //locks device to portrait view
  Flame.device.setPortrait();

  runApp(const GameAppWrapper());
}

class GameAppWrapper extends StatefulWidget {
  const GameAppWrapper({super.key});

  @override
  State<GameAppWrapper> createState() => _GameAppWrapperState();
}

class _GameAppWrapperState extends State<GameAppWrapper> with ValidateMixin {
  String currentRoute = '/';

  Widget _juegoWidget() {
    final game = isMobile ? TecGame() : TecGame.web();
    final gameWidget = GameWidget(
      game: game,
    );

    return isMobile
      ? gameWidget
      : Center(
        child: FittedBox(
            child: SizedBox(
          width: defaultWidth,
          height: defaultHeight,
          child: gameWidget,
        )),
      );
  }
  
  Widget getCurrentPage(String route, {Map<String, dynamic>? arguments}) {
    switch (route) {
      case '/puntajes':
        return ScoreMenuPage();
      case '/configuracion':
        return ConfiguracionPage();
      case '/juego':
        return _juegoWidget();
      case '/':
      default: // Same as '/'
        return const MenuInicioPage();
    }
  }

  @override
  Widget build(BuildContext context) {    
    return MaterialApp(
      onGenerateRoute: (settings) {
        //NOTE: uncomment and use this in case is required to pass arguments dynamically
        final args = settings.arguments as Map<String, dynamic>?;
        Widget toPage = getCurrentPage(settings.name!, arguments: args);
        
        return MaterialPageRoute(builder: (context) => toPage);
      },
      home: getCurrentPage(currentRoute),
    );
  }
}