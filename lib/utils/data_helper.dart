import '../models/news_model.dart';
import '../models/user_model.dart';

class DataHelper {
  factory DataHelper() => instance;

  DataHelper._();

  static final instance = DataHelper._();

  List<NewsModel> toListOfNews(Map<String, dynamic> value) {
    final data = value['getNews'] as List<dynamic>;
    final news = data
        .map(
          (e) => NewsModel.fromJson(
            e as Map<String, dynamic>,
          ),
        )
        .toList();
    return news;
  }

  List<UserModel> toListOfUsers(Map<String, dynamic> value) {
    final data = value['getUsersExcept'] as List<dynamic>;
    final users = data
        .map(
          (e) => UserModel.fromJson(
            e as Map<String, dynamic>,
          ),
        )
        .toList();
    return users;
  }
}
