import 'package:flutter/material.dart';
import 'package:traffic_lights/traffic_lights_state.dart';
import 'package:flutter/services.dart';

final imageMap = {
  States.g: Image.asset('assets/images/g.png'), // associate x with image
  States.y: Image.asset('assets/images/y.png'), // associate o with image
  States.r: Image.asset('assets/images/r.png') // associate o with image
};

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Traffic Lights',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Traffic Lights'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  final _gameState = TrafficLightsState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: ConstrainedBox(
            constraints:
            const BoxConstraints(minWidth: 90.0, minHeight: 120.0),
            child: AspectRatio(
              aspectRatio: 3 / 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    // sized to fill available horizontal/vertical space
                    child: AspectRatio(
                        aspectRatio: 3 / 4,
                        child: Stack(children: [
                          Image.asset('assets/images/grid.png'),
                          GridView.builder(
                              itemCount: TrafficLightsState.numCells,
                              gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: TrafficLightsState.col),
                              itemBuilder: (context, index) {
                                return TextButton(
                                  onPressed: () => _processPress(index),
                                  child: imageMap[_gameState.board[index]] ??
                                      Container(),
                                );
                              })
                        ])),
                  ),
                  Container(
                      margin: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              _gameState.getStatus(),
                              style: const TextStyle(fontSize: 36),
                            ),
                          ),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: _resetGame,
                            child: const Text('Reset',
                                style: const TextStyle(fontSize: 36)),
                          )
                        ],
                      ))
                ],
              ),
            ),
          ),
        ));
  }

  void _processPress(int index) {
    setState(() {
      _gameState.playAt(index);
    });
  }

  void _resetGame() {
    setState(() {
      _gameState.reset();
    });
  }
}
