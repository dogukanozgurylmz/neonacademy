import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  late FirebaseAuth firebaseAuth;
  void init() {
    firebaseAuth = FirebaseAuth.instance;
  }

  User? get currentUser => firebaseAuth.currentUser;

  Future<User?> signUp({
    required String userEmail,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: userEmail, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<User?> signIn({
    required String userEmail,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: userEmail, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return null;
    }
  }

  void sendEmailVerification() {
    currentUser!.sendEmailVerification();
  }

  Future<void> reload() async {
    await firebaseAuth.currentUser!.reload();
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  bool get emailVerified => currentUser!.emailVerified;
}
