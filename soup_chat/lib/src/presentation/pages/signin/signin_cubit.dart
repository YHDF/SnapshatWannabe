import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soup_chat/src/presentation/pages/signin/signin_state.dart';
import 'package:soup_chat/src/data/repositories/auth_repository.dart';
import 'package:soup_chat/src/data/repositories/user_repository.dart';
import '../../../domain/entities/user.dart';

class SignInCubit extends Cubit<SignInState> {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  SignInCubit({required this.authRepository, required this.userRepository}) : super(const Loading());

  Future<void> loginUser(String email, String password, SnapUser user) async {
    emit(const Loading());
    User? userFromFirebase = await authRepository.signIn(email: email, password: password);
    if(userFromFirebase != null) {
      emit(const Success());
    } else {
      emit(const SignInState.error('Register error'));
    }
  }
}