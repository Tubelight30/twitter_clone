import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone/core/core.dart';

typedef FutureEither<T> = Future<
    Either<Failure, T>>; //success can be different in different scenarios
//so we made it dynamic
typedef FutureEitherVoid = FutureEither<void>;
