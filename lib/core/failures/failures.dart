abstract class Failure {
  final String title;
  final String message;

  const Failure(this.title, this.message);

  List<Object> get props => [title, message];

  @override
  String toString() => 'Failure(title: $title, message: $message)';
}

class NoFailure extends Failure {
  NoFailure([super.title = '', super.message = '']);
}

class ServerFailure extends Failure {
  const ServerFailure(super.title, super.message);
}

class CacheFailure extends Failure {
  const CacheFailure({required String title, required String message})
    : super(title, message);
}

class CommonFailure extends Failure {
  const CommonFailure(super.title, super.message);
}

class InternetFailure extends Failure {
  const InternetFailure(super.title, super.message);
}

class AuthenticationFailure extends Failure {
  const AuthenticationFailure(super.title, super.message);
}
