// test code for traffic_light_state

import 'package:traffic_lights/traffic_lights_state.dart';

void main() {
  var s = TrafficLightsState();
  print(s);
  var plays = [4, 0, 2, 4, 0, 2, 9];
  for (var i in plays) {
    print('Playing at $i.\n');
    s.playAt(i);
    print(s);
  }
}