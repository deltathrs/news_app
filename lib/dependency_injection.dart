import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:news_app/core/network/api_services.dart';
import 'package:news_app/core/network/secure_storage_services.dart';
import 'package:news_app/features/auth/data/datasource/firebase_auth_datasource.dart';
import 'package:news_app/features/auth/data/repositories_impl/user_repoimpl.dart';
import 'package:news_app/features/auth/domain/repository/user_repository.dart';
import 'package:news_app/features/auth/domain/usecase/user_usecase.dart';
import 'package:news_app/features/auth/presentation/cubit/user/user_cubit.dart';
import 'package:news_app/features/news/data/datasource/news_datasource.dart';
import 'package:news_app/features/news/data/repositories_impl/news_repository_impl.dart';
import 'package:news_app/features/news/domain/repository/news_repository.dart';
import 'package:news_app/features/news/domain/usecase/news_usecase.dart';
import 'package:news_app/features/news/presentation/cubit/news/news_cubit.dart';

class DependencyInjection {
  DependencyInjection._();

  static final DependencyInjection instance = DependencyInjection._();

  static DependencyInjection get getInstance => instance;

  final getIt = GetIt.instance;

  void setupDI() {
    //Register Firebase Auth
    getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
    getIt.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());

    //Register Secure Storage
    getIt.registerLazySingleton<SecureStorageService>(
        () => SecureStorageService());

    //Register ApiService
    getIt.registerLazySingleton<ApiService>(
        () => ApiService(secureStorageService: getIt<SecureStorageService>()));

    //Register Datasource
    getIt.registerLazySingleton<NewsDataSource>(
        () => NewsDataSourceImpl(apiService: getIt<ApiService>()));
    getIt.registerLazySingleton<FirebaseAuthDatasource>(() =>
        FirebaseAuthDatasourceImpl(
            auth: getIt<FirebaseAuth>(), googleSignIn: getIt<GoogleSignIn>()));

    //Register Repository
    getIt.registerLazySingleton<NewsRepository>(
        () => NewsRepositoryImpl(newsDataSource: getIt<NewsDataSource>()));
    getIt.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
        firebaseAuthDatasource: getIt<FirebaseAuthDatasource>()));

    //Register Usecase
    getIt.registerLazySingleton<NewsUsecase>(
        () => NewsUsecase(newsRepository: getIt<NewsRepository>()));
    getIt.registerLazySingleton<UserUsecase>(
        () => UserUsecase(repository: getIt<UserRepository>()));

    //Register Cubit
    getIt.registerFactory<NewsCubit>(
        () => NewsCubit(newsUsecase: getIt<NewsUsecase>()));
    getIt.registerFactory<UserCubit>(
        () => UserCubit(userUsecase: getIt<UserUsecase>()));
  }
}
