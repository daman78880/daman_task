import 'package:daman_task/core/common_constants/common_constants.dart';
import 'package:daman_task/core/common_funcationality/common_functiionality.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'core/routes/routes.dart';
import 'core/theme/app_color_palette.dart';
import 'core/translator/local_translation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp();
  // await Firebase.initializeApp(options: DefaultFirebaseConfig.platformOptions);
  await GetStorage.init();
  await CommonFunctionality.checkUserFirstTimeLoginOrNot();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            title: 'Daman Task',
            translations: LocalString(),
            locale: const Locale('en', 'US'),
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.dark,
            getPages: appPages(),
            initialRoute: Routes.root,
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: const TextScaler.linear(1.0)),
                child: child!,
              );
            },
            theme: ThemeData(
              scaffoldBackgroundColor: lightColorPalette.backgroundColor,
              colorScheme: ColorScheme.fromSeed(
                  seedColor: lightColorPalette.backgroundColor),
              useMaterial3: true,
              fontFamily: CommonConstants.raleway,
            ),
          );
        });
  }
}
