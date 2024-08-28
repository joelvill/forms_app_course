import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/register/register_cubit.dart';
import '../widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo Usuario'),
      ),
      body: BlocProvider(
        create: (context) => RegisterCubit(),
        child: const _RegisterView(),
      ),
    );
  }
}

class _RegisterView extends StatelessWidget {
  const _RegisterView();

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FlutterLogo(
                size: 100,
              ),
              _RegisterForm(),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RegisterForm extends StatefulWidget {
  const _RegisterForm();

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final registerCubit = context.watch<RegisterCubit>();

    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextFormField(
            label: 'Nombre de usuario',
            onChanged: (value) {
              registerCubit.usernameChanged(value);
              formKey.currentState?.validate();
            },
            validator: (value) {
              if (value == null || value.isEmpty || value.trim().isEmpty) {
                return 'Campo requerido';
              }
              if (value.length < 6) {
                return 'El nombre de usuario debe tener al menos 6 caracteres';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20.0,
          ),
          CustomTextFormField(
            label: 'Correo electrónico',
            onChanged: (value) {
              registerCubit.emailChanged(value);
              formKey.currentState?.validate();
            },
            validator: (value) {
              if (value == null || value.isEmpty || value.trim().isEmpty) {
                return 'Campo requerido';
              }
              // if (!RegExp(
              //         r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
              //     .hasMatch(value)) {
              //   return 'El correo electrónico no es válido';
              // }
              final emailRegExp = RegExp(
                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
              );

              if (!emailRegExp.hasMatch(value)) {
                return 'El correo electrónico no es válido';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20.0,
          ),
          CustomTextFormField(
            label: 'Contrasena',
            obscureText: true,
            onChanged: (value) {
              registerCubit.passwordChanged(value);
              formKey.currentState?.validate();
            },
            validator: (value) {
              if (value == null || value.isEmpty || value.trim().isEmpty) {
                return 'Campo requerido';
              }
              if (value.length < 6) {
                return 'La contraseña debe tener al menos 6 caracteres';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20.0,
          ),
          FilledButton.tonalIcon(
            onPressed: () {
              formKey.currentState!.validate();
              registerCubit.submitForm();
            },
            icon: const Icon(Icons.save),
            label: const Text('Crear Usuario'),
          ),
        ],
      ),
    );
  }
}
