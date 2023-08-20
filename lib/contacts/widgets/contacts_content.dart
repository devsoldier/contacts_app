import 'package:contacts_app/contacts/contacts_details.page.dart';
import 'package:contacts_app/contacts/edit_contacts.page.dart';
import 'package:contacts_app/contacts/repository/data_classes/contacts_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../shared/theme.dart';
import '../contacts_bloc/contacts_bloc.dart';

class ContactsContent extends StatefulWidget {
  const ContactsContent({super.key});

  @override
  State<ContactsContent> createState() => _ContactsContentState();
}

class _ContactsContentState extends State<ContactsContent> {
  int? page;
  int? pageSize;
  int? currentPage = 1;
  final getIt = GetIt.instance;

  void showMessageDiaLog({
    required List<ContactsDetails?>? list,
    required int index,
    // required BuildContext context,
  }) async {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Are you sure you want to delete this contact?'),
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              context
                  .read<ContactsBloc>()
                  .add(DeleteContactsEvent(list![index]));
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

  @override
  void initState() {
    context.read<ContactsBloc>().add(const LoadContactsEvent(0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactsBloc, ContactsState>(
      builder: (context, state) {
        if (state is ContactsLoadedState && state.contactsDetails!.isEmpty) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                      height: 300,
                      width: 300,
                      'assets/images/empty_contacts.png'),
                  const Padding(
                    padding: EdgeInsets.only(top: kChildPadding),
                    child: Text('No list of contact here,'),
                  ),
                  const Text('add contact now')
                ],
              ),
            ),
          );
        }
        if (state is ContactsLoadedState) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                right: kChildPadding,
                bottom: 65,
              ),
              child: ScrollConfiguration(
                behavior: const ScrollBehavior(),
                child: ListView.builder(
                  itemCount: state.contactsDetails?.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ContactsDetailsPage(
                              contact: state.contactsDetails?[index],
                              index: index,
                            ),
                          ),
                        );
                      },
                      child: Slidable(
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditContactsPage(
                                      contact: state.contactsDetails?[index],
                                      index: index,
                                    ),
                                  ),
                                );
                              },
                              backgroundColor: const Color(0xFFEBF8F6),
                              foregroundColor: Colors.yellow,
                              icon: CupertinoIcons.pen,
                            ),
                            SlidableAction(
                              onPressed: (context) {
                                showMessageDiaLog(
                                  index: index,
                                  list: state.contactsDetails,
                                );
                              },
                              backgroundColor: const Color(0xFFEBF8F6),
                              foregroundColor: Colors.red,
                              icon: (CupertinoIcons.delete),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30, right: 15.0),
                          child: ListTile(
                            contentPadding: const EdgeInsets.only(
                                bottom: 5, right: 5, top: 5),
                            leading: SizedBox(
                              height: 55,
                              width: 55,
                              child: CircleAvatar(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(60),
                                  child: (state.contactsDetails![index]!
                                              .avatar !=
                                          null)
                                      ? Image.network(
                                          height: 55,
                                          width: 55,
                                          fit: BoxFit.cover,
                                          state.contactsDetails![index]!.avatar
                                              .toString(),
                                        )
                                      : Image.asset(
                                          'assets/images/placeholder_photo.png',
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                            ),
                            title: Text(
                                '${state.contactsDetails![index]!.firstName} ${state.contactsDetails![index]!.lastName}'
                                    .toString()),
                            subtitle: Text(
                              state.contactsDetails![index]!.email.toString(),
                              style: const TextStyle(color: Colors.black54),
                            ),
                            trailing: IconButton(
                              onPressed: () async {
                                await launchUrl(
                                  Uri.parse(
                                    "mailto:${state.contactsDetails![index]!.email}?subject=Greetings friend&body=Good day ${state.contactsDetails![index]!.firstName} ${state.contactsDetails![index]!.lastName}",
                                  ),
                                );
                              },
                              icon: const Icon(CupertinoIcons.paperplane),
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        } else if (state is ContactsErrorState) {
          return Expanded(
            child: Center(
              child: Text(state.errorMessage.toString()),
            ),
          );
        } else {
          return const Expanded(
            child: Center(
              child: Text('Fetching contacts'),
            ),
          );
        }
      },
    );
  }
}
