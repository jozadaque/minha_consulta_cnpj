abstract class ResultException implements Exception {}

class Exception404 implements ResultException {}

class ExceptionNotFounded implements ResultException {}

class RepositoryException implements ResultException {
  final String? message;

  RepositoryException(this.message);
}
