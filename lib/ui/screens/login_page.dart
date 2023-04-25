import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_explorer/blocs/user_cubit.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          TextFormField(
            controller: usernameController,
          ),
          TextFormField(
            controller: passwordController,
          ),
          ElevatedButton(
              onPressed: () async {
                await context.read<UserCubit>().login(usernameController.text, passwordController.text);
              },
              child: Text('Se connecter'))
        ],
      ),
    ));
  }
}
