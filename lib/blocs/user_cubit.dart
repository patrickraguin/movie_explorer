import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_explorer/repositories/user_repository.dart';

class UserCubit extends Cubit<bool> {
  UserCubit(this.userRepository) : super(false);

  final UserRepository userRepository;

  Future<void> init() async {
    emit(await userRepository.init());
  }

  Future<void> login(String username, String password) async {
    try {
      await userRepository.login(username, password);
      emit(true);
    } catch (e) {
      log(e.toString());
      emit(false);
    }
  }

  Future<void> rate(int movieId) async {
    await userRepository.rating(movieId, 5);
  }

  Future<void> logout() async {
    await userRepository.logout();
    emit(false);
  }
}
