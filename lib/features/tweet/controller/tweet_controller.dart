import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/core/enums/tweet_type_enum.dart';
import 'package:twitter_clone/core/utils.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/models/tweet_model.dart';

class TweetController extends StateNotifier<bool> {
  final Ref _ref;
  TweetController({required Ref ref})
      : _ref = ref,
        super(false);

  void shareTweet({
    required List<File> images, //will be empty list if no images are selected
    required String text, //will be empty string if no text is entered
    required BuildContext context,
  }) {
    //!text is absolutely necessary bcz we cannot tweet without text
    if (text.isEmpty) {
      showSnackBar(context, 'Please enter text');
      return;
    }
    //!images is not necessary bcz we can tweet without images
    if (images.isNotEmpty) {
      _shareImageTweet(
        images: images,
        text: text,
        context: context,
      );
    } else {
      _shareTextTweet(
        text: text,
        context: context,
      );
    }
  }

  //!both these functions are private bcz we dont want to expose them outside of the controller
  void _shareImageTweet({
    required List<File> images,
    required String text,
    required BuildContext context,
  }) {}

  void _shareTextTweet({
    required String text,
    required BuildContext context,
  }) {
    state = true; //isLoading = true
    final hashtags = _getHashTagsFromText(text);
    final link = _getLinkFromText(text);
    final user = _ref.read(currentUserDetailsProvider).value!;
    Tweet tweet = Tweet(
      text: text,
      hashtags: hashtags,
      link: link,
      imagesLinks: [],
      uid: user.uid,
      tweetType: TweetType.text,
      tweetedAt: DateTime.now(),
      likes: [],
      commentsIds: [],
      id: '',
      resharedCount: 0,
    );
  }

  String _getLinkFromText(String text) {
    //Saumya Gupta https://www.google.com
    //[Saumya, Gupta, https://www.google.com]
    String link = '';
    List<String> wordsInSentence = text.split(' ');
    for (String word in wordsInSentence) {
      if (word.startsWith('https://') || word.startsWith('www.')) {
        link = word;
      }
    }
    return link;
  }

  List<String> _getHashTagsFromText(String text) {
    //Saumya Gupta #flutter #dart
    //[Saumya, Gupta, #flutter, #dart]
    List<String> hashtags = [];
    List<String> wordsInSentence = text.split(' ');
    for (String word in wordsInSentence) {
      if (word.startsWith('#')) {
        hashtags.add(word);
      }
    }
    return hashtags;
  }
}
