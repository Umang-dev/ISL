// ignore_for_file: non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helper/pages/homepage.dart';
import 'package:velocity_x/velocity_x.dart';

class Verification extends StatefulWidget {
  final String VerificationId;
  final String Number;
  const Verification(
      {Key? key, required this.VerificationId, required this.Number})
      : super(key: key);

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  final _key = GlobalKey<FormState>();
  String Code = "";
  final snackBar = SnackBar(
      content: "Please Wait".text.make(),
      action: SnackBarAction(
        label: "Okay",
        onPressed: () {},
      ));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify Your Phone Number"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              "Code Sent to Your Number".text.make(),
              widget.Number.text.bold.make(),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _key,
                // Code Input
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          hintText: "123456",
                          border: OutlineInputBorder(),
                          labelText: "Enter 6 Digit Code"),
                      // validating Code
                      validator: (value) {
                        if (value!.isEmpty || value.length < 6) {
                          return ("Enter Valid 6 Digit Code");
                        } else {
                          return null;
                        }
                      },
                      // on saved
                      onSaved: (newValue) {
                        setState(() {
                          Code = newValue!;
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
                            final credential = PhoneAuthProvider.credential(
                                verificationId: widget.VerificationId,
                                smsCode: Code);
                            try {
                              await FirebaseAuth.instance
                                  .signInWithCredential(credential);

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);

                              setState(() {});

                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Homepage()));
                            } catch (e) {
                              // ignore: avoid_print
                              print(e);
                            }
                          }
                        },
                        child: const SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: Center(
                              child: Text(
                            "Verify ",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          )),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
