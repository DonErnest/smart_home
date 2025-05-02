import 'package:flutter/material.dart';

class ScrollableScreenCanvas extends StatelessWidget {
  final List<Widget>? appBarActions;
  final Widget? bottomBar;
  final Widget widget;

  const ScrollableScreenCanvas({
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
