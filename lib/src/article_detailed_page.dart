import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:kocham_cie_tato/src/constant.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleDetailedPage extends StatefulWidget{
  const ArticleDetailedPage({super.key});

  @override
  State<ArticleDetailedPage> createState() => _ArticleDetailedPageState();
}

class _ArticleDetailedPageState extends State<ArticleDetailedPage> {
  dynamic article;
  late final WebViewController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    article = Get.arguments['article'];
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(article['link']['\$t']));
    // #enddocregion webview_controller
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Article Page'),
      ),
      body:WebViewWidget(controller: _controller)
      /*
      SingleChildScrollView(
        child: Column(
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(0.0),
              //   child: Text(article['title']['__cdata'], style: headingStyle,),
              // ),
              // Container(
              //   height: 200,
              //   margin: const EdgeInsets.only(top: 10, bottom: 10),
              //   width: Get.size.width,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   child: ClipRRect(
              //     borderRadius: BorderRadius.circular(10),
              //     child: Image.network(article['media\$group']['media\$content'][0]['url'], fit: BoxFit.cover,),
              //   ),
              // ),

              //
              // Text(article['description']['__cdata'])
            ],
          ),
      ),

       */

    );
  }

}