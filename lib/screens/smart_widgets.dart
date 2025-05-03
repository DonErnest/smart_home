import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/app_routes.dart';
import 'package:smart_home/providers/smart_home_provider.dart';
import 'package:smart_home/widgets/big_appliances_grid.dart';
import 'package:smart_home/widgets/canvas.dart';
import 'package:smart_home/widgets/small_appliances_grid.dart';

class SmartWidgetsScreen extends StatefulWidget {
  const SmartWidgetsScreen({super.key});

  @override
  State<SmartWidgetsScreen> createState() => _SmartWidgetsScreenState();
}

class _SmartWidgetsScreenState extends State<SmartWidgetsScreen> {
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

  void goToList() {
    Navigator.of(context).pushNamed(AppRoutes.appliancesList);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenCanvas(
      appBarActions: [
        IconButton(onPressed: goToList, icon: Icon(Icons.list_alt_outlined)),
      ],
      widget: CustomScrollView(
        slivers: [
          const SliverAppBar(title: Text('Lights'), expandedHeight: 100),
          SmallAppliancesBuilder(
            manipulateGadget: lightningProvider.editLightingAppliance,
            appliances: lightningProvider.activeLighting,
            startAsyncManipulation: (_){},
            cancelAsyncManipulation: (_) {},
          ),
          const SliverAppBar(title: Text('Teapots'), expandedHeight: 100),
          SmallAppliancesBuilder(
            manipulateGadget: teapotProvider.editTeapot,
            appliances: teapotProvider.activeTeapots,
            startAsyncManipulation: teapotProvider.initiateBoiling,
            cancelAsyncManipulation: teapotProvider.cancelAsyncProcess,
          ),
          const SliverAppBar(title: Text('Conditioning'), expandedHeight: 100),
          BigAppliancesBuilder(
            appliances: conditioningProvider.activeConditioners,
            manipulateGadget: conditioningProvider.editConditioningAppliance,
          ),
        ],
      ),
    );
  }
}
