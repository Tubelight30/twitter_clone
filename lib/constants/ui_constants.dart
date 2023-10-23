import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twitter_clone/constants/constants.dart';
import 'package:twitter_clone/features/explore/explore_view.dart';
import 'package:twitter_clone/features/tweet/widgets/tweet_list.dart';
import 'package:twitter_clone/theme/theme.dart';

class UIConstants {
  static AppBar appBar() {
    //!created a static function named appBar of type AppBar.
    //!Static so that we dont have to make object to use it we can do UIConstants.appBar()
    return AppBar(
      title: SvgPicture.asset(
        AssetsConstants.twitterLogo,
        color: Pallete.blueColor,
        height: 30,
      ),
      centerTitle: true,
    );
  }

  static const List<Widget> bottomTabBarPages = [
    TweetList(),
    ExploreView(),
    Text("Notification Screen"),
  ];
}
