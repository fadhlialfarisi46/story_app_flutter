// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'no_data_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

NoDataResponse _$NoDataResponseFromJson(Map<String, dynamic> json) {
  return _NoDataResponse.fromJson(json);
}

/// @nodoc
mixin _$NoDataResponse {
  bool get error => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NoDataResponseCopyWith<NoDataResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoDataResponseCopyWith<$Res> {
  factory $NoDataResponseCopyWith(
          NoDataResponse value, $Res Function(NoDataResponse) then) =
      _$NoDataResponseCopyWithImpl<$Res, NoDataResponse>;
  @useResult
  $Res call({bool error, String message});
}

/// @nodoc
class _$NoDataResponseCopyWithImpl<$Res, $Val extends NoDataResponse>
    implements $NoDataResponseCopyWith<$Res> {
  _$NoDataResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NoDataResponseImplCopyWith<$Res>
    implements $NoDataResponseCopyWith<$Res> {
  factory _$$NoDataResponseImplCopyWith(_$NoDataResponseImpl value,
          $Res Function(_$NoDataResponseImpl) then) =
      __$$NoDataResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool error, String message});
}

/// @nodoc
class __$$NoDataResponseImplCopyWithImpl<$Res>
    extends _$NoDataResponseCopyWithImpl<$Res, _$NoDataResponseImpl>
    implements _$$NoDataResponseImplCopyWith<$Res> {
  __$$NoDataResponseImplCopyWithImpl(
      _$NoDataResponseImpl _value, $Res Function(_$NoDataResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? message = null,
  }) {
    return _then(_$NoDataResponseImpl(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NoDataResponseImpl implements _NoDataResponse {
  const _$NoDataResponseImpl({required this.error, required this.message});

  factory _$NoDataResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$NoDataResponseImplFromJson(json);

  @override
  final bool error;
  @override
  final String message;

  @override
  String toString() {
    return 'NoDataResponse(error: $error, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NoDataResponseImpl &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, error, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NoDataResponseImplCopyWith<_$NoDataResponseImpl> get copyWith =>
      __$$NoDataResponseImplCopyWithImpl<_$NoDataResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NoDataResponseImplToJson(
      this,
    );
  }
}

abstract class _NoDataResponse implements NoDataResponse {
  const factory _NoDataResponse(
      {required final bool error,
      required final String message}) = _$NoDataResponseImpl;

  factory _NoDataResponse.fromJson(Map<String, dynamic> json) =
      _$NoDataResponseImpl.fromJson;

  @override
  bool get error;
  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$NoDataResponseImplCopyWith<_$NoDataResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
