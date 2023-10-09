import 'package:flutter/foundation.dart';

import 'package:twitter_clone/core/enums/tweet_type_enum.dart';

@immutable
class Tweet {
  final String text;
  final List<String> hashtags;
  final String link;
  final List<String>
      imagesLinks; //these will the links of the images stored in appwrite storage
  final String uid;
  final TweetType tweetType;
  final DateTime tweetedAt;
  final List<String> likes;
  final List<String> commentsIds;

  final String id; //this will be the id of the tweet stored in appwrite
  final int resharedCount;
  final String retweetedBy;
  final String repliedTo;
  const Tweet({
    required this.text,
    required this.hashtags,
    required this.link,
    required this.imagesLinks,
    required this.uid,
    required this.tweetType,
    required this.tweetedAt,
    required this.likes,
    required this.commentsIds,
    required this.id,
    required this.resharedCount,
    required this.retweetedBy,
    required this.repliedTo,
  });

  Tweet copyWith({
    String? text,
    List<String>? hashtags,
    String? link,
    //these? imagesLinks,
    String? uid,
    TweetType? tweetType,
    DateTime? tweetedAt,
    List<String>? likes,
    List<String>? commentsIds,
    String? id,
    int? resharedCount,
    String? retweetedBy,
    String? repliedTo,
  }) {
    return Tweet(
      text: text ?? this.text,
      hashtags: hashtags ?? this.hashtags,
      link: link ?? this.link,
      imagesLinks: imagesLinks ?? this.imagesLinks,
      uid: uid ?? this.uid,
      tweetType: tweetType ?? this.tweetType,
      tweetedAt: tweetedAt ?? this.tweetedAt,
      likes: likes ?? this.likes,
      commentsIds: commentsIds ?? this.commentsIds,
      id: id ?? this.id,
      resharedCount: resharedCount ?? this.resharedCount,
      retweetedBy: retweetedBy ?? this.retweetedBy,
      repliedTo: repliedTo ?? this.repliedTo,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'text': text});
    result.addAll({'hashtags': hashtags});
    result.addAll({'link': link});
    result.addAll({'imagesLinks': imagesLinks});
    result.addAll({'uid': uid});
    result.addAll({'tweetType': tweetType.type});
    result.addAll({'tweetedAt': tweetedAt.millisecondsSinceEpoch});
    result.addAll({'likes': likes});
    result.addAll({'commentsIds': commentsIds});
    result.addAll({'resharedCount': resharedCount});
    result.addAll({'retweetedBy': retweetedBy});
    result.addAll({'repliedTo': repliedTo});

    return result;
  }

  factory Tweet.fromMap(Map<String, dynamic> map) {
    return Tweet(
      text: map['text'] ?? '',
      hashtags: List<String>.from(map['hashtags']),
      link: map['link'] ?? '',
      imagesLinks: List<String>.from(map['imagesLinks']),
      uid: map['uid'] ?? '',
      tweetType: (map['tweetType'] as String).toTweetTypeEnum(),
      tweetedAt: DateTime.fromMillisecondsSinceEpoch(map['tweetedAt']),
      likes: List<String>.from(map['likes']),
      commentsIds: List<String>.from(map['commentsIds']),
      id: map['\$id'] ??
          '', //this will retrieve the auto generated id of the user by appwrite.
      //! this '\$id' is a special key in appwrite which is used to retrieve the auto generated id of the tweet
      //! there are many other special keys like '\$collection' which is used to retrieve the collection name
      resharedCount: map['resharedCount']?.toInt() ?? 0,
      retweetedBy: map['retweetedBy'] ?? '',
      repliedTo: map['repliedTo'] ?? '',
    );
  }

  @override
  String toString() {
    return 'Tweet(text: $text, hashtags: $hashtags, link: $link, imagesLinks: $imagesLinks, uid: $uid, tweetType: $tweetType, tweetedAt: $tweetedAt, likes: $likes, commentsIds: $commentsIds, id: $id, resharedCount: $resharedCount, retweetedBy: $retweetedBy, repliedTo: $repliedTo)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Tweet &&
        other.text == text &&
        listEquals(other.hashtags, hashtags) &&
        other.link == link &&
        other.imagesLinks == imagesLinks &&
        other.uid == uid &&
        other.tweetType == tweetType &&
        other.tweetedAt == tweetedAt &&
        listEquals(other.likes, likes) &&
        listEquals(other.commentsIds, commentsIds) &&
        other.id == id &&
        other.resharedCount == resharedCount &&
        other.retweetedBy == retweetedBy &&
        other.repliedTo == repliedTo;
  }

  @override
  int get hashCode {
    return text.hashCode ^
        hashtags.hashCode ^
        link.hashCode ^
        imagesLinks.hashCode ^
        uid.hashCode ^
        tweetType.hashCode ^
        tweetedAt.hashCode ^
        likes.hashCode ^
        commentsIds.hashCode ^
        id.hashCode ^
        resharedCount.hashCode ^
        retweetedBy.hashCode ^
        repliedTo.hashCode;
  }
}
