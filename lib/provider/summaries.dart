import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html_character_entities/html_character_entities.dart';

import '../models/summary.dart';

class Summaries with ChangeNotifier {
  List<Summary> _dets = [];

  List<Summary> get dets {
    return [..._dets];
  }

  Future<void> fetchAndSetSummary() async {
    final Uri url =
        Uri.parse('https://techcrunch.com/wp-json/wp/v2/posts?page=1');
    final response = await http.get(url);
    final List<Summary> loadedSummary = [];
    final extractedData = jsonDecode(response.body) as List<dynamic>;
    if (extractedData == null) {
      return;
    }

    extractedData.forEach(
      (story) {
        String addDate = story['date'].toString().substring(0, 10);
        String title =
            story['title']['rendered'].toString().replaceAll("\$", "\$");
        String finalTitle = HtmlCharacterEntities.decode(title);

        String summary = story['excerpt']['rendered'].toString();
        summary = summary.replaceAll('[&hellip;]', '...');
        summary = summary.replaceAllMapped(RegExp(r"<.*?>"), (match) => "");
        summary = summary.replaceAll(RegExp(r"&#x[a-fA-F0-9]+;"), "");
        summary = summary.replaceAll(RegExp(r"&#[0-9]+;"), "");
        String filteredSummary = stripHtmlIfNeeded(summary);

        String imageUrl = story['jetpack_featured_media_url'].toString();

        String details = story['content']['rendered'].toString();
        details = details.replaceAllMapped(RegExp(r"<.*?>"), (match) => "");
        details = details.replaceAll(RegExp(r"&#x[a-fA-F0-9]+;"), "");
        details = details.replaceAll(RegExp(r"&#[0-9]+;"), "");

        loadedSummary.add(
          Summary(
              id: (story['id']),
              date: addDate,
              title: finalTitle,
              summary: filteredSummary,
              imageUrl: imageUrl,
              details: details),
        );
      },
    );
    _dets = loadedSummary.toList();
    notifyListeners();
  }

  String stripHtmlIfNeeded(String summary) {
    // The regular expression is simplified for an HTML tag (opening or
    // closing) or an HTML escape. We might want to skip over such expressions
    // when estimating the summary directionality.
    return summary.replaceAll(
        RegExp(r'</?(?!p)(?!ul)(?!li)(?!h)\w*\b[^>]*>'), '');
  }

  Summary findById(int id) {
    return _dets.firstWhere((tw) => tw.id == id);
  }
}
