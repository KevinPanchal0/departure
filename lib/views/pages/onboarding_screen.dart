import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List<Map<String, dynamic>> onboardingList = [
    {
      'image': 'assets/images/1.png',
      'title': 'Bhagavad Gita - Simplified',
      'subtitle': 'Read the Gita anytime, where ever you wish',
    },
    {
      'image': 'assets/images/2.png',
      'title': 'Multi Language',
      'subtitle': 'It build in two languages Hindi, English',
    },
    {
      'image': 'assets/images/3.png',
      'title': 'Let’s Start',
      'subtitle': 'Start app and enjoy it',
    },
  ];
  int index = 0;
  PageController pageController = PageController();

  Future<void> checkPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool("isSplashScreenVisited", true);
  }

  @override
  void initState() {
    super.initState();
    checkPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PageView.builder(
          controller: pageController,
          onPageChanged: (val) {
            index = val;
          },
          itemCount: onboardingList.length,
          itemBuilder: (context, index) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OnboardPage(
                image: onboardingList[index]['image'],
                title: onboardingList[index]['title'],
                subtitle: onboardingList[index]['subtitle'],
              ),
              const SizedBox(
                height: 400,
              ),
              OutlinedButton(
                onPressed: (index != 2)
                    ? () {
                        pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn);
                      }
                    : () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/',
                          (route) => false,
                        );
                      },
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.orangeAccent),
                  padding: WidgetStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 50),
                  ),
                ),
                child: Text(
                  (index != 2) ? 'Next' : 'Get Started',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardPage extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  const OnboardPage(
      {super.key,
      required this.image,
      required this.title,
      required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image),
        const SizedBox(
          height: 25,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(
          height: 25,
        ),
        Text(
          subtitle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
