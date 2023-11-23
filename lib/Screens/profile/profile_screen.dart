import 'package:flutter/material.dart';
import 'package:projet_d_integration/Screens/sign_in/sign_in_screen.dart';
import 'components/profile_menu.dart';
import 'components/profile_picture.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";

  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            const ProfilePic(),
            const SizedBox(height: 20),
            ProfileMenu(
              text: "My Account",
              icon: "icons/UserIcon.svg",
              press: () => {},
            ),
            ProfileMenu(
              text: "Notifications",
              icon: "icons/Bell.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "Settings",
              icon: "icons/Settings.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "Add",
              icon: "icons/Question mark.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "Log Out",
              icon: "icons/Logout.svg",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()), // Replace YourNextPage with the actual page
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}