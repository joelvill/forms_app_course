import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../infrastructure/inputs/inputs.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterFormState> {
  RegisterCubit() : super(const RegisterFormState());

  void submitForm() {
    emit(
      state.copyWith(
        status: FormStatus.validating,
        username: Username.dirty(value: state.username.value),
        password: Password.dirty(value: state.password.value),
        email: Email.dirty(value: state.email.value),
        isvalid: Formz.validate([state.username, state.password]),
      ),
    );

    // ignore: avoid_print
    print('Submit: $state');
  }

  void usernameChanged(String value) {
    final Username username = Username.dirty(value: value);
    emit(
      state.copyWith(
        username: username,
        isvalid: Formz.validate(
          [username, state.password],
        ),
      ),
    );
  }

  void emailChanged(String value) {
    final Email email = Email.dirty(value: value);
    emit(
      state.copyWith(
        email: email,
        isvalid: Formz.validate(
          [email, state.username, state.password],
        ),
      ),
    );
  }

  void passwordChanged(String value) {
    final Password password = Password.dirty(value: value);
    emit(
      state.copyWith(
        password: password,
        isvalid: Formz.validate(
          [password, state.username],
        ),
      ),
    );
  }
}
