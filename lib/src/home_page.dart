import 'package:flutter/material.dart';
import 'package:kocham_cie_tato/src/constant.dart';
import 'package:kocham_cie_tato/src/contact_us_page.dart';
import 'package:kocham_cie_tato/src/rss_articles_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: ([
            Expanded(
              child: Center(child: Text('Kocham Cie Tato', style: headingStyle,)),),
            Expanded(
                child: Column(
                  children: [
                const Spacer(),
                ButtonWidget(size: size, title: 'Read Articles', onTap: () => onPressRssArticles(context),),
                const SizedBox(height: 20,),
                ButtonWidget(size: size, title: 'Contact Us', onTap: () => onPressContactUs(context),),
                    const SizedBox(height: 40,),
              ],
            ))
          ]),
      )
    );
  }


  void onPressRssArticles(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>const RssArticlesPage()));
  }

  void onPressContactUs(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>const ContactUsPage()));
  }
}

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.size,
    required this.title,
    required this.onTap
  });

  final Size size;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: size.width*0.9,
        decoration: BoxDecoration(borderRadius:  BorderRadius.circular(10), color: Colors.amber),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Text(title, style: titleLarge,),
      ),
    );
  }
}