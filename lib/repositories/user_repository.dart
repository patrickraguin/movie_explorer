import 'package:dio/dio.dart';
import 'package:movie_explorer/models/token.dart';
import 'package:movie_explorer/repositories/preferences_repository.dart';

class UserRepository {
  UserRepository(this.preferencesRepository);

  final dio = Dio(BaseOptions(baseUrl: 'https://movies-backend-ykdv.onrender.com'));

  final PreferencesRepository preferencesRepository;
  Token? token;

  Future<void> login(String username, String password) async {
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
  }

  Future<void> rating(int movieId, double value) async {
    final response = await dio.post('/rating', data: {
      'movieId': movieId,
      'value': value,
    });

    if (response.statusCode == 403) {
      if (token == null) {
        throw Exception();
      }
      await _refreshToken();
      await rating(movieId, value);
    } else {
      throw Exception();
    }
  }

  Future<void> _refreshToken() async {
    final response = await dio.post('/users/refreshToken', data: {
      'refresh_token': token!.refreshToken,
    });

    if (response.statusCode == 200) {
      final data = response.data as Map<String, dynamic>;
      token = Token.fromJson(data);
      preferencesRepository.saveToken(token!);
    } else if (response.statusCode == 403) {
      token = null;
      preferencesRepository.removeToken();
    } else {
      throw Exception();
    }
  }
}
