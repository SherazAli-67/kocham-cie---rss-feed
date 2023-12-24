import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/route_manager.dart';
import 'package:kocham_cie_tato/src/article_detailed_page.dart';
import 'package:kocham_cie_tato/src/constant.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

class RssArticlesPage extends StatefulWidget{
  const RssArticlesPage({super.key});

  @override
  State<RssArticlesPage> createState() => _RssArticlesPageState();
}

class _RssArticlesPageState extends State<RssArticlesPage> {

  List<dynamic> feeds = [];
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initFeeds();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('RSS Articles Page'),
      ),
      body: isLoading ? const Center(child: CupertinoActivityIndicator(),): Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Latest Feeds', style: headingStyle,),
            Expanded(
                child: ListView.builder(
                    itemCount: feeds.length,
                    itemBuilder: (ctx, index) => Padding(padding: const EdgeInsets.all(10), child: _buildFeedItem(index),)))
          ],
        ),
      ),
    );
  }

  void _initFeeds() async{
    setState(() {
      isLoading = true;
    });
    final xmlToJSON = Xml2Json();
    Uri url = Uri.parse(apiURL);

    try{
      var response = await http.get(url);
      xmlToJSON.parse(response.body);
      String data = xmlToJSON.toGData();
      var jsonData = json.decode(data);
      var feed =jsonData['rss']['channel']['item'];
      setState(() {
        feeds = feed;
        isLoading = false;
      });
    }catch(e){
      debugPrint('Exception found: ${e.toString()}');
      Fluttertoast.showToast(msg: 'Failed to load articles due to: ${e.toString()}');
      setState(() {
        isLoading = false;
      });
    }


  }

  _buildFeedItem(int index) {
    return ListTile(
      onTap:() {
       Get.to(()=>  const ArticleDetailedPage(), arguments: {'article': feeds[index]});
      },
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 45,
        backgroundImage: NetworkImage(

          feeds[index]['media\$group']!= null ? feeds[index]['media\$group']['media\$content'] [0]['url'] : dummyImage
        ),
      ),
      title: Text(feeds[index]['title']['__cdata']),
    );
  }
}