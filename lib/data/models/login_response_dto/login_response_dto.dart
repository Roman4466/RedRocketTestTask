import 'package:freezed_annotation/freezed_annotation.dart';

import '../user_dto/user_dto.dart';

part 'login_response_dto.freezed.dart';
part 'login_response_dto.g.dart';

@freezed
class LoginResponseDto with _$LoginResponseDto {
  const factory LoginResponseDto({
    required String token,
    required String refreshToken,
    required UserDto user,
  }) = _LoginResponseDto;

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) => _$LoginResponseDtoFromJson(json);
}
