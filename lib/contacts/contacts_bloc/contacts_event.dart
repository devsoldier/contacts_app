part of 'contacts_bloc.dart';

@immutable
sealed class ContactsEvent extends Equatable {
  const ContactsEvent();

  @override
  List<Object?> get props => [];
}

final class LoadContactsEvent extends ContactsEvent {
  final int? pageIndex;

  const LoadContactsEvent(this.pageIndex);

  @override
  List<Object?> get props => [pageIndex];
}

final class LoadFavouriteContactsEvent extends ContactsEvent {
  final int? pageIndex;

  const LoadFavouriteContactsEvent(this.pageIndex);

  @override
  List<Object?> get props => [pageIndex];
}

final class SyncContactsEvent extends ContactsEvent {}

final class AddContactsEvent extends ContactsEvent {
  final String? firstName;
  final String? lastName;
  final String? email;
  final bool? isFavourite;
  final int? index;
  final int? id;

  const AddContactsEvent(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.isFavourite,
      this.index});

  @override
  List<Object?> get props => [firstName, lastName, email, index];
}

final class DeleteContactsEvent extends ContactsEvent {
  final ContactsDetails? contactsDetails;

  const DeleteContactsEvent(this.contactsDetails);

  @override
  List<Object?> get props => [contactsDetails];
}

final class SearchContactsEvent extends ContactsEvent {
  final String? searchQuery;

  const SearchContactsEvent(this.searchQuery);

  @override
  List<Object?> get props => [searchQuery];
}

final class UpdateContactsEvent extends ContactsEvent {
  final String? firstName;
  final String? lastName;
  final String? email;
  final bool? isFavourite;
  final int? index;
  final int? id;

  const UpdateContactsEvent(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.isFavourite,
      this.index});

  @override
  List<Object?> get props => [firstName, lastName, email, index];
}

// final class AddAsFavouriteEvent extends ContactsEvent {
//   final bool? isFavourite;
//   final int? index;

//   const AddAsFavouriteEvent({this.isFavourite, this.index});

//   @override
//   List<Object?> get props => [index];
// }

final class ContactsErrorEvent extends ContactsEvent {}
