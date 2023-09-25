// ignore: unused_import
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ContactsTab extends ConsumerStatefulWidget {
  const ContactsTab({super.key});

  @override
  ConsumerState<ContactsTab> createState() => _ContactsTabState();
}

class _ContactsTabState extends ConsumerState<ContactsTab> {
  int? initialIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: ToggleSwitch(
            customWidths: const [45, 90],
            initialLabelIndex: initialIndex,
            activeBgColor: [Theme.of(context).primaryColor],
            activeFgColor: Colors.white,
            inactiveBgColor: Colors.white,
            inactiveFgColor: Colors.black26,
            totalSwitches: 2,
            labels: const ['All', 'Favourite'],
            onToggle: (index) {
              initialIndex = index;
              // setState(() {});
              // if (searchQuery.isNotEmpty) {
              //   final readContactsBloc = context.read<ContactsBloc>();
              //   readContactsBloc.pageIndex = initialIndex;
              //   readContactsBloc.add(SearchContactsEvent(searchQuery));
              //   log('page: ${context.read<ContactsBloc>().pageIndex}');
              //   return;
              // }
              // if (index == 0) {
              //   context
              //       .read<ContactsBloc>()
              //       .add(const LoadContactsEvent(pageIndex: 0));
              // } else {
              //   context
              //       .read<ContactsBloc>()
              //       .add(const LoadFavouriteContactsEvent(1));
              // }
            }),
      ),
    );
  }
}
