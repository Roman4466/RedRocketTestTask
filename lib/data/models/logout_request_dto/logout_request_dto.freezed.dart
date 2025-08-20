// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'logout_request_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LogoutRequestDto _$LogoutRequestDtoFromJson(Map<String, dynamic> json) {
  return _LogoutRequestDto.fromJson(json);
}

/// @nodoc
mixin _$LogoutRequestDto {
  String get token => throw _privateConstructorUsedError;

  /// Serializes this LogoutRequestDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LogoutRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LogoutRequestDtoCopyWith<LogoutRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LogoutRequestDtoCopyWith<$Res> {
  factory $LogoutRequestDtoCopyWith(
    LogoutRequestDto value,
    $Res Function(LogoutRequestDto) then,
  ) = _$LogoutRequestDtoCopyWithImpl<$Res, LogoutRequestDto>;
  @useResult
  $Res call({String token});
}

/// @nodoc
class _$LogoutRequestDtoCopyWithImpl<$Res, $Val extends LogoutRequestDto>
    implements $LogoutRequestDtoCopyWith<$Res> {
  _$LogoutRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LogoutRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? token = null}) {
    return _then(
      _value.copyWith(
            token: null == token
                ? _value.token
                : token // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LogoutRequestDtoImplCopyWith<$Res>
    implements $LogoutRequestDtoCopyWith<$Res> {
  factory _$$LogoutRequestDtoImplCopyWith(
    _$LogoutRequestDtoImpl value,
    $Res Function(_$LogoutRequestDtoImpl) then,
  ) = __$$LogoutRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String token});
}

/// @nodoc
class __$$LogoutRequestDtoImplCopyWithImpl<$Res>
    extends _$LogoutRequestDtoCopyWithImpl<$Res, _$LogoutRequestDtoImpl>
    implements _$$LogoutRequestDtoImplCopyWith<$Res> {
  __$$LogoutRequestDtoImplCopyWithImpl(
    _$LogoutRequestDtoImpl _value,
    $Res Function(_$LogoutRequestDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LogoutRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? token = null}) {
    return _then(
      _$LogoutRequestDtoImpl(
        token: null == token
            ? _value.token
            : token // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LogoutRequestDtoImpl implements _LogoutRequestDto {
  const _$LogoutRequestDtoImpl({required this.token});

  factory _$LogoutRequestDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$LogoutRequestDtoImplFromJson(json);

  @override
  final String token;

  @override
  String toString() {
    return 'LogoutRequestDto(token: $token)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LogoutRequestDtoImpl &&
            (identical(other.token, token) || other.token == token));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, token);

  /// Create a copy of LogoutRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LogoutRequestDtoImplCopyWith<_$LogoutRequestDtoImpl> get copyWith =>
      __$$LogoutRequestDtoImplCopyWithImpl<_$LogoutRequestDtoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LogoutRequestDtoImplToJson(this);
  }
}

abstract class _LogoutRequestDto implements LogoutRequestDto {
  const factory _LogoutRequestDto({required final String token}) =
      _$LogoutRequestDtoImpl;

  factory _LogoutRequestDto.fromJson(Map<String, dynamic> json) =
      _$LogoutRequestDtoImpl.fromJson;

  @override
  String get token;

  /// Create a copy of LogoutRequestDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LogoutRequestDtoImplCopyWith<_$LogoutRequestDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
