import 'package:flutter/material.dart';
import 'package:smart_home/models/gadget.dart';

class GadgetProvider extends ChangeNotifier {
  void addAppliance(List<Gadget> gadgets, Gadget newGadget) {
    gadgets = [...gadgets, newGadget];
    notifyListeners();
  }

  void editAppliance<T extends Gadget>(List<Gadget> gadgets, T editedGadget) {
    final oldGadgetIdx = gadgets.indexWhere(
      (gadget) => gadget.id == editedGadget.id,
    );
    gadgets[oldGadgetIdx] = editedGadget;
    notifyListeners();
  }
}

class LightingProvider extends GadgetProvider {
  List<Light> _lighting = sampleLightingAppliances;
  List<Light> get lighting => _lighting;

  void addLightingAppliance(Light newAppliance) {
    addAppliance(_lighting, newAppliance);
  }

  void editLightingAppliance(Gadget editedAppliance) {
    final light = editedAppliance as Light;
    editAppliance(_lighting, light);
  }
}

class ConditioningProvider extends GadgetProvider {
  List<Conditioning> _conditioners = sampleConditioningAppliances;
  List<Conditioning> get conditioners => _conditioners;

  void addConditioningAppliance(Conditioning newAppliance) {
    addAppliance(_conditioners, newAppliance);
  }

  void editConditioningAppliance(Gadget editedAppliance) {
    final conditioner = editedAppliance as Conditioning;
    editAppliance(_conditioners, conditioner);
  }
}
