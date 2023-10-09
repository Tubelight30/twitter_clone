import 'package:flutter/foundation.dart';

@immutable
class UserModel {
  //this is what we store in the appwrite
  final String email;
  final String name;
  final List<String>
      followers; //!list of string bcz we will store follower's in the form of their id's
  final List<String> following;
  final String profilePic;
  final String bannerPic;
  final String uid;
  final String bio;
  final bool isTwitterBlue;
  const UserModel({
    required this.email,
    required this.name,
    required this.followers,
    required this.following,
    required this.profilePic,
    required this.bannerPic,
    required this.uid,
    required this.bio,
    required this.isTwitterBlue,
  });

  //suppose UserModel user = UserModel(name:'xyz',......);
  //user.copyWith(name:'abc'); only the name will be changed rest remain same
  //we need copyWith bcz all the fields are final and we cannot simply do user.name = 'abc';<--error
  UserModel copyWith({
    String? email,
    String? name,
    List<String>? followers,
    List<String>? following,
    String? profilePic,
    String? bannerPic,
    String? uid,
    String? bio,
    bool? isTwitterBlue,
  }) {
    return UserModel(
      email: email ?? this.email,
      name: name ?? this.name,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      profilePic: profilePic ?? this.profilePic,
      bannerPic: bannerPic ?? this.bannerPic,
      uid: uid ?? this.uid,
      bio: bio ?? this.bio,
      isTwitterBlue: isTwitterBlue ?? this.isTwitterBlue,
    );
  }

  //!when we have a UserModel Created and we call user.toMap() it will return a map of all the fields
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'email': email});
    result.addAll({'name': name});
    result.addAll({'followers': followers});
    result.addAll({'following': following});
    result.addAll({'profilePic': profilePic});
    result.addAll({'bannerPic': bannerPic});
    result.addAll({'bio': bio});
    result.addAll({'isTwitterBlue': isTwitterBlue});
    return result;
  }

  //!when we have a map and we want to convert it to UserModel
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      followers: List<String>.from(map['followers']),
      following: List<String>.from(map['following']),
      profilePic: map['profilePic'] ?? '',
      bannerPic: map['bannerPic'] ?? '',
      uid: map['\$id'] ??
          '', //this will retrieve the auto generated id of the user by appwrite.
      //!this '\$id' is a special key in appwrite which is used to retrieve the auto generated id of the user
      //!there are many other special keys like '\$collection' which is used to retrieve the collection name
      bio: map['bio'] ?? '',
      isTwitterBlue: map['isTwitterBlue'] ?? false,
    );
  }

  @override
  String toString() {
    return 'UserModel(email: $email, name: $name, followers: $followers, following: $following, profilePic: $profilePic, bannerPic: $bannerPic, uid: $uid, bio: $bio, isTwitterBlue: $isTwitterBlue)';
  }
  //we wont be using this in our application
  // @override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) return true;

  //   return other is UserModel &&
  //       other.email == email &&
  //       other.name == name &&
  //       other.followers == followers &&
  //       listEquals(other.following, following) &&
  //       other.profilePic == profilePic &&
  //       other.bannerPic == bannerPic &&
  //       other.uid == uid &&
  //       other.bio == bio &&
  //       other.isTwitterBlue == isTwitterBlue;
  // }

  // @override
  // int get hashCode {
  //   return email.hashCode ^
  //       name.hashCode ^
  //       followers.hashCode ^
  //       following.hashCode ^
  //       profilePic.hashCode ^
  //       bannerPic.hashCode ^
  //       uid.hashCode ^
  //       bio.hashCode ^
  //       isTwitterBlue.hashCode;
  // }
}
