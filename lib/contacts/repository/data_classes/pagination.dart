// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pagination.g.dart';

@JsonSerializable(
  genericArgumentFactories: true,
  includeIfNull: false,
  fieldRename: FieldRename.snake,
)
class Pagination<T> extends Equatable {
  final int? page;
  final int? perPage;
  final int? total;
  final int? totalPages;
  final List<T?> data;

  const Pagination(
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

  @override
  List<Object?> get props => [
        page,
        perPage,
        total,
        totalPages,
        data,
      ];

  @override
  bool get stringify => true;

  Pagination<T> copyWith({
    int? page,
    int? perPage,
    int? total,
    int? totalPages,
    List<T?>? data,
  }) {
    return Pagination<T>(
      page ?? this.page,
      perPage ?? this.perPage,
      total ?? this.total,
      totalPages ?? this.totalPages,
      data ?? this.data,
    );
  }
}
