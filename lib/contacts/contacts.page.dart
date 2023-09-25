// ignore: unused_import
import 'dart:async';
// ignore: unused_import
import 'dart:developer';

import 'package:contacts_app/contacts/screens/add_contacts.page.dart';
import 'package:contacts_app/shared/services/connectivity_service.dart';
import 'package:contacts_app/shared/custom_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../shared/theme.dart';
import 'widgets/contacts_content.dart';
import 'widgets/contacts_tab.dart';
import 'widgets/search_widget.dart';

class ContactsPage extends ConsumerStatefulWidget {
  const ContactsPage({super.key});

  @override
  ConsumerState<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends ConsumerState<ContactsPage> {
  final searchController = TextEditingController();

  void showMessageDiaLog(
    BuildContext context,
  ) async {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Do you want to sync contatcs?'),
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              // context.read<ContactsBloc>().add(SyncContactsEvent());
              Navigator.pop(context);
            },
            child: const Text('Yes', style: TextStyle(color: Colors.red)),
          ),
          CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No'))
        ],
      ),
    );
  }

  void showSnackBar() async {
    final connectivity = ref.read(connectivityService);
    connectivity.connectivityStream.listen((event) {
      if (!event) {
        showNoInternetSnackBar(context, 'No internet');
        setState(() {});
      } else {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        setState(() {});
      }
    });
    await ref.read(connectivityService).checkIfHasInternet();
  }

  @override
  void initState() {
    showSnackBar();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

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
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('My Contacts'),
          actions: <Widget>[
            IconButton(
              onPressed: () => showMessageDiaLog(context),
              icon: const Icon(Icons.cached),
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            Container(
              color: Colors.black12,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  kCanvasPadding,
                  kCanvasPadding,
                  kCanvasPadding,
                  kCanvasPadding,
                ),
                child: SearchWidget(searchController: searchController),
              ),
            ),
            const Padding(
                padding: EdgeInsets.all(kCanvasPadding), child: ContactsTab()),
            ContactsContent(searchController: searchController),
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
