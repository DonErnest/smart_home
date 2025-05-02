import 'package:flutter/material.dart';
import 'package:smart_home/models/gadget.dart';
import 'package:smart_home/services/light.dart';

class SmallAppliancesBuilder extends StatefulWidget {
  final List<Gadget> appliances;
  final void Function(Gadget gadget) manipulateGadget;

  const SmallAppliancesBuilder({
    super.key,
    required this.appliances,
    required this.manipulateGadget,
  });

  @override
  State<SmallAppliancesBuilder> createState() => _SmallAppliancesBuilderState();
}

class _SmallAppliancesBuilderState extends State<SmallAppliancesBuilder> {
  IconData getIcon(Gadget gadget) {
    if (gadget is Light) {
      return switch (gadget.state) {
        LightState.on || LightState.onMovement => Icons.lightbulb_outline,
        _ => Icons.lightbulb,
      };
    }
    return Icons.question_mark_rounded;
  }

  String getDisplayMessage(Gadget gadget) {
    if (gadget is Light) {
      return gadget.state.displayStatus;
    }
    return "something";
  }


  void switchGadget(Gadget gadget) {
    if (gadget is Light) {
      final editedGadget = switchLight(gadget);
      widget.manipulateGadget(editedGadget);
    }
  }

  void pushGadget(Gadget gadget) {
    if (gadget is Light) {
      final editedGadget = switchToDetectMovement(gadget);
      widget.manipulateGadget(editedGadget);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SliverGrid(
      // itemCount: widget.appliances.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      delegate: SliverChildBuilderDelegate(
        (ctx, idx) => InkWell(
          onTap: () => {switchGadget(widget.appliances[idx])},
          onLongPress: () {
            pushGadget(widget.appliances[idx]);
          },
          child: GridTile(
            footer: Text(
              getDisplayMessage(widget.appliances[idx]), textAlign: TextAlign.center,
              style: textTheme.titleLarge,
            ),
            child: Container(child: Icon(getIcon(widget.appliances[idx]))),
          ),
        ),
        childCount: widget.appliances.length
      ),
    );
  }
}
