import 'package:contacts_app/contacts/contacts_bloc/contacts_bloc.dart';
import 'package:contacts_app/shared/custom_snackbar.dart';
import 'package:contacts_app/shared/theme.dart';
import 'package:contacts_app/shared/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddContactsPage extends StatefulWidget {
  const AddContactsPage({super.key});

  @override
  State<AddContactsPage> createState() => _AddContactsPageState();
}

class _AddContactsPageState extends State<AddContactsPage> {
  final formKey = GlobalKey<FormState>();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  bool isFavourite = false;

  @override
  void dispose() {
    firstName.dispose();
    lastName.dispose();
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ContactsBloc>().state;

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
            title: const Text('Profile'),
          ),
          body: ListView(
            padding: const EdgeInsets.only(
              left: kCanvasPadding,
              right: kCanvasPadding,
            ),
            children: [
              const Align(
                alignment: Alignment.center,
                child: SizedBox(height: 48),
              ),
              Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(120),
                          child: CircleAvatar(
                            child: Image.asset(
                              'assets/images/placeholder_photo.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned.fromRect(
                    rect: Rect.fromCenter(
                        center: const Offset(250, 120), width: 58, height: 58),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            color: Colors.white,
                            child: IconButton(
                              onPressed: () {
                                isFavourite = !isFavourite;
                                setState(() {});
                              },
                              icon: (isFavourite)
                                  ? const Icon(
                                      color: Colors.red, Icons.favorite)
                                  : const Icon(
                                      color: Colors.red, Icons.favorite_border),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: kChildPadding, left: kChildPadding, bottom: 7),
                        child: Text(
                          'First Name',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                    TextFormField(
                      validator: Validator.notBlank,
                      controller: firstName,
                      autocorrect: false,
                      enableSuggestions: false,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        contentPadding: const EdgeInsets.all(kChildPadding),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: kChildPadding, left: kChildPadding, bottom: 7),
                        child: Text(
                          'Last Name',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                    TextFormField(
                      validator: Validator.notBlank,
                      controller: lastName,
                      autocorrect: false,
                      enableSuggestions: false,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        contentPadding: const EdgeInsets.all(kChildPadding),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: kChildPadding, left: kChildPadding, bottom: 7),
                        child: Text(
                          'Email',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                    TextFormField(
                      validator: Validator.email,
                      controller: email,
                      autocorrect: false,
                      enableSuggestions: false,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        contentPadding: const EdgeInsets.all(kChildPadding),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 35),
                  child: ElevatedButton(
                      onPressed: () {
                        FocusScopeNode currentFocus = FocusScope.of(context);

                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        if (!(formKey.currentState?.validate() ?? false)) {
                          return;
                        }
                        context.read<ContactsBloc>().add(
                              AddContactsEvent(
                                firstName: firstName.text,
                                lastName: lastName.text,
                                email: email.text,
                                isFavourite: isFavourite,
                              ),
                            );
                        if (state is ContactsLoadedState) {
                          showSnackBar(context, 'Contact Added');
                        } else {
                          showErrorSnackBar(context, 'something went wrong');
                        }
                      },
                      child: const Text('Done')))
            ],
          )),
    );
  }
}
