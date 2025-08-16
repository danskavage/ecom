class TFirebaseException implements Exception {
  final String code;

  TFirebaseException(this.code);

  String get message {
    switch (code) {
      case 'unknown':
        return 'An unknown Firebase error occured. Please try again.';
      case 'invalid-customer-token':
        return 'The customer token format is incorrect. Please check your customer token.';
      case 'customer-token-mismatch':
        return 'The customer token corresponds to a different audience';
      case 'user-disabled':
        return 'The user account has been disabled';
      case 'user-not-found':
        return 'No user found for the given email or UID';
      case 'invalid-email':
        return 'The email provided is invalid. Please enter a valid email.';
      case 'email-already-in-use':
        return 'The email provided is already registered. Please use a different email';
      case 'wrong-password':
        return 'Incorrect password. Please check your password and try again.';
      case 'weak-password':
        return 'The password is too weak. Please choose a stronger password.';
      case 'provider-already-linked':
        return 'The account is already linked with another provider.';

      default:
        return 'An unexpected Firebase error occured. Please try again.';
    }
  }
}
