import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smart_home/models/gadget.dart';
import 'package:smart_home/services/teapot.dart';

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
  List<Light> get activeLighting => _lighting.where((gadget) => gadget.status == GadgetStatus.active).toList();

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
  List<Conditioning> get activeConditioners => _conditioners.where((gadget) => gadget.status == GadgetStatus.active).toList();

  void addConditioningAppliance(Conditioning newAppliance) {
    addAppliance(_conditioners, newAppliance);
  }

  void editConditioningAppliance(Gadget editedAppliance) {
    final conditioner = editedAppliance as Conditioning;
    editAppliance(_conditioners, conditioner);
  }
}


class TeapotProvider extends GadgetProvider {
  List<Teapot> _teapots = sampleTeapotAppliances;
  List<Teapot> get teapots => _teapots;
  List<Teapot> get activeTeapots => _teapots.where((gadget) => gadget.status == GadgetStatus.active).toList();

  Map<String, Timer> boilingTimers= {};

  void addTeapot(Conditioning newAppliance) {
    addAppliance(_teapots, newAppliance);
  }

  void editTeapot(Gadget editedAppliance) {
    final teapot = editedAppliance as Teapot;
    editAppliance(_teapots, teapot);
  }


  void initiateBoiling(String teapotId) {
    Timer? timer;
    bool isCancelled = false;

    final teapot = teapots.firstWhere((teapot) => teapot.id == teapotId);
    // I took water boiling for 90 degrees Celsius not because I am stupid,
    // but because I live in an imaginary world and all of that has no meaning
    final boilFinishesAt = ((teapot.waterLevelMl * 180) / 1000).toInt();
    final heatingStep = boilFinishesAt / (90 - 20);
    print("Finishes at: ${boilFinishesAt}");
    boilingTimers[teapotId]?.cancel();

    boilingTimers[teapot.id] = Timer.periodic(Duration(seconds: 1), (timer) {
      if (!isCancelled) {
        final teapot = teapots.firstWhere((teapot) => teapot.id == teapotId);
        final boilingTeapot = boilWater(teapot, heatingStep);
        if (boilingTeapot.temperature > 90) {
          timer.cancel();
          boilingTimers.remove(teapot.id);
        }
        editTeapot(boilingTeapot);
      }
    });

    Future.delayed(Duration(seconds: boilFinishesAt), () {
      isCancelled = true;
      boilingTimers[teapot.id]?.cancel();
      boilingTimers.remove(teapot.id);
    });
  }

  void cancelAsyncProcess(String teapotId) {
    if (boilingTimers.containsKey(teapotId)) {
      final timer = boilingTimers[teapotId];
      timer!.cancel();
    }
  }

}