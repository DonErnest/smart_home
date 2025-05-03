import 'package:flutter/material.dart';
import 'package:smart_home/models/gadget.dart';

class GadgetFormController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final temperatureController = TextEditingController();
  final condModeController = TextEditingController();

  void dispose() {
    temperatureController.dispose();
    condModeController.dispose();
  }

  Conditioning getUpdatedConditioner(Conditioning editedConditioning) {
    final newMode = ConditioningMode.values[int.parse(condModeController.text)];
    final newEditedConditioning = editedConditioning.copyWith(
      temperature: double.parse(temperatureController.text),
      mode: newMode,
    );
    return newEditedConditioning;
  }

}