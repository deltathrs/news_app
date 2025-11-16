library auth_screen;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/core/utils/loading_utils.dart';
import 'package:news_app/features/auth/presentation/cubit/user/user_cubit.dart';
import 'package:news_app/features/news/presentation/cubit/news/news_cubit.dart';
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
      child: BlocListener<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UserLoading) {
            LoadingUtils.showLoading(context);
          }
          if (state is UserLoaded) {
            LoadingUtils.hideLoading(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MultiBlocProvider(
                          providers: [
                            BlocProvider(
                              create: (context) => GetIt.instance<NewsCubit>(),
                            ),
                            BlocProvider(
                              create: (context) => GetIt.instance<UserCubit>(),
                            ),
                          ],
                          child: const NewsScreen(),
                        )));
          }

          if (state is UserError) {
            LoadingUtils.hideLoading(context);
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
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
                      context.read<UserCubit>().signInWithGoogle();
                    },
                    child: SignInButton())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
