import 'package:contacts_app/contacts/add_contacts.page.dart';
import 'package:flutter/material.dart';

import '../shared/theme.dart';
import 'widgets/contacts_content.dart';
import 'widgets/contacts_tab.dart';
import 'widgets/search_widget.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('My Contacts'),
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.cached),
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            Container(
              color: Colors.black12,
              child: const Padding(
                padding: EdgeInsets.fromLTRB(
                  kCanvasPadding,
                  kCanvasPadding,
                  kCanvasPadding,
                  kCanvasPadding,
                ),
                child: SearchWidget(),
              ),
            ),
            const Padding(
                padding: EdgeInsets.all(kCanvasPadding), child: ContactsTab()),
            const ContactsContent(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddContactsPage(),
              ),
            );
          },
        ),
      ),
    );
  }
}
