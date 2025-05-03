import 'dart:async';
import 'dart:math';

import 'package:smart_home/models/gadget.dart';

Random random = new Random();


Teapot turnTeapot(Teapot teapot) {
  var newTeapotState = TeapotState.idle;
  if (teapot.state == TeapotState.idle &&
      teapot.waterLevelMl > 100.0 &&
      teapot.temperature < 90) {
    newTeapotState = TeapotState.heating;
    print("мдяяяяя");
  }
  return teapot.copyWith(state: newTeapotState);
}


Teapot checkWater(Teapot teapot) {
  final waterAmount = 150 + random.nextInt(1000 - 150) * 1.0;
  return teapot.copyWith(waterLevelMl: waterAmount, temperature: 20.0);
}



Teapot boilWater (Teapot teapot, double tempRise) {

  if (teapot.temperature < 100) {
    print("Че за хуйня");
    print(teapot.temperature + tempRise);
    return teapot.copyWith(temperature: teapot.temperature + tempRise);
  } else {
    return teapot.copyWith(temperature: 90, state: TeapotState.idle);
  }
}
