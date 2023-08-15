part of 'contacts_bloc.dart';

@immutable
sealed class ContactsState extends Equatable {
  const ContactsState();

  ContactsLoadedState copyWith({
    List<ContactsDetails?>? contactsDetails,
  }) {
    return ContactsLoadedState(contactsDetails: contactsDetails);
  }

  @override
  List<Object?> get props => [];
}

final class ContactsInitialState extends ContactsState {}

final class ContactsLoadedState extends ContactsState {
  final List<ContactsDetails?>? contactsDetails;

  const ContactsLoadedState({this.contactsDetails});

  @override
  List<Object?> get props => [contactsDetails];
}

final class ContactsLoadingState extends ContactsState {}

final class ContactsErrorState extends ContactsState {
  final String? errorMessage;

  const ContactsErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
