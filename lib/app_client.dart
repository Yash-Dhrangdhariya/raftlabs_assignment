import 'package:ferry/ferry.dart';
import 'package:gql_http_link/gql_http_link.dart';
import 'package:raftlabs_assignment/values/app_constants.dart';

class AppClient {
  static TypedLink initializeClient() {
    final client = Client(
      link: HttpLink(
        AppConstants.graphqlBaseURL,
      ),
      defaultFetchPolicies: {
        OperationType.query: FetchPolicy.CacheAndNetwork,
      },
    );

    return client;
  }
}
