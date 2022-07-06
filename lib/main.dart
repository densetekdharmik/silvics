import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:material_color_gen/material_color_gen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:silvics/auth/login_page.dart';
import 'package:silvics/splash_screen.dart';
import 'package:silvics/values/colors.dart';

import 'contain_page.dart';

void main() {
  runApp(const MyApp());
}

final MaterialColor = Color(0xFF591609).toMaterialColor();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Silvics',
          theme: ThemeData(
            useMaterial3: true,
            primarySwatch: MaterialColor,
              textTheme: TextTheme(
                headline1: TextStyle(color: AppColors.textWhite),
                headline2: TextStyle(color: AppColors.textWhite),
                bodyText2: TextStyle(color: AppColors.textWhite),
                subtitle1: TextStyle(color: AppColors.textWhite),
              ),
            appBarTheme: AppBarTheme(
              backgroundColor: AppColors.mainColor
            ),
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: Colors.white,
            ),
          ),
          home: const SplashScreen(),
        );
      },
    );
  }
}
