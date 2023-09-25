import 'package:contacts_app/contacts/repository/data_classes/contacts_details.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
sealed class ContactsState extends Equatable {
  const ContactsState();

  ContactsLoadedState copyWith({
    List<ContactsDetails?>? contactsDetails,
  }) {
    if (this is ContactsLoadedState) {
      return ContactsLoadedState(contactsDetails: List.from(contactsDetails!));
    }
    return ContactsLoadedState.fromLoaded(contactsDetails: contactsDetails);
  }

  @override
  List<Object?> get props => [];
}

final class ContactsInitialState extends ContactsState {}

final class ContactsLoadedState extends ContactsState {
  final List<ContactsDetails?>? contactsDetails;

  const ContactsLoadedState({this.contactsDetails});

  factory ContactsLoadedState.fromLoaded(
      {List<ContactsDetails?>? contactsDetails}) {
    return ContactsLoadedState(contactsDetails: List.from(contactsDetails!));
  }

  @override
  List<Object?> get props => [List.from(contactsDetails!)];
}

final class ContactsLoadingState extends ContactsState {}

final class ContactsErrorState extends ContactsState {
  final String? errorMessage;

  const ContactsErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
