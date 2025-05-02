import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/providers/smart_home_provider.dart';
import 'package:smart_home/widgets/canvas.dart';
import 'package:smart_home/widgets/small_appliances_grid.dart';

class SmartWidgetsScreen extends StatefulWidget {
  const SmartWidgetsScreen({super.key});

  @override
  State<SmartWidgetsScreen> createState() => _SmartWidgetsScreenState();
}

class _SmartWidgetsScreenState extends State<SmartWidgetsScreen> {
  late LightingProvider lightningProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    lightningProvider = context.watch<LightingProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollableScreenCanvas(
      widget: CustomScrollView(
        slivers: [
          const SliverAppBar(title: Text('My Appliances')),
          SmallAppliancesBuilder(
            manipulateGadget: lightningProvider.editLightingAppliance,
            appliances: lightningProvider.lighting,
          ),
        ],
      ),
    );
  }
}
