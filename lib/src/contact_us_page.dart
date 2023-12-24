import 'package:flutter/material.dart';
import 'package:kocham_cie_tato/src/constant.dart';

class ContactUsPage extends StatelessWidget{
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: const Text('Contact Us Page'),
    ),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
         Center(child: Text('Contact Us',style: titleLarge,)),
        Center(child: Text('+923 47 111 9876',style: headingStyle,)),

      ],
    ),
  );
  }

}