import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news_app/features/auth/presentation/screens/auth_screen.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  await dotenv.load(fileName: "key.env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: AuthScreen(),
        );
      },
    );
  }
}
