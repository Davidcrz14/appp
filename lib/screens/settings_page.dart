import 'package:flutter/material.dart';
import '../utils/app_localizations.dart';

class SettingsPage extends StatefulWidget {
  final Function(Locale) setLocale;

  const SettingsPage({super.key, required this.setLocale});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _currentLanguage = 'es';

  void _changeLanguage(String? newLanguage) {
    if (newLanguage != null) {
      setState(() {
        _currentLanguage = newLanguage;
      });
      widget.setLocale(Locale(newLanguage, ''));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('settings')),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(AppLocalizations.of(context).translate('language')),
            subtitle: Text(_currentLanguage == 'es' ? 'Español' : 'English'),
            trailing: const Icon(Icons.language),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(AppLocalizations.of(context).translate('selectLanguage')),
                    content: DropdownButton<String>(
                      value: _currentLanguage,
                      items: <String>['es', 'en']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value == 'es' ? 'Español' : 'English'),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        _changeLanguage(newValue);
                        Navigator.of(context).pop();
                      },
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
