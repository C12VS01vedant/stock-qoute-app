abstract class Failure {
  final String message;
  const Failure(this.message);
}

class DatabaseFailure extends Failure {
  DatabaseFailure({required String message}) : super(message);
}

class ServerFailure extends Failure {
  const ServerFailure({required String message, }) : super(message);
}