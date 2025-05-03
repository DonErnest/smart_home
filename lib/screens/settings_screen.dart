import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/models/gadget.dart';
import 'package:smart_home/providers/smart_home_provider.dart';
import 'package:smart_home/widgets/canvas.dart';
import 'package:smart_home/widgets/gadget_form/gadget_controller.dart';
import 'package:smart_home/widgets/gadget_form/gadget_form.dart';

class GadgetSettingsScreen extends StatefulWidget {

  const GadgetSettingsScreen({super.key});

  @override
  State<GadgetSettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<GadgetSettingsScreen> {
  late Gadget gadget;
  late ConditioningProvider conditioningProvider;
  late LightingProvider lightningProvider;

  final gadgetFormController = GadgetFormController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    conditioningProvider = context.watch<ConditioningProvider>();
    lightningProvider = context.watch<LightingProvider>();
    final gadgetArgs = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final gadgetId = gadgetArgs["id"];
    final gadgetType = gadgetArgs["type"];
    switch(gadgetType) {
      case GadgetType.conditioner:
        gadget = conditioningProvider.conditioners.firstWhere((gadget) =>
        gadget
            .id == gadgetId);
      case GadgetType.light:
        gadget = lightningProvider.lighting.firstWhere((gadget) =>
        gadget.id ==
            gadgetId);
    }

  }

  @override
  void dispose() {
    super.dispose();
    gadgetFormController.dispose();
  }

  void editGadget() {
    if (gadgetFormController.formKey.currentState!.validate()) {
      if (gadget is Conditioning) {
        final editedGadget = gadgetFormController.getUpdatedConditioner(gadget as Conditioning);
        conditioningProvider.editConditioningAppliance(editedGadget);
      } else if (gadget is Light) {
        final editedGadget = gadgetFormController.getUpdatedLight(gadget as Light);
        lightningProvider.editLightingAppliance(editedGadget);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenCanvas(
      widget: Column(
        children: [
          GadgetForm(
            gadget: gadget,
            controller: gadgetFormController,
          ),
          TextButton(onPressed: editGadget, child: Text("Save")),
        ],
      )
    );
  }
}
