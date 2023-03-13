import 'package:auth_app/cubits/cubits.dart';
import 'package:auth_app/repositories/auth_repository.dart';
import 'package:auth_app/screens/signUp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatelessWidget {
  static Page page() =>  MaterialPage<void>(child: SignInScreen());

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: const Text('Login'), backgroundColor: Colors.green,),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocProvider(
            create: (_) => SignInCubit(context.read<AuthRepository>()),
            child: const LoginForm(),
          )),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInCubit, SignInState>(
      listener: (context, state) {
        if (state.status == SignInStatus.error) {

        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const _EmailInput(),
          const SizedBox(
            height: 8,
          ),
          const _PasswordInput(),
          const SizedBox(
            height: 8,
          ),
          const _LoginButton(),
          const SizedBox(
            height: 8,
          ),
          const _LognupButton()
        ],
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          onChanged: (email) {
            context.read<SignInCubit>().emailChanged(email);
          },
          decoration: InputDecoration(labelText: 'Email'),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          onChanged: (password) =>
              context.read<SignInCubit>().passwordChanged(password),
          obscureText: true,
          decoration: const InputDecoration(
            labelText: 'Password',
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return state.status == SignInStatus.submitting
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  style:
                      ElevatedButton.styleFrom( primary: Colors.green[400],fixedSize: const Size(225, 40),),
                  child: const Text('Sign In',),
                  onPressed: () {
                    context.read<SignInCubit>().loginWithCredentials();
                  },
                );
        });
  }
}

class _LognupButton extends StatelessWidget {
  const _LognupButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: Colors.green[700], fixedSize: const Size(200, 40)),
      child: const Text(
        'Sign Up',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () => Navigator.of(context).push<void>(SignUpScreen.route()),
    );
  }
}
