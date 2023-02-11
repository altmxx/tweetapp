import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/summary.dart';
import '../models/detail.dart';
import '../provider/summaries.dart';

class TweetDetailsScreen extends StatefulWidget {
  static const routeName = '/tweetDetails';

  TweetDetailsScreen({super.key});

  @override
  State<TweetDetailsScreen> createState() => _TweetDetailsScreenState();
}

class _TweetDetailsScreenState extends State<TweetDetailsScreen> {
  int? tweetId;

  var _isinit = true;

  var _dispStory = Detail(
    id: null,
    imageUrl: '',
    title: '',
    story: '',
    date: '',
  );

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_isinit) {
      tweetId = ModalRoute.of(context)!.settings.arguments as dynamic;
      if (tweetId != null) {
        var fetchedStory =
            Provider.of<Summaries>(context, listen: false).findById(tweetId!);
        _dispStory.id = fetchedStory.id;
        _dispStory.imageUrl = fetchedStory.imageUrl;
        _dispStory.title = fetchedStory.title;
        _dispStory.story = fetchedStory.details;
        _dispStory.date = fetchedStory.date;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double divHeight = MediaQuery.of(context).size.height;
    double divWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
            child: Column(
              children: [
                Container(
                  width: divWidth,
                  height: divHeight / 3,
                  child: Image.network(_dispStory.imageUrl),
                ),
                Text(
                  _dispStory.title,
                  style: TextStyle(
                      fontFamily: 'Ubuntu',
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  margin: EdgeInsets.only(right: 10, bottom: 10),
                  alignment: Alignment.topRight,
                  child: Text(
                    'Dated: ${_dispStory.date}',
                    style: TextStyle(fontFamily: 'Ubuntu', fontSize: 12),
                  ),
                ),
                Text(
                  _dispStory.story,
                  style: TextStyle(fontFamily: 'Ubuntu', fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
