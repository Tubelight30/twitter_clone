import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone/core/core.dart';
import 'package:twitter_clone/core/providers.dart';

//when we want to sign up, want to get user account => Account
//when we want to access user related data we use => model.Account
final authAPIProvider = Provider((ref) {
  //Provider provides a read only value
  final account = ref.watch(appwriteAccountProvider);
  return AuthAPI(account: account);
});

abstract class IAuthAPI {
  //!I stands for Interface. this is interface for the AuthAPI class

  FutureEither<model.Account> signUp({
    required String email,
    required String password,
  });
  FutureEither<model.Session> login({
    required String email,
    required String password,
  });
  Future<model.Account?> currentUserAccount();
}

class AuthAPI implements IAuthAPI {
  final Account _account; //private variable
  //this is a service account variable not model account
  AuthAPI({required Account account}) : _account = account;

  @override
  //!if _account.get() doesn't have any value that means a user is not logged in
  //!maybe signed up but not logged in so we will return null in that case
  //!this is for persisting login state even after app restart
  Future<model.Account?> currentUserAccount() async {
    //we will use Future Provider for this
    try {
      return await _account.get();
    } on AppwriteException catch (e) {
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  FutureEither<model.Account> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final account = await _account.create(
        //this returns a model.Account
        userId: ID.unique(), //appwrite will auto generate unique app id
        email: email,
        password: password,
      );
      return right(account);
    } on AppwriteException catch (e, stackTrace) {
      return left(
        Failure(e.message ?? "Some unexpected error occurred.", stackTrace),
      );
    } catch (e, stackTrace) {
      return left(
        Failure(e.toString(), stackTrace),
      );
    }
  }

  @override
  FutureEither<model.Session> login({
    required String email,
    required String password,
  }) async {
    try {
      final session = await _account.createEmailSession(
        email: email,
        password: password,
      );
      return right(session);
    } on AppwriteException catch (e, stackTrace) {
      return left(
          Failure(e.message ?? "Some unexpected error occurred.", stackTrace));
    } catch (e, stackTrace) {
      return left(Failure(e.toString(), stackTrace));
    }
  }
}
