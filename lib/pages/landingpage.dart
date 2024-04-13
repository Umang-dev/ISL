import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:velocity_x/velocity_x.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            'Welcome to International Student Guide London!'
                .text
                .center
                .xl
                .black
                .bold
                .make(),
            Image.asset("assets/landingpage.jpeg"),
            SizedBox(
              height: 10,
            ),
            "Empowering Your Student Journey in the Heart of the UK"
                .text
                .bold
                .xl
                .make(),
            SizedBox(
              height: 10,
            ),
            """Navigate the bustling metropolis of London with ease using our comprehensive guide tailored specifically for international students. Whether you're embarking on your academic journey, settling into student life, or exploring the vibrant culture of this global city, our app is your indispensable companion"""
                .text
                .xl
                .make(),
            SizedBox(
              height: 20,
            ),
            "Key Features:".text.xl.bold.make(),
            SizedBox(
              height: 20,
            ),
            """1. BRP Card Assistance: Streamline the process of obtaining your Biometric Residence Permit (BRP) card with step-by-step guidance and essential resources."""
                .text
                .xl
                .make(),
            SizedBox(
              height: 10,
            ),
            """2. Accommodation Finder: Discover the perfect student accommodation tailored to your preferences and budget, ensuring a comfortable and convenient living experience."""
                .text
                .xl
                .make(),
            SizedBox(
              height: 10,
            ),
            """3. Bank Account Setup: Simplify the complexities of opening a bank account in the UK with expert advice and assistance at your fingertips."""
                .text
                .xl
                .make(),
            SizedBox(
              height: 20,
            ),
            "Explore Your Surroundings:".text.xl.bold.make(),
            SizedBox(
              height: 10,
            ),
            """Navigate London like a local with our interactive map feature, providing real-time information on nearby banks, restaurants, universities, and more. Whether you're looking for a cozy café to study in or need to locate the nearest ATM, our map has you covered."""
                .text
                .xl
                .make()
          ],
        ),
      ),
    ));
  }
}

Widget headTitle(String text) {
  return text.text.bold.xl.make();
}

Widget infoText(String text) {
  return text.text.xl.make();
}

Widget urlOpen(String url) {
  return InkWell(
    onTap: () async {
      await launchUrlString(url);
    },
    child: Text(
      url,
      style: const TextStyle(color: Colors.blue, fontSize: 16),
    ),
  );
}
