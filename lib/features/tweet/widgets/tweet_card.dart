import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:like_button/like_button.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/constants/constants.dart';
import 'package:twitter_clone/core/enums/tweet_type_enum.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/tweet/controller/tweet_controller.dart';
import 'package:twitter_clone/features/tweet/widgets/carousel_image.dart';
import 'package:twitter_clone/features/tweet/widgets/hashtag_text.dart';
import 'package:twitter_clone/features/tweet/widgets/tweet_icon_button.dart';
import 'package:twitter_clone/models/tweet_model.dart';
import 'package:twitter_clone/theme/theme.dart';
import 'package:timeago/timeago.dart' as timeago;

class TweetCard extends ConsumerWidget {
  final Tweet tweet;
  const TweetCard({
    required this.tweet,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserDetailsProvider).value;
    //!we want the likes array to be updated with our uid and not the uid of the user who created the tweet so we created currentUser
    return currentUser == null
        ? const Loader()
        : ref.watch(userDetailsProvider(tweet.uid)).when(
              data: (user) {
                return Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(user.profilePic),
                            radius: 35,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //if the tweet is a retweet then we show the retweeted by text
                              //otherwise this row is not shown
                              if (tweet.retweetedBy.isNotEmpty)
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      AssetsConstants.retweetIcon,
                                      color: Pallete.greyColor,
                                      height: 20,
                                    ),
                                    const SizedBox(width: 2),
                                    Text(
                                      '${tweet.retweetedBy} retweeted',
                                      style: const TextStyle(
                                        color: Pallete.greyColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 5),
                                    child: Text(
                                      user.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 19,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '@${user.name}• ${timeago.format(
                                      tweet.tweetedAt,
                                      locale: 'en_short',
                                    )}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Pallete.greyColor,
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
                              ),
                              //need to add replied to
                              HashtagText(text: tweet.text),
                              if (tweet.tweetType == TweetType.image)
                                CarouselImage(imageLinks: tweet.imagesLinks),
                              if (tweet.link.isNotEmpty) ...[
                                const SizedBox(height: 4),
                                AnyLinkPreview(
                                    displayDirection:
                                        UIDirection.uiDirectionHorizontal,
                                    link: 'https://${tweet.link}'),
                              ],
                              Container(
                                margin: const EdgeInsets.only(
                                  top: 10,
                                  right: 20,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TweetIconButton(
                                      pathName: AssetsConstants.viewsIcon,
                                      text: (tweet.commentsIds.length +
                                              tweet.resharedCount +
                                              tweet.likes.length)
                                          .toString(),
                                      onTap: () {},
                                    ),
                                    TweetIconButton(
                                      pathName: AssetsConstants.commentIcon,
                                      text: tweet.commentsIds.length.toString(),
                                      onTap: () {},
                                    ),
                                    TweetIconButton(
                                      pathName: AssetsConstants.retweetIcon,
                                      text: tweet.resharedCount.toString(),
                                      onTap: () {
                                        ref
                                            .read(tweetControllerProvider
                                                .notifier)
                                            .reshareTweet(
                                              tweet,
                                              currentUser,
                                              context,
                                            );
                                      },
                                    ),
                                    LikeButton(
                                      size: 25,
                                      onTap: (isLiked) async {
                                        ref
                                            .read(tweetControllerProvider
                                                .notifier)
                                            .likeTweet(tweet, currentUser);
                                        return !isLiked;
                                      },
                                      likeBuilder: (isLiked) {
                                        return isLiked
                                            ? SvgPicture.asset(
                                                AssetsConstants.likeFilledIcon,
                                                color: Pallete.redColor,
                                              )
                                            : SvgPicture.asset(
                                                AssetsConstants
                                                    .likeOutlinedIcon,
                                                color: Pallete.greyColor,
                                              );
                                      },
                                      likeCount: tweet.likes.length,
                                      isLiked:
                                          tweet.likes.contains(currentUser.uid),
                                      countBuilder: (likeCount, isLiked, text) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(left: 2),
                                          child: Text(
                                            text,
                                            style: TextStyle(
                                              color: isLiked
                                                  ? Pallete.redColor
                                                  : Pallete.whiteColor,
                                              fontSize: 16,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    // TweetIconButton(
                                    //   pathName: AssetsConstants.likeOutlinedIcon,
                                    //   text: tweet.likes.length.toString(),
                                    //   onTap: () {},
                                    // ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.share_outlined,
                                        size: 25,
                                        color: Pallete.greyColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 1),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Pallete.greyColor,
                    )
                  ],
                );
              },
              error: (error, stackTrace) => ErrorText(
                error: error.toString(),
              ),
              loading: () => const Loader(),
            );
  }
}
