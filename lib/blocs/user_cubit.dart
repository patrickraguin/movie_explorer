import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_explorer/repositories/user_repository.dart';

class UserCubit extends Cubit<bool> {
  UserCubit(this.userRepository) : super(false);

  final UserRepository userRepository;

  Future<void> login(String username, String password) async {
    try {
      await userRepository.login(username, password);
      emit(true);
    } catch (e) {
      log(e.toString());
      emit(false);
    }
  }
}
