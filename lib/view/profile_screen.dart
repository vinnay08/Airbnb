import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text(
                      "Profile",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Icon(
                      Icons.notifications_none_outlined,
                      size: 35,
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.black54,
                      radius: 35,
                      backgroundImage: NetworkImage(
                          "https://tse3.mm.bing.net/th?id=OIP.Bo5gMo2MDR3GDp28toJnhwHaHk&pid=Api&P=0&h=180"), //Replace  with after solve authetication ${FirebaseAuth.instance.currentUser!.photoURL}
                    ),
                    SizedBox(
                      width: size.width * 0.03,
                    ),
                    Text.rich(
                      TextSpan(
                          text:
                              "Display Name\n", //${FirebaseAuth.instance.currentUser!.displayName}
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                                text: "Show Profile",
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 16)),
                          ]),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: Colors.black12,
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  elevation: 4,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: Row(
                      children: [
                        Text.rich(
                          TextSpan(
                            text: "Airbnb your place\n",
                            style: TextStyle(
                              height: 2.5,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: "It's simple to get started",
                                style: TextStyle(
                                  height: 1.2,
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Image.network(
                          "https://static.vecteezy.com/system/resources/previews/034/950/530/non_2x/ai-generated-small-house-with-flowers-on-transparent-background-image-png.png",
                          height: 140,
                          width: 135,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: Colors.black12,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Settings",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 20,
                ),
                profileInfo(Icons.person_2_outlined, "Personal Information"),
                profileInfo(Icons.security, "Login & security"),
                profileInfo(Icons.payments_outlined, "Payments and payouts"),
                profileInfo(Icons.settings_outlined, "Accessibility"),
                profileInfo(Icons.note_outlined, "Taxes"),
                profileInfo(Icons.person_2_outlined, "Personal information"),
                profileInfo(Icons.translate, "Translation"),
                profileInfo(Icons.notifications_outlined, "Notifications"),
                profileInfo(Icons.lock_outline, "Privacy and sharing"),
                profileInfo(Icons.card_travel, "Travel for work"),
                const SizedBox(height: 15),
                const Text(
                  "Hosting",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 25),
                profileInfo(Icons.add_home_outlined, "List your space"),
                profileInfo(Icons.home_outlined, "Learn about hosting"),
                const SizedBox(height: 15),
                const Text(
                  "Support",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 25),
                profileInfo(Icons.help_outline, "Visit the Help Center"),
                profileInfo(Icons.health_and_safety_outlined,
                    "Get help with a safert issue"),
                profileInfo(Icons.ac_unit, "How Airbnb works"),
                profileInfo(Icons.edit_outlined, "Give us feedback"),
                const SizedBox(height: 15),
                const Text(
                  "Legal",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 25),
                profileInfo(Icons.menu_book_outlined, "Terms of Service"),
                profileInfo(Icons.menu_book_outlined, "Privacy Policy"),
                profileInfo(Icons.menu_book_outlined, "Open source licenses"),
                const SizedBox(height: 10),
                const Text(
                  "Log out",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(
                  color: Colors.black12,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Version 24.34 (28004615)",
                  style: TextStyle(fontSize: 10),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding profileInfo(icon, name) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 35,
                color: Colors.black.withOpacity(0.7),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                name,
                style: TextStyle(fontSize: 17),
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                size: 20,
                color: Colors.black.withOpacity(0.7),
              )
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Divider(
            color: Colors.black12,
          )
        ],
      ),
    );
  }
}
