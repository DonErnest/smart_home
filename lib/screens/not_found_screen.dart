import 'package:flutter/material.dart';
import 'package:smart_home/widgets/canvas.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenCanvas(
      widget: Column(
        children: [
          Text("No route has been found (as backend developer, this is 404)"),
        ],
      ),
    );
  }
}
