class InvalidApiKeyException implements Exception {
  final String message;

  InvalidApiKeyException(this.message);
}


class WeakPasswordException implements Exception {
  final String message;

  WeakPasswordException(this.message);
}

class EmailAlreadyInUseException implements Exception {
  final String message;

  EmailAlreadyInUseException(this.message);
}

class UserNotFoundException implements Exception {
  final String message;

  UserNotFoundException(this.message);
}