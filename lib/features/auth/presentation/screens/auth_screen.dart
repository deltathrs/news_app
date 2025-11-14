library auth_screen;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/features/news/presentation/screens/news_screen.dart';
import 'package:sizer/sizer.dart';

part '../widgets/google_sign_in_button.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Text(
                "News App",
                style:
                    GoogleFonts.poppins(fontSize: 26.sp, color: Colors.black),
              ),
              SizedBox(
                height: 15.h,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NewsScreen()));
                  },
                  child: SignInButton())
            ],
          ),
        ),
      ),
    );
  }
}
