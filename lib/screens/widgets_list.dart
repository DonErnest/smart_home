import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lightningProvider = context.watch<LightingProvider>();
  }

  String getGadgetTitle(Gadget gadget) {
    if (gadget is Light) {
      return "Light: ${gadget.name}";
    }
    return "something";
  }


  @override
  Widget build(BuildContext context) {
    return ScreenCanvas(
      widget: ListView.builder(
        itemCount: lightningProvider.lighting.length,
        itemBuilder:
            (ctx, idx) => Card(
              child: ListTile(
                title: Text(getGadgetTitle(lightningProvider.lighting[idx])),
              ),
            ),
      ),
    );
  }
}
