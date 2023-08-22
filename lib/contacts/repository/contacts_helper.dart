import 'package:contacts_app/contacts/repository/data_classes/contacts_details.dart';

class ContactsHelper {
  static List<ContactsDetails?> searchFilter(
    List<ContactsDetails?> allContacts,
    String? searchQuery,
  ) {
    return allContacts.where((element) {
      return (element!.firstName!
              .toLowerCase()
              .contains(searchQuery!.toLowerCase())) ||
          (element.lastName!
              .toLowerCase()
              .contains(searchQuery.toLowerCase())) ||
          ('${element.firstName} ${element.lastName}')
              .toLowerCase()
              .contains(searchQuery.toLowerCase());
    }).toList();
  }

  static List<ContactsDetails?> favouriteFilter(
      List<ContactsDetails?> allContacts) {
    return allContacts.where((element) {
      return element!.isFavourite ?? false;
    }).toList();
  }
}
