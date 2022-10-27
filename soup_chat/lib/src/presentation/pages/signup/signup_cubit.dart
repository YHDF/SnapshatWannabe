import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soup_chat/src/domain/entities/user.dart';
import 'package:soup_chat/src/presentation/pages/signup/signup_state.dart';

import '../../../data/repositories/auth_repository.dart';
import '../../../data/repositories/user_repository.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  SignUpCubit({required this.authRepository, required this.userRepository}) : super(const Loading());

  Future<void> registerUser(String email, String password, SnapUser user) async {
    emit(const Loading());
    User? userFromFirebase = await authRepository.signUp(email: email, password: password);
    if(userFromFirebase != null) {
      await userRepository.createUser(user);
      emit(const Saved());
    } else {
      emit(const SignUpState.error('Register error'));
    }
  }
}