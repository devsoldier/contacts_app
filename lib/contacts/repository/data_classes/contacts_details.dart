// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contacts_details.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ContactsDetails extends Equatable {
  final int? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? fullName;
  final bool? isFavourite;
  final String? avatar;

  const ContactsDetails({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.fullName,
    this.isFavourite,
    this.avatar,
  });

  factory ContactsDetails.fromJson(Map<String, dynamic> json) =>
      _$ContactsDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ContactsDetailsToJson(this);

  @override
  List<Object?> get props => [
        id,
        email,
        firstName,
        lastName,
        fullName,
        isFavourite,
        avatar,
      ];

  @override
  bool get stringify => true;

  ContactsDetails copyWith({
    int? id,
    String? email,
    String? firstName,
    String? lastName,
    String? fullName,
    bool? isFavourite,
    String? avatar,
  }) {
    return ContactsDetails(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      fullName: fullName ?? this.fullName,
      isFavourite: isFavourite ?? this.isFavourite,
      avatar: avatar ?? this.avatar,
    );
  }
}
