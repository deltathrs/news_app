import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/features/news/domain/entities/news_entity.dart';
import 'package:news_app/features/news/domain/usecase/news_usecase.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final NewsUsecase newsUsecase;
  NewsCubit({required this.newsUsecase}) : super(NewsInitial());

  Future<void> fetchNewsArticles() async {
    emit(NewsLoading());
    try {
      final articles = await newsUsecase.fetchNewsArticles();
      emit(NewsLoaded(articles: articles));
    } catch (e) {
      emit(NewsError(message: e.toString()));
    }
  }
}
