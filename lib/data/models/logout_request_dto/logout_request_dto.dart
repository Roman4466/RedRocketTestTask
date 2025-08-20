import 'package:freezed_annotation/freezed_annotation.dart';

part 'logout_request_dto.freezed.dart';
part 'logout_request_dto.g.dart';

@freezed
class LogoutRequestDto with _$LogoutRequestDto {
  const factory LogoutRequestDto({required String token}) = _LogoutRequestDto;

  factory LogoutRequestDto.fromJson(Map<String, dynamic> json) => _$LogoutRequestDtoFromJson(json);
}
