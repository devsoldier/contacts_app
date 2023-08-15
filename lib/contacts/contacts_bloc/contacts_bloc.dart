import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:contacts_app/contacts/repository/data_classes/contacts_details.dart';
import 'package:contacts_app/contacts/repository/data_classes/pagination.dart';
import 'package:contacts_app/contacts/repository/storage_service.dart';
import 'package:contacts_app/shared/service/result.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../repository/contacts_service.dart';

part 'contacts_event.dart';
part 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  final apiService = GetIt.I<ContactsService>();
  final storage = GetIt.I<StorageService>();
  // int? totalPage;
  int? pageIndex;
  Result<Pagination<ContactsDetails>>? response;
  List<ContactsDetails?> paginatedContactsList = [];
  List<ContactsDetails?> favouriteContactsList = [];
  List<ContactsDetails?> searchResult = [];

  ContactsBloc() : super(ContactsInitialState()) {
    on<ContactsEvent>((event, emit) async {
      try {
        if (event is LoadContactsEvent && paginatedContactsList.isEmpty) {
          if (storage.contactsList.isEmpty) {
            response = await apiService.getContacts();
            final totalPage = response?.data?.totalPages;
            if (totalPage == null) return;
            for (int i = 1; i <= totalPage; i++) {
              final contactsList = await apiService.getContacts(pageNo: i);
              paginatedContactsList.addAll(contactsList.data!.data);
            }
          } else {
            paginatedContactsList = storage.contactsList;
          }
        }

        if (response!.isFailure || paginatedContactsList.isEmpty) {
          emit(ContactsErrorState(
              response!.message ?? 'Failed to receive contacts'));
        }

        if (event is LoadContactsEvent) {
          pageIndex = event.pageIndex;
          storage.storeContacts(paginatedContactsList);
          emit(state.copyWith(contactsDetails: paginatedContactsList));
        }

        if (event is LoadFavouriteContactsEvent) {
          pageIndex = event.pageIndex;
          favouriteContactsList =
              favouriteFilter(paginatedContactsList).toList();
          emit(state.copyWith(contactsDetails: favouriteContactsList));
        }

        if (event is AddContactsEvent) {
          paginatedContactsList.add(
            ContactsDetails(
              id: event.id,
              email: event.email,
              firstName: event.firstName,
              lastName: event.lastName,
              isFavourite: event.isFavourite,
            ),
          );
          storage.storeContacts(paginatedContactsList);
          if (pageIndex == 0) {
            emit(state.copyWith(contactsDetails: paginatedContactsList));
          } else {
            favouriteContactsList =
                favouriteFilter(paginatedContactsList).toList();
            emit(state.copyWith(contactsDetails: favouriteContactsList));
          }
        }

        if (event is DeleteContactsEvent) {
          paginatedContactsList.remove(event.contactsDetails);
          storage.storeContacts(paginatedContactsList);
          if (pageIndex == 0) {
            emit(state.copyWith(contactsDetails: paginatedContactsList));
          } else {
            favouriteContactsList =
                favouriteFilter(paginatedContactsList).toList();
            emit(state.copyWith(contactsDetails: favouriteContactsList));
          }
        }

        if (event is UpdateContactsEvent) {
          ContactsDetails? matchedContact = paginatedContactsList[
              paginatedContactsList
                  .indexWhere((element) => element?.id == event.id)];

          matchedContact?.firstName =
              event.firstName ?? matchedContact.firstName;
          matchedContact?.lastName = event.lastName ?? matchedContact.lastName;
          matchedContact?.email = event.email ?? matchedContact.email;
          matchedContact?.isFavourite =
              event.isFavourite ?? matchedContact.isFavourite;

          storage.storeContacts(paginatedContactsList);
          if (pageIndex == 0) {
            emit(state.copyWith(contactsDetails: paginatedContactsList));
          } else {
            favouriteContactsList =
                favouriteFilter(paginatedContactsList).toList();
            emit(state.copyWith(contactsDetails: favouriteContactsList));
          }
        }

        if (event is SearchContactsEvent) {
          if (pageIndex == 0) {
            searchResult =
                searchFilter(paginatedContactsList, event.searchQuery);
            emit(state.copyWith(contactsDetails: searchResult));
          } else {
            searchResult =
                searchFilter(favouriteContactsList, event.searchQuery);
            emit(state.copyWith(contactsDetails: searchResult));
          }
        }
      } catch (e, s) {
        log('$e\n$s');
        emit(ContactsErrorState('$e'));
      }
    });
  }
}

List<ContactsDetails?> searchFilter(
  List<ContactsDetails?> allContacts,
  String? searchQuery,
) {
  return allContacts.where((element) {
    return (element!.firstName!
            .toLowerCase()
            .contains(searchQuery!.toLowerCase())) ||
        (element.lastName!.toLowerCase().contains(searchQuery.toLowerCase()));
  }).toList();
}

List<ContactsDetails?> favouriteFilter(List<ContactsDetails?> allContacts) {
  return allContacts.where((element) {
    return element!.isFavourite ?? false;
  }).toList();
}
