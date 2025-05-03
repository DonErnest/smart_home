import 'package:smart_home/models/gadget.dart';

Conditioning turnConditioning(Conditioning gadget) {
  final newState = switch (gadget.state) {
    ConditionState.on => ConditionState.off,
    ConditionState.off => ConditionState.on,
  };
  return gadget.copyWith(state: newState);
}