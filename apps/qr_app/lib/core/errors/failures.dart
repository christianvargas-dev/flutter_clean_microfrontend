abstract class Failure {
  final String? message;

  const Failure([this.message]);
}





class ScanFailure extends Failure {
  const ScanFailure([String? message]) : super(message);
}

class AuthFailure extends Failure {
  const AuthFailure([String? message]) : super(message);
}

class StorageFailure extends Failure {
  const StorageFailure([String? message]) : super(message);
}



