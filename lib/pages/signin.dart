// ignore_for_file: sort_child_properties_last

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:helper/pages/verification.dart';
import 'package:velocity_x/velocity_x.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

String greeting = "";
DateTime now = DateTime.now();
greet() {
  int hours = now.hour;

  if (hours >= 1 && hours <= 12) {
    greeting = "Good Morning";
  } else if (hours >= 12 && hours <= 16) {
    greeting = "Good Afternoon";
  } else if (hours >= 16 && hours <= 21) {
    greeting = "Good Evening";
  } else if (hours >= 21 && hours <= 24) {
    greeting = "Good Night";
  }
  print(greeting);
  return greeting;
}

class _SignInState extends State<SignIn> {
  final _key = GlobalKey<FormState>();
  String number = "";
  final snackBar = SnackBar(
      content: "Please Wait".text.make(),
      action: SnackBarAction(
        label: "Okay",
        onPressed: () {},
      ));
  @override
  void initState() {
    super.initState();
    greet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            "$greeting".text.headline4(context).bold.make(),

            "Welcome".text.headline5(context).bold.make(),
            "to".text.make(),
            "ISL".text.headline3(context).bold.make(),
            "International Students Guide London".text.bold.make(),
            // "$greet()".text.make(),
            const SizedBox(
              height: 50,
            ),
            // Sign In using phone number
            Form(
              key: _key,
              // number Input
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: "+44 0123456789",
                        border: OutlineInputBorder(),
                        labelText: "Enter Phone Number"),
                    // validating number
                    validator: (value) {
                      if (value!.isEmpty || value.length < 9) {
                        return ("Enter Valid Phone Number");
                      } else {
                        return null;
                      }
                    },
                    // on saved
                    onSaved: (newValue) {
                      setState(() {
                        number = newValue!;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Verify phone number
                  ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll((Colors.black))),
                      onPressed: () async {
                        const CircularProgressIndicator();
                        if (_key.currentState!.validate()) {
                          // call verification
                          _key.currentState!.save();

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                          FirebaseAuth.instance.verifyPhoneNumber(
                              phoneNumber: number,
                              verificationCompleted: (_) {},
                              verificationFailed: (e) {
                                const SnackBar(
                                  content: Text("Unknown Error Ocurred"),
                                );
                              },
                              codeSent: (String verificationID, int? token) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Verification(
                                              VerificationId: verificationID,
                                              Number: number,
                                            )));
                              },
                              codeAutoRetrievalTimeout: (e) {
                                const SnackBar(
                                  content: Text("Unknown Error Ocurred"),
                                );
                              });
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      child: const SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Verify ",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      )),
                  const Text("or"),
                  // Sign in using google
                  TextButton(
                      onPressed: () => {
                            AuthService().signInWithGoogle(),
                            ScaffoldMessenger.of(context).showSnackBar(snackBar)
                          },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.network(
                              "https://1000logos.net/wp-content/uploads/2016/11/New-Google-Logo.jpg",
                              width: 35,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              "Sign In With Google ",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 17),
                            ),
                          ],
                        )),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10)),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AuthService {
  signInWithGoogle() async {
    // Sign in with google
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    // get details
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    // create new user
    final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);
    // actual sign in
    return await FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((value) => {print(value)})
        .onError((error, stackTrace) => {print(error)});
  }
}
