import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'appTitle': 'ContaSync',
      'welcomeMessage': 'Welcome to ContaSync',
      'settings': 'Settings',
      'language': 'Language',
      'selectLanguage': 'Select language',
      'email': 'Email',
      'password': 'Password',
      'login': 'Login',
      'pleaseEnterEmail': 'Please enter your email',
      'pleaseEnterPassword': 'Please enter your password',
    },
    'es': {
      'appTitle': 'ContaSync',
      'welcomeMessage': 'Bienvenido a ContaSync',
      'settings': 'Configuración',
      'language': 'Idioma',
      'selectLanguage': 'Seleccionar idioma',
      'email': 'Correo electrónico',
      'password': 'Contraseña',
      'login': 'Iniciar Sesión',
      'pleaseEnterEmail': 'Por favor ingrese su correo electrónico',
      'pleaseEnterPassword': 'Por favor ingrese su contraseña',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'es'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
