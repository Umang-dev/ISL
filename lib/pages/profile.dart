import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:helper/pages/signin.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:velocity_x/velocity_x.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return profile(context, user);
  }
}

Widget numberScreen(user) {
  return Column(
    children: [
      const CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 40,
        // Display Google image or placeholder
        foregroundImage: NetworkImage(
            "https://img.freepik.com/premium-vector/man-avatar-profile-picture-vector-illustration_268834-538.jpg"),
      ),
      // Show Phone Number
      Text(user!.phoneNumber ?? ""),
    ],
  );
}

Widget googleSignin(user) {
  final user = FirebaseAuth.instance.currentUser;
  return Column(
    children: [
      CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 40,
        // Display Google image or placeholder
        foregroundImage: NetworkImage(user!.photoURL ??
            "https://img.freepik.com/premium-vector/man-avatar-profile-picture-vector-illustration_268834-538.jpg"),
      ),
      // If used google then shows email or no email
      Text(user.email ?? "No Email"),
      // If used google and have displaye name then shows  or not
      Text(user.displayName ?? ""),
      // If used phonenumber shows number  or not
      Text(user.phoneNumber ?? "")
    ],
  );
}

Widget profile(context, user) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            user!.phoneNumber == null ? googleSignin(user) : numberScreen(user),
            const SizedBox(
              height: 20,
            ),
            // Sign out Button
            InkWell(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
              },
              child: Container(
                width: MediaQuery.sizeOf(context).width / 2,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: "Sign out".text.white.center.bold.xl2.make(),
              ),
            ),
            SizedBox(height: 10),
            InkWell(
              onTap: () async {
                // await FirebaseAuth.instance.signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ContactUs()));
              },
              child: Container(
                width: MediaQuery.sizeOf(context).width / 2,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: "Contact Us".text.white.center.bold.xl2.make(),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Contact Us".text.make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "Have Questions?".text.xl.bold.make(),
              SizedBox(
                height: 20,
              ),
              Image.asset('assets/contact.png'),
              Row(
                children: [
                  Icon(
                    Icons.phone_rounded,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  "+1 2153269654".text.xl.bold.make()
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Icon(
                    Icons.mail,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  "umangusadadiya011@gmail.com".text.xl.bold.make()
                ],
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () async {
                  var url = Uri.parse(
                      "mailto:umangusadadiya011@gmail?subject=Have Questions&body=Write your Query");
                  await launchUrl(url);

                  if (await canLaunchUrl(url)) {
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10)),
                  child: "Contact Us".text.white.bold.make(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              "Please contact us for more details or any other technical issues."
                  .text
                  .xl
                  .make(),
            ],
          ),
        ),
      ),
    );
  }
}
