import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthCubit() : super(AuthState.initial());

  Future<void> signInWithGoogle() async {
    emit(state.copyWith(status: AppStatus.loading));
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        emit(state.copyWith(status: AppStatus.unauthenticated));
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);

      final user = userCredential.user!;
      emit(state.copyWith(
        status: AppStatus.authenticated,
        userName: user.displayName ?? user.email,
        userEmail: user.email ?? '',
      ));
    } catch (e) {
      emit(state.copyWith(status: AppStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> signInWithFacebook() async {
    emit(state.copyWith(status: AppStatus.loading));
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(result.accessToken!.tokenString);
        final userCredential =
            await _auth.signInWithCredential(facebookAuthCredential);

        final user = userCredential.user!;
        emit(state.copyWith(
          status: AppStatus.authenticated,
          userName: user.displayName ?? user.email,
          userEmail: user.email ?? '',
        ));
      } else {
        emit(state.copyWith(status: AppStatus.unauthenticated));
      }
    } catch (e) {
      emit(state.copyWith(status: AppStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await GoogleSignIn().signOut();
    await FacebookAuth.instance.logOut();
    emit(state.copyWith(
        status: AppStatus.unauthenticated, userName: null, userEmail: null));
  }
}
