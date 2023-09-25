import 'package:twitter_clone/core/core.dart';

abstract class IUserAPI {
  FutureEitherVoid saveUserData();
}

class UserAPI implements IUserAPI {
  @override
  FutureEitherVoid saveUserData() {}
}
