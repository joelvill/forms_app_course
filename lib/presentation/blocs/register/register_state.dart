part of 'register_cubit.dart';

enum FormStatus { invalid, valid, validating, posting }

class RegisterFormState extends Equatable {
  final FormStatus status;
  final bool isValid;
  final Username username;
  final Password password;
  final Email email;

  const RegisterFormState({
    this.status = FormStatus.invalid,
    this.isValid = false,
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.email = const Email.pure(),
  });

  RegisterFormState copyWith({
    FormStatus? status,
    bool? isvalid,
    Username? username,
    Password? password,
    Email? email,
  }) {
    return RegisterFormState(
      status: status ?? this.status,
      isValid: isvalid ?? isValid,
      username: username ?? this.username,
      password: password ?? this.password,
      email: email ?? this.email,
    );
  }

  @override
  List<Object> get props => [status, username, password, email, isValid];
}
