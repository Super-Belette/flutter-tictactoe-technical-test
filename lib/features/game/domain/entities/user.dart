import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class User with _$User {
  const factory User({required String nickname, required String avatarPath}) =
      _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
