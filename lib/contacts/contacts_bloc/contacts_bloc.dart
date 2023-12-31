import 'dart:developer';

import 'package:contacts_app/contacts/repository/contacts_helper.dart';
import 'package:contacts_app/contacts/repository/data_classes/contacts_details.dart';
import 'package:contacts_app/contacts/repository/storage_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../repository/contacts_service.dart';

part 'contacts_event.dart';
part 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  final apiService = GetIt.I<ContactsService>();
  final storage = GetIt.I<StorageService>();
  int? pageIndex;
  String activeSearchText = '';

  Future<List<ContactsDetails?>?> _searchResult(String search) async {
    activeSearchText = search.toString();
    final searchResult = await apiService.searchContacts(
      searchQuery: search,
      pageIndex: pageIndex,
    );
    return searchResult;
  }

  ContactsBloc() : super(ContactsInitialState()) {
    on<ContactsEvent>((event, emit) async {
      try {
        if (event is LoadContactsEvent) {
          if (activeSearchText.isNotEmpty) {
            final searchResult = await _searchResult(activeSearchText);
            emit(state.copyWith(contactsDetails: searchResult));
          }
          if (apiService.isContactsLoaded == false) {
            await apiService.loadAllContacts();
            emit(ContactsLoadingState());
          }
          pageIndex = event.pageIndex;
          emit(state.copyWith(
              contactsDetails: apiService.paginatedContactsList));
        }

        if (event is SyncContactsEvent) {
          emit(ContactsLoadingState());
          await apiService.syncContacts();
          emit(state.copyWith(
              contactsDetails: apiService.paginatedContactsList));
        }

        if (apiService.result?.isFailure ?? false) {
          emit(ContactsErrorState(
              apiService.result!.message ?? 'Failed to receive contacts'));
        }

        if (event is LoadFavouriteContactsEvent) {
          pageIndex = event.pageIndex;
          await apiService.loadFavouriteContacts();
          if (activeSearchText.isNotEmpty) return;
          emit(state.copyWith(
              contactsDetails: apiService.favouriteContactsList));
        }

        if (event is AddContactsEvent) {
          await apiService.addContacts(
            email: event.email,
            firstName: event.firstName,
            lastName: event.lastName,
            isFavourite: event.isFavourite,
          );
          if (pageIndex == 0) {
            emit(state.copyWith(
                contactsDetails: apiService.paginatedContactsList));
          } else {
            final favouriteContactsList = ContactsHelper.favouriteFilter(
                apiService.paginatedContactsList);
            emit(state.copyWith(contactsDetails: favouriteContactsList));
          }
        }

        if (event is DeleteContactsEvent) {
          await apiService.deleteContacts(event.contactsDetails);
          if (pageIndex == 0) {
            emit(state.copyWith(
                contactsDetails: apiService.paginatedContactsList));
          } else {
            final favouriteContactsList = ContactsHelper.favouriteFilter(
                apiService.paginatedContactsList);
            emit(state.copyWith(contactsDetails: favouriteContactsList));
          }
        }

        if (event is UpdateContactsEvent) {
          await apiService.updateContacts(
            id: event.id,
            email: event.email,
            firstName: event.firstName,
            lastName: event.lastName,
            isFavourite: event.isFavourite,
          );
          if (pageIndex == 0) {
            emit(state.copyWith(
                contactsDetails: apiService.paginatedContactsList));
          } else {
            final favouriteContactsList = ContactsHelper.favouriteFilter(
                apiService.paginatedContactsList);
            emit(state.copyWith(contactsDetails: favouriteContactsList));
          }
        }

        if (event is SearchContactsEvent) {
          final searchResult =
              await _searchResult(event.searchQuery.toString());
          emit(state.copyWith(contactsDetails: searchResult));
        }
      } catch (e, s) {
        log('$e\n$s');
        emit(ContactsErrorState('$e'));
      }
    });
  }
}
