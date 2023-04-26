import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_explorer/blocs/profile_state.dart';

import '../models/profile.dart';
import '../repositories/user_repository.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UserRepository userRepository;

  ProfileCubit(this.userRepository) : super(ProfileState.loading());

  Future<void> loadProfile() async {
    emit(ProfileState.loading());
    try {
      emit(ProfileState.loaded(await userRepository.fetchProfile()));
    } catch (e) {
      emit(ProfileState.error());
    }
  }

  Future<void> saveProfile(String firstname, String lastname) async {
    emit(ProfileState.loading());
    try {
      final Profile profile = Profile(firstname, lastname);
      await userRepository.updateProfile(profile);
      emit(ProfileState.loaded(profile));
    } catch (e) {
      emit(ProfileState.error());
    }
  }
}
