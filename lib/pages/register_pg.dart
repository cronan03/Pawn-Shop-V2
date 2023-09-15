import 'package:bpgc_pawn_shop/pages/loading.dart';
//import 'package:bpgc_pawn_shop/pages/user_info.dart';
//import 'package:bpgc_pawn_shop/pages/login_pg.dart';
import 'package:bpgc_pawn_shop/services/google_sign.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:bpgc_pawn_shop/components/button.dart';
import 'package:bpgc_pawn_shop/components/tf.dart';
import 'package:bpgc_pawn_shop/components/tile.dart';
import 'package:get/get.dart';
//import 'package:bpgc_pawn_shop/pages/user_info.dart';




class RegisterPage extends StatefulWidget {
 // final Function()? onTap;
  const RegisterPage({super.key,});

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  // sign user in method
  void signUserUp() async {



    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // try sign in
    try {
      if(passwordController.text == confirmpasswordController.text)
      {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: usernameController.text,
        password: passwordController.text,);
        Navigator.pop(context);
        Get.offAllNamed('/userinfo');
      }
      else if(passwordController.text != confirmpasswordController.text)
      {
        Navigator.pop(context);
        showErrorMessage("Passwords don't match.");
      }
      
      // pop the loading circle
     // Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      Navigator.pop(context);
      //show error
      showErrorMessage(e.code);
    }
  }

  // wrong email message popup
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  // wrong password message popup
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.pinkAccent,Colors.purpleAccent]
          )
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 25),
      
                // logo
                 Expanded(
                  flex: 3,
                  child: Center(
                    child: Image.asset(
                      "assets/fp2.png",
                      height: 400,
                    )
                  ),
                ),
      
                const SizedBox(height: 60),
      
                // welcome back, you've been missed!
                const Flexible(
                  flex: 1,
                  child: Text(
                    'The Official Pawn Shop of BPGC',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
      
                const SizedBox(height: 25),
      
                // username textfield
                Flexible(
                  flex: 1,
                  child: MyTextField(
                    controller: usernameController,
                    hintText: 'Email',
                    obscureText: false,
                  ),
                ),
      
                const SizedBox(height: 10),
      
                // password textfield
                Flexible(
                  flex: 1,
                  child: MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),
                ),
      
                const SizedBox(height: 10),

                // password textfield
                Flexible(
                  flex: 1,
                  child: MyTextField(
                    controller: confirmpasswordController,
                    hintText: 'Confirm Password',
                    obscureText: true,
                  ),
                ),
      
                const SizedBox(height: 10),
      
                // forgot password?
                // Flexible(
                //   flex: 1,
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 25.0),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.end,
                //       children: [
                //         Text(
                //           'Forgot Password?',
                //           style: TextStyle(color: Colors.grey[600]),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
      
                const SizedBox(height: 25),
      
                // sign in button
                Flexible(
                  flex: 1,
                  child: MyButton(
                    onTap: signUserUp,
                    text: "Sign Up",
                    //text2: "Sign Inn",
                    
                  ),
                ),
      
                const SizedBox(height: 25),
      
                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Flexible(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Flexible(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
      
                //const SizedBox(height: 50),
      
                // google + apple sign in buttons
                Flexible(
                  flex: 2,
                  child: Center(
                    child: SquareTile(
                      imagePath: 'assets/fp1.jpeg',
                      onTap: ()=> AuthService().signInGoogle(),
                      )
                      ),
                ),
                      
                  
                      
                   const SizedBox(height: 15),
                      
                  // not a member? register now
                  Flexible(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already a member?',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () => Get.off(() => const Loading(rt: '/login')),
                          child: const Text(
                            'Login now',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                              ],
                            ),
                ),
          ),
        ),
      );
  }
}