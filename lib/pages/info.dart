// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:velocity_x/velocity_x.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DataInfo(
                                  data: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Divider(),
                                      headTitle('What a BRP is ?'),
                                      infoText(
                                          "A biometric residence permit (BRP) can be used to confirm your: identity, right to study, right to any public services or benefits you’re entitled to"),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      headTitle('What’s on your BRP ?'),
                                      infoText(
                                          "Your BRP will include: your name, date and place of birth your fingerprints and a photo of your face (this is your biometric information) your immigration status and any conditions of your stay whether you can access public funds, for example benefits and health services"),
                                      Image.asset('assets/Picture 1.jpg'),
                                      Image.asset('assets/Picture2.jpg'),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      headTitle('Where to collect BRP ?'),
                                      infoText(
                                          """Your actual visa, in the form of a Biometric Residence Permit (BRP), will need to be collected after arriving in the UK. Your BRP is the documentary evidence of your UK immigration permission.
Students starting in Lent or Easter terms should select to collect their BRP from the Post Office in their visa application. The decision letter you will receive with the outcome of your visa application will normally confirm the collection point; if not, please check your original application form for the location by logging into your UKVI account. You are advised to collect your BRP as soon as possible after arrival in the UK.
Students starting in Michaelmas Term will have the option of collecting their BRP from the University. Information for Michaelmas Term 2024 entry will be updated on this webpage at the relevant time.
"""),
                                      Image.asset('assets/Picture3.jpg'),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      headTitle(
                                          'If your BRP is lost or stolen:'),
                                      infoText(
                                          """You can report your biometric residence permit (BRP) lost or stolen from inside or outside the UK. You can only apply for a replacement from inside the UK. The Home Office will contact you within one working day of reporting it. You can get someone to report for you, for example a legal representative, a charity, employer, college or university. There are other ways to prove your immigration status while you wait for a replacement BRP.

Useful Links:"""),
                                      InkWell(
                                        onTap: () async {
                                          await launchUrlString(
                                              "https://www.gov.uk/biometric-residence-permits");
                                        },
                                        child: const Text(
                                          "https://www.gov.uk/biometric-residence-permits",
                                          style: TextStyle(
                                              color: Colors.blue, fontSize: 16),
                                        ),
                                      )
                                    ],
                                  ),
                                  Title:
                                      "Biometric residence permits (BRPs)")));
                    },
                    child: infoCard(context, "assets/Picture 1.jpg",
                        "Biometric residence permits (BRPs)"),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DataInfo(
                                    data: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Divider(),
                                        infoText(
                                            '''The National Insurance number is a number used in the United Kingdom in the administration of the National Insurance or social security system. It is also used for some purposes in the UK tax system.
You can apply for a National Insurance number if you:
⦁	live in the UK
⦁	have the right to work in the UK
⦁	are working, looking for work or have an offer to start work
You can start work before you receive your National Insurance number if you can prove you have the right to work in the UK.'''),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        headTitle(
                                            '''What documents you’ll need ?'''),
                                        infoText(
                                            '''If you have any of the following documents, get them ready before you start:
⦁	a passport from any country
⦁	a biometric residence permit (BRP)
⦁	a national identity card from an EU country or from Norway, Liechtenstein or Switzerland
You might need to enter information from one or more of these documents.
You can still apply if you do not have any of these documents, but you may need to attend an appointment in person to prove your identity.
'''),
                                        headTitle('''Prove your identity:
'''),
                                        infoText(
                                            '''If you can, you’ll need to take and upload:
⦁	a photo of yourself holding your passport
⦁	photos of other identity documents
You can use a smartphone, tablet or a digital camera.
How to apply for NI Number :
Use link: '''),
                                        InkWell(
                                          onTap: () async {
                                            await launchUrlString(
                                                "https://www.gov.uk/apply-national-insurance-number");
                                          },
                                          child: const Text(
                                            "https://www.gov.uk/apply-national-insurance-number",
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 16),
                                          ),
                                        ),
                                        infoText(
                                            '''After you apply, you’ll get an email with your application reference number. The email will tell you if you need to provide more proof of your identity. When you have proven your identity, it can take up to 16 working days to get your National Insurance number.''')
                                      ],
                                    ),
                                    Title: "National Insurance (NI) Number")));
                      },
                      child: infoCard(context, "assets/Picture3.jpg",
                          "National Insurance (NI) Number")),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DataInfo(
                                    data: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Divider(),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        headTitle('''What is Share Code ?'''),
                                        infoText(
                                            '''A share code is an online nine-digit alpha-numerical code provided by the UK government. It is used by non-UK nationals to verify their right to work. Each code is unique and can be shown to employers to demonstrate an individual’s immigration status and employment details.

The share code also shows the kind of work the employee is legally allowed to carry out and the length of time they can work for.  They were introduced as part of the UK immigration system to help employers during the hiring process post-Brexit.
'''),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        headTitle(
                                            '''How to get share code ?'''),
                                        infoText('''Link:'''),
                                        urlOpen(
                                            'https://www.gov.uk/view-prove-immigration-status')
                                      ],
                                    ),
                                    Title: "Share Code")));
                      },
                      child: infoCard(
                          context, "assets/Picture3.jpg", "Share Code")),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DataInfo(
                                    data: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Divider(),
                                        infoText(
                                            '''An NHS number is a 10-digit unique identifier assigned to every patient in England, Wales, and the Isle of Man. Here’s how it works and how you can use it:
⦁	Purpose: The NHS number helps healthcare staff and service providers identify you correctly and match your details to your health records. It ensures seamless access to your medical history and relevant information.
⦁	Generation:
⦁	You receive an NHS number either at birth or when you first access NHS care (usually by registering with a GP practice).
⦁	This number remains valid for life unless you’re assigned a new one due to reasons like adoption or gender reassignment.
⦁	Finding Your NHS Number:
⦁	Documents and Letters: You can find your NHS number in documents or letters sent by the NHS, such as prescriptions, test results, hospital referral letters, and appointment letters.
⦁	Online Services:
⦁	Use the Find your NHS number service online.
⦁	Log in to the NHS App (if you’ve registered) or some GP online services.
⦁	Contact Your GP Surgery:
⦁	Call your GP surgery and ask them for your NHS number.
⦁	You might need to prove your identity over the phone or visit the surgery with proof of identity.
⦁	Registration:
⦁	If you’ve never had NHS care or treatment, you can register with a GP surgery to get an NHS number.
⦁	During registration, you’ll be assigned an NHS number, which will be shown in your registration letter.
⦁	Entitlement to Services:
⦁	Having an NHS number doesn’t automatically grant free access to all NHS services. In England, some services may require payment.
If you’re denied care due to not knowing your NHS number, you can file a complaint with the NHS1234
Useful Link:'''),
                                        urlOpen(
                                            'https://www.nhs.uk/nhs-services/online-services/find-nhs-number/')
                                      ],
                                    ),
                                    Title: "NHS Number")));
                      },
                      child: infoCard(
                          context, "assets/Picture3.jpg", "NHS Number"))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DataInfo(
                                  data: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                          child:
                                              Image.asset('assets/Pic4.jpeg')),
                                      headTitle('''Oyster Card:'''),
                                      infoText(
                                          '''⦁	An Oyster card is a convenient smart card used for public transportation in London. It allows you to travel seamlessly across various modes of transport, including buses, trams, the London Underground (Tube), Docklands Light Railway (DLR), and some National Rail services.
⦁	Here’s how to get an 18+ Student Oyster photocard:
⦁	You must be 18 or over, a student, and living in a London borough during term time.
⦁	Enrol at a school, college, or university registered on the TfL scheme or be on a mandatory work placement in London.
⦁	Apply online through the TfL website after completing your campus enrolment.
⦁	Pay a £20 fee for the card, which remains valid until the end of your course.
⦁	Benefits:
⦁	Save 30% on adult-rate Travelcards and Bus & Tram Pass season tickets.
Link:'''),
                                      urlOpen(
                                          'https://tfl.gov.uk/fares/free-and-discounted-travel/18-plus-student-oyster-photocard'),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      headTitle('''TFL Charges:'''),
                                      infoText('''⦁	Buses and Trams:
⦁	Adult pay-as-you-go fare: £1.75 per journey.
⦁	Tube services:
⦁	Adult pay-as-you-go fare: £3.20 per journey.
⦁	Remember to touch in at the start of your journey and touch out at the end using yellow card.
'''),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      headTitle('''⦁	What Is a Railcard?'''),
                                      infoText(
                                          '''⦁	A Railcard is a magical pass that unlocks up to 1/3 off the price of most train fares.
⦁	There’s a Railcard for everyone, whether you’re a student, senior, frequent traveller, or even a veteran.'''),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      headTitle('⦁	Types of Railcards:'),
                                      infoText(
                                          '''⦁	16-25 Railcard: For those aged 16-25, enjoy a 1/3 discount on rail fares for days out, family visits, and festivals.
⦁	Senior Railcard: If you’re 60 or over, save 1/3 on rail fares for outings, holidays, and theatre trips.
⦁	Two Together Railcard: Travel with a partner? Get an average annual saving of £129 plus special partner discounts.
⦁	Disabled Persons Railcard: If you have a disability that makes train travel challenging, this Railcard is for you.
⦁	26-30 Railcard: Valid for those aged 26-30. For just £30, save 1/3 on most rail fares across Britain for a year.
⦁	Family & Friends Railcard: Kids aged 5-15 get a whopping 60% discount on fares! Up to four adults and four children can travel on one card.
⦁	Network Railcard: Ideal for those traveling in the South East. Enjoy an average annual saving of £191 plus partner discounts.
⦁	Veterans Railcard: If you’re a UK Armed Forces veteran, you may qualify for this Railcard and save 1/3 on most rail fares.
'''),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      headTitle('''⦁	How to Apply:'''),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Divider(),
                                          infoText(
                                              '''⦁	You can apply online for a digital or physical Railcard.
⦁	Visit a staffed station ticket office for a physical Railcard.
⦁	You can buy a Railcard for yourself or someone else.
⦁	For certain types of Railcards, you’ll need to provide proof of identity (e.g., passport or driver’s license).
'''),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          headTitle(
                                              '''⦁	Using Your Railcard:'''),
                                          infoText('''⦁	Get your Railcard.
⦁	Buy your discounted train tickets.
⦁	Always have your Railcard with you when you travel (whether it’s on your phone or in your wallet).
⦁	Enjoy savings on most Standard fares (minimum fare applies on weekdays).
'''),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          headTitle(
                                              '''⦁	Renewing Your Railcard:'''),
                                          infoText(
                                              '''⦁	Renew your Railcard online.
⦁	If you’re curious about the digital Railcard download code, cheap train tickets, logging into your account, or COVID-related refunds, we’ve got you covered!
'''),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          headTitle('''Railcard Linking:'''),
                                          infoText(
                                              '''⦁	If you have a Railcard, you can link it to your Oyster card for discounted train travel.
⦁	Using the Oyster App:
⦁	Download and install the official Oyster app on your smartphone.
⦁	Log into your account or sign up.
⦁	Navigate to the ‘Railcard’ section within the app.
⦁	Input your Railcard details to link it to your Oyster card.
⦁	In Person:
⦁	Visit an Underground station or a National Rail ticket office.
⦁	Take your Oyster card and your National Rail discount card.
⦁	Ask the staff to add your discount entitlement to your Oyster card.
Your Railcard discount will be valid until the expiry of the Railcard itself
'''),
                                          urlOpen(
                                              "https://www.16-25railcard.co.uk/"),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Center(
                                              child: Image.asset(
                                                  'assets/Pic5.jpeg')),
                                        ],
                                      )
                                    ],
                                  ),
                                  Title:
                                      "Student 18+ oyster card and Railcard")));
                    },
                    child: infoCard(context, "assets/Pic4.jpeg",
                        "Student 18+ oyster card and Railcard"),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DataInfo(
                                  data: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Divider(),
                                      Center(
                                          child:
                                              Image.asset('assets/Pic6.jpeg')),
                                      infoText(
                                          '''Opening a bank account in the UK as an international student is essential for managing your finances during your studies. Here are the steps and some recommended bank accounts:
'''),
                                      headTitle(
                                          '''⦁	Why Open a UK Bank Account?'''),
                                      infoText('''
⦁	Currency Conversion: Managing your finances from your home country account can be expensive due to currency conversion fees.
⦁	Local Payments: Employers and accommodation providers prefer payments from a UK account.
⦁	Direct Debits: Setting up recurring payments (e.g., phone contracts, gym memberships) is easier with a UK account.
⦁	Local Support: Dealing with account issues locally is more convenient.
'''),
                                      headTitle('''⦁	Documents Needed:'''),
                                      infoText(
                                          '''⦁	Passport: An in-date passport.
⦁	Visa: Proof of a valid visa.
⦁	Bank Statement: A recent bank statement from your home bank.
⦁	Proof of Address: Evidence of your UK or overseas address (check with the bank).
⦁	Student ID or Acceptance Letter: From your university.
'''),
                                      headTitle(
                                          '''⦁	Recommended Bank Accounts:'''),
                                      infoText('''⦁	No monthly account fee.
⦁	Manage your account via app, computer, phone, or in-branch.
⦁	Limited access to credit (no credit cards, loans, or mortgages).
⦁	Exclusive accommodation offers for settling into student life.
'''),
                                      InkWell(
                                        onTap: () async {
                                          await launchUrlString(
                                              "https://www.hsbc.co.uk/current-accounts/products/international-student/");
                                        },
                                        child: const Text(
                                          "Lloyds Classic Account⦁	, ⦁	NatWest Select Account⦁	 and⦁	 ⦁	Barclays Student Additions Account⦁	 are also good options.",
                                          style: TextStyle(
                                              color: Colors.blue, fontSize: 16),
                                        ),
                                      )
                                    ],
                                  ),
                                  Title: "How to open bank account")));
                    },
                    child: infoCard(context, "assets/Pic6.jpeg",
                        "How to open bank account"),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DataInfo(
                                  data: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Divider(),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                          child:
                                              Image.asset('assets/Pic7.jpeg')),
                                      infoText(
                                          '''⦁	Start your search early, as soon as you receive your university acceptance letter. This will give you more time and options to find a suitable place to live.
⦁	Consider your location and budget. Think about how close you want to be to your campus, public transport, shops, and other amenities. Also, set a realistic budget for your rent and living expenses, and look for places that match your criteria.
⦁	Choose your type of accommodation. There are different types of accommodation available for international students in the UK, such as university dormitories, private halls of residence, shared houses or flats, or homestays. Each type has its own advantages and disadvantages, so you should weigh them carefully and decide what suits you best.
⦁	Use reliable sources to find accommodation. You can use online platforms such as ⦁	Rentola, ⦁	Rightmove, or ⦁	Spare Room to search for available properties. You can also contact your institution’s housing office, student union, or international office for guidance and support. They may have lists of vetted landlords, agencies, or accommodation providers that cater to international students. You can also use social networks to connect with other students who are looking for accommodation or housemates.
⦁	Be careful of scams and frauds. Unfortunately, some people may try to take advantage of international students by offering fake or substandard accommodation. To avoid this, you should never pay any money or sign any contract before seeing the property in person and verifying its legitimacy. You should also read the terms and conditions carefully and ask for receipts and copies of any documents. If you have any doubts or concerns, you can seek advice from your institution or a trusted source.
Useful Links '''),
                                      urlOpen(
                                          'https://www.accommodationforstudents.com/'),
                                      urlOpen('⦁	https://rentola.co.uk/'),
                                      urlOpen(
                                          '⦁	https://www.rightmove.co.uk/student-accommodation/London.html/'),
                                      urlOpen(
                                          '⦁	https://www.mystudenthalls.com/student-accommodation/london/')
                                    ],
                                  ),
                                  Title: "How to find Accommodation")));
                    },
                    child: infoCard(context, "assets/Pic7.jpeg",
                        "How to find Accommodation"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget headTitle(String text) {
  return text.text.bold.color(Colors.red).xl.make();
}

Widget infoText(String text) {
  return text.text.color(Colors.black).xl.make();
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

class DataInfo extends StatelessWidget {
  final Widget data;
  final String Title;
  const DataInfo({
    Key? key,
    required this.data,
    required this.Title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Title.text.xl.make(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: data,
        ),
      ),
    );
  }
}

Widget infoCard(context, String imagePath, String maintitle) {
  return Column(
    children: [
      Container(
        // padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.contain,
                // colorFilter: ColorFilter.mode(Colors.re, BlendMode.lighten),
                image: AssetImage(imagePath)),
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(10)),
        width: MediaQuery.sizeOf(context).width / 2.2,
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            maintitle.text.color(Colors.black).center.bold.xl.make().frosted(
                  blur: 2,
                  width: MediaQuery.sizeOf(context).width / 2,
                  height: 126,
                )
          ],
        ),
      ),
    ],
  );
}
