import 'package:auth_app/cubits/cubits.dart';
import 'package:auth_app/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SignUpScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('Sign Up'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocProvider<SignUpCubit>(
            create: (_) => SignUpCubit(context.read<AuthRepository>()),
            child: const SignupForm(),
          ),
        ));
  }
}

class SignupForm extends StatelessWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status == SignUpStatus.error) {}
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          _EmailInput(),
           SizedBox(
            height: 8,
          ),
          _PasswordInput(),
           SizedBox(
            height: 8,
          ),
          _SignUpButton()
        ],
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
        buildWhen: (previous, current) => previous.email != current.email,
        builder: (context, state) {
          return TextField(
            onChanged: (email) {
              context.read<SignUpCubit>().emailChanged(email);
            },
            decoration: const InputDecoration(labelText: 'Email'),
          );
        });
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
        buildWhen: (previous, current) => previous.password != current.password,
        builder: (context, state) {
          return TextField(
            obscureText: true,
            onChanged: (password) {
              context.read<SignUpCubit>().passwordChanged(password);
            },
            decoration: const InputDecoration(labelText: 'Password'),
          );
        });
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return state.status == SignUpStatus.submitting
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(primary: Colors.green ,fixedSize: const Size(200, 40)),
                  onPressed: () {
                    context.read<SignUpCubit>().signUpFormSubmitted();
                  },
                  child: const Text('Sign Up'));
        });
  }
}
