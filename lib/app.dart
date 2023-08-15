import 'contacts/contacts_bloc/contacts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'contacts/contacts.page.dart';
import 'shared/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ContactsBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Contacts App',
        theme: kAppLightTheme,
        home: const ContactsPage(),
      ),
    );
  }
}
