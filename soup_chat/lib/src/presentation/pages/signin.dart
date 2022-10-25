import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soup_chat/src/data/repositories/auth_repository.dart';
import 'package:soup_chat/src/data/repositories/user_repository.dart';
import 'package:soup_chat/src/domain/entities/user.dart';
import 'package:soup_chat/src/presentation/pages/signin/signin_cubit.dart';
import 'package:soup_chat/src/presentation/pages/signin/signin_state.dart';

import '../bootstrap.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final FocusScopeNode _focusScopeNode = FocusScopeNode();
  final _controllerEmail = TextEditingController();
  final _controllerPassword = TextEditingController();
  final UserRepository? userRepository = UserRepository.getInstance();
  final AuthRepository? authRepository = AuthRepository.getInstance();
  SignInCubit? cubit;

  void _handleSubmitted(String value) {
    _focusScopeNode.nextFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<UserRepository?>(
            create: (context) => UserRepository.getInstance(),
          ),
          RepositoryProvider<AuthRepository?>(
            create: (context) => AuthRepository.getInstance(),
          ),
        ],
        child: BlocProvider(
          create: (context) {
            cubit = SignInCubit(
                userRepository:
                RepositoryProvider.of<UserRepository>(context),
                authRepository:
                RepositoryProvider.of<AuthRepository>(context));
            return cubit!;
          },
          child: BlocConsumer<SignInCubit, SignInState>(
            listener: (context, state) {
              if (state is Error) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('Error')))
                    .closed
                    .then((reason) {});
              } else if (state is Loading) {
                setState(() {
                  //displayLoader = true;
                });
              }
            },
            builder: (context, state) {
              if (state is Success) {
                return Bootstrap();
              }
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: Column(
                  children: [
                    Divider(height: MediaQuery.of(context).size.height / 8),
                    Form(
                      key: _formKey,
                      child: FocusScope(
                        node: _focusScopeNode,
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Column(
                                  children: [
                                    const Text(
                                      "Sign In",
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      "And start playing",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40),
                                  child: TextFormField(
                                    onTap: () {},
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: _handleSubmitted,
                                    controller: _controllerEmail,
                                    validator: (value) {
                                      if (value != null && value.isEmpty) {
                                        return 'Invalid email';
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                        enabledBorder: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 0.5),
                                        ),
                                        hintText: 'Email'),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 40),
                              child: TextFormField(
                                obscureText: true,
                                onTap: () {},
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: _handleSubmitted,
                                controller: _controllerPassword,
                                validator: (value) {
                                  if (value != null && value.isEmpty) {
                                    return 'Invalid password';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    enabledBorder: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 0.5),
                                    ),
                                    hintText: 'Password'),
                              ),
                            ),
                            const Divider(),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 40),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: MaterialButton(
                                  minWidth: double.infinity,
                                  height: 60,
                                  onPressed: () {
                                    if (_formKey.currentState != null &&
                                        _formKey.currentState!.validate()) {
                                      SnapUser user = SnapUser(
                                          email: _controllerEmail.text);
                                      cubit?.loginUser(_controllerEmail.text,
                                          _controllerPassword.text, user);
                                    }
                                  },
                                  color: Colors.blueAccent[400],
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(40)),
                                  child: const Text(
                                    "Sign In",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: Colors.white70),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      )
    );
  }
}