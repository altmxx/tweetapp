// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../provider/summaries.dart';

class DetailCard extends StatelessWidget {
  int id;
  String date;
  String title;
  String summary;
  String imageUrl;

  DetailCard({
    required this.id,
    required this.date,
    required this.title,
    required this.summary,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    // var divWidth = MediaQuery.of(context).size.width;
    final details = Provider.of<Summaries>(context, listen: false);

    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed('/tweetDetails', arguments: id);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        child: Column(
          children: [
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Flexible(
                  child: AutoSizeText(
                    title,
                    maxLines: 3,
                    style: TextStyle(
                        fontFamily: 'Ubuntu', fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              alignment: Alignment.centerRight,
              child: Text(
                date,
                style: TextStyle(
                    fontFamily: 'Ubuntu', color: Colors.blueGrey, fontSize: 11),
              ),
            ),
            Text(
              summary,
              style: TextStyle(fontFamily: 'Ubuntu'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.comment),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.check),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.share),
                ),
              ],
            ),
            // Divider(),
          ],
        ),
      ),
    );
  }
}
