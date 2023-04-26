import 'package:dio/dio.dart';
import 'package:movie_explorer/models/token.dart';
import 'package:movie_explorer/repositories/preferences_repository.dart';

import '../models/profile.dart';

class UserRepository {
  UserRepository(this.preferencesRepository);

  final dio = Dio(BaseOptions(baseUrl: 'https://movies-backend-ykdv.onrender.com'));

  final PreferencesRepository preferencesRepository;
  Token? token;

  Future<bool> init() async {
    token = await preferencesRepository.loadToken();
    return token != null;
  }

  Future<void> login(String username, String password) async {
    try {
      final response = await dio.post('/users/login', data: {
        'username': username,
        'password': password,
      });

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        token = Token.fromJson(data);
        preferencesRepository.saveToken(token!);
      } else {
        throw Exception();
      }
    } on DioError catch (_) {
      throw Exception();
    }
  }

  Future<void> rating(int movieId, double value) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer ${token?.accessToken}';
      await dio.post('/rating', data: {
        'movieId': movieId,
        'rating': 5,
      });
    } on DioError catch (e) {
      if (e.response?.statusCode == 403) {
        if (token == null) {
          throw Exception();
        }
        await _refreshToken();
        await rating(movieId, value);
      } else {
        throw Exception();
      }
    }
  }

  Future<void> _refreshToken() async {
    try {
      final response = await dio.post('/users/refreshToken', data: {
        'refresh_token': token!.refreshToken,
      });
      final data = response.data as Map<String, dynamic>;
      token = Token.fromJson(data);
      preferencesRepository.saveToken(token!);
    } on DioError catch (e) {
      if (e.response?.statusCode == 403) {
        token = null;
        preferencesRepository.removeToken();
      } else {
        throw Exception();
      }
    }
  }

  Future<void> updateProfile(Profile profile) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer ${token?.accessToken}';
      await dio.post('/profile', data: profile.toJson());
    } on DioError catch (e) {
      if (e.response?.statusCode == 403) {
        if (token == null) {
          throw Exception();
        }
        await _refreshToken();
        await updateProfile(profile);
      } else {
        throw Exception();
      }
    }
  }

  Future<Profile> fetchProfile() async {
    try {
      dio.options.headers['Authorization'] = 'Bearer ${token?.accessToken}';
      final response = await dio.get('/profile');
      return Profile.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response?.statusCode == 403) {
        if (token == null) {
          throw Exception();
        }
        await _refreshToken();
        return await fetchProfile();
      } else {
        throw Exception();
      }
    }
  }
}
