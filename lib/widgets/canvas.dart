import 'package:flutter/material.dart';

class ScreenCanvas extends StatelessWidget {
  final List<Widget>? appBarActions;
  final Widget? bottomBar;
  final Widget widget;

  const ScreenCanvas({
    super.key,
    required this.widget,
    this.appBarActions,
    this.bottomBar,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: bottomBar,
        appBar: AppBar(actions: appBarActions),
        body: Center(child: widget),
      ),
    );
  }
}
