import 'package:flutter/material.dart';
import 'package:diary_mobile/core/constant/app_constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(AppConstants.appName)), body: const Center(child: Text('Hoş Geldiniz!')));
  }
}
