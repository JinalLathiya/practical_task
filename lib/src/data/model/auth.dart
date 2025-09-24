import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth.g.dart';


@JsonSerializable(includeIfNull: false)
class LoginRequest extends Equatable {
  const LoginRequest({
    required this.email,
    required this.password,
    required this.device_id,
    required this.device_type,
    required this.device_token,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) => _$LoginRequestFromJson(json);

  final String email;
  final String password;
  final String device_id;
  final String device_type;
  final String device_token;

  @override
  List<Object?> get props => [email, password, device_id, device_type, device_token];

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}

@JsonSerializable()
class LoginResponse extends Equatable {
  const LoginResponse({required this.status, required this.message});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);

  final int status;
  final String message;

  @override
  List<Object?> get props => [status, message];

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
