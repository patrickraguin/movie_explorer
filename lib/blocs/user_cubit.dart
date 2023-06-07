import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_explorer/repositories/user_repository.dart';

class UserCubit extends Cubit<bool> {
  UserCubit(this.userRepository) : super(false);

  final UserRepository userRepository;

  Future<void> init() async {
    try {
      emit(await userRepository.init());
    } catch(e) {
      emit(false);
      log(e.toString());
    }
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

  Future<void> rate(int movieId, double rating) async {
    try {
      await userRepository.rate(movieId, rating);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> logout() async {
    try {
      await userRepository.logout();
      emit(false);
    } catch (e) {
      log(e.toString());
    }
  }
}
