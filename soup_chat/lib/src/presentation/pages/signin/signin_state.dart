import 'package:freezed_annotation/freezed_annotation.dart';
part 'signin_state.freezed.dart';


@freezed
class SignInState with _$SignInState {
  const factory SignInState.loading() = Loading;
  const factory SignInState.success() = Success;
  const factory SignInState.error(String message) = Error;
}