import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_data.g.dart';

@JsonSerializable()
class PostData extends Equatable {
  const PostData({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory PostData.fromJson(Map<String, dynamic> json) => _$PostDataFromJson(json);

  final int userId;
  final int id;
  final String title;
  final String body;

  @override
  List<Object?> get props => [userId, id, title, body];

  Map<String, dynamic> toJson() => _$PostDataToJson(this);
}
