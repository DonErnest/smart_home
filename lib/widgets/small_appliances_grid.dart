import 'package:flutter/material.dart';
import 'package:smart_home/models/gadget.dart';
import 'package:smart_home/services/light.dart';
import 'package:smart_home/services/teapot.dart';

class SmallAppliancesBuilder extends StatefulWidget {
  final List<Gadget> appliances;
  final void Function(Gadget gadget) manipulateGadget;

  final void Function (String id) startAsyncManipulation;
  final void Function (String id) cancelAsyncManipulation;

  const SmallAppliancesBuilder({
    super.key,
    required this.appliances,
    required this.manipulateGadget,
    required this.cancelAsyncManipulation,
    required this.startAsyncManipulation,
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
    } else if (gadget is Teapot) {
      return switch (gadget.state) {
        TeapotState.heating => Icons.electric_bolt,
        _ => Icons.disabled_visible,
      };
    }
    return Icons.question_mark_rounded;
  }

  String getDisplayMessage(Gadget gadget) {
    if (gadget is Light) {
      return gadget.state.displayStatus;
    }
    if (gadget is Teapot) {
      return "${gadget.state.displayStatus}\n${gadget.temperature.toInt()} degrees\n${gadget.waterLevelMl}ml";
    }
    return "something";
  }

  void switchGadget(Gadget gadget) {
    Gadget? editedGadget;
    if (gadget is Light) {
      editedGadget = switchLight(gadget);
    }
    if (gadget is Teapot) {
      editedGadget = checkWater(gadget);
    }
    widget.manipulateGadget(editedGadget!);
  }

  void pushGadget(Gadget gadget) {
    if (gadget is Light) {
      final editedGadget = switchToDetectMovement(gadget);
      widget.manipulateGadget(editedGadget);
    }
    if (gadget is Teapot) {
      final editedGadget = turnTeapot(gadget);
      if (editedGadget.state == TeapotState.idle) {
        widget.cancelAsyncManipulation(editedGadget.id);
      } else {
        widget.startAsyncManipulation(editedGadget.id);
      }
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
