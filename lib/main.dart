import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infootprints_ebook/activity/cubit/auth_cubit.dart';
import 'package:infootprints_ebook/activity/Welcome/HomePage.dart';
import 'package:infootprints_ebook/activity/general/SelectGeneresScreen.dart';
import 'package:infootprints_ebook/activity/general/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:infootprints_ebook/activity/utils/SharedPrefrence.dart';
import 'activity/Welcome/SelectedGenere.dart';
import 'firebase_options.dart';

void main() async {
  // Starting point of dart
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Infootprints',
        theme: ThemeData(
            textTheme: GoogleFonts
                .nunitoTextTheme(), // Changes the fontstlye of text in app (app should be connected to internet for first time for changes to take place)
            scaffoldBackgroundColor: CupertinoColors.systemGrey6,
            primarySwatch: Palette.kToDark),
        home: SplashScreen(),
      ),
    );
  }
}

class Palette {
  static const MaterialColor kToDark = const MaterialColor(
    0xff132EBE, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: const Color(0xff132EBE), //10%
      100: const Color(0xff132EBE), //20%
      200: const Color(0xff132EBE), //30%
      300: const Color(0xff132EBE), //40%
      400: const Color(0xff132EBE), //50%
      500: const Color(0xff132EBE), //60%
      600: const Color(0xff132EBE), //70%
      700: const Color(0xff132EBE), //80%
      800: const Color(0xff132EBE), //90%
      900: const Color(0xff132EBE), //100%
    },
  );
}
//  flutter build apk --target-platform android-arm,android-arm64