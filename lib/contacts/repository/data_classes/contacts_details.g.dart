// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contacts_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactsDetails _$ContactsDetailsFromJson(Map<String, dynamic> json) =>
    ContactsDetails(
      id: json['id'] as int?,
      email: json['email'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      fullName: json['full_name'] as String?,
      isFavourite: json['is_favourite'] as bool?,
      avatar: json['avatar'] as String?,
    );

Map<String, dynamic> _$ContactsDetailsToJson(ContactsDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'full_name': instance.fullName,
      'is_favourite': instance.isFavourite,
      'avatar': instance.avatar,
    };
