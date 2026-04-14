import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'app/screens/homescreenex.dart';
import 'app/screens/nav_bar/favourite.dart';
import 'auth/logic/auth_provider.dart';
import 'auth/model/user_model.dart';
import 'auth/screens/RegisterScreen.dart';
import 'onboarding/screens/onboarding_screen.dart';

// استيراد موديل UserModel

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(FavoritePlaceAdapter());

  // فتح الصناديق (Boxes)
  await Hive.openBox<UserModel>('userBox');
  await Hive.openBox<FavoritePlace>('favoritesBox');

  // تشغيل التطبيق مباشرة بدون DevicePreview
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: MaterialApp(


          debugShowCheckedModeBanner: false,
          title: 'سياحة الفيوم',

          theme: ThemeData(
            primarySwatch: Colors.amber,
            scaffoldBackgroundColor: Colors.grey.shade50,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.amber,
              foregroundColor: Colors.white,
              elevation: 0,
            ),

          ),

          initialRoute: '/onboarding',
          routes: {
            '/onboarding': (context) => const OnboardingScreen(),
            '/register': (context) => const RegisterScreen(),
            '/home': (context) => const HomeScreenex(),
          },
        ),
      ),
    );
  }
}
