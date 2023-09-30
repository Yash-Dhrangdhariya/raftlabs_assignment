class GraphQLQueries {
  factory GraphQLQueries() => instance;

  GraphQLQueries._();

  static final instance = GraphQLQueries._();

  String userById = r'''
          query Query($userId: String!) {
            userById(userId: $userId) {
              _id
              name
              userId
              email
              avatar
              news
              followings
              followers
            }
          }
          ''';

  String getNews = r'''
          query GetNews($userId: String!) {
            getNews(userId: $userId) {
              _id
              author
              title
              description
              image
              authorId
              publishedAt
            }
          }
          ''';

  String getUsersExcept = r'''
          query GetUsersExcept($exceptUser: String!) {
            getUsersExcept(exceptUser: $exceptUser) {
              _id
              name
              userId
              email
              avatar
              news
              followings
              followers
            }
          }
          ''';
}
