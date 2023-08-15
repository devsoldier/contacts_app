import 'package:json_annotation/json_annotation.dart';

part 'pagination.g.dart';

@JsonSerializable(
  genericArgumentFactories: true,
  includeIfNull: false,
  fieldRename: FieldRename.snake,
)
class Pagination<T> {
  final int? page;
  final int? perPage;
  final int? total;
  final int? totalPages;
  final List<T?> data;

  Pagination(
    this.page,
    this.perPage,
    this.total,
    this.totalPages,
    this.data,
  );

  factory Pagination.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$PaginationFromJson<T>(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T) toJsonT) =>
      _$PaginationToJson<T>(this, toJsonT);
}
