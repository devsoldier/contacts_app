// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:contacts_app/contacts/contacts_bloc/contacts_bloc.dart';
import 'package:contacts_app/contacts/edit_contacts.page.dart';
import 'package:contacts_app/shared/theme.dart';

import 'repository/data_classes/contacts_details.dart';

class ContactsDetailsPage extends StatefulWidget {
  final int index;
  final ContactsDetails? contact;

  const ContactsDetailsPage({
    Key? key,
    required this.index,
    this.contact,
  }) : super(key: key);

  @override
  State<ContactsDetailsPage> createState() => _ContactsDetailsPageState();
}

class _ContactsDetailsPageState extends State<ContactsDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Profile'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return ListView(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () async {
                    await Navigator.of(context)
                        .push(
                          MaterialPageRoute(
                            builder: (context) => EditContactsPage(
                                contact: widget.contact, index: widget.index),
                          ),
                        )
                        .whenComplete(() => setState(() {}));
                  },
                  child: const Text('Edit'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: kCanvasPadding,
                  right: kCanvasPadding,
                ),
                child: Stack(
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
                              child: (widget.contact?.avatar != null)
                                  ? Image.network(
                                      widget.contact!.avatar.toString(),
                                      width: 150,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
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
                          center: const Offset(250, 120),
                          width: 58,
                          height: 58),
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
                                  if (widget.contact?.isFavourite == null) {
                                    context.read<ContactsBloc>().add(
                                          UpdateContactsEvent(
                                              id: widget.contact?.id,
                                              index: widget.index,
                                              isFavourite: true),
                                        );
                                  } else {
                                    context.read<ContactsBloc>().add(
                                          UpdateContactsEvent(
                                              id: widget.contact?.id,
                                              index: widget.index,
                                              isFavourite: !(widget
                                                  .contact!.isFavourite!)),
                                        );
                                  }
                                  setState(() {});
                                },
                                icon: (widget.contact?.isFavourite ?? false)
                                    ? const Icon(
                                        color: Colors.red, Icons.favorite)
                                    : const Icon(
                                        color: Colors.red,
                                        Icons.favorite_border),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: kChildPadding, bottom: kChildPadding),
                  child: Text(
                    '${widget.contact?.firstName.toString()} ${widget.contact?.lastName.toString()}',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Container(
                color: const Color(0xFFF1F1F1),
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: kChildPadding,
                      bottom: kChildPadding,
                    ),
                    child: Column(
                      children: [
                        Image.asset('assets/images/email_icon.png'),
                        Padding(
                          padding: const EdgeInsets.only(top: kChildPadding),
                          child: Text(
                            widget.contact!.email.toString(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: kChildPadding,
                    left: kCanvasPadding,
                    right: kCanvasPadding),
                child: ElevatedButton(
                    onPressed: () async {
                      await launchUrl(
                        Uri.parse(
                          "mailto:${widget.contact?.email}?subject=Greetings friend&body=Good day ${widget.contact?.firstName} ${widget.contact?.lastName}",
                        ),
                      );
                    },
                    child: const Text('Send email')),
              )
            ],
          );
        },
      ),
    );
  }
}
