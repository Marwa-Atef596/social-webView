import 'package:easacc_task/home/screens/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../logic/auth_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state.status == AppStatus.loading) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => const Center(
                    child: CircularProgressIndicator(color: Colors.blue),
                  ),
                );
              }
              if (state.status == AppStatus.error) {
                Navigator.pop(context); // close loading
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage!)),
                );
              }
              if (state.status == AppStatus.authenticated) {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => SettingsPage()),
                );
              }
            },
            child: BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
              final width = MediaQuery.of(context).size.width;
              final height = MediaQuery.of(context).size.height;

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // GOOGLE BUTTON
                    Container(
                      width: width * 0.85,
                      height: height * 0.065,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border:
                            Border.all(color: Colors.grey.shade400, width: 1.2),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () =>
                            context.read<AuthCubit>().signInWithGoogle(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/google.png',
                              width: 28,
                              height: 28,
                            ),
                            SizedBox(width: 12),
                            Text(
                              'Login with Google',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: width * 0.045,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.03),

                    // FACEBOOK BUTTON
                    Container(
                      width: width * 0.85,
                      height: height * 0.065,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border:
                            Border.all(color: Colors.grey.shade400, width: 1.2),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () =>
                            context.read<AuthCubit>().signInWithFacebook(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/facebook.png',
                              width: 28,
                              height: 28,
                            ),
                            SizedBox(width: 12),
                            Text(
                              'Login with Facebook',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: width * 0.045,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
