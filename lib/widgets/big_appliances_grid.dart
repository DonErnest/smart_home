import 'package:flutter/material.dart';
import 'package:smart_home/models/gadget.dart';
import 'package:smart_home/services/conditioning.dart';
import 'package:smart_home/services/light.dart';

class BigAppliancesBuilder extends StatefulWidget {
  final List<Gadget> appliances;
  final void Function(Gadget gadget) manipulateGadget;

  const BigAppliancesBuilder({
    super.key,
    required this.appliances,
    required this.manipulateGadget,
  });

  @override
  State<BigAppliancesBuilder> createState() => _BigAppliancesBuilderState();
}

class _BigAppliancesBuilderState extends State<BigAppliancesBuilder> {
  IconData getIcon(Gadget gadget) {
    if (gadget is Conditioning && gadget.state == ConditionState.on) {
      return switch (gadget.mode) {
        ConditioningMode.cooling => Icons.snowing,
      ConditioningMode.heating => Icons.sunny,
        _ => Icons.air,
      };
    }
    return Icons.mode_fan_off_rounded;
  }

  String getDisplayMessage(Gadget gadget) {
    if (gadget is Light) {
      return gadget.state.displayStatus;
    }
    return "something";
  }

  void switchGadget(Gadget gadget) {
  }

  void pushGadget(Gadget gadget) {
    if (gadget is Conditioning) {
      final editedGadget = turnConditioning(gadget);
      widget.manipulateGadget(editedGadget);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SliverGrid(
      // itemCount: widget.appliances.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
      ),
      delegate: SliverChildBuilderDelegate(
            (ctx, idx) => InkWell(
          onTap: () => {switchGadget(widget.appliances[idx])},
          onLongPress: () {
            pushGadget(widget.appliances[idx]);
          },
          child: GridTile(
            header: Text(
              widget.appliances[idx].name,
              textAlign: TextAlign.center,
              style: textTheme.titleLarge,
            ),
            footer: Text(
              getDisplayMessage(widget.appliances[idx]),
              textAlign: TextAlign.center,
              style: textTheme.titleLarge,
            ),
            child: Container(child: Icon(getIcon(widget.appliances[idx]))),
          ),
        ),
        childCount: widget.appliances.length,
      ),
    );
  }
}
