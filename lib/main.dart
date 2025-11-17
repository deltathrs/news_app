import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/core/network/sharedpreferences_service.dart';
import 'package:news_app/dependency_injection.dart';
import 'package:news_app/features/auth/presentation/cubit/user/user_cubit.dart';
import 'package:news_app/features/auth/presentation/screens/auth_screen.dart';
import 'package:news_app/features/news/presentation/cubit/news/news_cubit.dart';
import 'package:news_app/features/news/presentation/screens/news_screen.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(
      fileName: "key.env"); //Apabila menggunakan dotenv untuk API Key
  DependencyInjection.getInstance.setupDI();
  await Firebase.initializeApp();

  final bool loggedIn = await SharedPrefUtils.isLoggedIn();

  runApp(MyApp(loggedIn: loggedIn));
}

class MyApp extends StatelessWidget {
  final bool loggedIn;

  const MyApp({super.key, required this.loggedIn});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => GetIt.instance<UserCubit>(),
              ),
              BlocProvider(
                create: (context) => GetIt.instance<NewsCubit>(),
              ),
            ],
            child: loggedIn ? const NewsScreen() : const AuthScreen(),
          ),
        );
      },
    );
  }
}
