import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    loadNewPage();
  }

  void loadNewPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool? isIntroScreenVisited =
        prefs.getBool("isSplashScreenVisited") ?? false;
    (isIntroScreenVisited)
        ? Future.delayed(const Duration(seconds: 5), () {
            Navigator.of(context).pushReplacementNamed('/');
          })
        : Future.delayed(const Duration(seconds: 5), () {
            Navigator.of(context).pushReplacementNamed('onboarding');
          });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              'BHAGVAD GITA',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const Text('Hindi & English'),
            const SizedBox(
              height: 25,
            ),
            const CircularProgressIndicator(
              color: Colors.orangeAccent,
            )
          ],
        ),
      ),
    );
  }
}
