import 'package:flutter/material.dart';
import 'package:smart_home/models/gadget.dart';

class GadgetFormController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final temperatureController = TextEditingController();
  final condModeController = TextEditingController();

  void dispose() {
    nameController.dispose();
    temperatureController.dispose();
    condModeController.dispose();
  }

  Conditioning getUpdatedConditioner(Conditioning editedConditioning) {
    final newMode = ConditioningMode.values[int.parse(condModeController.text)];
    final newEditedConditioning = editedConditioning.copyWith(
      name: nameController.text,
      temperature: double.parse(temperatureController.text),
      mode: newMode,
    );
    return newEditedConditioning;
  }

  Light getUpdatedLight(Light editedLightning) {
    final newEditedLightning = editedLightning.copyWith(
      name: nameController.text,
    );
    return newEditedLightning;
  }

}