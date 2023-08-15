// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'contacts_details.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ContactsDetails {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? fullName;
  bool? isFavourite;
  String? avatar;

  ContactsDetails({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.fullName,
    this.isFavourite,
    this.avatar,
  }) {
    if (firstName != null) {
      formatFullName;
    }
  }

  factory ContactsDetails.fromJson(Map<String, dynamic> json) =>
      _$ContactsDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ContactsDetailsToJson(this);

  String? get formatFullName {
    fullName = '$firstName $lastName';
    return fullName;
  }
}
