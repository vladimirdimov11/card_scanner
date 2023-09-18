import 'package:shelf/shelf.dart';

import '../utils/api_controller.dart';

class CardController extends ApiController {
  CardController();

  @override
  void registerRequests(WrappedRouter router) {
    router.addRequest(
      RequestType.POST,
      '/api/card',
      cardHandler,
    );
  }

  Response cardHandler(Request request) {
    return responseBuilder.buildOK(data: {'Success': true});
  }
}
