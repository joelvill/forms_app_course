part of 'register_cubit.dart';

enum FormStatus { invalid, valid, validating, posting }

class RegisterFormState extends Equatable {
  final FormStatus status;
  final String username;
  final String password;
  final String email;

  const RegisterFormState(
      {this.status = FormStatus.invalid,
      this.username = '',
      this.password = '',
      this.email = ''});

  RegisterFormState copyWith(
      {FormStatus? status, String? username, String? password, String? email}) {
    return RegisterFormState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      email: email ?? this.email,
    );
  }

  @override
  List<Object> get props => [status, username, password, email];
}
