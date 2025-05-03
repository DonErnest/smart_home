import 'package:flutter/material.dart';
import 'package:smart_home/models/gadget.dart';
import 'package:smart_home/widgets/gadget_form/gadget_controller.dart';

const List<Widget> condIcons = <Widget>[Icon(Icons.sunny), Icon(Icons.ac_unit), Icon(Icons.air)];

class GadgetForm extends StatefulWidget {
  final Gadget gadget;
  final GadgetFormController controller;

  const GadgetForm({super.key, required this.controller, required this.gadget});

  @override
  State<GadgetForm> createState() => _GadgetFormState();
}

class _GadgetFormState extends State<GadgetForm> {
  late final List<bool> selectedMode;

  @override
  void initState() {
    super.initState();
    if (widget.gadget is Conditioning) {
      selectedMode = ConditioningMode.values.map((_) => false).toList();
      final conditioner = widget.gadget as Conditioning;
      final currentModeIdx = ConditioningMode.values.indexWhere(
        (mode) => mode == conditioner.mode,
      );
      selectedMode[currentModeIdx] = true;
      widget.controller.condModeController.text = currentModeIdx.toString();
      widget.controller.temperatureController.text = conditioner.temperature.toString();
    }
  }

  Widget getForm(Gadget gadget) {
    if (gadget is Conditioning) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Column(
          children: [
            // temperature
            TextFormField(
              decoration: const InputDecoration(label: Text("Set temperature")),
              controller: widget.controller.temperatureController,
              maxLines: 1,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            // mode
            const Text('Set mode'),
            ToggleButtons(
              onPressed: (int index) {
                setState(() {
                  // The button that is tapped is set to true, and the others to false.
                  for (int i = 0; i < ConditioningMode.values.length; i++) {
                    selectedMode[i] = i == index;
                    widget.controller.condModeController.text = index.toString();
                  }
                });
              },
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              selectedBorderColor: Colors.blue[700],
              selectedColor: Colors.white,
              fillColor: Colors.blue[200],
              color: Colors.blue[400],
              isSelected: selectedMode,
              children: condIcons,
            ),
          ],
        ),
      );
    }

    return Column();
  }

  @override
  Widget build(BuildContext context) {
    return Form(key: widget.controller.formKey, child: getForm(widget.gadget));
  }
}
