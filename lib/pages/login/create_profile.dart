import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sari/pages/main.dart';
import 'package:sari/pages/login/profile_signup.dart';
import 'package:logger/logger.dart';

class CreateProfile extends StatefulWidget {
  const CreateProfile({super.key});

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  List<String> profileNames = ['Christian'];
  final profileController = TextEditingController();

  void handleProfileTap(int index) {
    // Handle profile tap logic here (e.g., navigate to profile page)
    Logger().d("Profile $index tapped: ${profileNames[index]}");
  }

  void addNewProfile(String profile) {
    setState(() {
      profileNames.add(profile);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          color: const Color(0xFFB3CDE4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'lib/assets/Sari-Logo.svg',
                    width: 131,
                    height: 93,
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Tap your Profile',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: StatefulBuilder(
                    builder: (context, setState) {
                      return GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 1.0,
                          mainAxisSpacing: 1.0,
                        ),
                        itemCount: profileNames.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                              onTap: () => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MyApp()),
                                    //MaterialPageRoute(builder: (context) => const Correction()),
                                  ), // Call handleProfileTap
                              child: Column(
                                children: [
                                  const SizedBox(
                                    width: 75,
                                    height: 75,
                                    child: CircleAvatar(
                                      backgroundColor: Color(0xFF1D3F58),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(profileNames[index])
                                ],
                              ));
                        },
                      );
                    },
                  )),
              Column(
                children: [
                  Material(
                    color: Colors.transparent,
                    child: Center(
                      child: SizedBox(
                        height: 75,
                        width: 75,
                        child: Ink(
                          decoration: const ShapeDecoration(
                            color: Color(0xFF1D3F58),
                            shape: CircleBorder(),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.person_add),
                            color: Colors.white,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfileSignup(
                                            controller: profileController,
                                          ))).then((newProfile) {
                                if (newProfile != null) {
                                  addNewProfile(newProfile);
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  const Text('Add Profile')
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
