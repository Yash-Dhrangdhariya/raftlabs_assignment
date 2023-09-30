class GraphQLMutations {
  factory GraphQLMutations() => instance;

  GraphQLMutations._();

  static final instance = GraphQLMutations._();

  String followings = r'''
            mutation Followings($sendingUserId: String!, $receivingUserId: String!) {
              followings(sendingUserId: $sendingUserId, receivingUserId: $receivingUserId)
            }
          ''';

  String createNewsArticle = r'''
          mutation CreateNewsArticle($author: String!, $authorId: String!, $title: String!, $description: String!, $image: String!) {
            createNewsArticle(author: $author, authorId: $authorId, title: $title, description: $description, image: $image) {
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

  String createUserIfNotExist = r'''
          mutation CreateUserIfNotExists($name: String!, $userId: String!, $email: String!, $avatar: String!) {
            createUserIfNotExists(name: $name, userId: $userId, email: $email, avatar: $avatar) {
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
