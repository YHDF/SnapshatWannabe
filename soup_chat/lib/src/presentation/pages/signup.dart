import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soup_chat/src/domain/entities/user.dart';
import 'package:soup_chat/src/presentation/pages/signup/signup_cubit.dart';
import 'package:soup_chat/src/presentation/pages/signup/signup_state.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/user_repository.dart';
import '../bootstrap.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}
class _SignupPageState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final FocusScopeNode _focusScopeNode = FocusScopeNode();
  final _controllerEmail = TextEditingController();
  final _controllerPassword = TextEditingController();
  final _controllerPseudo = TextEditingController();
  final _controllerBirthDate = TextEditingController();
  final AuthRepository? authRepository = AuthRepository.getInstance();
  SignUpCubit? cubit;

  void _handleSubmitted(String value) {
    _focusScopeNode.nextFocus();
  }

  @override
  Widget build(BuildContext context) {
    if(authRepository!.isSignedIn()) {
      return Bootstrap();
    } else {
      return Scaffold(
        resizeToAvoidBottomInset: false,
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
              cubit = SignUpCubit(
                  userRepository:
                      RepositoryProvider.of<UserRepository>(context),
                  authRepository:
                      RepositoryProvider.of<AuthRepository>(context));
              return cubit!;
            },
            child: BlocConsumer<SignUpCubit, SignUpState>(
              listener: (context, state) {
                if (state is Error) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('Erreur')))
                      .closed
                      .then((reason) {});
                } else if (state is Loading) {
                  setState(() {
                    // TODO loading animation
                  });
                }
              },
              builder: (context, state) {
                if (state is Saved) {
                  return Bootstrap();
                }
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                                        "Sign Up",
                                        style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "It's free!",
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
                                      controller: _controllerPseudo,
                                      validator: (value) {
                                        if (value != null && value.isEmpty) {
                                          return 'Nickname is required';
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
                                          hintText: 'Nickname'),
                                    ),
                                  ),
                                  const Divider(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40),
                                    child: TextFormField(
                                      onTap: () {},
                                      textInputAction: TextInputAction.next,
                                      onFieldSubmitted: _handleSubmitted,
                                      controller: _controllerEmail,
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (value) {
                                        if (value != null && value.isEmpty) {
                                          return 'Email is required';
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
                                          hintText: 'Email Address'),
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
                                      return 'Password is required';
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
                                            nickname: _controllerPseudo.text,
                                            avatar: "",
                                            birthDate: _controllerBirthDate.text,
                                            email: _controllerEmail.text);
                                        cubit?.registerUser(
                                            _controllerEmail.text,
                                            _controllerPassword.text,
                                            user);
                                      }
                                    },
                                    color: Colors.redAccent[400],
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    child: const Text(
                                      "Sign Up",
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
        ),
      );
    }
  }
}
