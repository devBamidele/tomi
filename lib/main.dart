import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';

import 'config/router/app_router.dart';
import 'config/theme/theme.dart';
import 'feature/auth/application/auth_manager.dart';
import 'feature/auth/data/model/auth_session.dart';
import 'feature/auth/data/model/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Hive.initFlutter();

  // Register ALL adapters
  Hive
    ..registerAdapter(UserAdapter())
    ..registerAdapter(AuthSessionAdapter());

  await AuthManager.instance.init();

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp.router(
        routerConfig: appRouter.config(),
        debugShowCheckedModeBanner: false,
        title: 'Career Path Pilot',
        theme: AppTheme.lightTheme,
      ),
    );
  }
}

/*
Bamideledavid.ajewole@gmail.com Bamidele1234!@#$ Bamidele
bamideledavid.femi@gmail.com Password1! David
ajewole.bamidele@stu.cu.edu.ng Password1! Femi
 */
