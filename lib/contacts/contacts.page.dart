// ignore: unused_import
import 'dart:async';
// ignore: unused_import
import 'dart:developer';

import 'package:contacts_app/contacts/add_contacts.page.dart';
import 'package:contacts_app/contacts/contacts_bloc/contacts_bloc.dart';
import 'package:contacts_app/contacts/repository/connectivity_service.dart';
import 'package:contacts_app/shared/custom_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

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
  final connectivityService = GetIt.I<ConnectivityService>();

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
              context.read<ContactsBloc>().add(SyncContactsEvent());
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
    connectivityService.connectivityStream.listen((event) {
      if (!event) {
        showNoInternetSnackBar(context, 'No internet');
      } else {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
      }
    });
    await connectivityService.checkIfHasInternet();
  }

  @override
  void initState() {
    showSnackBar();
    super.initState();
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
