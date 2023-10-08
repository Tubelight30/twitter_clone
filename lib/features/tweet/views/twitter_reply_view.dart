import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/constants/constants.dart';
import 'package:twitter_clone/features/tweet/controller/tweet_controller.dart';
import 'package:twitter_clone/features/tweet/widgets/tweet_card.dart';
import 'package:twitter_clone/models/tweet_model.dart';

class TwitterReplyScreen extends ConsumerWidget {
  static route(Tweet tweet) => MaterialPageRoute(
      builder: (context) => TwitterReplyScreen(
            tweet: tweet,
          ));
  final Tweet tweet;
  const TwitterReplyScreen({
    required this.tweet,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tweet"),
      ),
      body: Column(
        children: [
          TweetCard(tweet: tweet),
          ref.watch(getRepliesToTweetsProvider(tweet)).when(
                data: (tweets) {
                  return ref.watch(getLatestTweetProvider).when(
                        data: (data) {
                          //print(data.events);
                          //subscription: ws://192.168.151.196:80/v1/realtime?project=64e1db63df0354c2f3c6&channels%5B%5D=databases.64ef1174a443b1c45a0b.collections.65185f7f1adbc9bcdea7.documents
                          if (data.events.contains(
                            'databases.*.collections.${AppwriteConstants.tweetsCollection}.documents.*.create',
                          )) {
                            tweets.insert(
                              0,
                              Tweet.fromMap(data.payload),
                            );
                          } else if (data.events.contains(
                            'databases.*.collections.${AppwriteConstants.tweetsCollection}.documents.*.update',
                          )) {
                            //get id of the original tweet
                            final startingPoint =
                                data.events[0].lastIndexOf('documents.');
                            final endPoint =
                                data.events[0].lastIndexOf('.update');
                            final tweetId = data.events[0]
                                .substring(startingPoint + 10, endPoint);
                            //getting the original tweet from database using the tweet id
                            var tweet = tweets
                                .where((element) => element.id == tweetId)
                                .first;
                            //getting the index of the original tweet
                            final tweetIndex = tweets.indexOf(tweet);
                            tweets.removeWhere(
                                (element) => element.id == tweetId);

                            //getting the updated tweet from payload
                            tweet = Tweet.fromMap(data.payload);
                            tweets.insert(tweetIndex, tweet);
                          }
                          return Expanded(
                            child: ListView.builder(
                              //!listview builder has tendency to take up entire screen it is not getting entire screen here so we wrap with expanded so it gets all the available space
                              itemCount: tweets.length,
                              itemBuilder: (BuildContext context, int index) {
                                final tweet = tweets[index];
                                return TweetCard(tweet: tweet);
                              },
                            ),
                          );
                        },
                        error: (error, stackTrace) => ErrorText(
                          error: error.toString(),
                        ),
                        loading: () {
                          return Expanded(
                            child: ListView.builder(
                              itemCount: tweets.length,
                              itemBuilder: (BuildContext context, int index) {
                                final tweet = tweets[index];
                                return TweetCard(tweet: tweet);
                              },
                            ),
                          );
                        },
                      );
                },
                error: (error, stackTrace) => ErrorText(
                  error: error.toString(),
                ),
                loading: () => const Loader(),
              ),
        ],
      ),
      bottomNavigationBar: TextField(
        onSubmitted: (value) {
          ref.read(tweetControllerProvider.notifier).shareTweet(
              images: [], text: value, context: context, repliedTo: tweet.id);
        },
        decoration: const InputDecoration(
          hintText: 'Tweet your reply',
        ),
      ),
    );
  }
}
