import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_explorer/blocs/profile_cubit.dart';
import 'package:movie_explorer/blocs/profile_state.dart';
import 'package:movie_explorer/models/data_state.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state.dataState == DataState.loaded) {
            firstnameController.text = state.profile!.firstname;
            lastnameController.text = state.profile!.lastname;
          }
        },
        builder: (context, state) {
          switch (state.dataState) {
            case DataState.loading:
              return SizedBox(
                  height: MediaQuery.of(context).size.height, child: const Center(child: CircularProgressIndicator()));
            case DataState.error:
              return const Center(
                child: Text('Une erreur est survenue, veuillez recommencer'),
              );
            case DataState.loaded:
              return Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: firstnameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Le champs doit être renseigné';
                        } else {
                          return null;
                        }
                      },
                    ),
                    TextFormField(
                      controller: lastnameController, // Lien avec le controleur
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Le champs doit être renseigné';
                        } else {
                          return null;
                        }
                      },
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            final String firstname = firstnameController.text;
                            final String lastname = lastnameController.text;
                            context.read<ProfileCubit>().saveProfile(firstname, lastname);
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Text('Enregistrer'))
                  ],
                ),
              );
          }
        },
      ),
    );
  }
}
