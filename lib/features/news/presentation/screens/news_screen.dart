library news_screen;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/core/utils/loading_utils.dart';
import 'package:news_app/features/auth/presentation/cubit/user/user_cubit.dart';
import 'package:news_app/features/auth/presentation/screens/auth_screen.dart';
import 'package:news_app/features/news/presentation/cubit/news/news_cubit.dart';
import 'package:news_app/features/news/presentation/screens/news_detail_screen.dart';
import 'package:sizer/sizer.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final NewsCubit newsCubit = GetIt.instance<NewsCubit>();

  @override
  void initState() {
    // TODO: implement initState
    newsCubit.fetchNewsArticles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        FlutterExitApp.exitApp();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          title: Text(
            'Latest News',
            style: GoogleFonts.poppins(
                fontSize: 20.sp, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: EdgeInsets.all(8),
              child: IconButton(
                onPressed: () {
                  context.read<UserCubit>().signOut();
                },
                icon: Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
        body: BlocListener<UserCubit, UserState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is SignOutLoading) {
              LoadingUtils.showLoading(context);
            }

            if (state is SignOutLoaded) {
              LoadingUtils.hideLoading(context);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BlocProvider(
                            create: (context) => GetIt.instance<UserCubit>(),
                            child: const AuthScreen(),
                          )));
            }

            if (state is SignOutError) {
              LoadingUtils.hideLoading(context);
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          child: Column(
            children: [
              BlocBuilder<NewsCubit, NewsState>(
                bloc: newsCubit,
                builder: (context, state) {
                  if (state is NewsLoaded) {
                    return Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.articles.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              NewsDetailScreen(
                                                newsArticle:
                                                    state.articles[index],
                                              )));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // IMAGE DI KIRI
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  state.articles[index].url,
                                              width: 110,
                                              height: 110,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  Container(
                                                width: 110,
                                                height: 110,
                                                color: Colors.grey[300],
                                                child: const Center(
                                                    child:
                                                        CircularProgressIndicator()),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Container(
                                                width: 110,
                                                height: 110,
                                                color: Colors.grey[300],
                                                child: const Icon(
                                                    Icons.image_not_supported),
                                              ),
                                            )),

                                        const SizedBox(width: 12),

                                        // TITLE + DESCRIPTION DI KANAN
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // TITLE
                                              Text(
                                                state.articles[index].title,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),

                                              const SizedBox(height: 6),

                                              // DESCRIPTION
                                              Text(
                                                state.articles[index]
                                                    .description,
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black87),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    );
                  }

                  if (state is NewsError) {
                    return Expanded(
                        child: Center(child: Text('Error: ${state.message}')));
                  }

                  return const Expanded(
                      child: Center(child: CircularProgressIndicator()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
