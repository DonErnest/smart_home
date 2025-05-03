import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/app_routes.dart';
import 'package:smart_home/models/gadget.dart';
import 'package:smart_home/providers/smart_home_provider.dart';
import 'package:smart_home/widgets/canvas.dart';

class WidgetsList extends StatefulWidget {
  const WidgetsList({super.key});

  @override
  State<WidgetsList> createState() => _WidgetsListState();
}

class _WidgetsListState extends State<WidgetsList> {
  late LightingProvider lightningProvider;
  late ConditioningProvider conditioningProvider;
  late TeapotProvider teapotProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lightningProvider = context.watch<LightingProvider>();
    conditioningProvider = context.watch<ConditioningProvider>();
    teapotProvider = context.watch<TeapotProvider>();
  }

  String getGadgetTitle(Gadget gadget) {
    if (gadget is Light) {
      return "Light: ${gadget.name}";
    } else if (gadget is Conditioning) {
      return "Conditioner: ${gadget.name}";
    } else if (gadget is Teapot) {
      return "Teapot: ${gadget.name}";
    };
    return "something";
  }

  void goToAppliance(Gadget gadget) {
    Navigator.pushNamed(
      context,
      AppRoutes.widget,
      arguments: {"id": gadget.id, "type": gadget.type},
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Gadget> allGadgets = [
      ...lightningProvider.lighting,
      ...conditioningProvider.conditioners,
      ...teapotProvider.teapots,
    ];
    return ScreenCanvas(
      widget: ListView.builder(
        itemCount: allGadgets.length,
        itemBuilder:
            (ctx, idx) => GestureDetector(
              onTap: () {
                goToAppliance(allGadgets[idx]);
              },
              child: Card(
                child: ListTile(title: Text(getGadgetTitle(allGadgets[idx]))),
              ),
            ),
      ),
    );
  }
}
