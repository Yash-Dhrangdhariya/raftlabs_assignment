import 'package:graphql/client.dart';

import 'app_constants.dart';

class AppClient {
  static final GraphQLClient client = GraphQLClient(
    link: HttpLink(
      AppConstants.graphqlBaseURL,
      useGETForQueries: true,
    ),
    cache: GraphQLCache(),
    defaultPolicies: DefaultPolicies(
      query: Policies(
        cacheReread: CacheRereadPolicy.ignoreAll,
        fetch: FetchPolicy.cacheAndNetwork,
        error: ErrorPolicy.none,
      ),
    ),
  );
}
