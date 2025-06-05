import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:printhub/pages/newuploadscreen.dart';
import 'package:printhub/pages/signinscreen.dart';

///
/// EDIT PROFILE SCREEN
///
class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  void _onSaveChanges() {
    // TODO: Implement save changes logic
    debugPrint("Save changes tapped");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar with a back arrow and centered title
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            // TODO: Implement back navigation
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        centerTitle: true,
        title: const Text(
          "Edit Profile",
          style: TextStyle(color: Colors.black),
        ),
      ),

      // Body
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Avatar + Camera icon
              SizedBox(
                height: 120,
                width: 120,
                child: Stack(
                  children: [
                    // Circular avatar
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: Colors.grey.shade300, width: 2),
                      ),
                      child: ClipOval(
                        child: Image.network(
                          'https://via.placeholder.com/150', // Replace with actual image
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Camera icon in a small circle
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Name
              _buildTextField(
                label: "Name",
                initialValue: "Melissa Peters",
                obscureText: false,
              ),
              const SizedBox(height: 16),

              // Email
              _buildTextField(
                label: "Email",
                initialValue: "mepeters@gmail.com",
                obscureText: false,
              ),
              const SizedBox(height: 16),

              // Password
              _buildTextField(
                label: "Password",
                initialValue: "••••••••",
                obscureText: true,
              ),
              const SizedBox(height: 16),

              // Date of Birth
              _buildTextField(
                label: "Date of Birth",
                initialValue: "23/05/1995",
                obscureText: false,
              ),
              const SizedBox(height: 16),

              // Country
              _buildTextField(
                label: "Country",
                initialValue: "Cyprus",
                obscureText: false,
              ),
              const SizedBox(height: 32),

              // Save changes button (green)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _onSaveChanges,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF34C759), // green
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Save changes",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // Bottom navigation bar with 2 icons (home, profile)
      bottomNavigationBar: const _CustomBottomNav(selectedIndex: 0),
    );
  }

  // A helper method to build a labeled text field
  Widget _buildTextField({
    required String label,
    required String initialValue,
    required bool obscureText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 15, color: Colors.black),
        ),
        const SizedBox(height: 6),
        TextFormField(
          initialValue: initialValue,
          obscureText: obscureText,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
        ),
      ],
    );
  }
}

///
/// PROFILE SCREEN
///
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  void _onEditProfile(context) {
    // TODO: Implement edit profile logic
    debugPrint("Edit profile tapped");
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const EditProfileScreen(),
      ),
    );
  }

  void _onSignOut(context) {
    // TODO: Implement sign-out logic
    debugPrint("Sign out tapped");

    FirebaseAuth.instance.signOut().then((_) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>
              const SignInScreen(), // Replace with your login screen
        ),
      );
    }).catchError((error) {
      debugPrint("Sign out failed: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar with a back arrow and centered title
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.black),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            children: [
              // Large circle avatar
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey.shade300, width: 2),
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/profilebg.png', // Replace with actual image
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Name + sub-text
              const Text(
                "Melissa Peters",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                "student of sfedu",
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
              const SizedBox(height: 2),
              const Text(
                "Cyprus",
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),

              const SizedBox(height: 24),

              // Edit profile button (black)
              SizedBox(
                width: 140,
                child: ElevatedButton(
                  onPressed: () => _onEditProfile(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text(
                    "Edit profile",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ITEMS / PRICE section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "ITEMS",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "PRICE",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Example item rows
              _buildItemRow(
                itemName: "Brand\nProduct name\nDescription\nQuantity: 01",
                price: "\$10.99",
              ),
              const Divider(color: Colors.grey, height: 20),
              _buildItemRow(
                itemName:
                    "Another brand\nProduct name\nDescription\nQuantity: 02",
                price: "\$22.50",
              ),
              const Divider(color: Colors.grey, height: 20),

              const SizedBox(height: 40),

              // Sign out button (black)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _onSignOut(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    "Sign out",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // Bottom navigation bar with 2 icons (home, profile)
      bottomNavigationBar: const _CustomBottomNav(selectedIndex: 1),
    );
  }

  /// Helper method for building each item row under ITEMS / PRICE
  Widget _buildItemRow({
    required String itemName,
    required String price,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            itemName,
            style: const TextStyle(fontSize: 14, color: Colors.black),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          price,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

///
/// A custom bottom nav bar with 2 icons (Home, Profile)
/// No labels, just icons
///
class _CustomBottomNav extends StatelessWidget {
  final int selectedIndex;
  const _CustomBottomNav({Key? key, required this.selectedIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                // TODO: Navigate to home
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const MergedTabScreen(),
                  ),
                );
              },
              icon: Icon(
                Icons.home_filled,
                color: selectedIndex == 0 ? Colors.black : Colors.grey,
              ),
            ),
            IconButton(
              onPressed: () {
                // TODO: Navigate to profile
                debugPrint("Profile tapped");
              },
              icon: Icon(
                Icons.person,
                color: selectedIndex == 1 ? Colors.black : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
