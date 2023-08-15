import 'package:contacts_app/contacts/contacts_bloc/contacts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ContactsTab extends StatefulWidget {
  const ContactsTab({super.key});

  @override
  State<ContactsTab> createState() => _ContactsTabState();
}

class _ContactsTabState extends State<ContactsTab> {
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
              setState(() {});
              if (index == 0) {
                context.read<ContactsBloc>().add(const LoadContactsEvent(0));
              } else {
                context
                    .read<ContactsBloc>()
                    .add(const LoadFavouriteContactsEvent(1));
              }
            }),
      ),
    );
  }
}
