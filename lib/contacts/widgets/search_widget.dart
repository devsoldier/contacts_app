import 'package:contacts_app/contacts/contacts_bloc/contacts_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/theme.dart';
import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  final TextEditingController searchController;
  const SearchWidget({super.key, required this.searchController});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final formKey = GlobalKey<FormState>();
  // final searchController = TextEditingController();
  final searchFocusNode = FocusNode();

  @override
  void dispose() {
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Form(
          key: formKey,
          child: TextFormField(
            controller: widget.searchController,
            autocorrect: false,
            enableSuggestions: false,
            focusNode: searchFocusNode,
            textInputAction: TextInputAction.search,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(kChildPadding),
              hintText: 'Search Contact',
            ),
            onChanged: (value) {
              context
                  .read<ContactsBloc>()
                  .add(SearchContactsEvent(widget.searchController.text));
            },
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              color: Colors.black38,
              Icons.search,
            ),
          ),
        ),
      ],
    );
  }
}
