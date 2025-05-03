import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/models/gadget.dart';
import 'package:smart_home/providers/smart_home_provider.dart';
import 'package:smart_home/widgets/gadget_form/gadget_controller.dart';

const List<Widget> condIcons = <Widget>[
  Icon(Icons.sunny),
  Icon(Icons.ac_unit),
  Icon(Icons.air),
];

class GadgetForm extends StatefulWidget {
  final Gadget gadget;
  final GadgetFormController controller;

  const GadgetForm({super.key, required this.controller, required this.gadget});

  @override
  State<GadgetForm> createState() => _GadgetFormState();
}

class _GadgetFormState extends State<GadgetForm> {
  late final List<bool> selectedModes;
  late LightingProvider lightningProvider;
  late ConditioningProvider conditioningProvider;
  
  late ConditioningMode? selectedMode;
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lightningProvider = context.watch<LightingProvider>();
    conditioningProvider = context.watch<ConditioningProvider>();
  }

  @override
  void initState() {
    super.initState();
    if (widget.gadget is Conditioning) {
      selectedModes = ConditioningMode.values.map((_) => false).toList();
      final conditioner = widget.gadget as Conditioning;
      final currentModeIdx = ConditioningMode.values.indexWhere(
        (mode) => mode == conditioner.mode,
      );
      selectedModes[currentModeIdx] = true;
      selectedMode = conditioner.mode;
      widget.controller.condModeController.text = currentModeIdx.toString();
      widget.controller.temperatureController.text =
          conditioner.temperature.toString();
      widget.controller.nameController.text = conditioner.name;
    } else if (widget.gadget is Light) {
      final lightning = widget.gadget as Light;
      widget.controller.nameController.text = lightning.name;
    }
  }

  List<Widget> getFormFields(Gadget gadget) {
    if (gadget is Conditioning) {
      return [
        // temperature
        TextFormField(
          decoration: const InputDecoration(label: Text("Set temperature")),
          controller: widget.controller.temperatureController,
          maxLines: 1,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          validator: (value) {
            if (value == null) {
              return "please, enter temperature";
            }
            final tempAsDouble = double.parse(value);
            if (selectedMode == ConditioningMode.heating && (tempAsDouble > 25.0 || tempAsDouble < 20)) {
              return "Conditioner can heat only in range from 20 to 25 degrees!";
            }
            return null;
          },
        ),
        // mode
        const Text('Set mode'),
        ToggleButtons(
          onPressed: (int index) {
            setState(() {
              // The button that is tapped is set to true, and the others to false.
              for (int i = 0; i < ConditioningMode.values.length; i++) {
                selectedModes[i] = i == index;
                selectedMode = ConditioningMode.values[index];
                widget.controller.condModeController.text = index.toString();
              }
            });
          },
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          selectedBorderColor: Colors.blue[700],
          selectedColor: Colors.white,
          fillColor: Colors.blue[200],
          color: Colors.blue[400],
          isSelected: selectedModes,
          children: condIcons,
        ),
      ];
    } else if (gadget is Light) {
      return [];
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    final formFields = getFormFields(widget.gadget);
    return Form(
      key: widget.controller.formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(label: Text("Edit name")),
              controller: widget.controller.nameController,
              maxLines: 1,
              maxLength: 30,
              validator: (value) {
                if(value == null) {
                  return "Please, enter name of the appliance!";
                }
                final allGadgets = <Gadget>[
                  ...lightningProvider.lighting,
                  ...conditioningProvider.conditioners,
                ];
                if (allGadgets.indexWhere((gadget) => gadget.name == value) !=
                    -1) {
                  return "Gadget with such name already exists!";
                }
                return null;
              },
            ),
             if (formFields.isNotEmpty) ...formFields,
          ],
        ),
      ),
    );
  }
}
