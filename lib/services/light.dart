import 'package:smart_home/models/gadget.dart';


Light switchLight(Light gadget) {
  final newState = switch (gadget.state) {
    LightState.on => LightState.off,
    LightState.off => LightState.on,
    _ => gadget.state,
  };
  return gadget.copyWith(state: newState);
}

Light switchToDetectMovement(Light gadget) {
  final newState = switch (gadget.state) {
    LightState.onMovement => LightState.off,
    LightState.off => LightState.onMovement,
    _ => gadget.state,
  };
  return gadget.copyWith(state: newState);
}