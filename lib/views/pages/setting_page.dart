import 'package:departure/providers/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    final langPro = Provider.of<LanguageProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Settings'),
      ),
      body: Column(
        children: [
          Column(
            children: [
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                color: Colors.orangeAccent,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Language',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              RadioListTile(
                activeColor: Colors.orangeAccent,
                title: const Text('English'),
                value: 'english',
                groupValue: langPro.languageModel.language,
                onChanged: (val) {
                  langPro.languageChange(val);
                },
              ),
              RadioListTile(
                activeColor: Colors.orangeAccent,
                title: const Text('Hindi'),
                value: 'hindi',
                groupValue: langPro.languageModel.language,
                onChanged: (val) {
                  langPro.languageChange(val);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
