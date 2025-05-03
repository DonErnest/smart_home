import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/app_routes.dart';
import 'package:smart_home/providers/smart_home_provider.dart';
import 'package:smart_home/screens/not_found_screen.dart';
import 'package:smart_home/screens/smart_widgets.dart';
import 'package:smart_home/screens/widgets_list.dart';


void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => LightingProvider()),
          ChangeNotifierProvider(create: (ctx) => ConditioningProvider()),
        ],
        child: MaterialApp(
          routes: {
            AppRoutes.main: (ctx) => SmartWidgetsScreen(),
            AppRoutes.appliancesList: (ctx) => WidgetsList()
          },
          initialRoute: AppRoutes.main,
          title: "Your Smart Home, meat sack",
          onUnknownRoute:
              (s) => MaterialPageRoute(builder: (ctx) => NotFoundScreen()),
        ),
      )
  );
}
