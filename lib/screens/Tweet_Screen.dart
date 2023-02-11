import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../widgets/detail_card.dart';

import '../provider/summaries.dart';

class TweetScreen extends StatefulWidget {
  const TweetScreen({super.key});

  @override
  State<TweetScreen> createState() => _TweetScreenState();
}

class _TweetScreenState extends State<TweetScreen> {
  late Future _summaryFuture;

  Future _obtainSummaryFuture() {
    return Provider.of<Summaries>(context, listen: false).fetchAndSetSummary();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _summaryFuture = _obtainSummaryFuture();
  }

  @override
  Widget build(BuildContext context) {
    double divWidth = MediaQuery.of(context).size.width;
    double divHeight = MediaQuery.of(context).size.height;
    // var news = Provider.of<Summaries>(context);
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Image.asset('assets/Images/profileIcon.png')),
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: 25,
                    width: 25,
                    child:
                        SvgPicture.asset('assets/icons/FeatureStrokeIcon.svg'),
                  ),
                ),
              ],
            ),
          ),
          // Divider(),
          Expanded(
            child: Container(
                height: divHeight,
                width: divWidth,
                // color: Colors.blueGrey,
                child: FutureBuilder(
                  future: _summaryFuture,
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      if (snapshot.error != null) {
                        return const Center(
                          child: Text('An Error Occured'),
                        );
                      } else {
                        return Consumer<Summaries>(
                          builder: (ctx, sumData, child) => ListView.builder(
                            itemBuilder: (ctx, i) {
                              return DetailCard(
                                  id: sumData.dets[i].id!,
                                  date: sumData.dets[i].date,
                                  title: sumData.dets[i].title,
                                  summary: sumData.dets[i].summary,
                                  imageUrl: sumData.dets[i].imageUrl);
                            },
                            itemCount: sumData.dets.length,
                          ),
                        );
                      }
                    }
                  },
                )),
          )
          // Divider(),
        ],
      )),
    );
  }
}
