part of 'news_cubit.dart';

@immutable
sealed class NewsState {}

final class NewsInitial extends NewsState {}

final class NewsLoading extends NewsState {}

final class NewsLoaded extends NewsState {
  final List<NewsEntity> articles;

  NewsLoaded({required this.articles});
}

final class NewsError extends NewsState {
  final String message;

  NewsError({required this.message});
}
