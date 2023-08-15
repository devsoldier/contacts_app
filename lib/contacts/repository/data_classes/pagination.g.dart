// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pagination<T> _$PaginationFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    Pagination<T>(
      json['page'] as int?,
      json['per_page'] as int?,
      json['total'] as int?,
      json['total_pages'] as int?,
      (json['data'] as List<dynamic>)
          .map((e) => _$nullableGenericFromJson(e, fromJsonT))
          .toList(),
    );

Map<String, dynamic> _$PaginationToJson<T>(
  Pagination<T> instance,
  Object? Function(T value) toJsonT,
) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('page', instance.page);
  writeNotNull('per_page', instance.perPage);
  writeNotNull('total', instance.total);
  writeNotNull('total_pages', instance.totalPages);
  val['data'] =
      instance.data.map((e) => _$nullableGenericToJson(e, toJsonT)).toList();
  return val;
}

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);
