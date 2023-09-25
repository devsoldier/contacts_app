import 'package:flutter/material.dart';

import 'contacts/contacts.page.dart';
import 'shared/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contacts App',
      theme: kAppLightTheme,
      home: const ContactsPage(),
    );
  }
}
