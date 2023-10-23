import 'package:flutter/material.dart';

import '../widgets/splash/splash_body.dart';

class SplashView extends StatelessWidget {
  // ignore: constant_identifier_names
  static const String ScreenRoute = 'splash_screen';

  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashViewBody(),
    );
  }
}
