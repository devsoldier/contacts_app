import 'package:contacts_app/contacts/contacts_notifier/contacts_state.dart';
import 'package:contacts_app/contacts/repository/contacts_repository.dart';
import 'package:contacts_app/contacts/repository/data_classes/contacts_details.dart';
import 'package:contacts_app/shared/services/connectivity_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final contactsNotifierProvider =
    NotifierProvider<ContactsNotifier, ContactsState>(ContactsNotifier.new);

class ContactsNotifier extends Notifier<ContactsState> {
  @override
  ContactsState build() {
    loadContacts();
    return ContactsLoadingState();
  }

  ContactsRepository get contactsRepository =>
      ref.read(contactsRepositoryProvider);

  String activeSearchText = '';
  int? pageIndex;

  Future<List<ContactsDetails?>?> _searchResult(String search) async {
    activeSearchText = search.toString();
    final searchResult = await ref
        .read(contactsRepositoryProvider)
        .searchContacts(searchQuery: search);
    return searchResult;
  }

  Future<void> loadContacts() async {
    try {
      final internet = ref.read(connectivityService).isOnline;
      if (!internet) {
        state = ContactsNoInternetState();
        return;
      }
      final result = await contactsRepository.retrieveAllPage();
      if (result.isSuccess) {
        state = state.copyWith(contactsDetails: result.data);
      } else if (result.isFailure) {
        state =
            ContactsErrorState(result.message ?? 'Failed to receive contacts');
      } else {
        state = ContactsLoadingState();
      }
    } catch (e) {
      state = ContactsErrorState('$e');
    }
  }

  // Future<void> syncContacts() async {
  //   await ref.read(contactsRepository).syncContacts();
  // }

  Future<void> loadFavouriteContacts() async {
    await contactsRepository.loadFavouriteContacts();
    if (activeSearchText.isNotEmpty) return;
    state = state.copyWith(
        contactsDetails: contactsRepository.favouriteContactsList);
  }

  Future<void> addContacts({
    required String email,
    required String firstName,
    required String lastName,
    required bool isFavourite,
  }) async {
    await contactsRepository.addContacts(
      email: email,
      firstName: firstName,
      lastName: lastName,
      isFavourite: isFavourite,
    );
    state = state.copyWith(
        contactsDetails: contactsRepository.paginatedContactsList);
  }

  Future<void> deleteContacts(ContactsDetails contact) async {
    await contactsRepository.deleteContacts(contact);
  }

  Future<void> updateContacts({
    int? id,
    String? email,
    String? firstName,
    String? lastName,
    bool? isFavourite,
  }) async {
    await contactsRepository.updateContacts(
      id: id,
      email: email,
      firstName: firstName,
      lastName: lastName,
      isFavourite: isFavourite,
    );

    state = state.copyWith(
        contactsDetails: contactsRepository.paginatedContactsList);
  }

  Future<void> searchContacts(String? searchQuery) async {
    final searchResult = await _searchResult(searchQuery.toString());

    state = state.copyWith(contactsDetails: searchResult);
  }
}
